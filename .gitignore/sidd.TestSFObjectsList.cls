@isTest
class TestSFObjectsList {
    
    static testMethod void getObjectsListTest(){
        test.startTest();
        SFObjectsList obj = new SFObjectsList();
        obj.getObjectsList();
        system.assertEquals(true, obj.lstObjects.size() > 0);
        test.stopTest();
    }
    
    static testMethod void showFieldsTest(){
        test.startTest();
        SFObjectsList obj = new SFObjectsList();
        obj.selectedObj = 'Account';
        obj.showFields();
        system.assertEquals(true, obj.lstFields.size() > 0);
        test.stopTest();
    }
    
    static testMethod void queryResultTest(){
        test.startTest();
        account a = new account(name='sidd');
        insert a;
        
        SFObjectsList obj = new SFObjectsList();
        obj.objList = new list<Sobject>();
        obj.selectedObj = 'Account';
        obj.lstFields = new list<SFObjectsList.Wrapper>();
        SFObjectsList.Wrapper objWrapper = new SFObjectsList.Wrapper('Id','Id',true);
        obj.lstFields.add(objWrapper);
        objWrapper = new SFObjectsList.Wrapper('Name','String',true);
        obj.lstFields.add(objWrapper);
        obj.queryResult();
        system.assertEquals(false, obj.mapRes.isEmpty());
        test.stopTest();
    }
}