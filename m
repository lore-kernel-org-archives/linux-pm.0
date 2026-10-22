Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792645870;
	b=2oUBzPuZAyDS6NxLY6MbhvnaqtKwy/d7/CUb3PQwXAdIsiMNYwk013zKINP7eoGHCFKq
	 dvS5HFtv2LIafctWvPLJmjhMouMm3CsnEJzGFcQzv5CDKV8sMJESRiRrjr1HUcl2K0c+p
	 J47J0usBNACNRC0hO6T8pr4I1oJwNo8wNtG+fMT+eCDI6iQd/A5L2HfmkEArrlw3iswqP
	 DKPXk5GhadZaFVmwMhklJGG3c9pQZlo8GtpNbhe2gJ+H+YUYXq1had99yBUUNq3OQNBRX
	 Gx008H9foeV7Q8DsbeaNHKa9xFxzLR4CTKVl1dDNxamM9p1vhTIDBQMvZmyizYNQpQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645870;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SUPx8zY1+kcUd4Fjaogw3QAnQedY2aoGxBYkMKek8PI=;
	b=CnVUdz1T7n9wXEuHl45qbDUjrRgEBuMqc5TZlXu4anELRyam/xWFuUmJJKtbyJOOmS1Q
	 URuSBJbG0OviLWPFz7S+Sgrhhyo/PO7HxFAtBBlunkBOd6/dypHW+kOwN4nfO+DcfndFC
	 nsswzaB4IDfZH5vQO+vISSUW6Q8zAqE8m0sj+C3cCjkddIHPYAWFoPDKQ6/ClkgPdigHL
	 Wj4erdHkrkPR5yWE/Rf0KrYZDNhXSNVQiEqBQmbv/uyheh3OdgUFH1Sgx+fYRlPl9Jwvp
	 7XlJd3oOn9jj23o4QKKc87iuyAv/xRl1HYAzCGq/0pp+XulOXmxR3cKEZ+6xWVNpOlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WxELNRix;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.55
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3D606A31A;
	Thu, 22 Oct 2026 05:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48D3D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WxELNRix
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrLdq7AI17IJFe+qHFSUt/JB2QEvBVu3Z2pqR3p00BxXWoRZtojiyibm429GGxXWCnr1e7YEjx/Q/adovySr7BRD2eHcnR4IlSKh0rWcPmI6IXr7i9EFJUA41wCVvUJchCrHRvCteG8OXMmAihKX30fTfFEGEJzlQ2yRHElNa0ghY9wb0mY9n6xYyWU3cbzpMCsBfi9h1Rjr/oENmpa3wV3fWVQBV/ByOIZFUkU22kkya538910QBCgTnm/gfdqjTF6hSKM5JvUuVtTI/tA4H3eLyV8jJYqgTxkypz+Ibl0rYQbCRo09rF+v6B9PffNS9TSXdqONNDN79aCHcj1S2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUPx8zY1+kcUd4Fjaogw3QAnQedY2aoGxBYkMKek8PI=;
 b=icnEXXZBkMMqbnfbJrDWhI4hY1tU8CCC1nmUAidT1SNXBB6jmEwDUdjL9X1pVIFPJwxUVOEisogs3jUop3A6pAGNxIe9+w3+p8faljE4T+e01JHJ2vI0j82HYr3oobCWjciMgqDSeyJ7JP9tbLfVx3d8b1uER2d4sM6LwIa7WAjsePVKqGv6efMj618PQ/zukGiNeUZQ+KcHFU2q4yXlYiuKP1tCr0KdJWJacu7ybZIfsMTAy1AmytCL0J7/X9ILJx9qcJ7a9I6f/c6UBvFzx2oIys0rV7yKJr6lVFt4BM7VArgl+qg810UJRxANoYHjvn8a4z4ca2yFSdubY7cTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUPx8zY1+kcUd4Fjaogw3QAnQedY2aoGxBYkMKek8PI=;
 b=WxELNRixywqfbY+OhXxagc4DvsnbXa48uere/cuguR82vt8EJoTxbzldc1/idu2Q5G6Ih68LNjSS3CxQQmPGdG/xKhA4Y5ZfjC5tQxbstMFM5D/dwPyj//ijeSIPXbi3GGt+VvxgXdSA6d1xgEZKqiU1Yv3/Z2nkioD0olbdtB0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 by BN7PPF7C0ACC722.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 05:11:03 +0000
