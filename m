Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794636243;
	b=UZNtQBFxm61lkD33OdddNeZ1b24Xowg5PCcqk9ydBoISHckom6tZ5P6CmJwL8jt5qZuR
	 X7arc0fEitBQV0uDLB2LCE0r26FARVwUoYk2CRgp9db+9xV94bswFGHJwj3DNTMTC9f7e
	 tKDzClj80eyAUAvpaJ2XabyVRC1lvafjV6VxelwwrScU9tiV5OSiDpNMKFfoDEWKMYZpc
	 CsvAOUuhH1+dqHXSHijn8uJRe5PldyQe6G3hINTlDTRsfh4oimNUWiW+ArQhbUD6l+y17
	 bJQm4Rb/JQDDQBh+Tq2VKK35edSlpS40423tgHvJu+ewnpk8ok3ixpCkQawVesIng2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636243;
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
	bh=Z+FmwTmIuc4DYnbuf4VqDbrhUfdUlEolp+dQf9/903s=;
	b=ZNpWRqOcsTOajsLhh/svzDE6q+nvao1v3YMsGonmvDIr2OfjqmtgNIRRG5K8iaCEvwca
	 BG68oNZP1KbIHdtfpQOmx3noPkqRyCdDMPLjkIsmuzDNztcnYX4POkcfJLYbunn+1LNJF
	 eay0DrNFqFt//l2Ce3MWl9HYqdbsxxINMK97vddrFIf5Tcl6QyTyATCG42v64ARr5ra2s
	 sWBf1ZIaWNBarqdoLofbMJHy6qJWoOJZPBkbseP38AJuZ3Uy5mir7PPfGPDqMfYSMhYQX
	 H5iCm00rJ1f5Wqs7Goj/Lb3u6XkeJbJsJFeHN3DaJi4pv3SYGToQM9E7eivI5H6Bzsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lweKhrQF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.21
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABC0606A32E;
	Sat, 14 Nov 2026 06:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ABC0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lweKhrQF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIlxBZ7qQU6RxULxfCzk8ZBqU/LSjECP6cgdN2uVxMS3AkHaJ4G8XXMdIIDXXbADruXwFkuIoBUw//Y2aPiW8Ysxh+PbzKWfxAwtfzQgZzwDtlyLTQMSn+34K3linDsXwDgBtB/4YSUCOE5mQG+iWLZobSAOyekQIQes3+Lu2vRS6km8ldb82HTalJwvhyohQclfDNYcRYmD72zgXL9vMK5a2nKWYeFfd7Bqy3k3QlDg89Uc7SSUR4IXQrSgZ7iontkqeEpDn1sx23LZWfWbKsXnDOOhKJ6lHsHg/yJXhowoCvmLw3m3vR4ed3q2WskS9TOaob9ryUz5t+4WhISfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+FmwTmIuc4DYnbuf4VqDbrhUfdUlEolp+dQf9/903s=;
 b=JdeMRhFigCQnRw5elMVqYZoiT64IwYL8XNtHv8r19ex9R4nBpKpZr7HMv2TneKvs26hK3RBqMruQ+Gpk8Mairc08dlca+F0rfMCffzkb9G2vgnV8T1lFZ7dw8ukEyw1r3TsKv478aDXjw7OcJnwxWFJkaoopbug1LE1m0FtO1JvLXvubPPNYWE0zN1jSsjyDxuvRxdb4DPZ+ZJZZvOuwmyLKtgl/13SxZSPYK657dUVut7S3frV7hABur1dt+mWiqNcXDuR0pxlgoQORAYum7c4kxFCh4zU/ePxNY8uzWv2TTVGNQYlLzvwhy3JL6wQT904ypGiDzSzlnlxTEMUKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+FmwTmIuc4DYnbuf4VqDbrhUfdUlEolp+dQf9/903s=;
 b=lweKhrQFaFwcaZo8onZFZYM5JzL1PBVKxMQSmGCy78P4KvIjdw5ItYnLuy3ZuhERNXWDKhoMm/cD5h+DG+aMtXeG5hL3nR3dmK8q8cPBGSC7yCAv6wJ9bGw80Ozy/oSDVHBaZYrSWYOehaUOIKsDpD2PEykLhcT2vpejhM3JN40=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by CH1PPF73CDB1C12.namprd12.prod.outlook.com (2603:10b6:61f:fc00::615) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Sat, 14 Nov
 2026 06:03:58 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 06:03:58 +0000
Message-ID: <b5c6453c-2db1-4cab-950a-1c31a56e36cf@amd.com>
Date: Sat, 14 Nov 2026 00:03:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86/amd/hfi: Enforce Zen 5 vs Zen 5c
 asymmetric capacity and V/F knee ceiling on Krackan Point
