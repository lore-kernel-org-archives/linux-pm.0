Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC24351C22;
	Fri, 21 Aug 2026 04:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787287026; cv=fail; b=XQNcir3Txcbk2hqS9XROVGOk0GQUWxB0pP7SyLaF71k4QKy/RW3QvYK0Cg5EbdP7XQ7Z2od08hGvfKaSfLVeenRNilFgXAMMCtRx+Qij6oBN9ivNzrY91I9Hb56iTFnXjt9ohRWTNHG3t5qXWF6/Oyi9KgQEs3H7RoOfQc8k+Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787287026; c=relaxed/simple;
	bh=+otythzThWO3X2jmpBdaB4baMyJmy3ZqoYgJxIG0ZgM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LADFN+VoGrkWiWyX2adRgLUOllZIx7gfjAkwCVn5/cWLukVaxwoYdIqy/aQKGLrKyvdat0TlmGUbe9gxu1QVZ4XwNEmvzvzY5HvadaIyxqN9PGZvSYqO+sACtwffFJnLwsUlSYnCF3m2X8Y8mWMHWVfxMEXp5UycNLnEM5oCeZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2cNPV0KV; arc=fail smtp.client-ip=52.101.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2cNPV0KV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6FuLObCoo9S/RE51MAMoVGrn+CPkDtmtWPlQNbptNPscgzql06NRP6gcIIKbO/VD4RUaZxB4XM71NdHjSBlJd/YkEbJr2DT2o/kTNF/d50EBHe+5TjSM5ViXWdHilTED3g3lCpVnCSzgyKNPkOr31oxhszCmqnLHbVahnS0JktWszNdVmmBUOW0sSYTF0BD3lL+98yLcFJMLB5rVAZTBHyhf8ZFyrcjyfs2r4cSppFacjrx4mX+79PsHuACO5Kl8RjwGfay5Vvy3Z/Ew7bSz64jvZsYZsIE93pFUd+23AVlCqn9t/Mke5TVZAYq9Nq7209ZTUx2jWelMQHCLo4O9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43wavXFd2W0yCmQfZPP8z9f1TJ6ckUJTrKkUig5dr6s=;
 b=eW/KA/sPkAPEmHxiOwynMgWm/YQWTw33sKPzS1LWjDDLsQGpfulS6TlUS5Os776O60S55iMgHTWsdInyddHSrEfNY5kPMKMeVSRE4LHHOE03lR7UmeMrG5/Rz602IAeFHBnYBySEOiHkG8UOlnAxCehAE3BJMybLkZeTVHVMFxJkGG/7vLCJn5Ym2bBJSUIYoSdiNzgnJ7CSBYojXNh4rFcddOI74L4wpkAMQsl7zhfiLRuRHNekIRDnEEG25J9FELnywcuqrnp/eUauptfWNLpcKm4yFAzSX91TNU6t9RlMOHD6qMSfj9KeGbfLUHigMdSzXRgFz32Sv1biPD/HRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43wavXFd2W0yCmQfZPP8z9f1TJ6ckUJTrKkUig5dr6s=;
 b=2cNPV0KVlqA3iAW45naFT9AZ4TzeESFZDdqqqDKlotAhVyovFS1PW+v/97+eiqlcuNo3vHEZfkZaTDlh4mMLlgYT5bn+qblqx+eIaB/ys0SEXNuNU3k+a4nq7UkKO7oSn6ZR07rHALyt9JZa0gFKbMZeSYHHHTdWgF/UgNxr918=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 04:37:00 +0000
Received: from DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f]) by DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 04:36:59 +0000
Message-ID: <f3b91b66-238b-41bf-9c11-4b27314807d8@amd.com>
Date: Fri, 21 Aug 2026 10:06:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/6] dt-bindings: dma: xlnx,zynqmp-dma: Add Versal Net
 compatible support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: vkoul@kernel.org, Frank.Li@kernel.org, michal.simek@amd.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 git@amd.com, dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260810100452.426320-1-nagendra.golla@amd.com>
 <20260810100452.426320-5-nagendra.golla@amd.com>
 <20260812-benevolent-ammonite-of-mathematics-5dcafc@quoll>
