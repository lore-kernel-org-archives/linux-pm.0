Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9FF381EBC;
	Fri, 21 Aug 2026 04:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787286658; cv=fail; b=XyiLuh/xZmX8zbCsdVwW/M/U8Ku1oDZYo3Vh+A9ix6jFCxsBCVwI6ESu7LtzsjEKIU44upDzkKqyfU2NIdEaqu2QkrDq2ZSSckJ1GQr1zY5x15uLAE01gOgfIQdjzgwrtJsf/PcAQ/sdS29T8OsHyJmPydcpXlF/8AUxXOlrUlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787286658; c=relaxed/simple;
	bh=SCZ+VWT3Fe9Q1RGJN/OccAz5n81W6eKViDkqD5l3EGo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qz2/InwLsiH0sm45etY//RO2E9etFMmMN6xhd0zVb9SPYTowxIZhI4ZfovI3nykcmZXA8oBB2uzeESWP9JjrjkKzFGf23y3UZ7yV7u2MxKNxzywcONurY2PTrgG13PI3t5kRmhLE6fEeVxZ65auW0k7dhT8M7ZDf8tm+QIwK/rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TRugsU/i; arc=fail smtp.client-ip=40.107.209.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TRugsU/i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeFg/UUnsQh3qrmmmUAPi/+KBDFLSo3555kQUmbIiX4i2mYlunltH73FA5ZF5LmWeDUfFyzCMHFYuFlDwx1bKDBEKZ/uLDGrFuxrM6i6sONM8ELA6sLMfdo7hiki5gZcv1eZkKMoFnu+nHjPByR5RJgj79QZ6PKqNZ6FnLscF4G8oay/MT9XNjR4h2J4jyx6/8Wdq/aiK/7tMTrl1EdzeR9eu6VNDYC8Nkptm4nex5FaaEaN3YBUvk/bCTRaZeHNRMKiMzR52TvuPFFXVmG+wBPuyepcLZdzpfFihuoU+YlBvw0K6d7YtBJEW2ZeI/Pgnfq3AEtEOQV6aI+PJTT2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRuDooq4PEa3a7nVd4TkBWCSjj4cSjJ+h3KbUFho21Y=;
 b=NkHHtZX+BerZSGk4v/KdhuYNsGquzGOddlVYe3SYqNhtHTKnnCiZI6KYPI5EZmiWDVPxl43sikm3J2X4+TAwSqlQJRxIQu19MOLO7XpIiwRuaZI+WXoPM142meGHSkffZ5Mn9SojksMjcHLnzelXExoK6XKyW4oJPExOp/O2dvYjJWzvleyNmpNtZnN2y6WWWgQ7Tibk6iIKKSQQlEQQ2SgcGhubL4jBX566OIvewZok0drG66wnsxjZM6uRrhJBDr2bvvpQJeAvuSaqMSZ1PNGYKYrJcscJFt/+GqhL2i2+7gzeMiuE9X4K5DnLVdUNLYfUZhDZUgeGCpCaMDOzfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRuDooq4PEa3a7nVd4TkBWCSjj4cSjJ+h3KbUFho21Y=;
 b=TRugsU/iYK9ZiQAIJB7aZodPqL57PXh9KZsa29oFwni+/ueRZ5H+Kk2hAlwXC7tcqY5TecAAlHQ3Gp6/5ax2Y3LszPF/lHRp1O45LhG+V+ReQNjaWZztVI9zwwZXmehnMpVidNnAmGTQ7FL+tUGTgCEAQQeMU8dRFhoxsKDK8M0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 04:30:49 +0000
Received: from DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f]) by DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 04:30:49 +0000
Message-ID: <a75c97df-d956-462a-b44f-9fa984cd5423@amd.com>
Date: Fri, 21 Aug 2026 10:00:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/6] dt-bindings: dma: xlnx,zynqmp-dma: Add Versal Net
 compatible support
To: Frank Li <Frank.li@oss.nxp.com>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 git@amd.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260810100452.426320-1-nagendra.golla@amd.com>
 <20260810100452.426320-5-nagendra.golla@amd.com> <antQqyT-slTnY2e1@SMW015318>