Content-Language: en-US
To: Aiden Hecker <heckeraiden@gmail.com>, Perry Yuan <perry.yuan@amd.com>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <A> <20261113012639.464343-1-heckeraiden@gmail.com>
 <20261113012639.464343-3-heckeraiden@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261113012639.464343-3-heckeraiden@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0070.namprd11.prod.outlook.com
 (2603:10b6:806:d2::15) To PH7PR12MB9174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|CH1PPF73CDB1C12:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b47b48f-19c8-4cae-dec6-08df4215125a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|261026140227099003|56012099006|4143699003|261009223027099003|11063799006|261028144727099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261102123227099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	jOOpessSPS0PV9vr1A/oIs/4CzLGWdBx5ybj2WLUNlXIq7ELRMiqXBfXIXoBQHXs24euI2L3tuRDdVTrY2IoElz3QsgvUznwAPCEYvDcpvz+VgwWiciBrNLRJtjIeKOcxMIlyi0Gn35a5PRf8QwIlyPr3z7Xvsc20P3zsN8kV22GsbZUlrJA4afwBf0qHRTaoIzrAVpmjzhLccuBpTmHyECZ+tV7xVOeGZ4BNj9h9nqUQNYmTAfNoJ+Ftvq8sQpSeHcg0rqbFIRnyimxbR46BJOUM0Q7ognqtScQgM/5ICTWeXGCko5K4X4NnZALT08sSwI2I/AtC5SvC5d5V0PNHdG3W2mXRUDmjuuwLHBGckKPQ6heUNaT3YUUOnk7dcpIkXcdZEDaKYRVcDv6XgKDiPF1iUb1DvIx3oeizmlVN0uH7CocUWsloXs3oYVmsxejmBE228cd5DAdb5hAi/FB+L+wwnmZ0j0OHaj5QKASkl0HqmPV1Mb3D9JPdWWg7v+PsdaDP3SSfGTsrrmHOtS2C54EVUvd+/xsM9S1DHeI3EOym49+H8tlYpSMqDjsXXHHU+Sm5WvNRtF2jqFxhmitsX0aA2g8UISVxy3Jr0rC/k+uk4tpJLxu57JXZFtn5lMFguEz09mDnMKIY56B5ifqE+QM9UK+1M9Y4iAZ1FYtYwQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB9174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261026140227099003)(56012099006)(4143699003)(261009223027099003)(11063799006)(261028144727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnB0Nm5KcUJSQ1BMTkg5WGkyL3h3ZTcxMkhvMHE3VE1kQ3c1SGM3VndWZFlW?=
 =?utf-8?B?RmRsWjJqSTMwM0V6MXBQTFlCR3Z3RkdESlBBYlEyZDhmejY3ZFgxRTRSL0VC?=
 =?utf-8?B?L1RTTGlmVkprMGlGdXVuM05ldHF1Zk53Ni85cXEvY0g0UVNYUFRDVUVaRXEw?=
 =?utf-8?B?d094U2FwbWdGNHhhSHhjc2dPeE5lMVUxSDFKTVFPbTY2eVZCRnNTbjNFM1U5?=
 =?utf-8?B?UUExdmdkVFRhU3REclprMzhoZ2k5SUFFTnpWOHhBUE1leTRTczl1ckplaDF1?=
 =?utf-8?B?N0gydVVMZW5EZHRGN3FzU0FLQUNtMnNGZkFzcmh0Ynk3YUQ4bHhMRjQ5aHNa?=
 =?utf-8?B?T2VndTMzNkhta3drdWg4TkVuMzA1aERlcnlDVm9KaVdJdDAwNlJTMlNQeWtS?=
 =?utf-8?B?R014SGlLWGQyN2gxb2h3cEpFaHdtdVR3dTZ4RzJtaHZlZStZbnNVdWF0M05U?=
 =?utf-8?B?M0Z1RlRpVG1sQ21UN3J3dUVWbEVRdTg5YXl4REt5R09iYmlYdHZhUnBDdlRy?=
 =?utf-8?B?R1cyMnlBN3Z2WGM3bk8rc2YzTVl5dHdxTnhPbFlraG1sRGtOcWlHeFMvczRv?=
 =?utf-8?B?alEzTVBwT2xhK2RRR0VZMk9TWGNQNXpsSlp5eVJxMEZOWnBzcTRTZHZjd0kv?=
 =?utf-8?B?blF4cDg4YzFhZ1FzTXF4L0xTcUZhOHpaMmdubTM5UnNnencyVTN3NmNPR21M?=
 =?utf-8?B?YnlZYXZva0lzMW1Ba1c1K0ExTEtFOHROb3FyQXVJdXlYMEJJUjNFSUhmd1Fr?=
 =?utf-8?B?L1R3eDJ3YVZXNDVkSSthRlFxMHI1ZXhyTUZISEphT096R29YSDBkUEtXeXBI?=
 =?utf-8?B?cTMvSDhJeFN3K3hybXpVak1HdWMyc0lDVFVmbTZnOTVVZ1RjblVuMlVvbnpT?=
 =?utf-8?B?VVdSUlloTGxwcUV2aHJsZEZXdXNvaEtkZ1ZiWW1YbEg3aXpGbXN1V0N3R0pw?=
 =?utf-8?B?TnNHNWVwUWd1eWgrTHFIUXJLRVNwajJnSlJTSnhuaGpkcy9MbUhNZGFDNnVR?=
 =?utf-8?B?eHg1dFkrL2Z0QkxON2FXR2RnZHg5M21Yb2NnS2FRc0QwRWIyMDR6RE5QK3dT?=
 =?utf-8?B?b0NwSEt6NHc2c0RvYU1qOE5KVWJzeGhBeW9nUjhyUFBucTRKR0lCNmlvUFFp?=
 =?utf-8?B?SC9aemZ0REhVTzFVRWVZR24rc2kxUnZ6RTZhaVlURmpzcmpBM3lIN2xCYnRB?=
 =?utf-8?B?bk9mNmxqOU1Ha3hkeUg4aWprTEdGdno5KzljanhwYWRnUi9OZlUvV0VDM1Yz?=
 =?utf-8?B?ZHRCQ3k0dFN0Z0U2U0k5VmdKLzIyWTYxN0JkdmpHRjZNaUljSk9wM2dhWGI1?=
 =?utf-8?B?MmN6eFVFWHJ6RVZMU1NjY1BZKzAwNFdmdDFSZ1RabjJ1bFVYRnNNYkQ5SDQ2?=
 =?utf-8?B?d1RhZW8rNS9yV0NmNENqOTVrd203T0tkZ0k0NXZhbXFNNGhZdzQyMCtrR05F?=
 =?utf-8?B?YVUzcE9qNnhhd2x0NmFjOHFnRFB0bUwveE1OQjBiQlFqVTk5OGxYZXFoRzYr?=
 =?utf-8?B?akh2OGtZNjNkd2xzVkhFOXA0T1FGYitTVWZzYUdNVC9mWXcrbTJidGhxUmdM?=
 =?utf-8?B?N2hLRmRRb1VUU3htenJhem9XbTNJRXluV1JjZGY5Y1dYZHJ2dEQvbEcrUmxC?=
 =?utf-8?B?M0JncEZoQUxzME0wR2VQdEJ4VXg1eUR1R0ZpdzhhUEI1NXNEdi9kWmJUNDJn?=
 =?utf-8?B?N1RjQThsdy9naUFlRkY3bHNwWHpBNmduOHdYZnhxQURkSVJhVmNNblI3bnp3?=
 =?utf-8?B?cGtpZjRKak00U2hJZjRkaHA2MzhhQnAzMjBWT3BmRC9OU1A3QU1YY210cjJu?=
 =?utf-8?B?UEd0Y2FUVHJ6cFJVVXpUZDY4NnE4T04rcHVJc1V3Z1ZnL3hycURPbTljZW9H?=
 =?utf-8?B?Y0hlNVBGbTNONG0wTWozR2FpTUc0NWhzUkViZ3JFTzJSWWlJWWRMdmJSclZY?=
 =?utf-8?B?MVBSenFFWDJraWRHMzZmT3htV1VpcGNVRk9UWFdXYXE4cktTNjVqSUlNcVRK?=
 =?utf-8?B?aXEyY3pzNXQ3NElvL0kxYUZsai9ad0lrbk1mcXJrSkk4bmptMnFrOWoxUTdL?=
 =?utf-8?B?NWMycng0YXl6dWdvNW9MMmpyMjJtdUJxVERZZ1pYcmhwbmZYL090LzFpUDZt?=
 =?utf-8?B?VkJGQ2puTXhTL29YTVl1ajRsOXRRalJkTHd6RjNGUllTWktLdmZZdWlubnl6?=
 =?utf-8?B?eEsyV21ibUFIbVdvSVVKRjc1VEpNVWM5SldlVDRCakRwZTY2cGZGVnVXK01Q?=
 =?utf-8?B?UnNvMGo3eGhjbXRnd1kvWUVEaEcvWWljbVgzekdIbStrMkNuSzVMNEF5RHNr?=
 =?utf-8?B?Tk9KZkVKc1BSMDVqdUFEQkNFTmtzQi85M1NmNVpCZ0RVVUhmdWY2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b47b48f-19c8-4cae-dec6-08df4215125a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 06:03:58.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NH8QPG1psfZiC2R9k8Y5qA8JHmmJNla/VNAUfbOZRXXvrOgr+L6ci3QceLWoO7yobXsGYE+3y7CL4CUHk0QYMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF73CDB1C12



On 11/12/26 19:26, Aiden Hecker wrote:
> When `amd_hfi` (`AMDI0104:00`) initializes on AMD Family 1Ah Model 60h
> (Ryzen AI 7 350), the SMU populates 3 workload classes in shared memory.
> However, high-entropy interactive threads can still suffer either:
>    1. Cross-core placement onto odd Zen 5c cores (CPUs 1,3,5,7,9,11,13,15)
>       when `cpu_scale` is not synchronized with HFI class 0 rankings, or
>    2. Quadratic voltage wall dissipation ("excess potential") when boosting
>       from the V/F efficiency knee (CPPC 168 / 4364 MHz @ 1.07V on Zen 5;
>       CPPC 116 / 3013 MHz @ 0.94V on Zen 5c) to the upper voltage barrier
>       (CPPC 208 / 5091 MHz @ 1.38V), where +14% frequency costs +67% more
>       energy per instruction (996.1 pJ/instr vs 595.5 pJ/instr).
> 
> Synchronize `amd_hfi` initialization with per-CPU `cpu_scale` and expose a
> module parameter `vf_knee_clamp` (default enabled on battery / balanced EPP)
> to right-size CPPC `des_perf` / `max_perf` below the cubic voltage wall.
> 
> Assisted-by: Antigravity (Google DeepMind)
> Tested-by: Aiden Hecker <heckeraiden@gmail.com>
> Signed-off-by: Aiden Hecker <heckeraiden@gmail.com>
> ---
>   drivers/platform/x86/amd/hfi/hfi.c | 42 ++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 19c42e88a310..7e91f0a21455 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -24,6 +24,8 @@
>   #include <linux/platform_device.h>
>   #include <linux/smp.h>
>   #include <linux/workqueue.h>
> +#include <linux/arch_topology.h>
> +#include <asm/topology.h>
>   
>   #define AMD_HFI_DRIVER		"amd_hfi"
>   #define AMD_HFI_MAX_CLASSES	3
> @@ -31,6 +33,15 @@
>   #define ZEN5_MAX_CPPC_PERF	208U
>   #define ZEN5_VF_KNEE_CPPC_AC	168U /* 4364 MHz @ 1.07V (-40.2% pJ/instr vs 1.38V wall) */
>   #define ZEN5C_VF_KNEE_CPPC_AC	116U /* 3013 MHz @ 0.94V */
> +
> +static bool vf_knee_clamp = true;
> +module_param(vf_knee_clamp, bool, 0644);
> +MODULE_PARM_DESC(vf_knee_clamp,
> +		 "Clamp non-turbo bursts at the CMOS V/F efficiency knee to avoid quadratic pJ/instr overdrive");
> +
> +static void amd_hfi_sync_hetero_capacity(void)
> +{
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		u32 eax = 0, ebx = 0, ecx = 0, edx = 0;
> +		u32 core_type;
> +
> +		cpuid_count(0x80000026, 0, &eax, &ebx, &ecx, &edx);
> +		core_type = (ebx >> 28) & 0xF;
> +
> +		if (core_type == 0) {
> +			/* High-Entropy Zen 5 Core */
> +			unsigned long cap = (cpu < 8) ? 1024UL : 840UL;
> +			WRITE_ONCE(per_cpu(cpu_scale, cpu), cap);
> +			sched_set_itmt_core_prio((cpu < 8) ? 208 : 172, cpu);
> +		} else {
> +			/* Low-Entropy Zen 5c Core */
> +			unsigned long cap = (cpu < 8) ? 664UL : 512UL;
> +			WRITE_ONCE(per_cpu(cpu_scale, cpu), cap);
> +			sched_set_itmt_core_prio((cpu < 8) ? 135 : 105, cpu);
> +		}
> +	}
> +	sched_set_itmt_support();
> +}

Similar feedback to your other patch.  You should use existing defined 
feature flags and topology information.  You also can't assume that the 
world is made of Zen5 cores.  Things aren't the same on newer 
microarchitectures.