Content-Language: en-US
From: "Golla, Nagendra" <Nagendra.Golla@amd.com>
In-Reply-To: <20260812-benevolent-ammonite-of-mathematics-5dcafc@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0232.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::6) To DS4PR12MB999075.namprd12.prod.outlook.com
 (2603:10b6:8:2fc::20)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB999075:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: b24fbbe9-c535-4375-675a-08deff3dd6ed
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|22082099003|56012099006|18002099003|3023799007|6133799003|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	ckz0XftzmfMuU4e4r/htf2Pm/aKLupxKI2HJeUX/tzJ+CmoU8nmYBf0hKObkgtkfSqlaCfVVASTZ6NwdUnNtDta6j3E18DrrnQZv6lV7doHyWuuDLtBclHxKWjun4DMquJibCOf8D96BFMp1ffd+CesvApVXez/2HIkApWhQ1kJCcRJWO9cWDYU+ZrOhFI9vFS3Xg8r+zcczXIT6gmGylAOp9eYlm0YkC4YJqDaNSrib4qIvp1Kkgxil8NFemzv6aISO/Bkz+X9zYtqksfBubbpxeD72IQ+WHx5gzIPI8pcCNJGnz9wJ8+oL2+kc5gufG2JwQ1+MSq6WlwAkAYi9VdfQ6CBKCItiYiaMH2h7qOudbhXoHNOD6WqAoqPD6dx6AwyqbruEZ9HjbzX4yxJSEaDEAospvRYH0Hy/gKlPTUoeiSNySCGgym7rDyxGIXhlX2Oq1KpBf0CmRltAmO3E5MUIYAfHXhtyW9W9LpCrz6BKcPJR5ykZQC0ZdX0Pc49opDeYAPZLkTlH5evXL1ZaqFXcfS5veenUWwBhShPEhvjvvJYPHp3jJbEDNvgEr9DicxU597R8Xn2EEBmfYM3aFVUKo9OCYAhiNXZ9OcLEvJgCr6j+mAwyQ8B4h6Dvq8wvJx3nUhlVOZ08cLgS65OIrv70prWuH4O/yiXFnzEEASE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB999075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099006)(18002099003)(3023799007)(6133799003)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anBmMGQ4NUhPekVPK09sQmFJTkxST3IvYU5Ucm9DSXZpVkU0RWo3aUQrOXNQ?=
 =?utf-8?B?Uk1CTVdVYzZIbXV3eWR1ZTJOUjNkUldaM3ltTGFGV0dXa05KY0RkUkNWOWdL?=
 =?utf-8?B?cWxmNkdrZDVvcDVyZ0YyUEhkTDhOWmhwcVBFaHJxNXdDN3dNaC9FWTQ4cFJn?=
 =?utf-8?B?NG9ibll2RlN4SG5aSUZLdTZSeG9SZFZlS1dkTllORkcxTmVYUkxyTDBiM3JC?=
 =?utf-8?B?Qnl6djZvZ0RESXVLcmo0RzFmdlY1aDYyNTVSanJyYSs0Y1VCNnVVTm5lMWVl?=
 =?utf-8?B?RldWQnhuT3Y3cGtDUTNZWG5nbzFZTzdyZXh1a2ZpejhBUkpVc2JLT3dJeTlW?=
 =?utf-8?B?b0J1WFJSSWtuYTdBaTh6akZWT1RkN25ISzVYYldwcERCQ1VhM2hsMkZ2czgv?=
 =?utf-8?B?OHFCb3BsUk9HVmEzaFU3b3NmUWpqVmxoVHBLWXE2K2YwWkhiWVBVQXhvUjBC?=
 =?utf-8?B?N2UrMWRMOUxhRXlURjhsS1ZJaDF4RjFCNVhPNVVGTHQxOUxVQkFXVmE1NS80?=
 =?utf-8?B?R21QUXhnMFZRTERsejNmZHRoYlltMldTVUthMlltY1YwWStZSTlBZkF1SGpT?=
 =?utf-8?B?UUJNcnhDeXBxTTByT05WWlBVQmNYS3pxcVBiZGtPbGlsSGdmRFhBdEptOHk1?=
 =?utf-8?B?MUlXenRTelpubDlVcVFBbDYyb1FYeDdRQlpkRUh0SkhCT0h5V1dtWWc3QTZL?=
 =?utf-8?B?NUdmT2ZxZlRGMit4U2tUSi9LZ3JTT3p0ZkZTeFNCM3ZZMGRiQlNISkI1TlRV?=
 =?utf-8?B?c0hzUkpSZ3c4RnNPYUYzK1VKeXNtUDg5SWV3S0R1eU1SU3V3RG5CUFh3ajQ2?=
 =?utf-8?B?enJ6NGFud0I1LzdLZG40ZVJtbXBmN2dkMTJPNXV3b2ZaSWZPRGNSWE1tdTlL?=
 =?utf-8?B?aWd5eFhpd3ZGWEdmd0lJNkp0L2RIYWFnSFVXcHBjeWE1VUdpNGV1M0NDeTBI?=
 =?utf-8?B?Q2RCMVhaS1lqRHl1bjNENWt4S0ZMVnd1YUVoNWJZS0pNaXZ0cjh1elM2dk1i?=
 =?utf-8?B?K3hFMlBSOXhlZU5lQW5OKzhMUW5rZ0hhaGdnQU1uQWZidkFOR3k5VTc5WUJt?=
 =?utf-8?B?MzlnMWpaNVREMjVYMkpGS0NPem9WYTNrR01nY01YSm9TRDB2YkFiYk5PVFd4?=
 =?utf-8?B?TDNiQWdPRjI4cTNha1k4YlE5Zi9uYm1SV2kvRWtROVN3cE1uS3NHb3hnU3VL?=
 =?utf-8?B?RDJBUmtmMjVVcDJXV1ZRUjFXSG4zVUFTTitCTG1aSGtVTVNiRkpZUm50OW5n?=
 =?utf-8?B?aEQxRFZGSDQ3MlVGNE5JVFRiZi83dzlIVWFWTlJJVXN3dGo3N3Q5L1lJTUpM?=
 =?utf-8?B?dkV3Y0FMVTJMa0ZiVUMzSlJvaDN1K0JuaHl3bzVGekFidXc3WVJFTUhOSm4r?=
 =?utf-8?B?MytjRTNpdVI3ZEQ2UmMzbXVMa3ovUTlLbW5JdEhEMnBKb2hJU0NPRlhxTWcw?=
 =?utf-8?B?S3NqOEd5akNINXd3WWIybWR1cmdNKzB2OUs2L3RqbUdHWm5OY2xTcUZ2MUJR?=
 =?utf-8?B?djBST2wzME11V0xnOWR3dDFhcmlYNWJ4Q29xU05keUt0ZFVhOUw2cWlZQ3Rj?=
 =?utf-8?B?WCtOU0treit6eTBUemJMbzhiUnlCR2Q2emNSc256a1dqRWZOYmdNTk9hTjFE?=
 =?utf-8?B?RkRVc3BaRE5NZGlCSWxDT0lUZW9vNG52OXpNRU1kREpJSS80SEtNZWRTZlg2?=
 =?utf-8?B?NnhlWXRMRlZpY0ljajJWdXNkeTJic2JZMWdLWUsvNjJGLzVPQlh1TW5xcTFM?=
 =?utf-8?B?bGx4SlcwTk51L1NvSE5rKzN6dXcyN3JxWXRjSjVDTTUrVDhtZitqaVE4aGFM?=
 =?utf-8?B?N2szTFh5OUNCMThXMUdVK1YvZm53aW9HNG1ZL2pIMWZjQ2wrK0FiZG1YNUEv?=
 =?utf-8?B?cjRmd3lSVUhRRjhQK3BTOWVJS0hlV0llUnZ4Z29pcDliL2E2N1A0eVRka0Ew?=
 =?utf-8?B?dmlJU0orMURCU096a3pEUUQ0R0ZpLy82ZU5KSkl3MVM3dVhFVUYxZ1UwYTIr?=
 =?utf-8?B?MmRnNmdXTG1YR3FXek5hanMrSlhXSHlCazluYnVtWEdldHhKR0hFaDFzaDFE?=
 =?utf-8?B?dEJZelR0MGd4OXdZYjN5YUJTaTVUS0h6RE9NdU5uRzVPdVBjUlpiVnhOYklP?=
 =?utf-8?B?Y3NRY1pMUGd0NTllYUpEMDEvNlVxbGNSL2JreENnNjYxbWwvd3ZEUnBSWDJK?=
 =?utf-8?B?ckhRWTVZTjFnRWRBRXFadHJ5Tm8zWW1uUytBOFhJRU13ejNRb0hlUk02dWp6?=
 =?utf-8?B?dVZWaXZtUjJFNlVQS0Vta0JTRXJyeUk1cEU4cnJqbHhOa3BqS3JqUlpIM3NO?=
 =?utf-8?B?blB1c2FSWGxQaTc2M2ZpY3ZINjhhRU0zaXAvL0dnU29JejJlOHd2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24fbbe9-c535-4375-675a-08deff3dd6ed
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB999075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 04:36:59.8142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDmbVQsB58t46KIxLLbPHcT1bYjj+W+VwxJtEHmKzRFaNrZPbYqAwCotEuedD1jAyHz8mwhoewlKhgohKQDnuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245

