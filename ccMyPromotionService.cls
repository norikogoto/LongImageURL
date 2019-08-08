/**
 *
 * Created by Noriko Goto
 * Copyright 2019 CloudCraze Software, LLC. All rights reserved.
 * Redistribution and use in source or binary forms, with or without
 * modification is PROHIBITED.
 *
 */
global with sharing class ccMyPromotionService extends ccrz.ccServicePromotion {
    
    global virtual override Map<String, Object> getFieldsMap(Map<String, Object> inputData) 
   	{

        ccrz.ccLog.log(System.LoggingLevel.DEBUG,'M:E:ccMyPromotionService:getFieldsMap');

        inputData = super.getFieldsMap(inputData); 
        String objectFields = (String)inputData.get(ccrz.ccService.OBJECTFIELDS); 
        objectFields += ',Long_Image_URI__c' ;
        
        ccrz.ccLog.log(System.LoggingLevel.DEBUG,'M:X:ccMyPromotionService:getFieldsMap:objectFields',objectFields);
        
        return new Map <String,Object> {ccrz.ccService.OBJECTFIELDS => objectFields}; 
    }
   
    global virtual override Map<String, Object> prepReturn(Map<String, Object> inputData){
        setLongURL(inputData);
        ccrz.ccLog.log(System.LoggingLevel.DEBUG,'M:X:ccMyPromotionService:prepReturn');
 		
        return super.prepReturn(inputData);
    }

	public void setLongURL(Map<String, Object> returnMap) {
		
        List<Map<String, Object>> promotionList = (List<Map<String, Object>>) returnMap.get(ccrz.ccApiPromotion.PROMOTIONLIST);

        for(Map<String, Object> promotion : promotionList) {
            String longImageURI = (String)promotion.get('longImageURI');
            String imageURI = (String)promotion.get('imageURI');
            String imageSource = (String)promotion.get('imageSource');
           
ccrz.ccLog.log(System.LoggingLevel.DEBUG,'M:X:ccMyPromotionService:setLongURL:imageURI',imageURI);


            if(imageSource == 'URI' && String.isBlank(imageURI)) {
                
            	promotion.put('imageURI', longImageURI);
        	}
        }   
        ccrz.ccLog.log(System.LoggingLevel.DEBUG,'M:X:ccMyPromotionService:setLongURL:returnMap',returnMap);
	}
}
