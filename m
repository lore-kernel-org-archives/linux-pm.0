Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011017.outbound.protection.outlook.com [40.93.194.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA5C4973B6;
	Thu,  8 Oct 2026 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463101; cv=fail; b=ikb1h+tgx77Q6sD3VJ7WcoYtWxfgr2t0Fr6++7kXSCiEL7irhu4UahNQ0x5XlGbu/EnnNRpgYLRnj1q4MSd762x/dhWzaij+5jKMNVegooCbAhzDxQc1zThfallLa0Mu2uSjVmaJvYu5yrjskiA+QNK62RX0XKTZja5J/IG1OjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463101; c=relaxed/simple;
	bh=W99GBuWIzYPiJ0yOjoDU/XbgBuQTMu6sMrt8us++SwY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oTdFMGNWuWjLqzL+qTCBAM9trQ6r1c6qQhTMp53yTM3rWOTfnvXD7Z/CzgyNORbaO+VKxI3kuqbHugzL8jJmuP658mrzjYiF+fwG1Sj6UhOrEYV8+vvJZzrU4bMU1CSqdRaNGn6sUN6a/IilQ+Tre2LOSslfArmMFRBt/u4VfJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M7qFFLfr; arc=fail smtp.client-ip=40.93.194.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M7qFFLfr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJAaNhk97dFRY3gLvwjZYjWBVPpkwd+3dhkPxZNoafzYu5dpTxXNPQvx7NoYRHC2Rls7OuWYapsQeIX4e3KdLvr+6AKJiUMmIEtJAfQc4weIyHnV9VQ0gQm0Cih3B2rrAHLO5HBeTqDl59n+MDK9HAZMmtieimpoQNXiWLyP97HRaEjn8Gy7APOw6j1j+YCFNs3ImU0P5mYBlHpxWiCbkIdYYljWwXH8uo/L7ZXP1CfxuRQbt71iLOogF0UzxP12KabmYdIIHzXyggrFOJt6W4Kkwnh+lZQcOObO5MKI0VEgHSvzdvotWA37wUpCJ5NoDypkLSMih7hIB0l8+FBh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxObsGAnrRHwxgLHoKJApxtASl1nG5pbvp83vRwvZqY=;
 b=OaySMa+0OCEK/5pBl60siXSSVZeoYW14B5xRVxuBZnBgUPS4rW+TD7WBGtQcdkMM21uSY4qwTm+1LIr/KTbNgGP+vBblUppoDTLmBSgCqcMOG3WUHFWSf2QUHFZyOjlcjX3ciC1iscDuOBPm7CfnvuPXzXnp+WakzVwozMcwi/wYoCX2k2I/FBOBJbDTo/VPvvigtiUohhDzAUczsM7RuxMfPuAMDwgys4l0yrYNJR4YQrNJNOclOFwHzhWKffK+ziuO4JHWsTcdn66HtMXn1nR3kXX211jq8amiL8y1bLRczhfYiJ22DjOin5o7wZ4JjldypA3xnrAc3qa3ATxk2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxObsGAnrRHwxgLHoKJApxtASl1nG5pbvp83vRwvZqY=;
 b=M7qFFLfrvniyMmpt3r1cCPB7VcD1BEk2JUsl62pjktISrjz6KCm2V33RbAmoSEwxK7b0kcxJe+FnddKmCkzqJLB6lQ7Z+GaGrIG0m9IaUTZFcYgB2nW483LHJ+xarQgtzMj1OTKLFYvvmRnUobHlN3WOizeDIndJjuPj4m57Ii0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 12:38:17 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 12:38:16 +0000
Message-ID: <021964cd-404f-4df7-8e40-a4a41490ea4c@amd.com>
Date: Thu, 8 Oct 2026 07:38:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Supply nominal/lowest freq for
 TRX40-based motherboards
Content-Language: en-US
To: Giovanni Gherdovich <ggherdovich@suse.cz>, Huang Rui <ray.huang@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261007144150.15113-1-ggherdovich@suse.cz>
 <27b226c7-f30b-4863-96e6-6798232863c5@amd.com>
 <93531c5c-5638-4a20-919a-8471a7222218@suse.cz>
 <ab7921dd-1a28-4df4-a4a8-718e1489ec33@amd.com>
 <93ad2855-d876-4df3-a105-f08d93dc7d7d@suse.cz>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <93ad2855-d876-4df3-a105-f08d93dc7d7d@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0048.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::23) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: f20784c2-f952-453c-20bb-08df253906ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1OfKttcSy0joXy6jM10b3eVIFLEAO8XuZQUyrd61rN6L6b7zm2QgXFYAOBCY3+JHIwGgGsb/njJ5ZKSYmRa2q57919MTii/jXva4o62iJFdGZb7q/3WJqunIKE+LRmHJMBg7wVwJQhqKgKSRbAGbV/ifIhG7IMIrdaN+vOnADcAwP2Y/mnpyQKjmD2+gh4GAOiGbmFObrGOK9b6VvHjZkTzT/lRKBCBw59cKbqaYD+4fpYtBDd60L7narh27aAF2Qt3qNP1oEJpzK9RVk/QnHCudBlrcrNcUgeZ5/iSwFE+3Ekmafy0s6O2zkLkOMsGwAsdQg338w348RFg1R/MuvZIw3tT+XTSpm9sDc8Ui9mUjJjjEC4lum0n1AmgXZNuPJ/Q+KRPZXxk3S/W0eKlauAAfS4mveWeQ6smJZ9nFJiI6W6fUIYkJf4Jju4w6zGIZVFJx7j1Mj+SpQXeP1DlJIUGa1kBbNca0/MqJ4jjCsmxm4XMUmcA2v9MXj5IVpRxkPHZRw+EQw6P5tN86Xdl+crYETnSrShsexyLY9w/PQ1Aj6LDu9y/jhu901kbrb/QtawPaZ0uDcp3Cv4zNOmyG1TNY9RuHANyMyiREhaRNf2HNku11CxVUbjA7knXeZ+FEnM4/q1Sb1KDKPfAV4+plTun6fNsdUblRvX/QMe+6WfA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qy8zcjcyeHJOWFJhbDFFRzN0T0NBdndhOXpEVzhSS09ycVVacnFCNnZQN0lJ?=
 =?utf-8?B?RXBiYy9TYkUxTnovRW1MZ0xuOC9Yd3doNk1jTEl5U1RUVVBXeGJzaDhteFFj?=
 =?utf-8?B?WGdUUFZPMGZrWEdjK0NQRnpGNC9wNk1BSEhDY1JSNkdHU3c3QjlhYUVvTVVx?=
 =?utf-8?B?eGcvWkhSSGNleSs5b210SUxJUk5ZREgyV0plUTdPWFB4MldmR3BtcXREY1NV?=
 =?utf-8?B?THRpcmdCUVNxVTB2emlvREFmb1UzZTBOclI4Y1RiYmI2aHR0S2Jkc21KOTFV?=
 =?utf-8?B?UnUyRHNLdjIxZ1d2TkNkck5yajBlRDI1MXNxRUJveGZjWjlyWmhGOWh6UEly?=
 =?utf-8?B?LzA3NHozbFgxNUpzYWxod3VyMXNFdDh6d1dFdnl1ay91ZDY1Slp1QUFRNXNN?=
 =?utf-8?B?TVQzYzlmQ3F1VmZHK2g4RmpldGRlUlFpd002K1NqU1Q0Nnc5bmxxa3ppT1l3?=
 =?utf-8?B?TTc5TEZmNndxUm5pbDlJK0ZjbUhZR1lWYVZaT1c2bTR1REE2Mkw4RGc4VUlY?=
 =?utf-8?B?akRXajRVVzhrR2I0QytxbXkwMGtLMkNRcnZoMjExQTFHNUM3R0k3USsxUVli?=
 =?utf-8?B?RXEvc0UzVnBVTUVHSmJnc0lzZ2UxYUNraTZERndDTG1hdTBlcGdwY1BKSVIz?=
 =?utf-8?B?RC9pbE0zaFA0aER2dlBvM1JYZi9qak5GRmZFOFZIbjV2RC82MGNFMk9oTE1X?=
 =?utf-8?B?cENhMDhTKzU4WENlMlF0Wi8wZHRmejJrV1FZUGpzYUZiWENWWERTdEtWd1lU?=
 =?utf-8?B?UlBNWGQydHQwRlJxczJ0VTBXblptQzcvdWRpdWZUUlpSY1VkNlJPc0daOUNI?=
 =?utf-8?B?T09XeXdtMEJkbmFVM3B0ZjFnSzRJWDA3NCtpbWhxZ3l6TFhKTHExWW5IU3lt?=
 =?utf-8?B?eFZiYW9IU01JRWVaM25jYUsvMXdRVUk3RFFLSFV4Q2wxbGllNU52WjF0UkZt?=
 =?utf-8?B?cmZScFgwQklRRU9qLzNMM1BRc0VXQ29IQkNIcjUxZUlacG9idDdYZmZ4emJM?=
 =?utf-8?B?MzNNVDFha21RMk1yZkljT0ZFSm93TXYwY05sQnAwTFV2cTVyenl1eWxWeTFQ?=
 =?utf-8?B?WnRkbUJSNnZNR0daVXJDYzEwUkQ4WVE0TnFHc0N2STVLRnZaaXBpMEpPUkU0?=
 =?utf-8?B?aGJZZzNvbXZEOHJQbWR6S0dBTHdPQzYvUEhkdVh3L3ZlQ25OS3JEbWNkRGpn?=
 =?utf-8?B?NG9hU0dPOStORVhiM1NwVXBZaXVpRDg2dng5VFI5ckY1WDU0TlpTUlUzMFhZ?=
 =?utf-8?B?YUgwd2dYNUZRRnlwRXlLNFVGVWxscVFBZ0s2UFF0SFdGQ3A1bHNNSVRrNVVh?=
 =?utf-8?B?TVZXUUhWN3RTWkxzTVpKVkxUMmUxeTN5RktSdjhCK213NHNFc1dSY0FiRlBZ?=
 =?utf-8?B?R2N3M1lGRXdtdTdyME4wYUlubmRhc0RXNTZzTm1oRlRyYjMyTjAwREwwd3o0?=
 =?utf-8?B?MFg3OGlXQ0NNdnF6cUYyR2hNc3JJd0s1cnBXRGk5amJuZGlUeGpHVFBka3A4?=
 =?utf-8?B?Skt1eGM2VDVCNE5aTU1vM3VTR3FhTHo1SG8vK3A1Qy8xcmdFT0VtR3NrMFZy?=
 =?utf-8?B?NEtUZzhlVnJ0MXQ5dDdkd0JzMEx4c2t3MlhlTW9Pb2UzMXdTYlFjSks5YXdF?=
 =?utf-8?B?eUxNZ2dSZE5ERm8zd00rZ2F3R3hrWWhnNkNWeHRhVzR3eHpmTHk0RzcrVi82?=
 =?utf-8?B?eHIxYXAyUmdRRVg1SnNNOGQ0T3l5Y21VTmZaNGtpVGpPR3VYKzlRc0NxMWxk?=
 =?utf-8?B?RXFlcEJ1ZEt6amp6aGEvVk4ydzREbjNVTVVQOWdFRTU5bFN3Q0hHMHdqdHhr?=
 =?utf-8?B?aUc2NDZwM2ttelYxMm96QWhuZW9uQlVWWWNkRXpBeXlHQ29FaGNyY3NoR29l?=
 =?utf-8?B?SUxmdDZnUWFMOURQK3o5VC9MWEhFaXV1Q2lUNnRZY0g1cElkbjhJT0wvWVBo?=
 =?utf-8?B?d3JRRTZMRmY1b1NxUURsQXVlSk1wZHhlc3lXcmgxTFZ6bitSZG14YzRHMWpO?=
 =?utf-8?B?WXFSbjMxQlNENmFlQ1ptYTViaFoyNFozOTJxNGhzNWZoTUcxcFpsNDhzT3Bm?=
 =?utf-8?B?NFhXVTErTUhYNUtUdG94WUk3ZmVTUng2K3JkQ0lXdURHaW1hd2kxY0lOMWZ1?=
 =?utf-8?B?Z0c2TlNHNmZWelZaUU94L1h3TTFhL3RWUnRmQXY5MnNjRHdLTWZwY1Q3Y3R4?=
 =?utf-8?B?NlQ3VDRCYlhMb1VOVmY1MWZiSnVCRVR1MkpkZTJIUVB4eWJyK1drVFl6UXpx?=
 =?utf-8?B?MnFNbUh5QW5JdWZOYkxxMmhCdW02T2hEVGh2NVk1TXdGYlVRQW9aQmJoSWxx?=
 =?utf-8?B?SnBnV28vMnl0eFd4cHVWMHZTZ09DYzU4VEN3VlUwb2JqVHBFK3YrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20784c2-f952-453c-20bb-08df253906ae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 12:38:16.7465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJ8ha49s2FBOWNOlCOlFOCBLG3BO4t9bLqC0eoXXCi1ez57FrSFJLn/nkrJGihYm7HDeFUMqCCs2iG5SYLIjoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893



On 10/8/26 02:18, Giovanni Gherdovich wrote:
> On Wed Oct 7, 2026 21:45, Mario Limonciello wrote:
>>
>> Thanks! Based on the findings from the BIOS update everything in
>> this thread should be enough to either make a v2 incorporating
>> feedback (mostly making it clearer) or to drop the patch.
> 
> The patch can be dropped, as the latest BIOS release fixes the
> problem; lowest and nominal freq are present in the ACPI _CPC package,
> and amd-pstate loads without issues.
> 
> Here a summary for posterity, hardware and working firmware:
> 
>    Motherboard: MSI TRX40 PRO WIFI
>    CPU: AMD Ryzen Threadripper 3960X
>    BIOS Vendor: American Megatrends International
>    BIOS Version: 2.94
>    BIOS Release Date: 06/15/2026
> 
> 
> Thanks,
> Giovanni

Great news, thanks!
