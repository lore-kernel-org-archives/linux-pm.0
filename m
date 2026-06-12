Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013029.outbound.protection.outlook.com [40.107.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4BD36A377;
	Fri, 12 Jun 2026 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305301; cv=fail; b=sJ8fkajfIy4zpA9INiBQL8zl6rru4CKPHias+1hgioOR8txQZvYaWFljqPz4aC4GqxxancUurnMAbv5Jtd7AM9nON2awcq19B+zFZp8OKqtQ4G9KF4uqgjilB8G5Dqsk1dJkb9HmR2qpND/UoluM4SChwXpJ5KOvmtWHbskzBs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305301; c=relaxed/simple;
	bh=6PvnyNAs8Mkag2UrNF+sIZtVUj4Qod02Q5Zn+KKzzZA=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r0wxy2zKxN8mGomvuNuz2XvFzD2u2axNP/J7PDMGnU7WpGrfBrO6DXUS6Vg2rg4aUOKj21hqrQCxGYKZmaAzo/Hc6jKlSOPm5w4DqIh20Zn2R4CBqj1SG+l/5dIwdibNMOH0kLr2PJLIHFLxL6Q6SXQ67Kc/+68FLDHbMXd4wQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=dmAogyHz; arc=fail smtp.client-ip=40.107.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="dmAogyHz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpfdNh3Xn1CcHX5L+MQj4Phz1px6w6sGiHNSH/LNDWVBEVT16FsnY/89Fv3ZJF9Ne9r6DcsUZGQz9SX2uK2dIYP89E+cr+nvoiZIAgu9NiEtddfl9O6rcGq/Bt2C18GfJYuhdyGncewMn1xepYOU+biPksAf3f/HQj+3GBTHFn65lODZTON1gpakltd4vM0U/gf0RUsH2RNglBgyQa2kr1J9aMPFR6CMQDx+04bTbsxRbEKf/eWMV7FG7W4x46kHKA75l6IDnx29vq6gJssk6WJTcqedV9gqs0X5HcofPvv5sBFNHv4zOW7MJbqGqAIsr9hM/b6d9uI+HGdADlyPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PvnyNAs8Mkag2UrNF+sIZtVUj4Qod02Q5Zn+KKzzZA=;
 b=UKmZvGPyV9lncSsBBLxPREIQeTnexoxc8g+8e27wO5RhWEMzRYuSdLbbriMrn0FtW6Isj+6qsBBPKSQa6hrsGjIJf96G5oQNm+6N4CbEGDBG7/LRt3Hlvq95Wc8Ebi5k8NLEdrvf3bQ4RQF03Qn/iW4HZsYqkAUQbD+Ldgwpkupn+sjSjquR7yu85AeRScDSn51RImN+MAYOS13VM0ECBWt0R0ctTQRCLPK9YNa7JnNg18GNCr5SWTqEB1pE2HCPb8hqPcddOam8j9quSYZHAhH3aq45E1qlo6gKGmQYlQsum+CQ2Azvt3jcABcrf8JfdTiaRAEazTYsTME4WjZp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PvnyNAs8Mkag2UrNF+sIZtVUj4Qod02Q5Zn+KKzzZA=;
 b=dmAogyHzYn+6RfCMWfYkbnu4BhgGNbT3550Q2bF0k26mp+Hnr7Pw85jt13P5ZgBgzH+z3TilJNXNWVIFp0XpqZ0bfTSimfTqVWeeKylXV4v6NlnE4hdjGAX3W3rfIhF+iqX7A7Z7TFxs8xBOoJOwDxcNt6au6BvLCzUOsvRlMGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by BY5PR03MB5112.namprd03.prod.outlook.com (2603:10b6:a03:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 23:01:37 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 23:01:37 +0000
Message-ID: <ced074e6-0316-4e12-848f-52a15a4e0389@citrix.com>
Date: Sat, 13 Jun 2026 00:01:33 +0100
User-Agent: Mozilla Thunderbird
To: jmattson@google.com
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, bp@alien8.de,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org,
 tglx@kernel.org, viresh.kumar@linaro.org, x86@kernel.org, yosry@kernel.org
References: <20260612215729.1532175-1-jmattson@google.com>
Subject: Re: [PATCH v2 0/3] Fix three racy updates to MSR_K7_HWCR
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20260612215729.1532175-1-jmattson@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0604.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::13) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|BY5PR03MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a68423e-0d3f-4444-221d-08dec8d68e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ejNt+vzK4IkedG4fqgctoN1IrEmj9MjHsMIix1SIvf85nPbqotkdTaitVOAX7Zij36il0x2ebnQG70oBbhzJNrcwpx8KT+epJVJOdtaBYND8JeM4h1difgoA0MlWncqfDbfZZm5sLYAD3qgPyuXxX+wLu1DpSnXAnSA/lkfV2uzeY3BuAaEeBHxllRzSKrecZEC8Jr0T5sfnv6LlPdW0gwlrJSd5xirdT15lVUNi+IDuIN0mO+DkTDiOy6hVBrcdAcbMNUYbVHTpyJTH+SSYGdgmrXULwN330Ek0MOVf48SuTsYGxr/2WKW0e9ZoskVMZWkzLojvxrn+M/uI1gdtOs0J+ZFJRJBBH60+8K9kSM2Ls5iMwQl2NTak1FHoQBq5W8cTXOnbH42W43db7WWS+1Q3/YWOup6qOlb1nN8S8gujupz3zUdr0WRzB10nG49az5FYnQWtfj4gK2yYYB0QUwKPJfcwag9i+DvL8hQC6MzNxgN3RqBHlGjFhYExxXGLu9uqtnNtw+807Ldbe37xoUqm5RrtGX8pY5V98OMpHoZot0ukwDUbwxqKBq046WdBz1kbOJKXjgkRFBAST8EiKrGoNTvXPcjJy4/PIdpRatpUUBcg5QCATLiikU6Hxw9tEIwim9N7H8ibOB5L3fcEq32kWLdT49jPNldohWul8nDO5wDvyiRBDI/LQJ1Phs0z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUtrZm9rdkJtK242cmdVbU1ZN211Q3pDVStubWtQNU42M3RycVp3ajZ6R2Np?=
 =?utf-8?B?d3JMcmExMHhLeFE3QmMzOWVBVHdXWjNPbE1sU0tnRzh0QVZSUWVadzdvUzJP?=
 =?utf-8?B?NnhiRlNHUStmTW12VU8wY0p4QXlZU1VzOVZEQ2FYbTd3Y2htR3IwcnFBV3l2?=
 =?utf-8?B?cEF3ZHhRQlp4eWtKWHpxbGVWcnVvemVuZ3FGREp2Z2J3SFB5Ym9RNU5VcklK?=
 =?utf-8?B?d0VnSVBqbjJhVUhzcjJ3WHpCdmhjemhTZnJHa20yV2lqQXNqT0R6a3JUMFQy?=
 =?utf-8?B?bjk5Nldtc1F5ZGZ3RWt5dGpZWFZUMmFPMldWSEd2RnZjdjRWd1JESjJ4WE8z?=
 =?utf-8?B?SVZUbEt5MkphZ0ppU1AxaUN5Si82dGs5SUJiREtJN2RSOTczc2NOcVQybUky?=
 =?utf-8?B?eTliMm9TSjFpdHN0TUlFMnA5KzJkSDFyNXNMbm5SSFA2K3VkZEplVVJqOC9i?=
 =?utf-8?B?Mjkrc1Z3RUtSL1pESzdIeFFEYTBnK2VLVkRwRWR6aU5lV2M2azFxaG9USUlu?=
 =?utf-8?B?K0hYaUhIekFoeWNBOFBZKzVLeHVyd21OTUVKVEEwL2FITTRaVTJzbVFjQ2VM?=
 =?utf-8?B?aHREVjR3N2U1OWpFcy91YVBHejFIamhNRHhrZlNHcFBzRm96aHcyeDA5S09N?=
 =?utf-8?B?VjJPYmJFaXR4clhjSU1hSHExcVJWR3J2NUY2aXNNUGFQSDNWVlZzeGFEc0Yz?=
 =?utf-8?B?M0xlbUdGYVJrMjBGNGxrcWU0NzMvZmlEYmZDd3VFZ1NacStoMkRoWXMydDBn?=
 =?utf-8?B?M21ZeThOOEJZdVVsRmtVVmc0VmxIa0R2cTdLdUJ5VEtZd09QcXNMbnZ1TWJ2?=
 =?utf-8?B?RkcyRVg4MFdQQmhFVmh2MThpcHRuN05WN2RPSTZhZ2pFS1dDYXI1VGlNZTNk?=
 =?utf-8?B?TlIrdFJNajVkbmEwQ1Y5WWViSnh4b09ua2FqNTYzYnlWc1dqdEt1cTFoMHJs?=
 =?utf-8?B?dHl0eXJtaGdvbW9kdFE4MDZHZmFzbUM5ZWh0aWZ5a2g0QW5BTUFYTGtlSlU3?=
 =?utf-8?B?NEZ6M0J6S2E4VWdUelNMb1YxOUJXTlZ4QWZ2Wm1BODI5Y0lUTjFYaTYxUnVk?=
 =?utf-8?B?dUU3TFJkS3VSbWdML0lsSWJOaWd2d3dmQmtHTENWckdzb0hxU0Z6ZmtwdHZz?=
 =?utf-8?B?SVZLK25NdG52T0JOclFjcFBSQjkwdi9FUDc3OGpBczZOd0oxU1VYYzBZZE04?=
 =?utf-8?B?VHRoNnNmMTE2a1R0dDFqMTNPdnRGN3UxcUYvblFQZm0zSWF1RWhuWitSL1pF?=
 =?utf-8?B?NVF2MFBXQlVqRWM0ZkNab3I5dXRwNHI4a3lpRTRXTDFDbEk2TnovQkxTQXNs?=
 =?utf-8?B?dS9UbVp6MU9Gc3ZiK3MwQTZUSHM0WkwzZHF5NzZkZ0VtSUFINmprTW9PZ2Rn?=
 =?utf-8?B?R2hLRmVLazM0UDNvNVlsUWdSc3kwOXRJbzkrKzVZR0M3Y0xnOXpyY3FBUFhY?=
 =?utf-8?B?REsxZ1VacTZGMkR3N3Q3cFB1ZWNKTU82MktlVEJxZnMxWVNjM3FKbW13SGZP?=
 =?utf-8?B?L2cxdkUxdGxKS2dKcmQ3ZTA2SnZ5c0NkS0k2WTRpa1pyd1RlWTVLbVdBcFor?=
 =?utf-8?B?ZHplU2JjQWphT3oybkpoaG5VNTIvelNobkoybEJ5TTNvay9YSlNLUStmZExm?=
 =?utf-8?B?ZnNQSDNlRDN0dzBESnlQNURjQlZCQTc3Ujc4K0M5WmtCOTR1K2tWU0VYaXFZ?=
 =?utf-8?B?QzBPT1RXYTZpM25zRDcrR3d6Sld6UWJsMVZXUHNWc1JTMm1BYkxNU1B3QzhH?=
 =?utf-8?B?YTZYQW5DT3hlbFk4N0ZoMGFGdW1ocHhPZEhFdTBidGR4U0RWbkhKdFlSbEUy?=
 =?utf-8?B?MkgxVWhMVGVMMk1MKy8vTHhzR1ZJTUFveTlDVEVwYzhxQWRNcDdrQ0NobkZP?=
 =?utf-8?B?ZDZ0RlhuSnBkM0ZWS0ZZUnJjakZnbDZXZEhpZWRZcTkxZDZBYUFlTWxKSWtG?=
 =?utf-8?B?Y2pkZUw1K1FiU3dRMU56TGc4aDVZS29waTQ4WEgwb3JOZmZuTTVvbjhLN3VJ?=
 =?utf-8?B?aVZ5V0FxQmk0TGg0bmhrMFFqVzNlM1Zrc3g0cHIyb2dKN05uZCt2N1poQWFt?=
 =?utf-8?B?dDdUS1U3akw3RHVJZ0JhS2t1V0NiNFRNeW5BWVNCSFBjcFhYOFZJbmRySXRP?=
 =?utf-8?B?S0Z6YmE2dFNENWxEd3Y2TmNCbDVXcU1FWWp4U1VoZTNsOGNObFpnK2dNNUVL?=
 =?utf-8?B?ek5MVU9MdW4wUzA3WG1uR25iNGgrNjFuODV0UEx3WitzSExkUklBMkRIZ2s2?=
 =?utf-8?B?VU9NVDE1SXU2WXhuS0JTMXFVMU9OUXhWdENrK0E5a2lVZmdqTGZEL1ljUW5G?=
 =?utf-8?B?bGRBY1M4bVBrQzZoTzFqSlM2a21NUS9XelB3SGFhYlRwTFF5dy9XcUlPd1Nx?=
 =?utf-8?Q?vNzCN+EhI2+WlPrc=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a68423e-0d3f-4444-221d-08dec8d68e84
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 23:01:37.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxRsTqZM8xjVVlcJi03pLjVTNqmjsjLn8dgTEtl9NXYIv5AbURP375KnmZRKtgOS476XJT/u9TiH8/mIXMW4zE3/3ysRJ+PJqnLAyBZdGTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5112

> hoists the HWCR update logic out
> into a new helper, amd_update_hwcr(), which performs the read-modify-write
> with interrupts disabled

Add some `perf` to your test scenario and these bugs will reappear, this
time caused by NMIs.

I don't have any good suggestions. Core scope MSRs are horrible because
you can't update them atomically.

At boot time you can fix it by ensuring the RMW will cause both threads
to write the same value (i.e. the modify is not dependent on the read
value, and that there is exactly one WRMSR in the entire kernel for this
MSR).

For runtime with multiple agendas going on, you need some kind of
spinlock because it's a plain concurrency problem.

~Andrew
