Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794578131;
	b=oYgxtJxQDskBfwNaP6t19Ra6L+P4SVH0UMdvI53QG9WZKPrRLDCLuxwpAIN95HAprPAb
	 gDmLLdjv4VgJuLvMHR7GFGjtaog4MDywE6MDrai2kqCKPYGE6z/pkP1DB5gr23q6PIzPn
	 JdVQgyavSb+yJMfHvOjerSMhC54tQXhC91XKlGXM3B3tOEub5KF4Pjz9v97hMG0MbGO2e
	 oxwIp8yUm8opaE7BTMJuNrxM7l1/l0pdCwh9BhqYZtG1whA5ADSGloTT0BYOU9kf59YMa
	 gHy/JWmOGTqurD7+OOoKqlimdmvLtkykSbRUbpeomvq1HVR+0uQcf1XfN4X1knsU/CQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578131;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=t6pTPht3eimr74wi6pmlhJjfBxTMCktHwtP93q4eCVI=;
	b=nFOxBySF9CE/FaO9jLcJk2qxk7l7lVnPi2fUFmNZDqx6TRxkSYTfqBtj0gzxrZDpiMUL
	 g58qnc5BeUIk1U5W9eFJhwIOw9/1o63tH7V6HTEWa3u+++ujgqnuCWqgQM8VOaWdB+9rw
	 K4foQMm6hD5WTlEofG2twXxbNoToIKz78u7z0eSQQ+ShbRyIoVFAc6yFF+iX1KVIxe+Z0
	 3kQArb8qpybhPADhSn/WUaqdA1PjNcqwevbnZ3d1nJRrTIIl31i/cJFfWRWVVRyHxs81G
	 j+ZLejAd/GLPqNzSIPR3fu0h7/hIXJPBHNhmnTBDgKkarwH/QucMi3EL6GtrkPOO3iA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oRi8t7Sq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.51
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5F606A339;
	Fri, 13 Nov 2026 13:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97C5F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oRi8t7Sq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWAnek0Rlzpsl8/YbLqV/iqGW3D3pGLJtu4M+qtkNBPyoeGeBAriacjAvYjSFDid0PUbfO8aNhmwq3l7U6W4Q+sXDOvYDWzwtqw9y0S6lngYSqdpjSVP9Cbupardt6LtO57GUNIJwtiwHCG/lZRPUIcb1/WBzTrv3o7ZqMz+Th4lQnZNwAlIJZGZRJ8wY4ca6GT+u0L1bSD7T4O+ewTWrKmKbMdmM15WHPNXffT7pBQDajnrtLh3x9+kG2agHp6Jhb/K8mME72E5NSlAYya0V6SZV3+KULwKNuWfJm7Vqo3fQIehf821Nc5D8xugPRWZ1ISn9WOR/6PPKmP4aoR6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6pTPht3eimr74wi6pmlhJjfBxTMCktHwtP93q4eCVI=;
 b=eFoLMUH2Y9wfzuHz0He/pF2zaOGgmSGhkb+M6PH/YgvpB2BbZKJtufsplEXYK4QUDQKW8jVQ4/gXoN+LbOMOu8DBtonqd1QQhB3R6c+KlrJysmBsXpMqYWjTuDhvpd7nkbuhofPjxO9N0Y4IrwBVh7z/PEvASC/jWV0m8zeLItWrMdDEPmbcy8MmuTrIIR5OrbIEC2+Wogjg33twUfAvlDB6CScV4iu0KVsSOa589ooAiThw/O6/fch5LcpCQuTAvwtGb2NGNOxeQDD/sa5Ndq/V0nux9qTDZS9zTjvt62D+Ov0483RdofKJW73nF1MwSPk3lJV1DVYstDTogJEPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6pTPht3eimr74wi6pmlhJjfBxTMCktHwtP93q4eCVI=;
 b=oRi8t7SqK048AM2E16Ao+7MsJp+1YDM/Ue/qTDPG/bTxnkbARb15hh/uHxdtapjpeGl/qjhdv2wcwfEirmd/tKdWlqLSGtpSo3sb5l/VKq62jFSeB9hXAE//gZrrI4EaEGK+5GhbMCGfGI0zvlqS6N8HBJMfG3frsAUFcZU1UHCmoEemvWm9ab0IXfOBl0Pnmf63/dfXBE6xCt/xJqqGPDF3TV0KozinUFcPTbzdYegszsIRbO0T7+Vn70qrmk2Fc7L2V0PmnoGBTFOeEFQiv04m+TyY1ULRKzzGH7vi+7RXxu8VRTmtkh3/LD/wtF1LBOcQFXYJZeLS91NpXQ74Lw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:55:22 +0000
