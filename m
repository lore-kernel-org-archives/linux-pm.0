Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795430928;
	b=3VieBtmzPpCXiJbJXXz77D+YubMYZuD7VUUrq6XGblUs9/cgiv0oAUiUukiebSdR29Cj
	 v2txkNi1F5YjuPa1HLt6y4nd2XMhnp7KFtxqt0T03oDenDG4iQyzCZN9Sy41FHLr3E9Vj
	 jbXvstKQ4E+HN0cxCdM/Q8vPuuue5DnYFLGjsk9pXxmkmtRZ8r1SGqDgkWv6NpByTQvWS
	 qUR0EVUt3n/UsowHgs3t9xKB7m+cBnRWoRdsXhbl89hE9rx5pNgm1q8+ncimh3nmc8U/y
	 yMP8KBYHxGznsf4nv1VOhy2/SGa5NbVhu+0zdBa8uCUF2hoHWe4pSieQ+egIDyITc0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430928;
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
	bh=4i3oy5Kcr6Jwl5pZ2XVfYPO655s35Y+M6Z3SZL+FooE=;
	b=IP4MzngFIxJoxz2LwgNEMQcsqvVl45xdvnUAHGnrIKjLGYXruN+6EV8S/DfSLsT6sbPU
	 G0b7aFDsCWZvLXtERiVv85UiXv8h8qbYTjEx/69K0+iPmWvgMil9OurU4uOGddRv0E1kE
	 lP8yKykMvXTQBmOciNWU2GSQkBs8xP8nV6nHguuJnHaAV682HjXBqHu63GI58cAG1Z/kx
	 AocwhJDqB0WCi7flbA0SQBGs44Yv1qDP/WWpQdYJjCoz0PQnq/uk7IiBwceJOzJSbf26D
	 TO3DI6oN81HQKvf0tjuFLQGh0vWeWNwIwEbkE6svHdxVSmWqiipbzz8mFhXGCmNQvdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g1YbKAr3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.17
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B0606A31F;
	Mon, 23 Nov 2026 10:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E32B0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g1YbKAr3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYLAyMm7WuNmGmJJMgXPormezx1qaZth40dacYg5goEjTaHDPOSI6atsrM1v2Ioic92i6rL8bXyhuq18Bzi4FZ0h2XN4WRiiV2DSptRimfKFPX0c05ODyq6vP/g/Rr7das907Izm6WvS3W32KM5TiDWbqTGFq9zMxNzv5RIRZ7FSnYjtm5nCD+gXyasndXL3hdebi0SjlwAV6SdIn1MZHWrNuswqNi22ccvqEE45OVzrx+px/gRodewnCJz2OX++reArCHYIhMLej+LUC7hDC0N8pMe7EB6Hck7amqFZ3mL0m4mMkPcy5b+gUQkG7qUIDbtjy5ckWzMOfGkcWC66kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4i3oy5Kcr6Jwl5pZ2XVfYPO655s35Y+M6Z3SZL+FooE=;
 b=qF7t6pA6qa8DSzuxBxsNb2QgLveaOoRYo7yhQy51cE19zISoxwJfQ2EOUyhG0zjjScg7/uv8lv9hjYs2hyVSg+CvHhU8W8plnOrq8ddmJGxPSLvaCbRqpOe4ieu42LIFnFtdNoeuOHTDLztoDtwTfH22Lws1HMsCq3vI8Yhg0VzKR2zC1t7lstTFD/jIvKHluyeYMxMoq7TOpV9Bl8AHeBIQ7T6UGJj72eJolELYJxciZirzKV11wfVaQhlm+BOQHrU+KPOUZh3NwyQ/34X5kCAPCkhkTGjn0s/2NjfAXho9BdQGPYCz7JjUFsEo7WoUR2DU2xsw7GZtHl6DS+FQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4i3oy5Kcr6Jwl5pZ2XVfYPO655s35Y+M6Z3SZL+FooE=;
 b=g1YbKAr3U/QstvGqTSkfQ6Qnrpn+sKgUJJjDSZ87YPgitbybxh8Ok6ukL3+xrmStkEIG6R+tvmcwRKOmbemkDgADUq2LqTZe67xirvm6G4LC1iMqoXxAMMdPnX+n5WyLjvNg4UO5wYFj4FaYzGhBrjZAwjQau1S6FHRB6j1x8ag=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21) by CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 10:48:40 +0000