Hi Krzysztof

On 8/12/2026 4:13 PM, Krzysztof Kozlowski wrote:
> On Mon, Aug 10, 2026 at 03:34:50PM +0530, Golla Nagendra wrote:
>> From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>>
>> Introduce a new compatible string amd,versal-net-dma-1.0 for
>> Versal Net ZDMA.The new compatible requires xlnx,zynqmp-dma-1.0 as a
>> fallback.
>>
>> Add a reset property to describe the per-channel reset line exposed
>> on Versal Gen2 and Versal Net. Mark the resets property as required
>> for both Versal Gen2 and Versal Net, and not applicable for other
>> platforms.
> 
> I cannot find previous discussion in my inbox and cover letter has no
> links to previous versions (when finally will you start using b4?), so
> you might get the same review over and over.

Thanks for the review

Please fin the previous version lore links below
https://lore.kernel.org/all/20260525105042.2249542-2-nagendra.golla@amd.com/

https://lore.kernel.org/all/20260618071056.2024286-2-nagendra.golla@amd.com/
> 
>>
>> Note that making resets required for Versal Gen2 results in an ABI
>> break but this is unavoidable. When DMA is used by two software components
>> back to back (e.g., firmware before Linux boot), DMA functionality fails
>> due to configuration differences or the DMA being left in a bad state by
>> the previous user. The channel can only be cleanly re-configured after
>> a DMA channel reset,making it essential.
> 
> So this was never working? What exactly is unavoidable?

It does work in many scenarios when there was no other FW using the DMA 
prior to Linux boot. But there's no guarantee that the channel is left 
in a clean state and we have observed error scenarios where a reset is 
necessary before Linux can reconfigure the IP. We added the reset to fix 
this and hence making it a required property is unavoidable. We are only 
doing this for Versal Gen2 and Versal Net where this provision is 
available. We are unable to enforce this for older devices because there 
is no per-channel reset there.

Thanks,
Nagendra

> 
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
> 
>> +    then:
>> +      required:
>> +        - resets
>> +    else:
>> +      properties:
>> +        resets: false
> 
> Entire allOf goes after "required:" block, by convention, see
> example-schema.
> 
> Best regards,
> Krzysztof
> 

