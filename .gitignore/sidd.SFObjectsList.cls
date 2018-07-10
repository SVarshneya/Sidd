public class SFObjectsList {
    public list<SelectOption> lstObjects {get;set;}
    public string selectedObj {get;set;}
    public list<Wrapper> lstFields{get;set;}
    public list<Sobject> objList {get;set;}
    public map<string,list<String>> mapRes {get;set;}
    
    public SFObjectsList(){
        lstObjects = new list<SelectOption>();
        getObjectsList();
    }
    @TestVisible
    void getObjectsList(){
        for(Schema.SObjectType ty : schema.getGlobalDescribe().values()){
               SelectOption s = new SelectOption(String.valueOf(ty),String.valueOf(ty),false);
               lstObjects.add(s); 
        }
    }
    
    public pageReference showFields(){
        lstFields = new list<Wrapper>();
       Map<String,Schema.SObjectField> mapFields = schema.getGlobalDescribe().get(selectedObj).getDescribe().fields.getMap();
       Wrapper obj = null;
        for(Schema.SObjectField fld : mapFields.values()){
            
            schema.DescribeFieldResult fResult = fld.getDescribe();
            obj = new Wrapper(fResult.getName(),String.valueOf(fResult.getType()),false);
            lstFields.add(obj);
        }
        
        return null;
    }
    
    public pageReference queryResult(){
        mapRes = new map<string,list<String>>(); 
        String query = 'SELECT ';
        for(Wrapper obj : lstFields){
            if(obj.selected){
                query += obj.fieldName +',';
            }
        }
        system.debug('==query=='+query);
        query = query.removeEnd(',');
        query += ' FROM '+ selectedObj;
        system.debug('==query22=='+query);
        objList = Database.query(query);
        for(sobject sObj : objList){
            for(Wrapper obj : lstFields){
                if(obj.selected){
                    if(!mapRes.containsKey(obj.fieldName)){
                        mapRes.put(obj.fieldName, new list<String>());
                    }
                    mapRes.get(obj.fieldName).add(string.valueOf(sObj.get(obj.fieldName)));
                }
            }
        }
        return null;
    }
    
    public class Wrapper{
        public String fieldName {get;set;}
        public String dataType {get;set;}
        public boolean selected {get;set;}
        
        public Wrapper(String fName, String dType, Boolean selected){
            fieldName = fName;
            dataType = dType;
            this.selected = selected;
        }
    }
}