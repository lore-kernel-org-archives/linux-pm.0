Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794923504;
	b=0KIEfMc+zLomlMk99fYkqu0IQAiZmH9OL/8YT8o7eKnUilc8tbL5d6TMuNvceGI/tdrK
	 rZ3Eux5XnRikRccUUt6cFvKCGbbilyPk7IuW74hB/jfKuuwu30VoXXtle4ga8gDl7s+1Z
	 hmSB/9r1xaU04yM77vrFOSsU4XVxeFrIH/KJ3pFO+AceD2KtpA1YOF26CyF5DfpMf7VaQ
	 jOYjjUls10xuVoRGrSanN3C9kTCy4+pHPXUU+epavUkmG0aNFmt9vtKRH+kvjzV1zQ0ym
	 J8PNswNGR/UNNhnpWpwjxwqP5BIKhx1HUPiQUGJrw/is6lMYf8Pe+x26ufSBlG93MEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923504;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=OVn6R3nqsUq3DyCmwZqtFrwAH76VSe4Nbh3fg0qKZu0=;
	b=h4xUmfXAZPaP0oRmXgBF1U94gV1LGLwRptz+v+a+qAypD+ol6JsGBK9K+zKQCHV+zAjf
	 lq7gVIXoCeGFanA+RUIsaWPgah6V26Gwx+pWLZP8/XY9hQju8Itxk6iZeV4awMe/hrAE5
	 Rf0h7HN8aSLFLw1UtXD2mYYlexNhz843HJkv2iefu4RxT5qBGFK+eD7/esfmreEbKyr3T
	 BqpX0XEUNFTAgyNnx9BAzWPq8mfk4sDh7Yem+MOMXyV42BDoZ2KAtlk6MUkaP2UpYdPe1
	 EE9CB7WLHagfisMh3h8s+/f+QitFU4oIgk6Cj8ubFIseP8eeDdnvg4c86KZpL6594Cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XhFq9qz7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.64
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A5A606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 13:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5A5A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XhFq9qz7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RABlaRNapu2UVEq3GcNC5lJ6Xc7PYUoNN2+uwSrBiCn1SJoXIxaBr/jzwxPMrjUva0j/TsqT2wbbR9ckDb6VdSRcIcbnReOd76xwVWGOLmfSDuECOO9zA37IHGmrWVZE4uH9PEoOyh5l6mgIukjxJw6reE9sF81rAMRFCGnL1CwRhtacGOf5/hl7QYclzNHHwXnUH+Ry01NSJslDUQauThXlUnDSSlBUIs80/Vxqb36nRB+6KBBntJkM+Nv9ATWSTtUl+FSPLoWtHuZ8JNUOTQQLFvZVUg62LLROJxcxX+ZlhDTNytUypW1e9Fjnemc9tP/EYK0bvV0k+46dYANARw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVn6R3nqsUq3DyCmwZqtFrwAH76VSe4Nbh3fg0qKZu0=;
 b=OFbQBX79A+6nxNv8q47PdlmZ6rxVmuJTxFRSYG7A0j42+qhOLw7JpJ2nvGtHt1E7H263Ut9q9ViZrjWBfybSa5gPiUY+1//052+g4tgAXD7TDpKEfImLt/oQNn6yqgIjrVaWmHuhZv+OmfomikFpdeBBzqa9GoijirZTfJvZPjRLM9TQXa8C/Jw74bjfAwNnfitovMp1mx7C3o9A3bTeZTm8/g9jJUxPvfBdql3yGp8jSj2jeAc7x+6QbTqbRDQqkRgRYnVeNiZaP1szCGXA/7+AXUiAki3+SuMCxmYO8NevHZyVh8DOJnbJVc80cVg3x2+8ZR64TmTd13fsv1pbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVn6R3nqsUq3DyCmwZqtFrwAH76VSe4Nbh3fg0qKZu0=;
 b=XhFq9qz7BsaheczR7ETT9JLvHoHg8GTdGB3M0om3DfuuaaGlSoTdjDAPdHVWCZLSZ0FZ+YQpMqpnIUCL5VDx0I2azkgnIjgWn6n5R7rxnKtiLCtF15OoyoXr/hIpkAx26jZAVWzQiOlZ+aPmvUW8gOXfb99IwVRVs+XQampVa4M=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 13:51:35 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 13:51:35 +0000
