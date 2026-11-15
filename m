Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794758098;
	b=PCC0lKVue/BWF4cXmEuxeRFYM5R3Wwqn58mE5RfaIUNHupJICVGmorEr2LvrrRRN1X/8
	 Tr/x5I+U5LZ5DzNGR8MW+97cZFFa6HKDwki6DsNcJXkjz2XNIMRV6QUghML4uA/dH7js+
	 jpQmgyxwLWdJDUzNADefkaPCKDHSK86Boo9tx1n5wZ/4H4PdVo9WJNBqg3TQi03fmnYdy
	 1Yqkz7Vz40hAeT5eZC/Z7u/tPip/Q1/X1JuBt6xVcZQe3JmESD2JmsE6swvgYN6atmZvH
	 Vo5D/NXimdWCRMsfwhU+Lf+oAMYOQJTxBT1lNYtnRoLt+FrsO4O/6zTgRHdMFON6Xbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794758098;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:Content-Language:To:References:From:In-Reply-To:
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
	bh=ZvrzB4MUVs0yHM7iop93JVb/aqfcE8ryM9wLalC6plY=;
	b=t0hNZEKL3mHXyqX52qsGzfO7EA89ZxroCLQcU8T+x0FG5ehW34TTsnwK3TyZBr/jcNCO
	 KVV47LW0ypDr9AESrlkN44eJIXp7W0wHGA3eS/IAMarRVZKa76LWEh45DmIzUOzgCQsTQ
	 jpm87TRF277EkK2EbBceL0bVkV/w22r5F8jHKm01vZRsYWLtQeMyUoRPFBGpMvFCHk9wN
	 00bhwrF682C4v3zxWgR+bNPS8LwOTwONeTjpJtUfBV5eqzGKd0h046gN+0or4EZ2gL1jS
	 4oNzLayQI3bjLcV1f0rx5NRFOY8GEu3L4VveqMZAlCkDwPhyhVVaC7mF+AvDzdF7fzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="a/nXGgz1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.32
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011032.outbound.protection.outlook.com [40.93.194.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3869D606A31A;
	Sun, 15 Nov 2026 15:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3869D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=a/nXGgz1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdL+2oIrxB8dc8LQee2M6qbyQ9lJ3ANXPQz4/JXFkNlKaQ24tDbhN86QzDln1Cox1YxoXEkEJURec22zMLtPmglvhTvK3QMs1Te8zxr5GFWUf/8ZT/RpD3EkhvUi3bHrIeNWCeSU1Fg+FUZNw+AWtV7Ua+zNR14ur8wky9hK1Vil0Uld7cm4xk3DjzUWegg48nY5uPrxjHyXmJa8oK3G5tli7xU43DJGEMc2Wrwf/qhhVVP/JWVhXGwH1wA39mjygvXmqBF9OiHqNkTOUjxUgy6ZhYgp4pIJZhVRa7RJokUPCd5sSNvhBh7YdycqHBhRyK7+oVSXfAoXHi2BzYFeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvrzB4MUVs0yHM7iop93JVb/aqfcE8ryM9wLalC6plY=;
 b=nNfNJVHskuDWGhwUMKkdd0jqgEJCJpvoCBX6eXBO9H6rNDX5TpTe5rYQ5Qnf/Ou7LCGvBl2zU0ydyZefHhQpNJmDB1EIeNudxaQQpNleFQEEt/264VXZGuXeOOu3OItK1aC/WsZaoPLlAT+bzxpZW5FI0ZxbSUg4ogq6Q6aWjk8G6KJc1tdRvT5SNB/FOJKpmfQ/ZXCdv+NGrsD3ADsgAR8mvm5U9LJuAHwygQycOWkGXM5MiJiVCrUJ5zKog8WW0lv64myvI7s2sLlTJ0jf7BJAEg7DX8RSaplR0U03Qjcn4AFsN1et4DsXkzU0y1gF/fn0J8Iem1wqsE1WbY3piw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvrzB4MUVs0yHM7iop93JVb/aqfcE8ryM9wLalC6plY=;
 b=a/nXGgz17WP1BccIB4TX6J7Ao7h8jzN1doN656og0jSJL5wrz+zNJDjBOlDsSL7Xj0SxCPPXwn1UGJ1Cy6AhQdi8nwNdQcL/BjKuxIMxA3MVHYybTlTyM1WcltBNfps9vcfjQejKKtGK5MtmNt7WKqXRncm0YJjywBZgXYZ7zzc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by MW4PR12MB6754.namprd12.prod.outlook.com (2603:10b6:303:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sun, 15 Nov
 2026 15:54:52 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.012; Sun, 15 Nov 2026
 15:54:51 +0000
Message-ID: <ea92861f-cdf6-4828-9292-b49ad6c21590@amd.com>
Date: Sun, 15 Nov 2026 09:54:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cpufreq: amd-pstate: Set asymmetric CPU capacity on
 hybrid platforms
Content-Language: en-US
To: Vishal Badole <Vishal.Badole@amd.com>, ray.huang@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org, perry.yuan@amd.com,
 kprateek.nayak@amd.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261114150310.1377654-1-Vishal.Badole@amd.com>
 <20261114150310.1377654-2-Vishal.Badole@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261114150310.1377654-2-Vishal.Badole@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0110.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::22) To PH7PR12MB9174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|MW4PR12MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eff4796-7221-467d-7dd1-08df4330c8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|921020|261026140227099003|11063799006|261026121527099003|4143699003|261009223027099003|261021123027099003|261009221227099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003|56012099006|261028144727099003|10067099003|261102130727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ab2WRO795BnGb1ZWUSKEI+zoe8meGCewdziLfi6KJQ36ND2mPOy6u0/ducllzd8DhjVZSqvJvTo2aYIKp+375mKjeLiQpEFTYABMnU7NcaVuazQ281ehtylIPqP3ZF4unKlr+jYFSijjXImLZ8NVFtUOI2AZIfM49yML9o7RTu1noXlR4q/srAQYHqVDAkvNoSPimZ2yySf6kAoFG8af64AHPiWmLiA3cgLt6oWCUHobP4hgX1CQ6bh6gOw47OqB9RZN6lo9VeI+JY+gWUynB8aCvY0SBpHiBqB53g8WrRLeaO1a21MtQi9uNwPCMLpbm4eOvA/bnfZEOAAvAJWhSUb7o70r+ki7epqnzfK6jUGU/LkXYfXpwfp/OYNCYcYErEdrsYWvv+5YjghGWC3Q+SsCVBv3JwiuRLIK4G8TSvYAp6PbvDHrBHt6F6FtWvCh7SeDH8rIThmALlWMw2Z+dvO9iKjS03GpMB+Od8ErzHnIgf5QYmfjARpzKC3Lgcxo8fJ3zLq0T9g8aVhZAmyZyHfTT4wElmNrG9UMMo+oiB2j8ejmXO1xw1lKdXeIM/BIPJjCH5/+m/TZ9pmV5gZwwCQ6a7mFQ+a9pGWaGSCTwzOmIUIcPSJBiMVGWc1en/IcXznMdXBHFpTkZ+fXIfCi3dGlB0MAOVkPzeTNY94959w49uHE7w+b8l3g0cM/KSPe6lTFcaDpmu/z1zVXaZvJgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(921020)(261026140227099003)(11063799006)(261026121527099003)(4143699003)(261009223027099003)(261021123027099003)(261009221227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003)(56012099006)(261028144727099003)(10067099003)(261102130727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3p2ZTErTzFZeE1zci9nYkF0cEVJOTZ6L0RwbW5oU3F3bVRIdXNlNm9xcHp1?=
 =?utf-8?B?RUJEcEtxanEzTnlsblh2YkpxUnE0bkVObWE3bXdYM0ptcnU2cTY4bmhRZmpz?=
 =?utf-8?B?UDhsTWJHQ1pUd1drRDBMRWJETTVsbEo0ck5iNWpYSVd4dVlmWi9ENEJjVktq?=
 =?utf-8?B?OGZxSTVMWE5MVzNRL25aQTVLOGhjVzFiWVBFdTQranRib3c1ajV5d1pMTXlM?=
 =?utf-8?B?YTNYNDZEajkvVCtrV1FmVEdPRlZveHRkNzdTbHIwMVNZVmRSZmZxdW05bEtO?=
 =?utf-8?B?aVkxS2RjV1haZnJaQ3hlRnJVV3h0NDgrdmZZSGJFYkZTVTducVFZbko5WG5y?=
 =?utf-8?B?VUY3MVNleW01MDBaNE9WaDNrKzNOU29wNGEvTE9qalo5a1IyU21PUE1VdjlG?=
 =?utf-8?B?SkhOWGQ3ejdWZXpVWXAvUXhoTTR1K0VzMEZwTTdTQy9lK3prYkFKOTI1eFdu?=
 =?utf-8?B?bHJIV1hFaUxJVVkzc1B6NldtZStMcnRrMzkzYndzSzg4NlZpNi9nK0kraUQ2?=
 =?utf-8?B?ZzBKYWZkeTVpeStEYzloYlFkZDFKSVZWYXdsdmlIeVNjNjYyai92OGgvZk5n?=
 =?utf-8?B?NEgxaWFxMkt1QnVxM1hoeXBlOWpWNm1XajdoQ3FXNTlwQTR6RHh3NzFPZ0Vn?=
 =?utf-8?B?TDZ2aHA5TlMzc3c5VjNQenpwYlBsRHhtUVZpcklXTFVxSVMvb1BGd2pwT01h?=
 =?utf-8?B?Q2pPdkloRjhveVBBWVBSSlpIRHF1UDNaWjI5Si80SUpHVmRtV0hlVkRjeTFR?=
 =?utf-8?B?OU9sWTNnTkVPUWIwWDlFcWJVbTFQcjcyTDNUcmJMcUY3M0VBemJxbnhFTkVX?=
 =?utf-8?B?YjJWanhORXRIcVd2dFpxZkY0a1M3c2UzM3FhcTNBR0ZuTXBBV2xpV29pOVZm?=
 =?utf-8?B?NXFURGY4SE9Yd3RzZW8xVzNhUHRsZ3hLZTAwRDZuWk5zMEsyeGg3ckZPdXl1?=
 =?utf-8?B?QzRKMDB2c3dGajNBZjRzMmQzNkFYUVJpMjFHMUlKa3VMTGJJK0ZJazM5Wmd0?=
 =?utf-8?B?UUxsWUs2eFptREo4TzFjdnNhNzlINkxpZlEyeWRkTnQxd0pmREttcjhSQkRT?=
 =?utf-8?B?cEM3VnY2ZTV5dGFCVVhQVGNIMUozQ3ZNSUk4SXBzYlkyREM5Nzl3OVphNjhE?=
 =?utf-8?B?MkxzYUx5L2pmMEhXVmlZb244VFNIbnJJTUNaQmUzR042UHptTlNwdnFDeTJJ?=
 =?utf-8?B?SEdFOFNMTERwWDJ2elBQaEVmUkVyTmhIanFwQWhTVy81eDVDZUgrMmRkM2tY?=
 =?utf-8?B?M0xsb1ByVDVLMXZEV0hNeS9HSUlhYkVSNG53Q0dwUTE2Szd1VW9TSXVtclo4?=
 =?utf-8?B?UFR2ZGRQbEg1bDFuQnN0UEpaMVdaWTRralBKSHg4NCtja29tbHRTQm5QaFpo?=
 =?utf-8?B?UHBwelMzT01zOEl1RzhQaGNSZ2FCd09sTTJpNlRBUkgxb0JUc0JCNi9xVmxs?=
 =?utf-8?B?WnBEK0tBYWZFSk4ySWR1OE96bU5XajFBNEVnWCtOQm1udWxERFF0Sittd2pO?=
 =?utf-8?B?Vzd0K2c2ODU2anQyTFhZRWFZK0YzTDdQdXB5NlI4c2RBU01leGw1cW1FQmRB?=
 =?utf-8?B?U2s0UWYrV1dXVE05d1RrWDlsbzNsWC9TWVpjV2NNc0gzL0U3MTFBSE9ST2Vz?=
 =?utf-8?B?bmpkRU9wdTdVMThJUTBsQTkrVDRFVW5HeFNhdklKN1dCbzBrYWFFYURFUm9V?=
 =?utf-8?B?MEhxbjB4S205MzU0VXZtU3pGeEphbXJ6VXFueDQrN0d5ejdmV3djMFR0R1E3?=
 =?utf-8?B?dE42S3ljM3dsMWFaa2lWMkx4ZjNQc0t1RHVPQ3JOL1JyeW5odGtLaEpkcDdG?=
 =?utf-8?B?ZXhRYkZoUDBPcTlZRmViU01aRXpjeERiVHBwQUlaWElLbGkvaFhtMk5Gd2tq?=
 =?utf-8?B?dGl5NWlUODhVZHZKQlQ2MVVVSlVBTHRob2NJUEZsdGhWUFQ5OUxaaWZKK1cr?=
 =?utf-8?B?c2s1b3M5YWtiWlZqTDI4NnE4ZUVXV3dyTVlRMGMxYXVFZ1I3ajdGMmRDbEF1?=
 =?utf-8?B?WTdXeHdvOFVKNmpGVDR3UWt5U1hrY3NBdUl2Rm9WQStObEY4djFtQ3JqQ1Ft?=
 =?utf-8?B?M0w3UjlYTXFGRDFsMzlVdnlsV0dqdTZadXdZUmM0bHU3amtTdmZLeXVJMkdx?=
 =?utf-8?B?WnJwbWRhUmcyMWFUZUNuMjMzL3dzZTl0dzJPNUZuNmJFVnFuZEU4TWlXbStJ?=
 =?utf-8?B?RERQbEtxTDVmeXJLSjk2NnpLeURFNVpyN1pjT0Vvd3E3R2FwT0lmK2RNcWlI?=
 =?utf-8?B?UjJZYmc3VnNVWTZRb3VBMExlcEhkWS9DZXhtMjUyOEdSczZkTkwxQm1qZnNz?=
 =?utf-8?B?dWVnTS95UXgwek83bmFpV1FmTGFTajMxSGhYalN0SkJ1V3h0K1IxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eff4796-7221-467d-7dd1-08df4330c8aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 15:54:51.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1D84jm98qYsRk48xbuTQXIleM994HB6i8FK+fOQRYC+XQuZnLOd4vqLUr+qmQfOcGaYGVGmsZ2swSzUT2KNTAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6754



On 11/14/26 09:03, Vishal Badole wrote:
> AMD heterogeneous processors combine multiple core types (e.g.
> performance and efficiency cores) whose maximum sustained performance
> and frequency differ. On such platforms the Linux scheduler relies on
> per-CPU capacity values to place and balance tasks across cores.
> 
> Today amd-pstate does not export any per-CPU capacity information. As a
> result the scheduler sees every CPU as having identical capacity and
> treats performance and efficiency cores as interchangeable. Tasks are
> therefore placed and balanced without regard to core strength, which
> hurts both throughput and energy efficiency on hybrid systems.
> 
> This happens because the scheduler defaults to a uniform
> SCHED_CAPACITY_SCALE when no arch- or driver-supplied capacity exists,
> and amd-pstate never feeds the asymmetry it knows (via CPPC highest
> frequency or the effective highest performance register) into the arch
> hybrid capacity scaling interface.
> 
> Enable capacity aware scheduling on AMD heterogeneous-core processors.
> Use CPU 0 as the capacity reference, assuming it is a highest-performance
> CPU on the supported platforms. Cache its maximum frequency in kHz and
> effective highest performance once before driver registration, treating
> these reference capabilities as fixed for the lifetime of the system.
> During per-CPU initialization, compute each CPU's capacity relative to the
> cached reference and publish it:
> 
>   - When maximum-frequency data is available for both CPUs, scale by
> 	 frequency via arch_set_cpu_capacity().
>   - Otherwise, fall back to performance-register based scaling using the
>     effective highest_perf values.
> 
> Record frequency availability before applying the per-CPU fallback. Keep
> frequency and performance references separate instead of interpreting a
> boost-ratio numerator in performance units as MHz. The fallback base
> frequency still depends on each CPU's nominal frequency and performance,
> so calculate that conversion per CPU. Disable CAS if reference setup fails
> without preventing normal CPUFreq registration.
> 
> Capacity aware scheduling is enabled by default on supported hardware and
> can be turned off with the "amd_cas=disable" boot parameter. Its effective
> state is exposed through the "cas" sysfs attribute, and also exported via
> amd_pstate_cas_active() so amd-hfi can stand down when capacity aware
> scheduling owns the heterogeneous cores.
> 
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> ---
>   MAINTAINERS                  |   1 +
>   drivers/cpufreq/amd-pstate.c | 102 ++++++++++++++++++++++++++++++++++-
>   include/linux/amd-pstate.h   |  14 +++++
>   3 files changed, 115 insertions(+), 2 deletions(-)
>   create mode 100644 include/linux/amd-pstate.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 222b7fc2c3aa..26217272be95 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1324,6 +1324,7 @@ L:	linux-pm@vger.kernel.org
>   S:	Supported
>   F:	Documentation/admin-guide/pm/amd-pstate.rst
>   F:	drivers/cpufreq/amd-pstate*
> +F:	include/linux/amd-pstate.h
>   F:	tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
>   
>   AMD PTDMA DRIVER
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 4bedfbfc18b6..59eb2c4c7867 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -29,6 +29,7 @@
>   #include <linux/smp.h>
>   #include <linux/sched.h>
>   #include <linux/cpufreq.h>
> +#include <linux/sched/smt.h>
>   #include <linux/compiler.h>
>   #include <linux/dmi.h>
>   #include <linux/slab.h>
> @@ -39,6 +40,8 @@
>   #include <linux/power_supply.h>
>   #include <linux/static_call.h>
>   #include <linux/topology.h>
> +#include <linux/cpuset.h>
> +#include <linux/amd-pstate.h>
>   
>   #include <acpi/processor.h>
>   #include <acpi/cppc_acpi.h>
> @@ -86,6 +89,10 @@ static struct cpufreq_driver amd_pstate_driver;
>   static struct cpufreq_driver amd_pstate_epp_driver;
>   static int cppc_state = AMD_PSTATE_UNDEFINED;
>   static bool amd_pstate_prefcore = true;
> +static bool amd_pstate_cas = true;

As this strictly requires SMP support, what do you think about this 
instead to pick the default.

static bool amd_pstate_cas = IS_ENABLED(CONFIG_SMP);

> +static bool amd_pstate_cas_initialized;
> +static u32 amd_pstate_ref_freq_khz;
> +static u32 amd_pstate_ref_highest_perf;
>   static struct quirk_entry *quirks;
>   
>   /*
> @@ -957,8 +964,8 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>   		return;
>   
>   	/* should use amd-hfi instead */
> -	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
> -	    IS_ENABLED(CONFIG_AMD_HFI)) {
> +	if ((cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
> +	     IS_ENABLED(CONFIG_AMD_HFI)) || amd_pstate_cas) {
>   		amd_pstate_prefcore = false;
>   		return;
>   	}
> @@ -969,6 +976,64 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
>   	sched_set_itmt_core_prio((int)READ_ONCE(cpudata->prefcore_ranking), cpudata->cpu);
>   }
>   
> +bool amd_pstate_cas_active(void)
> +{
> +	return READ_ONCE(amd_pstate_cas_initialized);
> +}
> +EXPORT_SYMBOL_GPL(amd_pstate_cas_active);
> +
> +static bool __init amd_pstate_init_cas(void)
> +{
> +	int highest_perf, max_freq;
> +
> +	highest_perf = amd_get_effective_highest_perf(0);
> +	if (highest_perf <= 0) {
> +		pr_warn("Invalid reference highest performance (%d)\n", highest_perf);
> +		return false;
> +	}
> +
> +	max_freq = amd_get_max_frequency(0);
> +	if (max_freq < 0 || (u32)max_freq > U32_MAX / 1000) {
> +		pr_warn("Invalid reference maximum frequency (%d)\n", max_freq);
> +		return false;
> +	}
> +
> +	amd_pstate_ref_highest_perf = highest_perf;
> +	amd_pstate_ref_freq_khz = max_freq * 1000U;
> +
> +	return arch_enable_hybrid_capacity_scale();
> +}
> +
> +static void amd_pstate_set_cpu_capacity(struct amd_cpudata *cpudata,
> +					bool highest_freq_available)
> +{
> +	unsigned long capacity, max_capacity, capacity_freq, base_freq;
> +
> +	if (!IS_ENABLED(CONFIG_SMP))
> +		return;

 From what I can tell; I don't think this is realistically something 
that can get called since you already check to enable CAS based on this 
same check (IS_ENABLED(CONFIG_SMP)).

So please drop this check here.  More later about IS_ENABLED(CONFIG_SMP).

> +
> +	if (highest_freq_available && amd_pstate_ref_freq_khz) {
> +		capacity = cpudata->max_freq;
> +		max_capacity = amd_pstate_ref_freq_khz;
> +		capacity_freq = capacity;
> +		base_freq = max_capacity;
> +	} else {
> +		union perf_cached perf = READ_ONCE(cpudata->perf);
> +
> +		capacity = perf.highest_perf;
> +		max_capacity = amd_pstate_ref_highest_perf;
> +		capacity_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf);
> +		base_freq = perf_to_freq(perf, cpudata->nominal_freq, max_capacity);
> +	}
> +
> +	guard(mutex)(&sched_domains_mutex);
> +	arch_set_cpu_capacity(cpudata->cpu, capacity, max_capacity,
> +			      capacity_freq, base_freq);
> +	topology_set_cpu_scale(cpudata->cpu, arch_scale_cpu_capacity(cpudata->cpu));
> +	x86_topology_update = true;
> +	WRITE_ONCE(amd_pstate_cas_initialized, true);
> +}
> +
>   static void amd_pstate_update_limits(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata;
> @@ -1043,6 +1108,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   	u32 min_freq, max_freq, nominal_freq, lowest_nonlinear_freq;
>   	struct cppc_perf_caps cppc_perf;
>   	union perf_cached perf;
> +	bool highest_freq_available;
>   	int ret;
>   
>   	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> @@ -1069,6 +1135,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   
>   	/* try to look up from BIOS/quirk first, fall back to (nominal_freq * highest_perf)/nominal_perf */
>   	max_freq = amd_get_max_frequency(cpudata->cpu) * 1000;
> +	highest_freq_available = !!max_freq;
>   	if (!max_freq)
>   		max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
>   	WRITE_ONCE(cpudata->max_freq, max_freq);
> @@ -1100,6 +1167,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   			 bios_min_freq, cpudata->cpu);
>   	}
>   
> +	if (amd_pstate_cas)
> +		amd_pstate_set_cpu_capacity(cpudata, highest_freq_available);
> +
>   	return 0;
>   }
>   
> @@ -1923,12 +1993,20 @@ static ssize_t prefcore_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>   }
>   
> +static ssize_t cas_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_cas_active()));
> +}
> +
>   static DEVICE_ATTR_RW(status);
>   static DEVICE_ATTR_RO(prefcore);
> +static DEVICE_ATTR_RO(cas);
>   
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
>   	&dev_attr_prefcore.attr,
> +	&dev_attr_cas.attr,
>   	NULL
>   };
>   
> @@ -2438,12 +2516,23 @@ static int __init amd_pstate_init(void)
>   			return ret;
>   	}
>   
> +	amd_pstate_cas = amd_pstate_cas && IS_ENABLED(CONFIG_SMP) &&
> +			cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES);
> +
> +	/* Enable CAS for processors with heterogeneous cores. */
> +	if (amd_pstate_cas)
> +		amd_pstate_cas = amd_pstate_init_cas();
> +