Received: from DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f]) by DS4PR12MB999075.namprd12.prod.outlook.com
 ([fe80::4c9d:851d:3f44:800f%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 05:11:03 +0000
Message-ID: <212a4fc4-437a-409a-821e-86b9b8c7f85c@amd.com>
Date: Thu, 22 Oct 2026 10:40:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dmaengine: zynqmp_dma: Use PM guard for probe-time
 runtime PM reference
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Michal Simek <michal.simek@amd.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Harini Katakam <harini.katakam@amd.com>,
 Shyam Pandey <radhey.shyam.pandey@amd.com>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, git@amd.com
References: <20261009-adma-pm-fix-and-per-channel-reset-v4-0-55f5fe409c55@amd.com>
 <20261009-adma-pm-fix-and-per-channel-reset-v4-1-55f5fe409c55@amd.com>
 <asmsVD1RP6FoMN9l@SMW015318>
Content-Language: en-US
From: "Golla, Nagendra" <Nagendra.Golla@amd.com>
In-Reply-To: <asmsVD1RP6FoMN9l@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0069.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::17) To DS4PR12MB999075.namprd12.prod.outlook.com
 (2603:10b6:8:2fc::20)
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
X-MS-TrafficTypeDiagnostic: DS4PR12MB999075:EE_|BN7PPF7C0ACC722:EE_
X-MS-Office365-Filtering-Correlation-Id: 27326766-1af6-4b15-015c-08df2ffade51
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|261021123027099003|56012099006|261009220027099003|4143699003|11063799006|261009223027099003|261009223327099003|261009221227099003|261009221727099003|10067099003|22082099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	7+eiMIztOftif+r+52w89RZ/S/ya2IvX//KpqKelSkTu9Eyp/S3HJCnPJeHlX3HbeUMMWTVQ+0VTCAurvY2rUM8kRcGMCsLKTNa9fZIgn0AavvcmBpeUraLLrjptpM2xyMfo7GZxaJRfFkLX+UN7Gj+kTbKn0hFVaLdggJo7fuoEEVJ3EpMJFHYsEtDkKJbfo/qVM/XHlGEvlYm3L+MTg8McOzxaL/zqK+c9GqCL6N6fEeMLWsu3jYmPDslC7epfcdffwqb78y9ZEtkgtaBWngj61QmB6Vei3f96xq0HEBBHDOgNzwKekNhxytF9kjDevNlyASW3BxekNqGxco1F0UfSQV9CLZHke+ryziVYMcaZo3DG2KEhwsnAsct4A4iDFwc3S16BlMkvG4NdaqotRbdpURC+kXNj15mghS6WQ26dzBZdqOh1pIJTmDBPjx2Udn7TWcupsh4DwDcP9uYsAHd3DFVlRs6X91W43dlxDLrTVT+dKvspbrIt2D6Sjc49D13by0odn25BQxoaBvinL/E/7KAzLiojVJxqrAPs4LpioI9GTKXA7ddkLLhUsHRJnNlSHF6H+ea3LGK3jrsA7LZVDT447TystAQjvslwT3/4N1nmGtoOcByzsOE0ST3k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR12MB999075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(261021123027099003)(56012099006)(261009220027099003)(4143699003)(11063799006)(261009223027099003)(261009223327099003)(261009221227099003)(261009221727099003)(10067099003)(22082099003)(18002099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXJORUhRNU1uNVhzSWVpTjRQMkxhb291V0JxQmltUjUrck4zaVVhT1lVRzBM?=
 =?utf-8?B?d1E1M0Vad2hRK2F6bloyeEdkbVBnQjd1enQ5NDcvc1pGNnNkV1FST3VvbkFs?=
 =?utf-8?B?S0l4RGwwcXh6RExNTVFvZkROOXlHUU14YmUxbk1mcU5uaGNORGRpQTNleXhG?=
 =?utf-8?B?VDhHTG45Qmg2VDlNUTRNYldaRm5RT3QwYTJjZDN6R0FEdDliWWtubXpyS1hi?=
 =?utf-8?B?Z3g1WEsvanRvZHVVWW02R29aMlNUcDI4ZVpFUC93ZW82cG5DY0t4SHoxV1Nh?=
 =?utf-8?B?SUZuKy9IaHRaV0RwUjhNVDFVWnZHZUhiVmpVOFFoaHBIaDFDdis4ZjR2akd5?=
 =?utf-8?B?aElTZ3p5Y3pmVEY1Vm1zeU5nOHRRQlpMM2J3dzV5UTRmRFozMkFpMFJPZ01K?=
 =?utf-8?B?c2ZNMUhmNm40WE5oenVxL3ZvazREUHlqMHRqZzEyL3o2WXZ5cm1ocWdRV2dl?=
 =?utf-8?B?U3FyUEREdExOakZNTFQvaklxNzFGWktpSFBHQXpMVmIxT0xlODQ2eXBYUHdC?=
 =?utf-8?B?NUtiUnlTd3lsTTI0Rmp0U0xOTjhDMnJxVVE5VUtKajVIWk9pSTZ0cWJwbFZt?=
 =?utf-8?B?QmxCazlNZUpZLzhoSXJHSGJPRWdKZlVwSWtCbG5ud2swWDR0SVJIRGt6QWc3?=
 =?utf-8?B?SXdwbHl3UW91cXp4MnovVTg2aFFEVkxyN20zeVMrZ0pLcWxLMXRwN1Y4YXRu?=
 =?utf-8?B?S0pZRnlDQlV5QXNlZ0grdWc1SjdLU2tUcGFkVFpVaC9MVWwybDg5SStoRHIy?=
 =?utf-8?B?VkEyNWVnR3FCczU1QmRUaXBERm9NNGVkOUFQLzBuQmd3Q3pyeHVuNFRWd3NZ?=
 =?utf-8?B?bzFJU2krNS9TRGxCZ1c1YTVGblJuNmpaejlEQ1JuYzV1alFmWCswbmR6TjBC?=
 =?utf-8?B?dWtEamkwR0JSMDRXU1lKLzFtWUdsbndPT2t1dHhpblRLQkgrQkJiQTMzMmRw?=
 =?utf-8?B?WVBjWTV6cTVlK0wrQlhtVTFMWWxGcld2bGM1aXh0aFhhendqT2IzYXBwUlRX?=
 =?utf-8?B?eTFQOHRLQkRXc3QrM1VLUVc5SVo1NE5VL1V5aFd0S3M4a1JEQTRoNXB5ODRz?=
 =?utf-8?B?OTNqL0FYVWU4Q2JqdjFCYkU1Zi96SDN4R2hFVS9DN0p0eU1sdEZ6b1J1dGJx?=
 =?utf-8?B?bktEeWRrVDZhT2Yzb0NicUNNSHptaHcrMUcxdVlhYnVIdEsrZGdML1ZVT2ZF?=
 =?utf-8?B?SlpJMlRaRzBaeG5qc1E4QnlPalUxTDlzME9ZQXBYMW43cGFSN3RqcDBVWjZp?=
 =?utf-8?B?TmM4K2wydFV1WENtZDlvcWFncTJxZUwwVFYzMmVVUGNDQnMyRk0wMFF3ekpj?=
 =?utf-8?B?Nm10ZHlIMXBpZ3Fyd3lOK01jL1Qzc1kxUzNqTXA3ZlhPRVNNZjVnZ3pkTkhF?=
 =?utf-8?B?OGxac2JHdDNwaFMwdy9JR3VpS2FIL3FWcXNzSnVZQW1ya3JjYW1aaTh5N20w?=
 =?utf-8?B?c2lPTlh2RjhVL1I5a21rMjI1ejA5M0ZGaGJHbVpTMTZNbUZ4VzRYSE1YQnhP?=
 =?utf-8?B?clF5azlpeU81WlYrQy9XUUhXRnhyYTNITGRvNEMyOWh5RHVwZnM0a3QxV3ho?=
 =?utf-8?B?ZEJwQjJQS2Q4dDlOdG4vQTI2azVmZys5MHB0SzFOT2hhVmxId1lBOEVXeVlP?=
 =?utf-8?B?L2J2T1dVVWZpTHlSc0dWSDZmd0NWOVRaS2R1cmprLzVWY012eEFqdGFnQThl?=
 =?utf-8?B?dTZSTDZCeWxWRnRmRVhtNm9yWFY4c1BMWmorTndOR2VjWVk0QzdRU2JhL2dk?=
 =?utf-8?B?NjFjWTFWRVhYa1QxZlBTVVVnU2ErNFI4cktwc3BwelQ4bVk4YkNVQkI3QW15?=
 =?utf-8?B?aWJWYVFDMGJ0UHdCUVBBbTZHMVJGOXlIeG1yMEwwVWk4bUthQUdTU29wbW5P?=
 =?utf-8?B?aEMzbm96UGxqdExNZHpsbmNuaVNCaERwQjllWkJOekNLeEV6MDZMQWEwL0ZX?=
 =?utf-8?B?WEp6dWg2bjdiOC9qSS8wMUh6V0ZhYWlUZ0VGWUswaEJpZS84WU1nZ2g3Rnoy?=
 =?utf-8?B?THdNenpNbUxsQmVJRk4weGU3UFVBRjRhMmRSMk9jWkpJVVdZZFRTcGhXdDlv?=
 =?utf-8?B?NCtWbVdTemg4S0QweHNscEtJaks4ajJBOXlSR1VXVFMrZkltUFZqZ2tGTWov?=
 =?utf-8?B?WUNhMkNlTE5Wam1MUXY5cHpHRkYzNGNnc2hmNHdBWWNBaFBPSlFOM25kajMx?=
 =?utf-8?B?QktsODUxYnE2UWd1VXpoYnh4NUIwSW1LaWtZZ2xTcjFNWHAyd1hpZ2pZYmlZ?=
 =?utf-8?B?R3pud3BwVitOczVEL2d1NGpiakpaZFprUU45T1ViZVJnWXZ2aXNqK2Z2dE9R?=
 =?utf-8?Q?bJet9qSm1gu4ajIsl+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27326766-1af6-4b15-015c-08df2ffade51
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB999075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 05:11:03.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HD3p9n643+igRMJNOHYz3gCgiHblczUMWhB/WviyWC5atxCxMBUxJt0t7cIFvpugYXSXwN1fSSMFUKiYwqKMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7C0ACC722

Hi Frank,

On 10/10/2026 8:39 AM, Frank Li wrote:
> On Fri, Oct 09, 2026 at 09:30:10AM +0530, Golla Nagendra wrote:
>> Replace pm_runtime_resume_and_get() with the PM_RUNTIME_ACQUIRE_AUTOSUSPEND
>> guard to manage the probe-time runtime PM reference lifecycle. If the guard
>> acquire fails, fail probe immediately so a broken device is never
>> registered.
>>
>> When runtime PM is not enabled for the device, call
>> zynqmp_dma_runtime_resume() directly after pm_runtime_enable() to bring the
>> clocks up for probe.
>>
>> On probe failure after a successful guard acquire, drop the reference with
>> zynqmp_dma_probe_pm_put(), inhibit the guard destructor with
>> retain_and_null_ptr(), and gate the clocks through
>> zynqmp_dma_probe_fail(). When runtime PM is enabled,
>> zynqmp_dma_probe_pm_put() uses pm_runtime_put_sync_suspend(). When runtime
>> PM is not enabled for the device, balance the guard usage counter with
>> pm_runtime_put_noidle() and gate the clocks with
>> zynqmp_dma_runtime_suspend(). Runtime PM does not suspend a device that
>> is already disabled, so pair every direct zynqmp_dma_runtime_suspend()
>> call with pm_runtime_set_suspended() to keep the runtime PM status in
>> sync with the clocks.
>>
>> On probe success, release the probe-time reference with
>> pm_runtime_put_sync_autosuspend() when runtime PM is enabled for the
>> device. When runtime PM is not enabled for the device, balance the guard
>> usage counter with pm_runtime_put_noidle() only and leave the clocks
>> enabled so that later channel allocation can use the hardware. Inhibit the
>> guard destructor with retain_and_null_ptr(pm).
>>
>> Signed-off-by: Golla Nagendra <nagendra.golla@amd.com>
>> ---
>>   drivers/dma/xilinx/zynqmp_dma.c | 68 ++++++++++++++++++++++++++++++-----------
>>   1 file changed, 50 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
>> index 3b7dfa53f972..a48106e404e7 100644
>> --- a/drivers/dma/xilinx/zynqmp_dma.c
>> +++ b/drivers/dma/xilinx/zynqmp_dma.c
>> @@ -18,6 +18,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/clk.h>
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>> +#include <linux/cleanup.h>
>>   #include <linux/pm_runtime.h>
>>
>>   #include "../dmaengine.h"
>> @@ -1077,6 +1078,29 @@ static const struct dev_pm_ops zynqmp_dma_dev_pm_ops = {
>>   			   zynqmp_dma_runtime_resume, NULL)
>>   };
>>
>> +static void zynqmp_dma_probe_pm_put(struct device *dev)
>> +{
>> +	if (pm_runtime_enabled(dev))
>> +		pm_runtime_put_sync_suspend(dev);
>> +	else
>> +		pm_runtime_put_noidle(dev);
>> +}
>> +
>> +static int zynqmp_dma_probe_fail(struct zynqmp_dma_device *zdev, int ret)
>> +{
>> +	bool rpm_disabled = !pm_runtime_enabled(zdev->dev);
>> +
>> +	zynqmp_dma_chan_remove(zdev->chan);
>> +	zynqmp_dma_probe_pm_put(zdev->dev);
>> +	pm_runtime_disable(zdev->dev);
>> +	if (rpm_disabled || !pm_runtime_status_suspended(zdev->dev)) {
>> +		zynqmp_dma_runtime_suspend(zdev->dev);
>> +		pm_runtime_set_suspended(zdev->dev);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   /**
>>    * zynqmp_dma_probe - Driver probe function
>>    * @pdev: Pointer to the platform_device structure
>> @@ -1087,7 +1111,7 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>>   {
>>   	struct zynqmp_dma_device *zdev;
>>   	struct dma_device *p;
>> -	int ret;
>> +	int ret, pm_err;
>>
>>   	zdev = devm_kzalloc(&pdev->dev, sizeof(*zdev), GFP_KERNEL);
>>   	if (!zdev)
>> @@ -1128,21 +1152,30 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>>   	pm_runtime_set_autosuspend_delay(zdev->dev, ZDMA_PM_TIMEOUT);
>>   	pm_runtime_use_autosuspend(zdev->dev);
>>   	pm_runtime_enable(zdev->dev);
>> -	ret = pm_runtime_resume_and_get(zdev->dev);
>> -	if (ret < 0) {
>> -		dev_err(&pdev->dev, "device wakeup failed.\n");
>> -		pm_runtime_disable(zdev->dev);
>> -	}
>>   	if (!pm_runtime_enabled(zdev->dev)) {
>>   		ret = zynqmp_dma_runtime_resume(zdev->dev);
>> -		if (ret)
>> +		if (ret) {
>> +			pm_runtime_disable(zdev->dev);
>>   			return ret;
>> +		}
>> +	}
>> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(zdev->dev, pm);
>> +	pm_err = PM_RUNTIME_ACQUIRE_ERR(&pm);
>> +	if (pm_err) {
>> +		retain_and_null_ptr(pm);
> 
> Not sure why need call retain_and_null_ptr() here, generally only need
> call retain_and_null_ptr() at success pass if you use want to keep
> runtime_pm active. at fail case, needn't do that.
> 
>> +		pm_runtime_disable(zdev->dev);
> 
Thanks for the Review> If use devm_pm_runtime_enable(), needn't this one.

We intentionally keep the nondevmpm_runtime_enable()pm_runtime_disable() 
pair here and do not switch to devm_pm_runtime_enable(). 
devm_pm_runtime_enable() registers a devm action that calls 
pm_runtime_disable() automatically after .remove returns. Since remove() 
already calls pm_runtime_disable() explicitly itself, switching to the 
devm variant would mean pm_runtime_disable() gets called a second time 
for the same device — driving disable_depth into underflow, along with 
any other invalid state that comes from disabling an already-disabled 
runtime PM.

If we remove the explicit pm_runtime_disable() from remove() to avoid 
that double-disable call, it would affect the fix introduced in commit 
9c58a42c1612 ("dmaengine: zynqmp_dma: fix race between runtime PM and 
device removal"), 
https://lore.kernel.org/all/20260630064844.705173-2-nagendra.golla@amd.com/
which added that explicit disable specifically to close a race between 
runtime PM and device removal.
Dropping it would reopen that same race.

Thanks,
Nagendra

> 
>> +		if (!pm_runtime_status_suspended(zdev->dev)) {
>> +			zynqmp_dma_runtime_suspend(zdev->dev);
>> +			pm_runtime_set_suspended(zdev->dev);
>> +		}
>> +		return dev_err_probe(&pdev->dev, pm_err, "device wakeup failed\n");
>>   	}
>>
>>   	ret = zynqmp_dma_chan_probe(zdev, pdev);
>>   	if (ret) {
>>   		dev_err_probe(&pdev->dev, ret, "Probing channel failed\n");
>> -		goto free_chan_resources;
>> +		retain_and_null_ptr(pm);
>> +		return zynqmp_dma_probe_fail(zdev, ret);
>>   	}
>>
>>   	p->dst_addr_widths = BIT(zdev->chan->bus_width / 8);
>> @@ -1151,7 +1184,8 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>>   	ret = dma_async_device_register(&zdev->common);
>>   	if (ret) {
>>   		dev_err(zdev->dev, "failed to register the dma device\n");
>> -		goto free_chan_resources;
>> +		retain_and_null_ptr(pm);
>> +		return zynqmp_dma_probe_fail(zdev, ret);
>>   	}
>>
>>   	ret = of_dma_controller_register(pdev->dev.of_node,
>> @@ -1159,19 +1193,17 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
>>   	if (ret) {
>>   		dev_err_probe(&pdev->dev, ret, "Unable to register DMA to DT\n");
>>   		dma_async_device_unregister(&zdev->common);
>> -		goto free_chan_resources;
>> +		retain_and_null_ptr(pm);
>> +		return zynqmp_dma_probe_fail(zdev, ret);
>>   	}
>>
>> -	pm_runtime_put_sync_autosuspend(zdev->dev);
>> +	if (pm_runtime_enabled(zdev->dev))
>> +		pm_runtime_put_sync_autosuspend(zdev->dev);
>> +	else
>> +		pm_runtime_put_noidle(zdev->dev);
>> +	retain_and_null_ptr(pm);
> 
> You mix use auto cleanup and pm_runtime_put_sync_autosuspen() and
> pm_runtime_put_noidle() to make code mess up.
> 
> Frank
>>
>>   	return 0;
>> -
>> -free_chan_resources:
>> -	zynqmp_dma_chan_remove(zdev->chan);
>> -	if (!pm_runtime_enabled(zdev->dev))
>> -		zynqmp_dma_runtime_suspend(zdev->dev);
>> -	pm_runtime_disable(zdev->dev);
>> -	return ret;
>>   }
>>
>>   /**
>>
>> --
>> 2.43.7
>>

