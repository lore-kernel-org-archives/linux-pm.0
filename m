Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021095.outbound.protection.outlook.com [52.101.95.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021B53E9F8D;
	Mon, 27 Jul 2026 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168657; cv=fail; b=I9Zuapvx7EvehBnhQy2ZAk9SGnDLQi4R2b+KsgynbvVBA7OrzKqNcnmmQ9ir3kyFNc/Ryefkf5fsJsWiFOz2ZCqebt4TXJ59N7jXFWhiU3V8Eg2VKAaFbM0Box+CpEKRlYUanXCTwLzjKr24hFHjzQo2+XD+DfYAV0+LMsJ2kqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168657; c=relaxed/simple;
	bh=iRn44LNWdyVmR8bNOytbTV7QmEHMsyA+ahYRxPePR6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dKduIEvPYQ7FlEXaBznsePdxS4i/5TDY1gBJz7Ixg3rdAgU2vfmw77O48xOvVUzFYus9J6/hJCGJX8v2kEKDI77QAqQOnsqiQVOFdDUvcbCnc/r4Lr4TLjCTZZNDNfpVlH9ezWEvBIXq5nK3wPAiwVHavSA/AS48RyUOkh6Jqdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8TgDmj0jqfqbIdwLvQd9GXUxHud23mfAiDGyi8Ms2qQhp2GUCVKY6C7MiVsLvSGekVGuYo4uygjuHbHJ2d0gHJliClsZ5VKrHr7ljVRTDYs7FVclXUH1ZddQnSCzlvsJP3X8FMlG+I1E8QAtx2s+3fpW0Ywu8j5ZLewIELnDfjnI3wT6TrKGCJaVOgCd3VHKuBdDxAMBUszfTsqAAYXy8kl34rozqjqC4lTj+zSOAtu1Id8E8yfSPiDU/i2gGIa6SZUOGnfnSzwYdCtMHZyrzrPh8XgMAUM1ww0TAiyXuXIs9Tdau8xUeF1gmwJpCgVac/+shOQM/mMQ6Z8ToP2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=vvDPI/WeY3MVh0febHRyTlPIcmHeC6R7E/ONUQ8/8+Q=;
 b=jjbOAq/W7LwephjC/R8bGUL1lZJieUkYWcQJiqRqF5wwmcMLq8gp76ju37FaiYYfwD/bHdApeHvJGOJLhf1+qTQLK2oaBdV+RhRdahK4ClSFOVfVMBl1Uo7FaOBLYue+Z+3BHLCa4qHFyfBja8GfxaUnfxLJ3YAZvwz7dwnSxdavSkj47nyxlCNC6xc8qckZrkTW5F3CDnds1cBnZ/Sd2z2y3qzD8oejfU5nGtz2sWAVejVQlP9/zI46nJbJb7Kk7FQy+4fWEGj1lPbXiKgKdzmEbuZzVrVFGDZNFqaZ5ozQrceHE41Y/K0MGGGMU7tKdbTZWcFHnzBqjNQSx+t/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB9040.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 16:10:52 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 16:10:52 +0000
Date: Mon, 27 Jul 2026 12:10:48 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: gregkh@linuxfoundation.org, dakr@kernel.org, pavel@kernel.org, 
	lenb@kernel.org, zhongqiu.han@oss.qualcomm.com, akpm@linux-foundation.org, 
	bp@alien8.de, pmladek@suse.com, rdunlap@infradead.org, 
	feng.tang@linux.alibaba.com, pawan.kumar.gupta@linux.intel.com, kees@kernel.org, 
	elver@google.com, arnd@arndb.de, fvdl@google.com, lirongqing@baidu.com, 
	bhelgaas@google.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com, 
	chjohnst@gmail.com, nick.lange@gmail.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
Message-ID: <banmyhuvixvvix4pqpt773ofaqqvq73ddp6ljbdzdopjwlxo43@wbey3vr2du26>
References: <20260426160127.292486-1-atomlin@atomlin.com>
 <76opmfrrzgjgd2m7pnzjdd5h4a3bc3ofz4xwsxuavulnqslsm7@fuirka5jro5j>
 <CAJZ5v0g4ksMwxqso8nagPO6s59fFzWt0YSv=SJ1ePF1bfgUCjw@mail.gmail.com>
 <3uztb63u72mniljqb2cd4q7cbma2hvns27gn2j2xfm4q4ouuu6@zqyc2wjt55rp>
 <rl6tnqrym3nqhp3as6owwccabjik2mnlunu2nnlafullsozwet@buftmawjay2p>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rl6tnqrym3nqhp3as6owwccabjik2mnlunu2nnlafullsozwet@buftmawjay2p>
X-ClientProxiedBy: MN0PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:208:530::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: cac77ffe-6d42-4fa4-0f79-08deebf9a131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|4143699003|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YRe/RRiWIX01vJifCQ+GRO5kuMZ/isROjj42+qfi08pA3/lFcJ9oyXQkvIUJe1agce1rskvtcxoKqNstHvXoeB2b1Lc8amV4D0GY9XwpNgNFqF++hjWFWy2xujdXKLBVO3vN98OhD4lYYutTjhUK5AmiaW08jRzUaAbzLotdcRA9xhevq4KjMdl3UgUTpHyD0NFEmSp4HUQoU2juQw/U+R/xz9p1LlRWFopxJyOLY1ouicAgsrDjMm7Exr9fhlcOrOxpm5+Yh99mGq5+OcEKat5ANxHhRVVcdtcBuD+E15QBxYJ3OetUMalJ+nkQGmUbOvJc5QIjFV/9AZiTlqXhh+Ga5GRUucmIjgAH+3kVJVCDgkE+ihuWEggPUNwVBWZAfs+eaL4lTvY4glkbZdypiigZEhpNRT1L4zEDuQvZtiiNANCfO3wHdG45hQ4sHdTLollGlFT1vupQGBa5+FJUyj9GnrXB6VMUo+mljzLaQiodXfAjvBxsZp3jwaqj+671MXbIb3RX4g93j3Exijs31tdKpCLbUHK818507IIOdVhYJDEOJh5peXBvrIwteLdzKoKMWPZvq+/ykT1Yql0tNkhdif6XZzu7lXK0hM+mMZ29f41qYdvmSeejvMsE8z7l0PcILZ0VzUy9wR+vmZ9uiv9HJl1d+QBlilI+PHhGyJI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(4143699003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWhSZnRtNEtGYzI0ZmduS2F3b3luWUdXRmIwY3NkU3BFaFZXY0ZvU0t3N05i?=
 =?utf-8?B?WHVzSFFmSlhWZFh2Tm13WHRkSXJYMmZGZmo4SmJkTHc2YjU2cFlZa2xqSG1V?=
 =?utf-8?B?b0pKNlJ6QVR6aWcvZDJ6NC9ublV6bkJ3QUx6ZTV1Y2NyZkZ5bU9RVXd4a2pZ?=
 =?utf-8?B?R1FteG1xT1FEeWdJbUhhOW9BeEV1Z0J0Z3FzZmdOZUd3S1haWkxNYmdMTjdi?=
 =?utf-8?B?V2h3TWFJWXNpYUNFUVk0dG5iRHN0Y3ZSQ0NKUFJQL1Z2TFZTVXFZajFSbWEv?=
 =?utf-8?B?QWo3bjFadzhINWd1VjRxVW56ZmhMcFFWTUFtODg0Q2NpcUtTVURJQUt1cGlY?=
 =?utf-8?B?VFQ0OGtJbWlWR1pkQTR0cEtrWmp0RkVKUE05S1p6bTAyMFZSQXEvUEprek96?=
 =?utf-8?B?YmFPMURheHJMdTBYd201YmtBS1p5K0dkWXE2UU5BWTdPaXM5cHY5dmhFREtH?=
 =?utf-8?B?em1xQ2Fiam9BQS9tcDhEaisya3pTdzA0eTFJa2k1bzhyaVc0QzkzZENNNkhH?=
 =?utf-8?B?SWZEZnJPMzNha0VjYTl1bUpwM0VjaXdjN0J2My9kMlRudnF5U1dOWTl3NmhO?=
 =?utf-8?B?VkxRK0U0azlrSGx5SDFCaHg2ZHVzUVQyNE1RTStiamkxRk1wWVNLelF3bURM?=
 =?utf-8?B?TnlGWkJkOTZTMUFKKy9FRWF4dG1ObzdYNnpKMTViczZPZXo5WVlISmJma3Fu?=
 =?utf-8?B?V1NrWFlGQWdybG1YVWp5OElCdURQSEdZL3ZQUjRkdzBGVjlxb0lyT3RBaE50?=
 =?utf-8?B?T3g0eDJYMFdxL3dLOERBNTBaSG9RTk11amo4eEI5eWJtUitmKytFTEg1amx6?=
 =?utf-8?B?dVNuVTI1d1Z4TWNXL1dJUTNvWGwyUk1BdC9DL0paRWhqUFhpNHVzcGlFSHdz?=
 =?utf-8?B?eVhvZEZDVCtzemdHUEtSbUF6dXJLelhPd1pMc0l3TndZZ25KTnBXd3BjTkNR?=
 =?utf-8?B?MXZxRmxTR3hUZng5NnhzcVdtTUlXOVJNa2FrcVMyNDlTdWwyK09rQVVjamU2?=
 =?utf-8?B?SkNEdlBWcU9XOVQySGtCeE52RFNoRjNrajllWHBZNkErM2FBREk2M255NzVN?=
 =?utf-8?B?d3dWd0FiMjJldm9lbU1CUWVpbThWeE5pSGUzZTc0MG80dUk1OWhIcTRYbzhk?=
 =?utf-8?B?bno0Z3RPbld5cC9PV3NUY01aYXZDMGtnRkJKNUJFczg5TkhQSFVibXFhR21U?=
 =?utf-8?B?M0RnZ09pQUo5QlpkcU5ocUVrTDVlRTlEc3VlelRTbVE4Z2NvYTNVTmlVSWIw?=
 =?utf-8?B?QlAwbjNGNjkzOTFqQU40RmYzcC81a2IzQmtENTVhMk5qUmxxQ2RYWFJWdk0w?=
 =?utf-8?B?U0FicDA3cUQ0R0ZkOHFyNGgwbFlnN1lHY2NWZEI1a1pNaklqRGord1JpTHZZ?=
 =?utf-8?B?cU5UNkZodE8wa0g1cmJUbVZNYVoyblN2K0ZSeDVuUUpaVytWazNCK2NYajA3?=
 =?utf-8?B?eml0M2RkSGF0cmwwOHcxSDNDcjBUby94U1YxYUhwK0g1bU0zdVlpTlIrRVRn?=
 =?utf-8?B?ald4b241SzNneXFJVzMrcTUxT21uT0EzYk1HNlRINUwzQXJGdzF3SmRnNmxl?=
 =?utf-8?B?MDk2VDY0R3RGSy9QSklsa2NBdnFXdlUvSlU2K0Zjb0cyQ0tMUWo3eGZxSEVY?=
 =?utf-8?B?K2RpQ0xsMlh5MklKM2llK25zOEI2c1JyYkZSR2VlZUxZSVRtNk1vVjRwVXJ6?=
 =?utf-8?B?NVc5dTFndXZ1NzY3MmVWd0NxeHErMVdBU3pKK0ZISGY5M2NFTmEvNGhNY2Vv?=
 =?utf-8?B?Wmx4UVlkQ2djNkpLUWpxWEJ3b2ZrUkpSRzkva2tuZVBBa3liTkhxMDFzcnVY?=
 =?utf-8?B?b1EweDNpZXM5cXAwN21LNnFPS3NtRzlvKzA3UVRsSTE3RWRYTkZlQVNBeGg4?=
 =?utf-8?B?QTI0Q2dYV2kvQXltUG1QZVFpcnJVaXFxTVppTEhzRi9RQW02UlpoMjRyOHVi?=
 =?utf-8?B?UjRJNEF4VlQyRVN2RkdoQ2MxMVEwYkJ1dnFJUWkxYkphZlMyRlB1dlc1cW45?=
 =?utf-8?B?TUx0QkpxUUx2WGFtRGdTYU8ycEh5U3o1anFNUDJmWFBLblltQ2dvMlJsYVRH?=
 =?utf-8?B?UUtITE93b20ya2NhQnRsdGwyRkk5ajBoajF5UFJtSE44clVmajJXakRsQ00x?=
 =?utf-8?B?WWNYRnNrbzA5d0REcnU5SXNXV1VvbnQreTBZdHNWTXorcWsyMW4xV2xrTDJy?=
 =?utf-8?B?NTZMM3FCcHEwNzgzSGJ1T2xHa1FyRGJvNjBabkdUYndjMGREeUVVeGpLQWo5?=
 =?utf-8?B?TnpXSER2QnpENHhCQTJNbnJ2Uk9scUJlWTZSRXRaSkJ3NUt2clQ3d3A5RnpP?=
 =?utf-8?B?V3VrUjBiNlRvdkI2VHJzd0wrbEZDOWJTWUNuWXQrZzdWUVowb3V2Zz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac77ffe-6d42-4fa4-0f79-08deebf9a131
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 16:10:52.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8qPx21N7vWmv1kZEXewTGlAyjespEX1QKNRRuYyntJ+p15ZEcOf5mxBXw5bzsItJgvmRTI4ieBaQYMYl3sp+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB9040

On Sat, Jun 13, 2026 at 04:33:42PM -0400, Aaron Tomlin wrote:
> On Tue, Jun 02, 2026 at 09:03:28PM -0400, Aaron Tomlin wrote:
> > Hi Rafael,
> > 
> > Thank you for your review and the constructive feedback.
> > 
> > I certainly appreciate your reasoning concerning the naming convention and
> > its current CPU-specific scope.
> > 
> > However, before I prepare the next iteration, I thought it prudent to
> > briefly outline my original architectural reasoning for housing it within
> > the generic PM QoS code, simply to ascertain whether you remain of the view
> > that cpuidle is the most appropriate home.
> > 
> > My primary motivation for retaining it within the generic PM QoS framework
> > was to maintain strict symmetry with the existing sysfs interface.
> > 
> > The parameter is designed to align precisely with
> > /sys/devices/system/cpu/cpuN/power/pm_qos_resume_latency_us. That sysfs
> > attribute is exposed and managed by the generic device PM QoS code, quite
> > independently of cpuidle. Furthermore, the boot constraint itself is
> > applied via dev_pm_qos_expose_latency_limit(&cpu->dev, ...), which is
> > fundamentally a core QoS API.
> > 
> > Should we move the boot parameter parsing into cpuidle, the consequence is
> > that the cpuidle subsystem becomes responsible for parsing a boot string,
> > only to immediately pass that data back into the generic PM QoS framework
> > during CPU registration. Keeping the implementation within qos.c ensures
> > that the parsing logic and the underlying data structures remain cohesively
> > in the same subsystem. Crucially, it also preserves the flexibility to
> > extend this syntax to non-CPU devices in the future without necessitating
> > further refactoring.
> > 
> > I look forward to hearing your preference.
> 
> Hi Rafael,
> 
> I am writing to politely enquire whether you have had an opportunity to
> consider my reasoning concerning the generic PM QoS framework.
> 
> There is absolutely no urgency on my part; however, I am standing by to
> rebase and prepare v6 as soon as we reach a consensus on the most
> appropriate home for the parsing logic. Please do let me know how you would
> prefer to proceed.


Hi Rafael,

Please excuse the second gentle ping on this thread.

I appreciate how busy things can get, but I wanted to briefly check in to
see whether you have had an opportunity to consider the appropriate home
for the boot parameter parsing logic.

My primary motivation for retaining it within the generic PM QoS framework
was to maintain strict symmetry with the existing sysfs interface.

Original response: https://lore.kernel.org/lkml/3uztb63u72mniljqb2cd4q7cbma2hvns27gn2j2xfm4q4ouuu6@zqyc2wjt55rp/

I am entirely happy to proceed with whichever approach you see fit—please
just let me know your preference and I will get v6 prepared and submitted.


Kind reards,
-- 
Aaron Tomlin