Received: from IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1]) by IA1PR12MB292992.namprd12.prod.outlook.com
 ([fe80::4b88:460d:65c0:def1%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 10:48:40 +0000
Message-ID: <69481084-2af7-4156-aeba-3c883a644f1a@amd.com>
Date: Mon, 23 Nov 2026 16:18:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] platform/x86/amd: hfi: Stand down when amd-pstate CAS
 is active
To: Mario Limonciello <mario.limonciello@amd.com>, ray.huang@amd.com,
 rafael@kernel.org, viresh.kumar@linaro.org, perry.yuan@amd.com,
 kprateek.nayak@amd.com, hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Krishnamoorthi M <krishnamoorthi.m@amd.com>
References: <20261114150310.1377654-1-Vishal.Badole@amd.com>
 <20261114150310.1377654-3-Vishal.Badole@amd.com>
 <404553c5-60b3-464a-8d76-7850120f3d58@amd.com>
 <804443a9-b50c-4d22-bded-8c3d908ace08@amd.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <804443a9-b50c-4d22-bded-8c3d908ace08@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0231.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::18) To IA1PR12MB292992.namprd12.prod.outlook.com
 (2603:10b6:208:5a1::21)
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
X-MS-TrafficTypeDiagnostic: IA1PR12MB292992:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae256b3-ee5f-471c-f376-08df494f55e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|261009223027099003|261021121427099003|921020|261026140227099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261028144727099003|4143699003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	wdwH67gtJj4pbbEEL5JVwPN9l5qMtzuYSSJq0sMV5q6y90KrgtXhROw+FwHq73+/dGKuvMb2vFCEVFRavCeYe/CeanHvTDhRSWbaD2pY4VPrUiTkmJss/qAq3AFbpR9spyKukaUdbPvWvtoW0BsnRTggWnTC6sj5DVcwwxOIgO3rCNGfNfGnkVf5LfIGY2wMM9aM1QOK1xypBSohwYJeWNlbLBnH8yisebUX0Cayk1jx07RQBNFi5HOZlBYF3qFXZQtqr9hqEkC0fMpwAnVzAoq8iC50a1hgUPD3xylaGO8l+o1V5pefIHaszqiMcBjhzhrMv9D1kcgXlEKLEJmMMpF7pGahymVtcK9GQOE5xtLvqMtinvQuBpJlJ9h5OjkMrVASp04pKgBcW52BG9cGXTMZXjPbbcn/15+IvJ3lQX2eff/sBiw7OVDSAePRN6rvFGHefj96x0fpLuVgGtCwshhA2DjdKxj+s75fsQhQGq+oT5Lvpx3V2vGf/KfHCdERyrXd/Ceu6mQea/a+acR52ovSnbOLxwBUrblOMYXtL4XA3np5pBmvkTSUaxiaVBxARDBunP2orfXoVET9gt2dk3XOKZgQSX42Jsh/0WPLdx3T8atC9PNd1ZHbG91fEOqgzPFRpk6kK4DZ40AxEz28Vg2uwOMRv5SD5U2rHVEZ0AHc16JlesiRaqvxML5AfTI2YN4nsQustuXW/ssiq3I57A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB292992.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(921020)(261026140227099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261028144727099003)(4143699003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0hnYk14bGhNeGJPQ3lyMkR6TlhMWFZ3aXhNenY5Q25JVksraUJzVW9xU0VO?=
 =?utf-8?B?RVRPRGRvbnIyZ1J5bktuSVBWT09HcHoxVUllS1FXWnI5SWNOSmdIdExFWXBw?=
 =?utf-8?B?SWZRNy9OWHJFN0xmb3dtNkxlVE5qMTdIV0tkOVVPZUtZZytFQUVWVWJMWStW?=
 =?utf-8?B?UkVwWkpRQjlNa01HcHo3K0Y1TDFPVkNTWkRXTW1CZEpjSjFSNk8rN3NxOEJt?=
 =?utf-8?B?R0wvQWYxQkxBVUZFWElBQitmZndiTGpIMDdwUTlqMWlhdXA1cEY2cXRYbC9P?=
 =?utf-8?B?S01XS0p4M01DcFFGb0RMM1g3K1pzMlE3OTF3dG5kZnkyUnZSbkxNTFRzVVFO?=
 =?utf-8?B?NWc1TUxUUnZLTk1uSkhMdHhraXY5UVhIRmJnblBOSEZCZ0NLL1p3eENQUDJr?=
 =?utf-8?B?Z0Q4TTV3RUZ4bWUzTEtVSnJiYTBaRUsxYlk1bi9jUjkzRWdtbGx4U3NsaGUy?=
 =?utf-8?B?a2FkamVnWWR2OWl6ejNBcCt3MjJ0bHliayttRDV6aG41ekJuM282SkhMOWRa?=
 =?utf-8?B?dVFjaTluWmMzeTNxVDlvYWFiMCtwdmJ6NFNMZ3piSnE0VUp3cGh2azZFdVJR?=
 =?utf-8?B?V24wak9pMWMwRVNjQmxBeEdONERmMGc1cXhEMTR1WWJrMnVONXBCWHRJOG5Y?=
 =?utf-8?B?a1pMdThwYStVdGdnS3Z0bmxnOGhDSjgwdklQek9Db1hxQWV0bklxaEM2ZkpR?=
 =?utf-8?B?T0FiRUVLL1B1RXh0WTdwSUdRVU5FTmpBMUp1dGh2VnFZdklKaDZZdHk0dXNI?=
 =?utf-8?B?clBmOUhZQThJd093Z0daK0NpbkV4b1FBK3FhOFVCQVREODBsL3JIWEF3YTFh?=
 =?utf-8?B?TkxsR1lxcjRTampILytQWTU0UFp2dlFUbk5XL28xRnJhNzhSbWxzaDhnaG1z?=
 =?utf-8?B?YldBczRxdkhUYXJvaTZnM2FYdDRadTd0UG5ManpuMTFUVmVaMmRSQ2JIODNm?=
 =?utf-8?B?YXh0WkhNallRMmRMNXJRR3I0K3NqaWE0NjcyWmtpZ00xOHlCUmVjYitpS1hk?=
 =?utf-8?B?K0xSakpXYm5xbUFZcUJMUHo4U3dIQU9way9NVkYxNXdZVXJHaG16dkthcGlR?=
 =?utf-8?B?RUkvQ3V4RnJPUVZJTVc3MCsvSTh2UFptU0NDTXhGQ2gwYXM2SmdHZkFHTTJP?=
 =?utf-8?B?cDZNKzV4T2k1U1pJZ0JzeHROdTNyL3Fnekl6Z21CbVRGY0xySkVjblhsQThi?=
 =?utf-8?B?ZEtidHVMNVdxdU55OVdyWm1vNUhhbmhOelFrczZQVmNod0kxcWNISkxydFcr?=
 =?utf-8?B?S0l0YVlqcEgrTlg0dDFsT2tkR1F4eVdMeGZmOWpEbzd5LzUxK1hHMVlQd0M4?=
 =?utf-8?B?OEdqbnpTdnJEZ0ltTWYwNStOUTBtT1F5TjRGVU9meUE5U3IrZmFzbTVJNkVL?=
 =?utf-8?B?QWczTHlwb2NadDFhcWluaUdyVXlyellJR0pyQnZrM2RESHAvNTAwRU1NZFAw?=
 =?utf-8?B?VDZ1Z1hsMkdzd1RPT3piakFkUkZ2eVFROUhneHFYOTdra3NHbXRjUkRDNmdX?=
 =?utf-8?B?WXlEWUJUUEIzb0JrdGdJaXZCbi9YdUh4cHpFeWJvYzFNU1lVMWZ0M0I1WDRz?=
 =?utf-8?B?ekxYNDd6NmtqUHhSZ2N4U0VZSGFESDM2ZkYxMjc3VTdNNGFqbmtmdWE4Qjla?=
 =?utf-8?B?RFJERTNKVWNuRlNiUWN1MlI1cHkzZk0yakZQOWh4NXp5MzZQR3VBbjRXRkY3?=
 =?utf-8?B?K3lCd0xWN2QyMFh3UitoWWF2VHB1VjliNytxRlpFMlUzQTZjSzlVU2xtcm5w?=
 =?utf-8?B?eVZmdllBemJIV0U3SkxaRDhpclM2UVR2ZVBuMVJWRkkrYXpjZUJBbzlNMkVV?=
 =?utf-8?B?T3pHSUhuTUlkNGJxeTlpRVRiYWF0b1J1VG5aWnRQVm9QUnpsWFl6SEtmRWRV?=
 =?utf-8?B?OTdSWDhCQmJLUUY5U0lhQmx5VW5yT2F6b3VWd3R2ZjJvemtady9RcEo1eUpT?=
 =?utf-8?B?dTg2cWQwclJGSWoray95OHJDRVdoM0xkRW5sRTNxZ1IxVk55LzIycEZhNmgr?=
 =?utf-8?B?UGsvdzZOWDI4Z2JaYU5mK3pKbEpyRE9Xa05uS2svcHhrY3FrbVZMRGphVEsz?=
 =?utf-8?B?V2kyNnFrZW5JOS8wOXhNTXl5R01YeEthMHhmcW5NdjZ4dml0ZU5iTDZyVm84?=
 =?utf-8?B?N0VtNDhxN05vbE5wUnFDTHRHNWVDVVFPNzAvNG9TWTkwVzFiNzZuNVhnN3hI?=
 =?utf-8?B?ZVVUYmg2QTZTRUlHRU5PMmt5NWh4aDRiYldVYXdKTWdRcVFwYjVTUElxa1dS?=
 =?utf-8?B?TjdMa0VhR241WkM5WTUwMTlyRjdnTGxJZ1I4RnVrV1hLdXJETzZ4bmtIQVBB?=
 =?utf-8?Q?Upy9j+7Py84fOluh6Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae256b3-ee5f-471c-f376-08df494f55e4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB292992.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 10:48:40.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YiVevC89n+pif1QoEIGiiOr3GzlkdYeoIpirGdjN8lbD8tiWHBIB4Yy7BOtr98hybxetYKyZxmVLGrmARKByw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491



On 11/15/2026 7:52 PM, Mario Limonciello wrote:
> 
> 
> On 11/15/26 08:16, Mario Limonciello wrote:
>>
>>
>> On 11/14/26 09:03, Vishal Badole wrote:
>>> From: Krishnamoorthi M <krishnamoorthi.m@amd.com>
>>>
>>> When amd-pstate CAS is active, it takes ownership of per-CPU capacity
>>> values that the scheduler uses to distinguish performance and efficiency
>>> cores. amd-hfi manages the same scheduler state through its ranking
>>> mechanism. Running both simultaneously would cause them to overwrite
>>> each other's settings, leading to unpredictable task placement on hybrid
>>> platforms.
>>>
>>> Avoid loading amd-hfi if CAS is enabled.
>>>
>>> Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
>>
>> When a patch is authored by another person and you send it on their 
>> behalf you need to add your own S-o-b as well.
>>
>> Think of it like a chain of custody.
>>
>>> ---
>>>   drivers/platform/x86/amd/hfi/hfi.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/ 
>>> x86/amd/hfi/hfi.c
>>> index 86a7f4332c35..b6878614e2bc 100644
>>> --- a/drivers/platform/x86/amd/hfi/hfi.c
>>> +++ b/drivers/platform/x86/amd/hfi/hfi.c
>>> @@ -29,6 +29,8 @@
>>>   #include <asm/cpu_device_id.h>
>>> +#include <linux/amd-pstate.h>
>>> +
>>>   #include <acpi/pcc.h>
>>>   #include <acpi/cppc_acpi.h>
>>> @@ -536,6 +538,12 @@ static int __init amd_hfi_init(void)
>>>           !cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS))
>>>           return -ENODEV;
>>> +    /* amd-pstate CAS owns heterogeneous core scheduling when 
>>> enabled. */
>>> +    if (amd_pstate_cas_active()) {
>>> +        pr_debug("amd-pstate CAS is active, not loading amd-hfi\n");
>>> +        return -ENODEV;
>>> +    }
>>> +
> 
> The load order happens to work; but AFAICT this is just by coincidence 
> (link order).
> 
> If the link order was changed in the future this could break completely 
> non-obviously.
> 
> I think it would be most ideal to add deferred probing support or 
> forcing HFI into a later init call phase.
> 
Ack! I will add required changes to deffer the HFI driver probing.

>>>       ret = platform_driver_register(&amd_hfi_driver);
>>>       if (ret)
>>>           pr_err("failed to register HFI driver\n");
>>
> 

