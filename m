Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDBE432E79;
	Wed, 23 Sep 2026 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187084; cv=fail; b=aaJgODV3H8kRWj/JqAWO3zNLyq4EhwwEDF6q29SvsBL2bAlxp1pmkSYnaD8K04GMgNO30J87rkxI+J/QZM+NBSjqIvp7vefzOK4c3jeifye25jz6rqks40vS6YH4SKNxhKkQRZVh7K7/TZl8vcTL7FFmwqYscs/Ux5KwMwMTYN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187084; c=relaxed/simple;
	bh=o2NierycwLBSnO1ObqhQyh/THCsRfqfaWg63POWGTZk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J50wLJ+lXY4ObORAys95LW7dCMVFUw7zXu6yS7dGE7GrnsbpuKjhhxwHgzr2TW5t5F5S0yCmsBH4lI3kl2twxmSx4nVFyo381fMMeljVZWH7VFs4Dx/kCEPl7qpW3Pb/5mhS+Y4mydmyrzDxMwkLp3aYAeOLm0VQ9YLIpv+MFmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yzI4eZP3; arc=fail smtp.client-ip=52.101.57.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yzI4eZP3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ve/Naq809oCR5n6EeIdIteMZFgKjRM4uAQmSG/Dk7wopgQkTbJtoalRrcpGJeHxU7nUIgUc0/zKEGfIfeTpbrdq3DcTAam2i+t+bG7N/n7eTyHUQbIF1HOxq6bDVupiqE3QNeocN4mvalRWzH7aX0o5q+7ltK+wOKz/0Ad8ZFTY6UquuWMLlsS5SzekEwu7cnvW3RyB4BMeHzSVJCIGtlxv2DQlhdoox0as3TwZFhngCtUNkLqYcWOTUHv6SlsxdpKGo7YFNNdZFtCXps9AxDq+/Tt7KUlR2mOgxjLx8l/W+dsd6/2rv7gmQRHcW6qMCorDR3KQtoI3k+VOdhO+Kkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8Pg+w5OlOIt8oUfxxgKFc6HPcDpiBpJVky19IuKnE4=;
 b=Uv13xwqMVivG8es1wlKqCxowpqJsS/7EOeLWohFpmHK8rVgEEr7vs2dGJhqiD/r9ZmtmwrN43TuSIaKwwbc/tJWNmQQEAJGW72mRTdJEV/xR+nUFlYs8iDLngBBMC9Qwla7TWOtlRxv8Dt3qkH5zqrWRikI5I73DI44zTqxV9cZbcyXSmh90b3KJrmgABqeyx7u2MWySCI6P8I4nrRdFDn5tBi4uHP+zA+kuuJnnZSYun9/qReLwpZW2w8LibSrjba6gSnwoYOHCv7lUuDWp+LRldqOaMlliij92R9ReXNPSjNFOpBS4fInFSyflawEpQQrtZxX5OW2qyXNLIV1Z+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8Pg+w5OlOIt8oUfxxgKFc6HPcDpiBpJVky19IuKnE4=;
 b=yzI4eZP397vvbm4RS7MRopu+HraI4gaim5fL/kQziHhbtLADAsS1bCXL0vPcTPbQDmOcHFgJDMcqEKYPL8gxHS99S9fiVYoTb30IOxhLsYZzzCPOBLwVghljgeziwhASciCc1uBXGONOOEaY7kOpUoSSzKPESz8jnZfSbVh5a40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:11:17 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:11:17 +0000