Message-ID: <3e227f3f-c944-41f6-8449-ae8d15266f53@amd.com>
Date: Tue, 17 Nov 2026 07:51:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] cpufreq/amd-pstate-ut: Restore EPP state at end of
 amd_pstate_ut_epp()
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-pm@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-0-682aefd4fed6@amd.com>
 <20261116-superm1-linux-fabc6bcb-984e-4ba7-bb57-02cc3af08fa7-v1-5-682aefd4fed6@amd.com>
 <0e754ab7-6a47-4611-a35b-6fd9e88bda50@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0e754ab7-6a47-4611-a35b-6fd9e88bda50@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:806:120::13) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cea234-b049-448a-d716-08df44b1e520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261028144727099003|261026140227099003|261026121527099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	YkPtRkDkWTFHHn+EVhoP0qEOZ/yWfRiL2i3scljVrji7pu2zRylBsMnO6A1L21KxAudfvg3GpORlIwNriWRZ8rzjUp0xLHe4X1d3zWi5M7TDfufO9d85FVGRmyhjGywvcFi44kL9nbpU/BIqSdTHT7Jrw7GBJEg6jALc1wo/kvx2bqqLOsWq5NZ+ZYalpLUiJhwK3f2Ce0niZyK0PwvLA/ErLIUUMbz3UDSL+DMr8ACDRcY7WNs0GwPDS6DKxbbo/nYdQ5w2N7fPRGRiyTIOtIps/M+e5cxTzREAk3jVh/K7oB+nGeU7TkFA0Kis1fuk4FmMT446Q4xgoty9VRHrL58HOx5NYZMOimqtSC044lp3zUnBNlZ7VaNr5cQMQl9QWtXG6MNzM+8Roah/eDakW1/gh096IUk8FmL9KTTC6U9vIrzSPDlhdbhTkIxN40WVnurgYlTIHmVmx8BwSSPH4jGAyLpptSM6i+zweXXvngup6yzFcZGW9n1M4vSEIRgTashrkw+cnmPb4QJkV5MOULqBUQiUIYo0NF/FX8rwVdx3kJXEhz2jz9Xe0NZejbhKcServoDFz5fRC5b6E2Ao+Jt3PCCHpsrz0fWrbh4wf/KekB5EK2aDJqPSNBzSaJkpNMtG0fC09Iac7BPOdrpJXxBZ6ZtMdDFUGlUTNKqDaTk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWs0YzI2RkJwckVTTGZUZmh0OXdsekU1aVYvM3U2RFF3dWkwQ0Z5WEZNaWtz?=
 =?utf-8?B?R1dWZzRoYSt4ZEZGa01PV0xwT2g2ZjVRMGN4czBnNGM4Qm9uWnFBSUN6L3J0?=
 =?utf-8?B?ZHF4Ym9iYWl1YW9TcGo1bHF3c3ZOVzltN0hWNTZKWEh0VC9TdG5JWWlRRk1F?=
 =?utf-8?B?OXFGam5zWG9YRithQXpWV0hHUjROK1Z2R29ReUt3ZkJrdnFnQ0FqQmRHZWtz?=
 =?utf-8?B?RENFY3JDMnJ0VTVaSWc5VFBQL2dpVjVlejY1ZHZLYVZ1V08zTHd1eEtCTmo1?=
 =?utf-8?B?c1ducWY1OHJoNDlpeVgyMHUyUVZmRGZzZ3p0L1dmZWtDS1MzZ3N6aXVycXY1?=
 =?utf-8?B?Wjd3UXRTRWg3dnJ5c2NsdnRVR2MzRVNOMTdRT21VVm9IckRXRU5IMjNjcm1D?=
 =?utf-8?B?bG43dmFqN2JRYXAxYklwN1FVV3BWbDZCQmttY2huYkFuRUVuelhJYy9MTHly?=
 =?utf-8?B?RVNZcFFiSDk2bVBMbGpjMFQ2TklCQ09CMmFpN0ZCL1c5M29yUzdqMTZQems5?=
 =?utf-8?B?U1pqNjNaNmV0QW10OE9WeElqNzNYcXNWQ1dzNFhHZzVJUXlWTXFGVmU1RWZ3?=
 =?utf-8?B?WFVmY0Q1WkwyM2g3NGtzTG5Qcms2K294QnRhU1JtRFRkWldCNGZiblo4NUVR?=
 =?utf-8?B?K1hlRnBIRmVlWXVjUDhKNkg5QXh1UC9UYjBtS0wzbk9LZDc2OEhEOHBYbFBt?=
 =?utf-8?B?Z2lvMkdTNS8veURYa0tmVWptMEZ4Tm91b1docVBrSXM1YkdlL0xDSS8yb0l2?=
 =?utf-8?B?bmdHVUp4RGpZYmYvTzZkaWtsSkM0Q3VVWmhjNTF1OGNMRUkrYlJHVlE0Mk5l?=
 =?utf-8?B?dTdLOHY4WFhUM240dnNkVjZ6aS9wRENUR2E3UVhkTnRXZ1dPbFlFRUhJOGlR?=
 =?utf-8?B?dWhKbjBobCs2RXJTcW5kc0lqQWxGZFB0MDM0MjFycU5QSmJrRmJxUzRCMjZB?=
 =?utf-8?B?RU9TZGhNaDZJRUhmWVIzU1YxR3Q1VGdraW5jUkZ6aGpib1BDK1NiazRHakhT?=
 =?utf-8?B?eDJhdUVnYSthb3huTGE5NXFiTjQrdzZoOHBXQ0N5a3liNkZaYXNwalp6RS9m?=
 =?utf-8?B?bmZCb0tyc05ianV5dVVpcDhWRWU0MEZqQkhPOUJVNFVQQ28rSVZCNjZTdnVT?=
 =?utf-8?B?ZDN2M1k0eDNXRVliYVR3NXVWbDJZWUp5OGV0TmRLVS9MSCtDZHN0LzI1U1k4?=
 =?utf-8?B?U2kwaDJPdUhxczdueGhyZjFsL1RiN3ZJa2g4dVNFaHpwSXhBYlZ0ZHFSd1M3?=
 =?utf-8?B?bHdQamZCSHVlL2dMQTkzSnAyK0VxY0FCd3lEVzQ5emlJVGRneW5Fc3dNaUhY?=
 =?utf-8?B?MTlqVXA1M1hCOE1LNXVoY3BzY0VoWStHMDhpRDE5YVFJT2ppNExRdUw2a0NH?=
 =?utf-8?B?MFlROUN0NFZWa2ZmMDFmU3AwelM4eW5BSlE0VjRiT2Qwc2xVckhXTlFucFk3?=
 =?utf-8?B?U0ZUZHQvOGtLZlJMc1FKVmxmQ1AzU0orOGpMVExZNzVyT29KZ3hMVjRCL3pP?=
 =?utf-8?B?b0N2d3JtVkRaUXkxS25JZW96RVVIZ3k3THgrcTN5N00wc0Y3b1d4c2RsYTEx?=
 =?utf-8?B?RkxIV2dNbExyeFB1R0VlcE42Znlaekt4WGEvSWs3NzMva0M0VkZUUWhhbS91?=
 =?utf-8?B?cUdKZXY0M283Z2o1eFVIZzVTbUsrdVdETHhhd29rWVBKZkZNK2FGSWlJdXph?=
 =?utf-8?B?UVU1M1lWUmNBUzFyaytnSElEMkFBYjc1bjFwUXplL0JQeDFWaDIwU1Azd2xu?=
 =?utf-8?B?REJqdHRpVERja0MxMGJFVXVHUGd1N1k0KzJ4dnRmVmNPZlVrejRPT0dVQWpl?=
 =?utf-8?B?VzR4YWZYQTN2QUN0K1pRZGFROERYd0E0VWg4TlpDWkVJdHZYaVRVa1VleXFZ?=
 =?utf-8?B?MFRTOHA3dGxQVEtvL1c3UGI4dTlkZGJkZy9wNS85Vm9UTDc1dVV3d3E3K0lz?=
 =?utf-8?B?TzRyZi9OYklpcWtFOU9MRHo4a3RiWXdBTnUrSXpLQWR6d3ZsUGVXS1UvUTMr?=
 =?utf-8?B?ak9pS01ra1dPMjY3clVCSVBtcTZvY0JOVVpBS2hycVVlelhSWXRTaSt2eDkx?=
 =?utf-8?B?YXFWSVl5QVNxUUUyZ1hNdkFmNUlSWTZJeFBUSVRFTURaekFtWHFmNEpIWUY3?=
 =?utf-8?B?VGVkQTJJc3dHZ01MYS9BWmJXelFITnZBQ24wdFNLT29tY1NoTkdYMU45L3E2?=
 =?utf-8?B?cFZDNTE4TitMcGZOS0F2MG12ZThsRWgzRmE0NlUxOEQ4R3hDdis4RS9BbHdk?=
 =?utf-8?B?a2NEbUZRbisvd2NvQVdkNWtoME13ODRGb3UrTTQwOTlBbk0rWHVtZEw1U2tH?=
 =?utf-8?B?N0h4UEJCNnlVSGZSWmduSzhGdm40TVN4dm9CQmhjaENnN1VSTmdCZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cea234-b049-448a-d716-08df44b1e520
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 13:51:35.6090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3oy1kdbcyo0BgaiYpdOgEdLkE3Ad9pzwWmg07qN2Mew6tHtnGsQ+ILeB4DMuFcjgu0CotLjEXhI5H6POb7+8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337