This seem to be a pointless variable initialization, especially as it's 
a global variable and this runs on non-hetero systems too.  Maybe 
something like this:

0) See my previous comment about where to use IS_ENABLED(CONFIG_SMP).

1) Change amd_pstate_init_cas return type to void.

 > +static void __init amd_pstate_init_cas(void)

2) Add checks into the function like this:

static void __init amd_pstate_init_cas(void) {
	if (!amd_pstate_cas)
		return;
	if (!cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
		return;
	.
	.
	.
	amd_pstate_cas = arch_enable_hybrid_capacity_scale();
	
}

3) Change the call in this function to just:
amd_pstate_init_cas();

That should help avoid some extra variable writes.

>   	ret = amd_pstate_register_driver(cppc_state);
>   	if (ret) {
>   		pr_err("failed to register with return %d\n", ret);
>   		return ret;
>   	}
>   
> +	/* Per-CPU capacities are set during registration; rebuild domains once. */
> +	if (amd_pstate_cas)
> +		rebuild_sched_domains();
> +
>   	dev_root = bus_get_dev_root(&cpu_subsys);
>   	if (dev_root) {
>   		ret = sysfs_create_group(&dev_root->kobj, &amd_pstate_global_attr_group);
> @@ -2484,8 +2573,17 @@ static int __init amd_prefcore_param(char *str)
>   	return 0;
>   }
>   
> +static int __init amd_cas_param(char *str)
> +{
> +	if (!strcmp(str, "disable"))
> +		amd_pstate_cas = false;
> +
> +	return 0;
> +}
> +
>   early_param("amd_pstate", amd_pstate_param);
>   early_param("amd_prefcore", amd_prefcore_param);
> +early_param("amd_cas", amd_cas_param);
>   
>   MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
>   MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
> diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
> new file mode 100644
> index 000000000000..eb750abd20f7
> --- /dev/null
> +++ b/include/linux/amd-pstate.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Public interface for the AMD P-state driver.
> + */
> +#ifndef __LINUX_AMD_PSTATE_H__
> +#define __LINUX_AMD_PSTATE_H__
> +
> +#if IS_ENABLED(CONFIG_X86_AMD_PSTATE)
> +bool amd_pstate_cas_active(void);
> +#else
> +static inline bool amd_pstate_cas_active(void) { return false; }
> +#endif
> +
> +#endif /* __LINUX_AMD_PSTATE_H__ */