Message-ID: <60a5c26c-8fe2-477f-b576-2a18d8b6394d@amd.com>
Date: Wed, 23 Sep 2026 13:11:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
Content-Language: en-US
To: Fourhundred Thecat <400thecat@ik.me>, platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
 <8a5bef53-cae4-4aa6-a657-d11a6831d2b2@amd.com>
 <7962670b-168e-020e-b55f-c9ea49483f6b@ik.me>
 <bb82702c-6902-491a-8eae-2b90cd8c5c5a@amd.com>
 <4d377d87-c2d3-5541-53af-68c9d67daa72@ik.me>
 <55854916-292a-40ae-8421-1a784785d899@amd.com>
 <f872d7e0-79f6-911a-b0c0-639c58e780f3@ik.me>
 <66dee9c5-ad66-4bd7-982c-c5694d806cf2@amd.com>
 <0bb77796-790f-44db-b4cc-e4742ed1b2d0@amd.com>
 <eafbba40-a10f-6a7f-54e6-b14d59ad1525@ik.me>
 <99dcb462-5045-4fa7-9f6b-ee0f13ff96ab@amd.com>
 <4a161dd5-4dfe-81f4-e4d8-ba9d3280c25a@ik.me>
 <6d7773c8-0dc5-4e11-8bbb-088289dd508b@amd.com>
 <a5611ca8-b28d-4102-0caa-542fc162758a@ik.me>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a5611ca8-b28d-4102-0caa-542fc162758a@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:208:239::19) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: b1554070-0365-43f5-ec55-08df199e0fa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	wCNgxtUijpUSqEb3eOgq7R9YGl8HyLGZMNyLTHEYmTy+O6bACG1GvqpoflOQPdBZin7u0Bu897o54taywWK3Kg+aFS0V5Ptx1vSGujIEiL9P3HXFOozFNvQ1HxocCkWl4nPFVoUsnty7VH6Qto6zim9sU9gOaRMUJDhJ+zCjdwS8xWpEkrbG6NxG5xQb2hMtVViA+eT69sruhJohSlKXbJ/TP72ZZSx0/FPRzP5qX5cY5cZJXIpuSkKCSCeDIp4hZlanL3tsLE8WfQtK2c6Z0U+Wca3v7cIkI8kogBUnap5NaP6+LldzC5vc0rWpLEDaKyHtQVVMXY04t+inYPVlq16NSHZ0/cAkPopH/IX1JXTckCTjs3UZXyx9wCWDRLNVt75ycOlLXCY/p/ApS5kYMiTAF+h/dJMxJHH3WFapMI8lQ5csD3/qQ6qoEGM8cE9HTQ3Zs3dxPiP/tnLMc+b0uLOy1SIN9K500hDsDwBrOlP2xQh0qjRn3n0o01rY27pje6PBXunNFN2bUpknNNXeZ2TfFIPxQyXyPvCwHzI6CkNUcRwqZrlJGWTe8QLycTAYtwB68cuXtnKlBMUgfS7RHA0gsQkweNbMVDSYvS7E3+wCUl2AYnV3CNA+a2QaXwPAGXwPzaqGQGCmIRKFSI3FNbslwNHGSJEfFpCNZEwxidM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVBUNkVnSWdpMFBoOFhNR2szV1ZLL0h5OFpJMlNMY1RDbG94TkJYSXpwYmo3?=
 =?utf-8?B?V2UxMHlCR2p6aXNWN29iRVRKOTV4SER4dVlQaGdvcmo3WXFXSUhBVThpWG5r?=
 =?utf-8?B?cnQwZGVxSC90azJyR1hQVmpVM2VzY09QYWNtbkJnZFpyM1d2dGQ4U1BNaWEv?=
 =?utf-8?B?eDBaREVzaWozYnhUSk9yV3ExQUdqeTEzbDR2QTBwR2tKQVNpRzMvQWVxQ0JT?=
 =?utf-8?B?RTNNZTNZVXRXSGx0OEJ6N2FOL1pRTUlQSlF5Nm9pT2pucnd1eHRHVmswQnBN?=
 =?utf-8?B?NTlaNzhQRXM2WEE5R2NPM1lxRXV0eEVnMlRLR3hHMFplNG15VTBDenc3YkMr?=
 =?utf-8?B?QmE5M1kzNC92V0o4amFSTzNWUTdmelZraktrYWRWUFlMWXZrcnVaT2tjWnpH?=
 =?utf-8?B?b3B2VDM5Wi80bUJlY1ljR1ZCM2hhdmw4c2xIaUJpRml3OSs1OFVSdTBOVHVs?=
 =?utf-8?B?bnU4cENnOC9ZMnJ1SUorYzdHbG1EUE0vZ1Y1RE9vQ2RWRDZNRVI1U3I5MnNz?=
 =?utf-8?B?U2NVallSMWhYSzdUTW12dXpSZ1R1UE50T2VWdzV6SldHYnJNTTdEYmQ4c1Bo?=
 =?utf-8?B?VkJiMnM5cHZKNUdESVo3a1JQek9Tc2Q1T3N0Vk1Idm9UWHVXMWt5dStzQWp2?=
 =?utf-8?B?L2M5TUFENlBPZFdGWTBsdGEyYU1lQ0lOYWdKai9GaVh0T0FMbG9KU1N3VlRx?=
 =?utf-8?B?UjRibUlrWS9zaEcwanppZ0k1czVzaTVQSWhNOVFCdVpWKzNWTy81N0hQWGNF?=
 =?utf-8?B?c2NRQ0pKeXpzYW1rdnczWmpMdHdESlVTZXpPZWMzTHJ2L09ja1hoWVZxNGNi?=
 =?utf-8?B?WnV3dUZkNURkSjN1cDdTQWF0aUxkdGhGZ2Y1UHBSQ01mUVVOcGl4cmtKYXJk?=
 =?utf-8?B?MTUrZFRDRGJ5YTdUWlprT1FJM0pEaFgvK3NHeWIrbjJWUFFOZ1JJNkpmdm54?=
 =?utf-8?B?MllRSTJHZ3p1TTNEdG1TREhvNFlRMkxvUEJpazJseUZ1bkhDNWZhZnZ0MFMr?=
 =?utf-8?B?ZEt2MUU3RGJ3YU82SHk4Uk43MHI5YldFL1BqVkJGRVhKclJET0FKNXRwS25H?=
 =?utf-8?B?UHB0VzM3T3ZKYjIwMVRaTTRrQXRUYVMzZmF1MG8xaVZVS2p4TTJud2VHUCs0?=
 =?utf-8?B?bXIvK0ZhUG12NDRvbVpPbFdFdXZ1Y2MzYnlHZ2VJNFdyM2ZqQnFDdHJOa1VO?=
 =?utf-8?B?WW5XeHpKVFVOOGtPZnBrc0RmRU53enJsK1JJYU9uZmZZQTlCODUwOFhkSVoz?=
 =?utf-8?B?Y0hkT3prcVl5c2VHdm1RYlp3NlJEVVlyVUVCY0k1R2JZd1BCWU1DRklOK1Vn?=
 =?utf-8?B?TjlaQ0VWdm1BYk02NUtjMzFWblRDdWVEdkJ4N1k4L2w5Qk9EVWE0UkovNFkz?=
 =?utf-8?B?cUlWNDNOVWYwaWJrUVJVRFNrN0t0WTRqaGdLclM5SjVMQmwrTlUySjI3eEJo?=
 =?utf-8?B?SWxXYTB5eTdsZmQ1R3N1MU1XdHRVSjAweHo4RENZakorMzhDcEVWdlZOem0w?=
 =?utf-8?B?d3h4ZGxpQi9wUXk1R1RDVGFUQ1RhVkg0VkcwOFYzMXVEaFNxZWwvMGlFZUJI?=
 =?utf-8?B?TC90bUpTMmVpcVRUOU1VV045aEptRmVRd2Vvc3dtdEtWNVE0MjVPNGRwV3VG?=
 =?utf-8?B?NWREUjE0QnRyZVV3NHpwazBkNG41ekNKeUVPajFxRCtSWVJJTit5amZiT2h6?=
 =?utf-8?B?QmMxTTJURWFGZGFkb2VSVkowSHRqKzJHbGFtTUVKMXkwdUlrdVpiY0orSms3?=
 =?utf-8?B?RTFrY3BJS3djcjVrbGtVOXFYZWk3NWhMbUxvSFJaUlpIWG1PQmRqOW5SV1hx?=
 =?utf-8?B?US8vMlNYYXM3SXA2Yk5pY09EL3ZjQmNLLzZxZmhValBzbjFyQWtVT3R5azVs?=
 =?utf-8?B?eThhaWN4MG9XQm9XZmovc3RoQzVsYkp6R2xQQTBncFhnRmxGamJEbE5MTDYw?=
 =?utf-8?B?QVkzTFJ1UUdkcDhqb0h3TGdYRWt0NXk4N2VCRHZEMEVOQTdhaXI1cTFmNVow?=
 =?utf-8?B?bHNqaVA0bkd2cmFUK1lIRVJpK2xzN3kzN0xCc3VoTHQ5UVVjNUlvNm1GcFJx?=
 =?utf-8?B?THJtMVFRYjZNcFk0STh2cHRvQkp0SUZlZzR4UGQ1NEVxZ3lZbDVGRStSR1lY?=
 =?utf-8?B?cGtrNnhzU0VtL01TVEFENzR2TmxSSkJtVlV3TnBVZlhJcDFNNU5QeFNZMWla?=
 =?utf-8?B?akcwMUVuTkRDVVRCVjdzcFlSbEphbnR5UldFUitQcmFiNWZYeU13MzBMa0Ns?=
 =?utf-8?B?RGJqVkQrbktGWERXa3F6Rld3UUdUVGNKb3luSEhxK2lNTUpVbkRNZ3VYYlRK?=
 =?utf-8?B?UmszZ3IxeUU2WFQveFBOWUt0M1ZDdjdlSGM4bUtRUlZQVWxhNXViZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1554070-0365-43f5-ec55-08df199e0fa5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:11:16.9838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpvZNIXL8+tNxlIXiC/2ce3WMRIOKRPPbWAnlygxB99cxs1V4TBou11VV7p4D85aciRN5jtUBadtp0tbETY9Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781



On 9/23/26 13:02, Fourhundred Thecat wrote:

< snip noisy LLM interactions >

> I will boot amd_iommu=off next and send the same counters plus a full 
> amd-s2idle report from a cycle that actually resumes, so you can see 
> whether that configuration reaches hardware sleep or is simply failing 
> to get there in a way that happens to stay recoverable.

Please attach it when you have it.  Hopefully something stands out to me 
what could be wrong with the IOMMU here.

Another useful data point will be whether this can reproduce on 7.3-rc4 
with IOMMU enabled to rule out a backport issue.