Received: from SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7]) by SA1PR12MB5637.namprd12.prod.outlook.com
 ([fe80::29a8:4659:6935:73f7%3]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 13:55:22 +0000
Message-ID: <c5353b88-e1bb-4ea3-8a7d-f468c1155968@nvidia.com>
Date: Fri, 13 Nov 2026 19:25:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: CPPC: Scale EPP values to the register width
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Mario Limonciello <superm1@kernel.org>, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhanjie9@hisilicon.com, zhangpengjie2@huawei.com
References: <20261112131316.827708-1-christian.loehle@arm.com>
 <592580a1-ba88-4e22-b586-4aa2425f9760@arm.com>
 <CAJZ5v0gXjngKSxX0Ku2wccWj9+oDQ7YqS6ziFZXDzMgm5GjVzg@mail.gmail.com>
 <f8d23034-0d28-4726-829e-51cf687e5589@arm.com>
 <37efae02-1f49-45ff-9e51-5a6a921ed1d5@kernel.org>
 <4d9261e9-fc66-4197-b3ba-edcc98ffaaf7@arm.com>
 <2b72fea4-b2ba-4ae5-91e8-d5830f024b2f@arm.com>
 <CAJZ5v0g0b2iG21ExDhDjjaJN1Hwgmd53Ph690teqoRVexP1bTQ@mail.gmail.com>
 <5a7fe17b-2b65-4157-b6a7-d7c0a1ee3fb5@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <5a7fe17b-2b65-4157-b6a7-d7c0a1ee3fb5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::17) To SA1PR12MB5637.namprd12.prod.outlook.com
 (2603:10b6:806:228::13)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5637:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d5bcf5-8ca5-4578-8378-08df418dc233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|4143699003|56012099006|261021135927099003|261021123027099003|261021121427099003|261022105027099003|261026121527099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|261102123227099003|261102130727099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	5jLJ7J/0+o6UDdyXUWjm1KZLjGmq9Cb8cW3AP0MLnkxDrGnqxxFPYuPyjSgStmCWfvmqbhRDpCbpR9+rgW6KU6YgJTEaXhwcrhNj6jUWTk1SzsihsY5bG2tig1TSiL/W+GoEBmslggKwnYnrgHcT0hM1uMgkKmu+NyHuMSNV6aGNNjT2NdyLBgeiwhdf9VIGuwuWXxX1OYqdj/XhWY8cIQHKj92HRhWwNW/PkSOCAKeCcBkLmxCz46Ej6r3GnFpm8+7zEGinTF4H4dlwFwvvT/rVuGWeVzQgjpWBri9WnTI+uF0yY6AsFqYmxGduWNDqWv8UB4wJ1Bitp/LTWuW6efp5/rf6OeaU7C2V4VnycZuvFY/x/WiW0aGg4TqmONsZ5eVyZ2Tq8+VxJtGVVigPxSka/nBIPDyhALG+28S7B2vuhCyilenGgDsq9b+fmBgGkz/+EZA3IWtdrlXeltmMhrCMx0VmTUObqtVte6kQ8lJ/oGSf/4UwnWM0mYcu+cdG7tfSS6QC7RzJAelr5/6MXOyS21BHkl6WyXDe0HaLtEktQctUNp6eCR32So8KDtaA1foEuUBpDDQbEWJ4NQeBwFSIn8bvLNRDEHF1R0hWAkBzDjW8l/4FtwSeJO2XwDOABIElQLFWelfsXzIwo/UP0ivIbDGQtKhP5oiQbkBh5+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5637.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261021135927099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(261102123227099003)(261102130727099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajlneHl6N3JqRUxIaXB5TkhJWHdGTzdEdUpocGlqN1c4eVp5ZHVxcXg4WHp0?=
 =?utf-8?B?YSsvdGFmSEhsUFZzVWk1RFJzZEVxM09IZCtyaDdMSjdlZ1lLRElLaVlCV0hW?=
 =?utf-8?B?MHRHeThOODBNcWlwMkxvT1NyaGNIS3MzSXJ4WjNMOWY0V2hkNU5RbUhqMVov?=
 =?utf-8?B?dGRFUUhwNVpmTThLOXBIak1OWitUTGlPYzN6MjVhSGh1RkFYb1huZDVrUUhS?=
 =?utf-8?B?WVNVOWt2SmNaU0pORUFUOWsrZWlLc1lBaFIweWJUWmdOR2FVWE8yQy9iYzlK?=
 =?utf-8?B?Y2JXeThpdC9COGdyOVNTbWVaeENpMkZzWEFPT2JkczY1NWJ3aHRiMlRoalV4?=
 =?utf-8?B?YW9IeFoyMWVEWTlJcElMM2RzVkFDRFZDanJKazczUGVrWFptSUI5ZXp4Nmdy?=
 =?utf-8?B?aExJNDdiczExZUQ3eWRwUERQOWZ0MFRMMDJsOWVhdzFXZ3Rncmc4Ry93ZjVB?=
 =?utf-8?B?ZER2ZENCa3c4RDdoWVFlTloyMUlrQ3NQQklVK2dsM2RDSFBJVXAwZnJ0Skh1?=
 =?utf-8?B?bk55ZE44ZnlveVV2Wi9YUkFMampRQTdMUEUvbjZsMFczK2ZycmRULzVyOUY0?=
 =?utf-8?B?YmtYNitoTlpKMzNoVHQvWVV6NXcvSGlFenJieGgzMUlRU3I4WEo3eTJUT2lV?=
 =?utf-8?B?cTUvZjhIRzdLY0U3U05KUWFhM1RtVGtma1RFV1FkRWdzUTVyZjdxYVFLK3px?=
 =?utf-8?B?SDhpaU5Vell1TDN3S2ZVQi9oZGd6Mkk3cEFveG9mZHN1bnBRZHBmOXRNMEhR?=
 =?utf-8?B?WGljYUVWd3Y1TEg2bE44dE9YeWtyK1BTTlMyZElEU1dIamFMSzE3SXNhQ1dq?=
 =?utf-8?B?Y1VqV2dEUmMydmdpQkE4UnlvVERYcDdGcnpTTmFId0hRd2dEem1RUkRQcHI4?=
 =?utf-8?B?ZDd5bnk2a29XSVB1SEN6Q3BmV0ZleTkvSTJoT1NIb2gxK2V4TUZRdVJiaU52?=
 =?utf-8?B?ZGgzUjNxeVdLbmRsekQwcUNLd1loQVVPUHFQb0htcUE1OW1kckVuQzJBV25C?=
 =?utf-8?B?TVd0c2YxcXptZzB3NWU4by9ycFFQRXc5VmNjNEFXQTJMRFpqY25jQU1JY2Nq?=
 =?utf-8?B?amd2bHZ3UW8wVUVNYnJXSTlUaU1jOXBic2I4NWhYbTVhTldmRTllNUJqNUdG?=
 =?utf-8?B?cE5YanpmWk9sNCtRR24yNy8yRk9YYm94RTVabThoVVgwR1o3U2ZIN1JjbFJw?=
 =?utf-8?B?YkZWTE14S3g4NnZTVVFTTjllWTV0ZGoxckdHcmlUMCtGR1dTZVV4QlMvVGg0?=
 =?utf-8?B?cy9jUDJEaVNncStydmhERWRvL2ZwUVFiRDF6ZzdqbVdZWVZWYjhsS2V2K0Np?=
 =?utf-8?B?amgxb1JvanpTRkZZWmFGSjFoVTh1RkxYNVRxRTZiU0Y4U21QSWlnYWpYRTVa?=
 =?utf-8?B?VzJXN2J2QjZOMFc2elp0YUdsYzB2NEZ4bWx5Nm13NjZpMHhORG92RVhYRkxX?=
 =?utf-8?B?dS9QUzZhRHlybWNRQWFYdzZyYjdoZTdFVXVrWTJFTkY2dFZ3QWRtN3phSCs3?=
 =?utf-8?B?NmRhRnRYQlVhaHRzTjVUc1BnTklPQUVhSCtaaW9IME45MzViTFJLK2NMdk91?=
 =?utf-8?B?dHFWZDVnZnM0L3JzMDlGT1hPamxrYzRaYkZYaGZ3S0hsUCt4WFFZZkhFQTFN?=
 =?utf-8?B?NE1XV08zTm9OMmppTHNyVHNXRGtPaE5PQjRxQW4vNmdTdmtuVVR6Znczc3Er?=
 =?utf-8?B?Q1kyRHFjVWdSRnZSTmVPQndVbkNSQUJRS2RjSitsNm1Fc3pBWVFPYjZDS1Va?=
 =?utf-8?B?UFY3K252Z2VYdHVvaXhDYWI2YnJBQm9mTnptTjk0K0ZvcDczbUJVWko2OXd4?=
 =?utf-8?B?aXVKUVJEM3dyQzZET0VvVzFESUdkTnRMdE5wMHFVeVdjTFlmY0ZqWHRQYmZ3?=
 =?utf-8?B?ZnVSWlB6a21KK1o0c2pEZUdVNHE2R3ZCWUw0MUQ5czVaRy93V0ZXMDZmd0lS?=
 =?utf-8?B?SW5VNGt1VjVrWE5lcVRtOVRvYlFkWXRnbFk2dzRQZmF5S1pPUkVmZSs5am1v?=
 =?utf-8?B?NDNpUkZza0V6cm8yNXhIUjZzK1NrZXFjd3NrWGswSko4blhxenNtOVZycHFp?=
 =?utf-8?B?bG9ONDFHb0ZlRW5uMWtPSWZ6TG8wbVpxVmlsQVhkc1ZkT2hESU44YVpEUjQw?=
 =?utf-8?B?RHZGWjJGV0NtdEY0VWVSQ2pScWJmWnZxTTU3MS8zd0FFcXRjM3FpSVZnNGZz?=
 =?utf-8?B?dDhraWh2RlhMc09NbERMdWs5SUJKekhGQVJ1d1Qxbkt5RzNjREtQdmZxaVFm?=
 =?utf-8?B?LzBkdlBKS2N4UlhJQkFoeTdCcUhEd3JsVkRLWU4zbjg0OWUzaENaTWQvV3hl?=
 =?utf-8?Q?fHpboASvPCdRgZSI6k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d5bcf5-8ca5-4578-8378-08df418dc233
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5637.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:55:21.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrTY/uMNZBRdxH7+WWpgkcERXP4sBAvtIM+k/N6XGohjEeN/L0ye3vG1Usp7AVBJBbd9Xh8nt/pqTkOpiNSp9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342



On 13/11/26 18:02, Christian Loehle wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 11/13/26 12:28, Rafael J. Wysocki (Intel) wrote:
>> On Fri, Nov 13, 2026 at 1:22 PM Christian Loehle
>> <christian.loehle@arm.com> wrote:
>>>
>>> On 11/12/26 17:19, Christian Loehle wrote:
>>>> On 11/12/26 17:11, Mario Limonciello wrote:
>>>>> On 11/12/26 08:05, Christian Loehle wrote:
>>>>>> On 11/12/26 14:01, Rafael J. Wysocki (Intel) wrote:
>>>>>>> On Thu, Nov 12, 2026 at 2:58 PM Christian Loehle
>>>>>>> <christian.loehle@arm.com> wrote:
>>>>>>>>
>>>>>>>> On 11/12/26 13:13, Christian Loehle wrote:
>>>>>>>>> The EPP sysfs interface uses 0-255, but ACPI permits 4-8 bit fields.
>>>>>>>>> Writing 128 to a 4- or 6-bit SystemMemory field currently succeeds but
>>>>>>>>> stores zero, selecting maximum performance.
>>>>>>>>>
>>>>>>>>> Scale writes to supported narrow EPP registers and normalize reads to
>>>>>>>>> 0-255. Cover both EPP setters and cppc_get_perf() so saved firmware values
>>>>>>>>> round-trip correctly.
>>>>>>>>>
>>>>>>>>> Fixes: 922607a2b462 ("cpufreq: CPPC: Add support for autonomous selection")
>>>>>>>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>>>>>>>>> ---
>>>>>>>>>    .../ABI/testing/sysfs-devices-system-cpu      |  5 ++
>>>>>>>>>    drivers/acpi/cppc_acpi.c                      | 46 +++++++++++++++++--
>>>>>>>>>    2 files changed, 47 insertions(+), 4 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>>>> index d219fc27a0c9..c63b5cfd993c 100644
>>>>>>>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>>>> @@ -322,6 +322,11 @@ Description:     Energy performance preference
>>>>>>>>>                 performance increase/decrease and the result of the hardware's
>>>>>>>>>                 energy efficiency and performance optimization policies.
>>>>>>>>>
>>>>>>>>> +             For supported EPP registers narrower than eight bits, values are
>>>>>>>>> +             scaled and rounded to the nearest hardware preference.
>>>>>>>>> +             Reads use the same 0-255 scale and may differ from the requested
>>>>>>>>> +             value due to the reduced precision.
>>>>>>>>> +
>>>>>>>>>                 Writing to this file only has meaning when Autonomous Selection is
>>>>>>>>>                 enabled.
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>>>>>>> index 11a9f9eb6b4a..10b52163eb56 100644
>>>>>>>>> --- a/drivers/acpi/cppc_acpi.c
>>>>>>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>>>>>>> @@ -38,6 +38,7 @@
>>>>>>>>>    #include <linux/iopoll.h>
>>>>>>>>>    #include <linux/ktime.h>
>>>>>>>>>    #include <linux/list.h>
>>>>>>>>> +#include <linux/math64.h>
>>>>>>>>>    #include <linux/mutex.h>
>>>>>>>>>    #include <linux/rbtree.h>
>>>>>>>>>    #include <linux/rwsem.h>
>>>>>>>>> @@ -2841,6 +2842,25 @@ int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
>>>>>>>>>    }
>>>>>>>>>    EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>>>>>>>>>
>>>>>>>>> +/* Keep the EPP interface on an 8-bit scale, including firmware readback. */
>>>>>>>>> +static u64 cppc_scale_epp(const struct cpc_register_resource *reg,
>>>>>>>>> +                       u64 epp, bool to_reg)
>>>>>>>>> +{
>>>>>>>>> +     unsigned int width = reg->cpc_entry.reg.bit_width;
>>>>>>>>> +     u32 max;
>>>>>>>>> +
>>>>>>>>> +     if (reg->type != ACPI_TYPE_BUFFER || width < 4 || width >= 8)
>>>>>>>>> +             return epp;
>>>>>>>>> +
>>>>>>>>> +     max = BIT(width) - 1;
>>>>>>>>> +     if (to_reg)
>>>>>>>>> +             return DIV_ROUND_CLOSEST_ULL(epp * max,
>>>>>>>>> +                                          CPPC_EPP_ENERGY_EFFICIENCY_PREF);
>>>>>>>>> +
>>>>>>>>> +     return DIV_ROUND_CLOSEST_ULL(epp * CPPC_EPP_ENERGY_EFFICIENCY_PREF,
>>>>>>>>> +                                  max);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>    /**
>>>>>>>>>     * cppc_get_epp_perf - Get the epp register value.
>>>>>>>>>     * @cpunum: CPU from which to get epp preference value.
>>>>>>>>> @@ -2850,7 +2870,15 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>>>>>>>>>     */
>>>>>>>>>    int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>>>>>>>>>    {
>>>>>>>>> -     return cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
>>>>>>>>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>>>>>>>>> +     int ret;
>>>>>>>>> +
>>>>>>>>> +     ret = cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
>>>>>>>>> +     if (!ret)
>>>>>>>>> +             *epp_perf = cppc_scale_epp(&cpc_desc->cpc_regs[ENERGY_PERF],
>>>>>>>>> +                                        *epp_perf, false);
>>>>>>>>> +
>>>>>>>>> +     return ret;
>>>>>>>>>    }
>>>>>>>>>    EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
>>>>>>>>>
>>>>>>>>> @@ -3150,6 +3178,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>>>>>>         bool auto_sel_non_pcc;
>>>>>>>>>         bool epp_pcc;
>>>>>>>>>         bool epp_non_pcc;
>>>>>>>>> +     u64 epp;
>>>>>>>>>         int ret;
>>>>>>>>>
>>>>>>>>>         if (!cpc_desc) {
>>>>>>>>> @@ -3159,6 +3188,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>>>>>>
>>>>>>>>>         auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
>>>>>>>>>         epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
>>>>>>>>> +     epp = cppc_scale_epp(epp_set_reg, perf_ctrls->energy_perf, true);
>>>>>>>>>         if (!enable && auto_sel_reg->type == ACPI_TYPE_INTEGER &&
>>>>>>>>>             auto_sel_reg->cpc_entry.int_value == 1)
>>>>>>>>>                 return -EOPNOTSUPP;
>>>>>>>>> @@ -3177,7 +3207,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>>>>>>                         return ret;
>>>>>>>>>         }
>>>>>>>>>         if (epp_non_pcc) {
>>>>>>>>> -             ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
>>>>>>>>> +             ret = cpc_write(cpu, epp_set_reg, epp);
>>>>>>>>>                 if (ret)
>>>>>>>>>                         return ret;
>>>>>>>>>         }
>>>>>>>>> @@ -3205,7 +3235,7 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>>>>>>>>>                 }
>>>>>>>>>
>>>>>>>>>                 if (epp_pcc) {
>>>>>>>>> -                     ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
>>>>>>>>> +                     ret = cpc_write(cpu, epp_set_reg, epp);
>>>>>>>>>                         if (ret)
>>>>>>>>>                                 goto out_unlock;
>>>>>>>>>                 }
>>>>>>>>> @@ -3235,9 +3265,17 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>>>>>>>>>     */
>>>>>>>>>    int cppc_set_epp(int cpu, u64 epp_val)
>>>>>>>>>    {
>>>>>>>>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>>>>>>>>> +
>>>>>>>>>         if (epp_val > CPPC_EPP_ENERGY_EFFICIENCY_PREF)
>>>>>>>>>                 return -EINVAL;
>>>>>>>>>
>>>>>>>>> +     if (!cpc_desc)
>>>>>>>>> +             return -ENODEV;
>>>>>>>>> +
>>>>>>>>> +     epp_val = cppc_scale_epp(&cpc_desc->cpc_regs[ENERGY_PERF],
>>>>>>>>> +                              epp_val, true);
>>>>>>>>> +
>>>>>>>>>         return cppc_set_reg_val(cpu, ENERGY_PERF, epp_val);
>>>>>>>>>    }
>>>>>>>>>    EXPORT_SYMBOL_GPL(cppc_set_epp);
>>>>>>>>> @@ -3496,7 +3534,7 @@ int cppc_get_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>>>>>>>>>                 if (ret)
>>>>>>>>>                         goto out_err;
>>>>>>>>>         }
>>>>>>>>> -     perf_ctrls->energy_perf = energy_perf;
>>>>>>>>> +     perf_ctrls->energy_perf = cppc_scale_epp(energy_perf_reg, energy_perf, false);
>>>>>>>>>
>>>>>>>>>         if (CPC_SUPPORTED(auto_sel_reg)) {
>>>>>>>>>                 ret = cpc_read(cpu, auto_sel_reg, &auto_sel);
>>>>>>>>
>>>>>>>> +CC Sumit's actual email, sorry about that.
>>>>>>>
>>>>>>> So I'm assuming that this one is for Sumit to pick up and send again
>>>>>>> along with a new version of
>>>>>>>
>>>>>>> https://lore.kernel.org/linux-acpi/20261112080442.4007723-1-sumitg@nvidia.com/
>>>>>>>
>>>>>>> Or please let me know if that is not the case.
>>>>>>
>>>>>> Yup, while it fixes an issue by itself technically, I don't think there
>>>>>> are any affected platforms.
>>>>>> I'm hoping that Sumit this (and the limit-write-at-init) patch as a series
>>>>>> for all our convenience (and hopefully to get Sashiko to review them too).
>>>>>> (I guess I should've mentioned that in the notes.)
>>>>>>
>>>>>> And sorry about ACPI/CPPC having such high traffic lately, I'm expecting once
>>>>>> we've got the issues ironed out and the new features supported it'll be a
>>>>>> lot more boring :)
>>>>>
>>>>> So the basic idea with this patch that the userspace interface is always 8 bit so higher level software will not need to know the lower level implementation detail at the expense of some granularity.
>>>>>
>>>>> Makes sense to me, but I'd like to know how realistic this hardware is going to be.  If it's purely hypothetical hardware; how about proposing to ASWG that this field must always be 8 bit?
>>>>
>>>> Good point, IMO it's hypothetical hardware that hopefully doesn't and won't exist.
>>>> I'll try to raise this through that channel as well.
>>>
>>>
>>> Quick update on this, after proposing it, Souvik came back and made me aware that
>>> we've already proposed this:
>>> https://github.com/tianocore/edk2/issues/10838
>>>
>>> I guess forget about $SUBJECT after all and I'll probe-fail <8bit and get the amd-pstate
>>> handling correct.
>>
>> So should I wait for an update of
>>
>> https://lore.kernel.org/linux-acpi/20261112080442.4007723-1-sumitg@nvidia.com/
>>
>> or is it applicable as-is?  In which case, care to give it a tag?
> 
> I guess the issue is arguably preexisting and the fix doesn't touch the same code,
> so feel free to apply,


Yes, [1] can be applied as is. The issue Sashiko reported on it exists
without [1] too, and [2] fixes it.

[2] replaces the firmware MIN/MAX at init(). v5 of [1] kept them in
autonomous mode. I'm not aware of any platform that needs the OS to
keep them, but if one does, I will look at that separately.

I can also resend [1] and [2] as a series if you prefer.

[1] 
https://lore.kernel.org/linux-acpi/20261112080442.4007723-1-sumitg@nvidia.com/
[2] 
https://lore.kernel.org/all/20261112113204.778904-1-christian.loehle@arm.com/

Thanks,
Sumit