Content-Language: en-US
From: "Golla, Nagendra" <Nagendra.Golla@amd.com>
In-Reply-To: <antQqyT-slTnY2e1@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::8) To DS4PR12MB999075.namprd12.prod.outlook.com
 (2603:10b6:8:2fc::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB999075:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f758d9-2eb1-4ff9-a750-08deff3cfa14
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|22082099003|56012099006|18002099003|6133799003|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	/gsrWaSLH8t+apCBvIi1E77wSMPHWJLC/pU74pQuOVpVKr7BnjjFnuiJzRTb0G6ifgOMnOw03zOB2W4T3nvk6TJu8wMRp3ORAKEEgXqzFOgt6CG2sFeQoOevsfb5eTvEyZU6p90uNRJ+cgSHfPPee5WP8Zhvbe4QOKxbYn86q1yP0dZvIUAiYpGZFYC1RAzqCa+GOxnzau9AhpVax751LO+S7YJhRv9cFghatRA24vY6qBWbS01eTtr4MUjPGDPfOOXF49dXIcSVGe66VVIQcpLKeWH3mLLA0lR/23x3bm0jwgrGBT2bxSHRxCN2hkOvDLBUP/T/08pXwfXuXIyj0oIV8mHGGBYv+GH2e9xZYHuttaMOxEXG9Yz/pO9I3fUULCm5nJ3z6TCXYxl1x6xN7RMowRtEBQO5F2L/Go0stVDnYJWWOfCp6hvR3QETTyd2O5XWTtoSUfpZZqa9D6ZiEE6wNJoizy4J8ev2uFvJLMPYuF2wu9RujQQBYIK2+y2xMCGA/w2NtLDoftxG6g+H9ERLbqSOoGVupRsuNYqXkPqN2klvAiNnKNEFK9yF9uA6kawx7weSfIzLhf47AsRG/Q4why0j6qccsXqYxQANjhOjhsb/ONZleNOkU6xnlAxxPzMYSY/X2te0DVqt77mwXmq51DRyAjMDi5qxGIFKlag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB999075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099006)(18002099003)(6133799003)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTRZM056MlFtK0w2ekNTcllqM3YwQVhCam1QbWIrbW5lRWNPOXJUaW9yTWZI?=
 =?utf-8?B?cUNUR3FOZUNJS0tZTGpLZmZTT1pNSk9DdlNDS2Mwdk5waHNqTEJwWE53MXVM?=
 =?utf-8?B?UzBhbGdvY0czUzZUL1pqbzJYaENyeVNmQm1CNldCRGNtcnVjQk9vOXE4VXpE?=
 =?utf-8?B?ZWlKTmRRMlU4b0Q4R2hScU9hM1Y4NXFXdlFUdEdMTmphQzNkTFkyQjA4bG1i?=
 =?utf-8?B?YnBXRTFyR0sraFlKcit4RjVLd0pQVnhIMWRjUjVNMXBFeGQ2VU0xTkZHbUJY?=
 =?utf-8?B?SFBKZ2ltTlFTUWFTbW1ob0VGNlp4TCtrYllHakxGWHF2Q0hvQTdyYzN1Vysr?=
 =?utf-8?B?ai9CcUovcFdCTWFieHBqRFNwc1BJenB1bGlEY2ZwVFNYZUNaRCtxRVFKUzF5?=
 =?utf-8?B?MnM1YktWbmNMOVZwS3RxbDBsdSs2eEdFamlQUm5PbHZxbEhqSllac1V4Uko2?=
 =?utf-8?B?QmNNdXZUY0tVdmpTZHRQR3FSbWJKNVBVZWNQYldFdHBCLzRIaGJnbXBGWTFK?=
 =?utf-8?B?bW1mNG16d1pYMm96cHlWb01WYmxnWEZyZXBTbEplOVBJRXA0YS84T2pGbVdQ?=
 =?utf-8?B?ZGtRZnpyV09KNDJXNDI3UFVOZXM3RDFsK3ZMRzBya3M5L0taZDYyZ1ZVUXNT?=
 =?utf-8?B?a1UyRkc1ZTF6alRENm1rZ1NHOE82T0hWSktWTWJUbzFZVm1JdEtmM2IrcEEr?=
 =?utf-8?B?YithdStpKzZiWVcyZFpiQlA0QlZxZHRsNVpuT2lzNmpOSFk3bG9LR3lNL0ZT?=
 =?utf-8?B?V0pIZVhNek5DREtPUVRkcG1hSmFPS2RpWVR2Ykd4dDRpb0NZOXdIbWFzUnpa?=
 =?utf-8?B?ZTNpWjBRYklNb09ydDZGUEdobDZPeVJrdndyVmtycjVWQm9BQVFNLzdMNTJU?=
 =?utf-8?B?UnRMV2pLVWV2bEJlRFBKNVM4Q0R3Q1Fkd1NzN3J6TEl1Wk9TWklzSk9IbHNv?=
 =?utf-8?B?bjhtRXpiWWxsbkZ2MnhTRVg0VHFZWlptb0p2QlZoOTFTTG1VeC96SFNKM1JE?=
 =?utf-8?B?N3JMUmZaR09IYVJTY0U1WFhrYzQvMXlrU1FzZFpNOGgxbUF0ME1WY0dtSmp5?=
 =?utf-8?B?K0x1WkpCQkNyM1NpU3dzblpYTHNLTys0OU9FSHlrdmVRQXZJUExNUVZRLzRM?=
 =?utf-8?B?K04veVg2L0p1dGZHajFuL1FmVHB1K2trR00zRk5NR0FYc3ZYeHlTZkpER2g3?=
 =?utf-8?B?R24zZ051eVJ6Y3JvRXFsYlQwdGswa0pzQXJndUF1bHkyTU93MXJMeXRCZzJJ?=
 =?utf-8?B?MUIxekEvdmJObDdCQjJaTDZaclBleThEUkNJTVNXd0dYYUVxN1Z0amFid0VI?=
 =?utf-8?B?Ti90TXh3TXpXU3YzOHczZmxOYWFweXNUd1h1KzVqejZFUW1RR3NPN09oWTJG?=
 =?utf-8?B?bUJPdm10WE1ZM2w5NDBkQzNxWjRPdCttVHlDWDVsWDZVM0xtVmNRTUxuQ2Z3?=
 =?utf-8?B?aFl5TEZKU3kzZFBoQkpQOCtPeVpOejJ5a3c3OFFuaGwwcnlSeklDK0JKcmhZ?=
 =?utf-8?B?NnJ6VHpkNnRESFRnU0lDaGRBYXAwS1lJd2dqWFYzOVpERFBzcy8ySmFxRm9k?=
 =?utf-8?B?aWl0dkx4dG9pQ0tteVdvbDBNMW9yZndPRXlXaVlMMnhYbUNBNUpxbmpaTGJB?=
 =?utf-8?B?bEZUajRPc2JjSkdSR20zcmh1SGp6bkpIN0NlT1NWcEdqOTZNeDhXak5ETkEv?=
 =?utf-8?B?Y1p3ZFlnOXMzM0hxQlJJalNiRWpBV1NDdVllOVBzOGRFOVFxMjRHZlVtNW1Q?=
 =?utf-8?B?V3MxOFUrNU9KSW5iWURmUXJ3a0QxOXBscThXNTFEK0pXZ2pLYWpPd2ZYeDVM?=
 =?utf-8?B?NyszSDBoNzk1ZjhMRHBCcldsYUJQUW00WXRtOEFTSHJsZ2dYTkkvREYzTVUx?=
 =?utf-8?B?cW9mTGtzNWd4a3liR2tmSHBVeUlKT2dGWHhRRmVUQ3pDbEx6SVBIUTd4SVd2?=
 =?utf-8?B?cytYTHRaMmg2dDdqSlROTzZsV005dXQwZWpjNFZHa1hMeUZLemdFa2tMeWls?=
 =?utf-8?B?Rmp4QmFsd1hTRDlkaHc2cTZyRnNZUFNIanRIWVhQclNoUFJ0c084cXFteHd6?=
 =?utf-8?B?dkRNRk4vQU1yNFUzMlhjK1l5WDRPdXdUcXBCMys1djZiMDZmNlJlSHYwSnlv?=
 =?utf-8?B?VDUwZ1FiWFBXOG5WT0RFOXdSRjJZOWkxUXhJaDJ6NTZzVVZtMFpUV0FEMUJ4?=
 =?utf-8?B?UUlBV3pVNEsyZjFOeXBRQUVYK1hEblRNcUVmbjJBcU9hTnd5Ykt6QUt6VUZR?=
 =?utf-8?B?OTlOWEtJTHZmMW0yYnU1RjNKUGVLaHR0M1pzSWNZdHBNcVdocjhKMnFmd0hh?=
 =?utf-8?B?bkRJMFVnak5rWDdiTFlCVllOVzdWdWtTWThrcXhPZ3NEcXliTGlUdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f758d9-2eb1-4ff9-a750-08deff3cfa14
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB999075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 04:30:49.3183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRCt0HM9IDXobEYc3Grk9MtqWkHJnp/U22qEr4iphqjWp0Z7YZLQesJFUsuq/Np7IrECpcAWjxnsVsHlLQRRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245

