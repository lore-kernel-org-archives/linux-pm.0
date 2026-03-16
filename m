Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020119.outbound.protection.outlook.com [52.101.196.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA02F1A9FB7;
	Mon, 16 Mar 2026 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773658770; cv=fail; b=ufLqZXZ/l/J6Fw1mWyc3sJKCMtU64qiZ7mFw5XJRnEFMSJr6Yfo2tlwK0HDZjbr4gIR9JtkeX0vu/V3mvMv/jHw9K/ZEpNdnFm6nG5YQpMxFe3k+KDvHWPzrFHFg8T7VV4VcEwmWBUuJpUlbf2fcL0hL5upN21dj0zMlK+7o+Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773658770; c=relaxed/simple;
	bh=+otQwTTqj9ya/fh0Y96L8WQiwQ9mmo9q1P4ZR/SXgRE=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=PGYsHL/T4VrpBaM8jGPjgS7CeJ/7hyFBBseSMOAOJxoKyObU1ieYMmQjmvYw8QRTbZebyuOBzCQ9Ok4On9c3q9TDbAzRb8eilaUPgCPoGwc7xQa0L0unU0IOxVt97djm7N5j5c63RflCQIxZtGCPV00yLs3EcZaGfFvJZfZDnQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PinmCGjW; arc=fail smtp.client-ip=52.101.196.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PinmCGjW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJJnjxU6hG2hHr6IdFPn5UQ2AMa0DhyuyvWdvtVzO6jEdtrk3l1wf3enqvPqXc+KpkjDsnq9LcGEUWxbyAuucltOk8mmJA09Jt2ZlJual5qm0IpjPtoinXQWVEHVp1hza+wPCHwdRt8aI8A3z3VzjnxnVcp1viQgvBrR0/aFObJlpTCYTr1wcsku62RRtT5Z3OYiigicVAWoHFQKWV0ZfkoFHU32SoFcBAYg0Puh7nWfZgsbXhYjg1878/6W40/7Dx1RQZuJzeDQpEhz+k6Ra0xIUSg1Z+vwMlGB8TLSCP/dJBv0cRsPlaqMrPvKV/+w7ZTiAQQFkrkdDT1w68BPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+Sb02k1FQralKwJa561SCE8+wAx7naOqUwV3TSTLv4=;
 b=PuhwbKsV2+cguRtaL9yLlE24e3Sm/9d1C0RRab2D0Kn2RnMUnn348mra07BvcsqPPcSrw7C5AsF2bcTxBKpR2T6v3p1nXCXoOz9AN+HSFjbUoba1htTsQEGCXhaULlac2HM5HTwTNIGQhdZsEA20XpcINgH6F/jYez1rqMP6zoNdNjJ8erlVzGC7XsOQd7Pi1K2kL5c5nbn+pPQkaM4Rqcd8o66K+OTZgDnVUyFbNoyol0aBxsHJ4r1NqjsfieYqXYPapx6cQAH5dAFU3xnvuG8HyJ2vBm9LKiUD1q4pHFK1AqUqPQzV3NVS/OHQqM55YENrLrrG/tB5o/VawGaEnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+Sb02k1FQralKwJa561SCE8+wAx7naOqUwV3TSTLv4=;
 b=PinmCGjWsRJuV5CBeBNIbGLL0yOg0HGtHA0ublLY3BqltvrcXVoTP3iRf2g2JswDTY87UQxaOyEUgDssSicc+nsYvJJDBqpk8QhL6Q422HjfAkpAzh/Z29tti6jMvBM+tnfOXqxSLWNp14HC4RKtTwVi3epsXQ5yuHZGuQFSLaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB2682.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 10:59:23 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 10:59:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 10:59:22 +0000
Message-Id: <DH45K30G3Q8E.3D5NIDBS1IYP8@garyguo.net>
To: "K Prateek Nayak" <kprateek.nayak@amd.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Huang Rui"
 <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Srinivas Pandruvada"
 <srinivas.pandruvada@linux.intel.com>, "Len Brown" <lenb@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, "Vincent Guittot"
 <vincent.guittot@linaro.org>, "Miguel Ojeda" <ojeda@kernel.org>
Cc: "Perry Yuan" <perry.yuan@amd.com>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, "Dietmar Eggemann"
 <dietmar.eggemann@arm.com>, "Ben Segall" <bsegall@google.com>, "Mel Gorman"
 <mgorman@suse.de>, "Valentin Schneider" <vschneid@redhat.com>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Bert Karwatzki" <spasswolf@web.de>
Subject: Re: [PATCH v4 2/2] cpufreq: Pass the policy to
 cpufreq_driver->adjust_perf()
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
 <20260316081849.19368-3-kprateek.nayak@amd.com>
In-Reply-To: <20260316081849.19368-3-kprateek.nayak@amd.com>
X-ClientProxiedBy: LO4P123CA0519.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB2682:EE_
X-MS-Office365-Filtering-Correlation-Id: feb05a0e-e253-4010-6e6f-08de834b150e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|921020|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	iU2m+pXfV7yEb/1McAIYbgg7JlaCekScQlHOiPKx5Kvub/JhOqJZ22SgwBQkpp81dW2SuB1zHiTHBe44SSnTSXUYs+aKyd9ViAkvEpOKNiglSvfR1FooLF/Hc6VYgMjRaQbEf+IoKz/81dNniTjM6LeQj1HcBlBc4n12QQB72c/4XT5CelanquM9642OixBvK0ZQTbWMpPjrM18Mvbuhr3ya9P3/lIW5HlNIFZxeVNKqNtiIb6eGQuhQPcx/+ZXgjdhLblt4ezEDKSooGh6iyFJz2NsVqFZSIdwK3Ps2awUyIjPegOyvGBzjjBZOTyED39HkIaJnQhmfNusFa4yKKcvInkYHMCd2729Cfc/OxZM10adRAAAEXpB3DhihSpiy/fBuh178GpMkaTv6VB7fuWfNtK6hDjM9Hd3kBwqyJcFeE8tq/0yq4k3zqu6dqHrNik/BxctLiJNfu1K27Rjuc8Kg45mMEiYiZ97Oew7ZKTP2YF7EocsG7Oc+KHqBkKWfEfx3tuoC2d+RTQt6bwdpuo6MuqiJa37fDHU/HulkNKdEAkfu6A+Zaq3VlrqU/o3FiswpmZPC7s4LAUZ2Ye160lHEbCS3hoZa94PtxOTD1GO0pemRzXJio0xiCCtzHgW0w+BYj1nvnmBgce3viyThTSovtCSV19WwgJxcoJJoRxlF83b3daqjG4WB0ftAG7X21horNRh7vMMCV6d+BA6VjKW5KElW4Mufm/B+sHsLhWwj5TGDy/29P9SJoLrOi9etLRxHCcD5WhVp18vDxQECNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(921020)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFlMM2dla0ExZEpjbGNuY2l0QTV3QXJ3aldxSWxjWThBN3dZRmZhVjhhRms3?=
 =?utf-8?B?ZVlaZHA5VmxiTjlsbHNTRDFPMlcwV1pYNWVGVGNPdVdkb1VrZzZTbmFvd1A4?=
 =?utf-8?B?aEF0TmJ2eDZpaWxLTmFWaW5kTGNzREQ3WjNkYytQbWV1UUlqbkNnM0V4VnBW?=
 =?utf-8?B?VGJuZWxTYWJRYXR1RGJaS3lPbUdmM0Rqek90NnNzMGlQeXEvNk1ERksveGk0?=
 =?utf-8?B?SWZaZ3FBNWlLOWxGdWhhUHlvQUFmNUNrVkRCaWc3KzNlR1RPQnhPNllhUGlL?=
 =?utf-8?B?aG55NVFIYVc2MnIxMWx1MUpUdktVRCt5L2pXQ1FYWUlSZEVjQ3R5MVd3T2xp?=
 =?utf-8?B?c3A1SEF6eGU5YXJwM0RKZkg1N3hlTkVGaDl5dG5aZDNScVlQK2pkSGVZTUVL?=
 =?utf-8?B?WDJjYVlRWC9JUTBLU0pOQ3ZRSUViYURBU0dPNzBGSXlvbkFIaTBRQlpRSkpk?=
 =?utf-8?B?T3dpU29kd1FUSGVla2hWTElNUFBoR0FnZSs2VEM2eTNrTmJVUEVQcXdONTIz?=
 =?utf-8?B?NFdaV2NycUxWS0trVWxwaXQxWXBRclVKNXBpVE45T2JHSUR6QTdlVFduZEhh?=
 =?utf-8?B?YjhQcGF3cXJLeEM0S3NoNUlQU0R4L28yOWF0cTg3VWVhemtTa0krQm96bnNY?=
 =?utf-8?B?c0FwT0psOG5MMDk4YXlGeVVNUHNHMFR1WXpsWUM3ZEZ2Tmwwc3l1ZjJ1SGNL?=
 =?utf-8?B?UmF0TXJJU2loNWgxc1l1b05zN0QyZ2VaT09ZUHlFOU5Hci9rb1h4TzkzWjJq?=
 =?utf-8?B?YlExUi9vQzA3UGpENnROcHhNQTF1M25QTTlhWk1zZ3ZwZHJiSUQzU01EZFZM?=
 =?utf-8?B?bzNhM0FGTlRUYS9mZzdYbDA5aDNxMWl6S2lQNVA4VngxK1l2RUZPYnlQd1hB?=
 =?utf-8?B?TW85cFdybFRtM0tWUkgxWTN2SDIydUE1WjdPVFR5bDdLZ2lHd1QwWExzVWNE?=
 =?utf-8?B?dmMyS1dFWm9mYjZ4MnJ0dEZ3V0xMSUFzdnJ5K0NZZ0NUYnJoM1hBKzNPTTNC?=
 =?utf-8?B?SlFmR3VqdnNkSkFINmpyNi9zOVRaSXhucWFFd0hRRDJhN3RUc2RodDZPTEJF?=
 =?utf-8?B?VzNFMkw1L3lCZHlOajdmWWJweXBLNEw2M3doTmlzaVFwTm8xQjRPeE5sc3Z4?=
 =?utf-8?B?dlNTcmxmbUxMYjlsN0hLRHBLbERjS08rNER1c2JBcWwyR0VpNlhjZzE0VDEr?=
 =?utf-8?B?TnVwWDBKM3ZaZUhKa0lKT3Fza3IveFYxWk1GS3dKWXNycUxxOG1uYlRoNkJ6?=
 =?utf-8?B?dWs2TkVwRGxURHE0Z3VTTmJiaU5KMlJVTEFNdHRqQWZxRzVmRkptVDdCbUI0?=
 =?utf-8?B?eVVyYk1ZdDBTNWdYUHQ3cE81TXQzSlg0ODh3Z0lXYTNnRXExZnd3T2U0bTN0?=
 =?utf-8?B?RDQveEFGbGZaeGpkZ1c1ZDlpUTgvOFluV0pyTUh4NmgzN0RWTlFpczFtaVFZ?=
 =?utf-8?B?ZlNDQlUyWnpwbnJRTWpINmJxYzlRcmFpYnVHRXRyeGoyUUw3OUIyeXJKeWdX?=
 =?utf-8?B?eWMxRWJYNEpPWHl3M09YTU1zcTd5QVVBODdJeUtYU3FrOFV3UzU0Y2hQUTE5?=
 =?utf-8?B?R1NieTRqSHlHdnZmYVpxWUwxU1pmbFphaG01WVZNaUZXWmM4a1hhQzVWQi9q?=
 =?utf-8?B?eGpPUUgyYkxlQVE4OUJBcE4yMUdKNlNhaEtmZnkwNnQ5elZCd3dQaHdDK3VQ?=
 =?utf-8?B?UzZ2VFRteHVsNFlDdjlKQkhCcmhld2s4cjN1eDVJYUczdnBGTVF2eWlnM29P?=
 =?utf-8?B?VHRDdWdXcHdpQ1JkR1JaKzZwUVNaU2tNeEVkQkVoU2F3WXFSRllSN1JrSVpY?=
 =?utf-8?B?eFNnWmxJeHFQZWZocHFucVdpNUcvQjllYkNMZndBaWppTzFOdnNHcm1SQXln?=
 =?utf-8?B?MVFmQ2wzNHk1VzRBQnBTRFJzRmRTZkVvbHE0ZmxDaEV3dHFzblVLczI5cE1i?=
 =?utf-8?B?NzJiVFBIMUhtTFdOM3FNbm9UU2EzR05ENXdEaVNwVkwvZmNlWThmcldTSVZC?=
 =?utf-8?B?TE40R2ZQSU1GL05hS3picys4TUZTZlhVYytBUE1tdS9GamxZTWFKUTIxNUZW?=
 =?utf-8?B?YlhoZ01LL2lYOEd2QW4vOVBGUnMwTXcxM29hNkx4dzJZMjRrdjdHRVRySk5O?=
 =?utf-8?B?UDN1bndRNWQ3STRyWU5ad0had3VHMndEeTVwNlJ3ZnlLQ3hkeTBLeFNXNFF1?=
 =?utf-8?B?TFBPMk1yNkxzeEZDemFzS2thQWtoSnQ0bWVYU1VMMEhMQWxGNnBHQnRzRXU5?=
 =?utf-8?B?WklwTnh5RmlLMnM4TGtpbmJocXdVdWlsckhOUEdWQmUrNGEvek8wMWtnQ2g2?=
 =?utf-8?B?bW5vRkMxb3pZQzFHODBGbitQTGJOMnlxTWd6ZnlOc2RwTjVrb2kzUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: feb05a0e-e253-4010-6e6f-08de834b150e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 10:59:23.3076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkfEdths6yWwXMxEEr4K+mXAtDqUk/m4bYbY2zFdSiV83uV7AnDRG0xHQg3Vo9Afauhmc3L0coHOt6uqWGA0iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB2682

On Mon Mar 16, 2026 at 8:18 AM GMT, K Prateek Nayak wrote:
> cpufreq_cpu_get() can sleep on PREEMPT_RT in presence of concurrent
> writer(s), however amd-pstate depends on fetching the cpudata via the
> policy's driver data which necessitates grabbing the reference.
>
> Since schedutil governor can call "cpufreq_driver->update_perf()"
> during sched_tick/enqueue/dequeue with rq_lock held and IRQs disabled,
> fetching the policy object using the cpufreq_cpu_get() helper in the
> scheduler fast-path leads to "BUG: scheduling while atomic" on
> PREEMPT_RT [1].
>
> Pass the cached cpufreq policy object in sg_policy to the update_perf()
> instead of just the CPU. The CPU can be inferred using "policy->cpu".
>
> The lifetime of cpufreq_policy object outlasts that of the governor and
> the cpufreq driver (allocated when the CPU is onlined and only reclaimed
> when the CPU is offlined / the CPU device is removed) which makes it
> safe to be referenced throughout the governor's lifetime.
>
> Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for A=
MD P-State")
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Closes:https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de=
/ [1]
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Acked-by: Gary Guo <gary@garyguo.net> # Rust

Looks like a sensible thing to do, interestingly I noted that this (as an
effect) aligns the C API to what the Rust-side cpufreq API already has.

Best,
Gary

> ---
> changelog v3..v4:
>
> o Added the Fixes tag. (Gautham, Chris Mason's review-prompts)
> ---
>  drivers/cpufreq/amd-pstate.c     |  3 +--
>  drivers/cpufreq/cpufreq.c        |  6 +++---
>  drivers/cpufreq/intel_pstate.c   |  4 ++--
>  include/linux/cpufreq.h          |  4 ++--
>  kernel/sched/cpufreq_schedutil.c |  5 +++--
>  rust/kernel/cpufreq.rs           | 13 ++++++-------
>  6 files changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5faccb3d6b14..ad4b5f84773a 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -710,13 +710,12 @@ static unsigned int amd_pstate_fast_switch(struct c=
pufreq_policy *policy,
>  	return policy->cur;
>  }
> =20
> -static void amd_pstate_adjust_perf(unsigned int cpu,
> +static void amd_pstate_adjust_perf(struct cpufreq_policy *policy,
>  				   unsigned long _min_perf,
>  				   unsigned long target_perf,
>  				   unsigned long capacity)
>  {
>  	u8 max_perf, min_perf, des_perf, cap_perf;
> -	struct cpufreq_policy *policy __free(put_cpufreq_policy) =3D cpufreq_cp=
u_get(cpu);
>  	struct amd_cpudata *cpudata;
>  	union perf_cached perf;
> =20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 2082a9e4384f..17a5b8e0ea1e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2231,7 +2231,7 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
> =20
>  /**
>   * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
> - * @cpu: Target CPU.
> + * @policy: cpufreq policy object of the target CPU.
>   * @min_perf: Minimum (required) performance level (units of @capacity).
>   * @target_perf: Target (desired) performance level (units of @capacity)=
.
>   * @capacity: Capacity of the target CPU.
> @@ -2250,12 +2250,12 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
>   * parallel with either ->target() or ->target_index() or ->fast_switch(=
) for
>   * the same CPU.
>   */
> -void cpufreq_driver_adjust_perf(unsigned int cpu,
> +void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
>  				 unsigned long min_perf,
>  				 unsigned long target_perf,
>  				 unsigned long capacity)
>  {
> -	cpufreq_driver->adjust_perf(cpu, min_perf, target_perf, capacity);
> +	cpufreq_driver->adjust_perf(policy, min_perf, target_perf, capacity);
>  }
> =20
>  /**
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 51938c5a47ca..1552b2d32a34 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3239,12 +3239,12 @@ static unsigned int intel_cpufreq_fast_switch(str=
uct cpufreq_policy *policy,
>  	return target_pstate * cpu->pstate.scaling;
>  }
> =20
> -static void intel_cpufreq_adjust_perf(unsigned int cpunum,
> +static void intel_cpufreq_adjust_perf(struct cpufreq_policy *policy,
>  				      unsigned long min_perf,
>  				      unsigned long target_perf,
>  				      unsigned long capacity)
>  {
> -	struct cpudata *cpu =3D all_cpu_data[cpunum];
> +	struct cpudata *cpu =3D all_cpu_data[policy->cpu];
>  	u64 hwp_cap =3D READ_ONCE(cpu->hwp_cap_cached);
>  	int old_pstate =3D cpu->pstate.current_pstate;
>  	int cap_pstate, min_pstate, max_pstate, target_pstate;
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index cc894fc38971..4317c5a312bd 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -372,7 +372,7 @@ struct cpufreq_driver {
>  	 * conditions) scale invariance can be disabled, which causes the
>  	 * schedutil governor to fall back to the latter.
>  	 */
> -	void		(*adjust_perf)(unsigned int cpu,
> +	void		(*adjust_perf)(struct cpufreq_policy *policy,
>  				       unsigned long min_perf,
>  				       unsigned long target_perf,
>  				       unsigned long capacity);
> @@ -617,7 +617,7 @@ struct cpufreq_governor {
>  /* Pass a target to the cpufreq driver */
>  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>  					unsigned int target_freq);
> -void cpufreq_driver_adjust_perf(unsigned int cpu,
> +void cpufreq_driver_adjust_perf(struct cpufreq_policy *policy,
>  				unsigned long min_perf,
>  				unsigned long target_perf,
>  				unsigned long capacity);
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 153232dd8276..ae9fd211cec1 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -461,6 +461,7 @@ static void sugov_update_single_perf(struct update_ut=
il_data *hook, u64 time,
>  				     unsigned int flags)
>  {
>  	struct sugov_cpu *sg_cpu =3D container_of(hook, struct sugov_cpu, updat=
e_util);
> +	struct sugov_policy *sg_policy =3D sg_cpu->sg_policy;
>  	unsigned long prev_util =3D sg_cpu->util;
>  	unsigned long max_cap;
> =20
> @@ -482,10 +483,10 @@ static void sugov_update_single_perf(struct update_=
util_data *hook, u64 time,
>  	if (sugov_hold_freq(sg_cpu) && sg_cpu->util < prev_util)
>  		sg_cpu->util =3D prev_util;
> =20
> -	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
> +	cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
>  				   sg_cpu->util, max_cap);
> =20
> -	sg_cpu->sg_policy->last_freq_update_time =3D time;
> +	sg_policy->last_freq_update_time =3D time;
>  }
> =20
>  static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64=
 time)
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index 76faa1ac8501..a83aec198336 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1256,18 +1256,17 @@ impl<T: Driver> Registration<T> {
>      /// # Safety
>      ///
>      /// - This function may only be called from the cpufreq C infrastruc=
ture.
> +    /// - The pointer arguments must be valid pointers.
>      unsafe extern "C" fn adjust_perf_callback(
> -        cpu: c_uint,
> +        ptr: *mut bindings::cpufreq_policy,
>          min_perf: c_ulong,
>          target_perf: c_ulong,
>          capacity: c_ulong,
>      ) {
> -        // SAFETY: The C API guarantees that `cpu` refers to a valid CPU=
 number.
> -        let cpu_id =3D unsafe { CpuId::from_u32_unchecked(cpu) };
> -
> -        if let Ok(mut policy) =3D PolicyCpu::from_cpu(cpu_id) {
> -            T::adjust_perf(&mut policy, min_perf, target_perf, capacity)=
;
> -        }
> +        // SAFETY: The `ptr` is guaranteed to be valid by the contract w=
ith the C code for the
> +        // lifetime of `policy`.
> +        let policy =3D unsafe { Policy::from_raw_mut(ptr) };
> +        T::adjust_perf(policy, min_perf, target_perf, capacity);
>      }
> =20
>      /// Driver's `get_intermediate` callback.