On 11/17/26 04:03, K Prateek Nayak wrote:
> Hello Mario,
> 
> On 11/17/2026 9:07 AM, Mario Limonciello wrote:
>> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
>> index 506d7bb2e6609..a861216534b55 100644
>> --- a/drivers/cpufreq/amd-pstate-ut.c
>> +++ b/drivers/cpufreq/amd-pstate-ut.c
>> @@ -315,6 +315,8 @@ static int amd_pstate_ut_epp(u32 index)
>>   	struct cpufreq_policy *policy = NULL;
>>   	unsigned long orig_dynamic_epp = 0;
>>   	enum amd_pstate_mode orig_mode;
>> +	bool orig_raw_epp = false;
>> +	u8 orig_epp = 0;
>>   	struct amd_cpudata *cpudata;
>>   	unsigned long orig_policy;
>>   	int ret, cpu = 0;
>> @@ -329,6 +331,8 @@ static int amd_pstate_ut_epp(u32 index)
>>   	if (policy->driver_data) {
>>   		cpudata = policy->driver_data;
>>   		orig_dynamic_epp = cpudata->dynamic_epp;
>> +		orig_raw_epp = cpudata->raw_epp;
>> +		orig_epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
>>   	}
>>   
>>   	/* Drop reference before potential driver change. */
>> @@ -425,16 +429,27 @@ static int amd_pstate_ut_epp(u32 index)
>>   	if (policy) {
>>   		cpudata->policy = orig_policy;
>>   		/*
>> -		 * If the driver had enabled dynamic_epp to begin with,
>> -		 * restore it here before dropping policy reference.
>> +		 * Restore the original EPP state before dropping the policy
>> +		 * reference. If dynamic_epp was enabled to begin with, enable it
>> +		 * again. Otherwise the test may have left dynamic_epp enabled
>> +		 * (leaking the platform profile device) or changed the static
>> +		 * EPP, so write back the original value, which also tears down
>> +		 * dynamic_epp.
>>   		 */
>> -		if (orig_dynamic_epp) {
>> -			const char * const dynamic_string = energy_perf_strings[epp_modes[0]];
>> +		if (orig_mode == AMD_PSTATE_ACTIVE) {
>> +			char restore[8];
>>   			int ret2;
>>   
>> -			ret2 = store_energy_performance_preference(policy,
>> -								  dynamic_string,
>> -								  strlen(dynamic_string));
>> +			if (orig_dynamic_epp)
>> +				strscpy(restore, energy_perf_strings[epp_modes[0]],
>> +					sizeof(restore));
>> +			else
>> +				snprintf(restore, sizeof(restore), "%u", orig_epp);
> 
> it. If we restore the original epp via a u8, this will always put the
> driver into the raw EPP state - if user started with performance,
> they'll start seeing the raw value if they cat the file after ut run.
> 
> How about, restoring the actual string like so:

Sure I'll roll those in and send out a v2.  Thanks!

> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index 506d7bb2e660..bc696f452749 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -311,13 +311,13 @@ static int amd_pstate_ut_epp(u32 index)
>   		EPP_INDEX_BALANCE_PERFORMANCE,
>   		EPP_INDEX_PERFORMANCE,
>   	};
> +	char *orig_epp __free(cleanup_page) = NULL;
>   	char *buf __free(cleanup_page) = NULL;
>   	struct cpufreq_policy *policy = NULL;
> -	unsigned long orig_dynamic_epp = 0;
>   	enum amd_pstate_mode orig_mode;
>   	struct amd_cpudata *cpudata;
>   	unsigned long orig_policy;
> -	int ret, cpu = 0;
> +	int ret = 0, cpu = 0;
>   	u16 epp;
>   	int i;
>   
> @@ -325,14 +325,36 @@ static int amd_pstate_ut_epp(u32 index)
>   	if (!policy)
>   		return -ENODEV;
>   
> +	/* Prevent any changes. */
> +	down_read(&policy->rwsem);
> +
>   	orig_mode = amd_pstate_get_status();
>   	if (policy->driver_data) {
>   		cpudata = policy->driver_data;
> -		orig_dynamic_epp = cpudata->dynamic_epp;
> -	}
>   
> +		if (orig_mode == AMD_PSTATE_ACTIVE) {
> +			orig_epp = (char *)__get_free_page(GFP_KERNEL);
> +			if (!orig_epp) {
> +				ret = -ENOMEM;
> +				goto early_fail;
> +			}
> +
> +			ret = show_energy_performance_preference(policy, orig_epp);
> +			if (ret < 0)
> +				goto early_fail;
> +
> +			if (cpudata->dynamic_epp)
> +				strreplace(orig_epp, '(', '\0');
> +		}
> +	}
> +early_fail:
>   	/* Drop reference before potential driver change. */
> +	up_read(&policy->rwsem);
>   	cpufreq_cpu_put(policy);
> +
> +	if (ret < 0)
> +		return ret;
> +
>   	policy = NULL;
>   
>   	buf = (char *)__get_free_page(GFP_KERNEL);
> @@ -424,17 +446,11 @@ static int amd_pstate_ut_epp(u32 index)
>   out:
>   	if (policy) {
>   		cpudata->policy = orig_policy;
> -		/*
> -		 * If the driver had enabled dynamic_epp to begin with,
> -		 * restore it here before dropping policy reference.
> -		 */
> -		if (orig_dynamic_epp) {
> -			const char * const dynamic_string = energy_perf_strings[epp_modes[0]];
> -			int ret2;
> -
> -			ret2 = store_energy_performance_preference(policy,
> -								  dynamic_string,
> -								  strlen(dynamic_string));
> +		/* Restore the original EPP */
> +		if (orig_epp) {
> +			int ret2 = store_energy_performance_preference(policy,
> +								       orig_epp,
> +								       strlen(orig_epp));
>   			if (!ret && (ret2 < 0))
>   				ret = ret2;
>   		}