Hi Frank

On 8/11/2026 10:11 PM, Frank Li wrote:
> On Mon, Aug 10, 2026 at 03:34:50PM +0530, Golla Nagendra wrote:
>> From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>>
>> Introduce a new compatible string amd,versal-net-dma-1.0 for
>> Versal Net ZDMA.The new compatible requires xlnx,zynqmp-dma-1.0 as a
>> fallback.
>>
>> Add a reset property to describe the per-channel reset line exposed
>> on Versal Gen2 and Versal Net.
> 
> why only one reset if per-channel reset line?
Thanks for the review

Each ZDMA channel has its own DT node, so maxItems: 1 means one reset 
per channel node — which is exactly the per-channel reset.

Thanks,
Nagendra

> 
>> Mark the resets property as required
>> for both Versal Gen2 and Versal Net, and not applicable for other
>> platforms.
>>
>> Note that making resets required for Versal Gen2 results in an ABI
>> break but this is unavoidable. When DMA is used by two software components
>> back to back (e.g., firmware before Linux boot), DMA functionality fails
>> due to configuration differences or the DMA being left in a bad state by
>> the previous user. The channel can only be cleanly re-configured after
>> a DMA channel reset,making it essential.
>>
>> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>> Co-developed-by: Golla Nagendra <nagendra.golla@amd.com>
>> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
>> ---
>> Changes in V3:
>> - Use allOf:if:then: to restrict the resets property per-compatible,
>>    making it required for amd,versal2-dma-1.0 and amd,versal-net-dma-1.0
>>    and explicitly setting resets: false for all other platforms
>> - Add amd,versal-net-dma-1.0 compatible string with xlnx,zynqmp-dma-1.0
>>    as fallback
>> - Switch compatible from enum to oneOf to accommodate the new multi-item
>>    entry for Versal Net
>> - Add ABI break justification
>> ---
>>   .../dma/xilinx/xlnx,zynqmp-dma-1.0.yaml       | 25 ++++++++++++++++---
>>   1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
>> index 2da86037ad79..87c65aef5c7d 100644
>> --- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
>> +++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
>> @@ -18,15 +18,31 @@ maintainers:
>>
>>   allOf:
>>     - $ref: ../dma-controller.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - amd,versal2-dma-1.0
>> +              - amd,versal-net-dma-1.0
>> +    then:
>> +      required:
>> +        - resets
>> +    else:
>> +      properties:
>> +        resets: false
>>
>>   properties:
>>     "#dma-cells":
>>       const: 1
>>
>>     compatible:
>> -    enum:
>> -      - amd,versal2-dma-1.0
>> -      - xlnx,zynqmp-dma-1.0
>> +    oneOf:
>> +      - const: amd,versal2-dma-1.0
>> +      - const: xlnx,zynqmp-dma-1.0
> 
>           use enum
> 	 - enum
>               - amd,versal2-dma-1.0
>               - xlnx,zynqmp-dma-1.0
> 
>> +      - items:
>> +          - const: amd,versal-net-dma-1.0
>> +          - const: xlnx,zynqmp-dma-1.0
>>
>>     reg:
>>       description: memory map for gdma/adma module access
>> @@ -59,6 +75,9 @@ properties:
>>     power-domains:
>>       maxItems: 1
>>
>> +  resets:
>> +    maxItems: 1
>> +
>>     dma-coherent: true
>>
>>   required:
>> --
>> 2.43.7
>>

