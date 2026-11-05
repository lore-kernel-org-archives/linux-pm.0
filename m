Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793851909;
	b=k4bvwG7ba3KcHl0iWi8wwUj+w5uII7R9Mvc2Q/SUhpRhmoFF07QJAPnyNz0hcJPA+pWk
	 WZfqkF2Q+ZQef9jG12V/vrCnKEi+olKZPjOOUZ8BQzwh9M+5E92Rs/AbaeETcxeFgzO27
	 wIxVqHSUv1rZCCRums8rKmEJK4Die4uQFRNltrm9GGATT/xUTLg7Hi8pI/yr+t1GXnaXh
	 EkGWjoTsrygrx51DJwx3O3LkIbdfBb46BROZGCpsxBdfr7XL380B0/1hj5e6Er9CqyY69
	 MwCQv8yeSqUHNJqwh2AC/glD1icKRMUfiRsr5l7vFcM9C9ta+8GQDJ2rpF89TzbbHsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851909;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tsbYRq6+J0iw3I3nF2xANwCX78BHN+UqccXq3w8wcpI=;
	b=m88YKTTPJ6Y3Bcf1+yfAbSj6KK367FxZYuLnbGTtZiBr2TXvE7Z998zYcmnsR5Um5lLp
	 M7eOv/g5S4283lRsYMsoEEgmWngHjN/fPegIq840Nkx8nd94vzlYTMFdE4avxvkLN6g8D
	 zxQgjJUxOfrpWsPMOvRsXJ3FWq2ufA+hsU3msdPZU6X/edHqd6+pzVOQB47nhMYoNr5Lx
	 CviTR22WQA6daS7ISSyDVloEycVZK64ozxxCuk8yoYwFihs/a7v7QHaH0pAox3qwdc78N
	 Yt4KMmwdrUJgb3L0Ek/70PAEZ4UrIvyt/EQfwVHIIKRpC8cba36MbUyXluMB0mvBmKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uWNCwBm7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.66
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E57606A31B;
	Thu,  5 Nov 2026 04:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53E57606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uWNCwBm7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHLVZX3Jq+Ta8XX2iiH5oTIV5/qrT9vvUKFWqelVrhKPo71QjhbUVx8K1UZLG++ioT4B58pgpzYR00eWnGRErVBy+w772RsU25IMmh43pn4zK1d+FT1bcAV3ZkyTXMk3LUtgSR1WcPjkD16A0CoZe2EMAaRpyFeET6kWjTOM9I/vElZTZUQl58GdgZTAM3IG4Sq+hcolqF16uXahEMQMwBUqd+c8AtdI76AErkD+eIfCk2j7WVnQl41pedDHh8I1rNnxqAqETsYmVa84emo91KrENeudRQ0dfktV8R9zwm4jRs4Rzo5j+hLEp87lWrisZrqKKv+NJJpixVfp/wKleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsbYRq6+J0iw3I3nF2xANwCX78BHN+UqccXq3w8wcpI=;
 b=NyZirSxk77TvgPBdTuskgjK+EnXFqQWkSyVxER+0ZNcI3MhCLJrYGEcjFuvCZV9GGAxxBTgIu5ebRocPkziaN+VRMKhl05cwicAhabLoGaDNGHFbIdiv9x3uxPbibe4wlTxaRN9deGjE8mr8V3iKl4s02mIKXispvo+QojolIJPhb5IA0ysmRlxAkxrL5pw3I0768gv5BpZRK1PMBXdhV0tSpAWCDYKBvvjWrzEbjuN25aP3xr+noroXFmi4K7bNklmwHyDosXm3VFu+WEn6EIEbpe/ycvDs/XiTbrb5Sfi1uu/E8rrCtApf0FGvtjhkRbF06U5Wei+ttll7TaZ/qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsbYRq6+J0iw3I3nF2xANwCX78BHN+UqccXq3w8wcpI=;
 b=uWNCwBm7OldHpgM4pkr2JtEW2St7Lg1anXEBnOcCHjeFVPZkslrzb/4bRSrtFAlC8V/ZaBVnNcgqvly5RTU+lGKT7wLXpLq6+uJ9XsMb0Ba9I5+2/K4M3OM+EB0D5nz0xzMWIgdWmhOqkB1wMarvNuFqgyYx2dBU3edo0cg91dw=
Received: from SJ0PR03CA0214.namprd03.prod.outlook.com (2603:10b6:a03:39f::9)
 by PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 04:11:41 +0000
Received: from SJ1PEPF000037AC.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::a6) by SJ0PR03CA0214.outlook.office365.com
 (2603:10b6:a03:39f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:11:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AC.mail.protection.outlook.com (10.167.244.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:11:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:11:40 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:11:39 -0600
Received: from [10.136.35.83] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 22:11:36 -0600
Message-ID: <5af4860d-096a-4e9d-a3b3-0b8277924146@amd.com>
Date: Thu, 5 Nov 2026 09:41:35 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REPORT] sched: ITMT + DELAY_DEQUEUE: woken task waits ~1 ms
 behind another task on the preferred CPU while allowed CPUs are idle
To: Francesco Nigro <nigro.fra@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
	<vschneid@redhat.com>, Mike Galbraith <efault@gmx.de>, Mario Limonciello
	<mario.limonciello@amd.com>, Huang Rui <ray.huang@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20261103154603.1893325-1-nigro.fra@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261103154603.1893325-1-nigro.fra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AC:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 79c34353-5aaf-41fc-f954-08df3af2e51b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|30052699003|36860700016|82310400026|261022075727099003|261021123027099003|261026140227099003|5023799004|11063799006|261021121427099003|261026121527099003|261022105027099003|56012099006|261009223027099003|261021135927099003|261028144727099003|10067099003|18002099003|261102123227099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	CH9g3Um4kWOeLmSTsL00nJ7/xD0D9J+Tc8Wai5a56sUHKTpMoNa9Y4yjLgNzTWTS5PEpKf/yeM9WhIbSnjm3Xcsrjp0brYeh19dWa9IF8hY0QEqErW0AdmoUzPMQA1/LC4i2GF2VIv12XuFsQmuqvVvbmSoBdIZdfd8WzNCnMSlxI4/LbTXLX2kGVRvsjuq5c68tIeiVOK1fpMSpQYsybsakAVSkw6rvi+2sf0x+5Cf86SmuAxyu7U5egZEILLj+1JhAuUlNADo9mxBEQd61sE3x6VFRunzt49u9K2GuUmY9luX35dpp0S7FrpX/9lzPGJx+X3gpb9i7uCvRt2LkxaAYQTNKa3GTvkaF25WDI4a/W62SklPjg6jREAdzkt9d8eK3Fj8HbYHofhpddKmouFMrugcW/ISalQtzoNBBfATfcE1XhcTl/075qX4MT/GotjJJcCRRjIUMfANGLBG7uaLpCSA1Ll6JY7OJH+E7oxngz9kZnBW4kwsBV7G6wVhJPXCm9UiC3EE79ebOJ97vgs21m9X4VBznW50BqUmSg7FbCOofKVMqJ8K/Ym753N5iVFWMKBdE5CRemA6x6LON2A1VLd6m72M1j0kr3v1Z0Paza1zwL9+wpTqhYrqcOqEFoJzAotYvxmYNPeQOATtkIBK8ydA5RqmRTcHi5c66Ub0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(30052699003)(36860700016)(82310400026)(261022075727099003)(261021123027099003)(261026140227099003)(5023799004)(11063799006)(261021121427099003)(261026121527099003)(261022105027099003)(56012099006)(261009223027099003)(261021135927099003)(261028144727099003)(10067099003)(18002099003)(261102123227099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hGDi1Mwu//bpJU405EDcB3Ty6a1c16+jIKCqLK7K7VZ0NRED9J68dbyltZvHv1xZgwbw9bzbSn9BwdlzhZdWhsyL0Ezb1691QxRhOtxdGu+uKE+Nwn1qgs/xwFVpVy6z3p1y/PUXWhX2BMEgXozT2+Xm5f/bbDO1FxjvEnlSVgZTdMLvEEqs3pMoVAr0GScFsHaA7yizooTkeAUa2QqfwNeMuK7v93bfbwH4JtV4fzHjxs3WWoQc1NhAwrVsZzEd+nrb+l6FN+6Uyem2bkU0BJEWCjv94/FM7OpqQYxg/mB21i3+szEqe0nQCivGj348BSEE/XjC2lUMG03Q9xkPZfuIUS3fkWwiHP6pHe8NnxtSVtNxuHUhjN0VV4i6UFGSD8sZAupXTbqX4dwS3QZES48caR43Z2Dm5bwABX5+Z9jhsITvrdjITqlUlQR8YRjk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:11:40.8934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c34353-5aaf-41fc-f954-08df3af2e51b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889

Hello Francesco,

On 11/3/2026 9:16 PM, Francesco Nigro wrote:
> Hi,
> 
> A woken thread waits behind another running thread while other CPUs it
> is allowed to use are idle.
> 
> I see this on an AMD Ryzen 9 7950X running Fedora's 7.1.13 kernel, with
> ITMT (AMD preferred cores) and DELAY_DEQUEUE enabled. Two busy threads
> end up on the same CPU, the highest-ranked of the ones they are allowed
> on. When one of them is woken, it is queued behind the other one and
> starts one full CPU burst late (1 ms here). That happens to 0.08-0.36 %

That % seems very low for this to make a visible impact but yes, since
wakeups and load-balancing is lockless, there is a chance concurrent
instances can stack tasks, momentarily, on the same idle CPU that
suddenly turns very busy.

> of wakeups. Reproducer, scripts and raw results (commit 49b6d72):
> https://github.com/franz1981/itmt-delay-dequeue-repro
> 
> Kernel and machine
> 
>   - Fedora 7.1.13-100.fc43.x86_64, untainted, Fedora's stock .config
>     (at the link above): HZ=1000, PREEMPT_DYNAMIC (lazy), SCHED_MC_PRIO,
>     SCHED_AUTOGROUP, FAIR_GROUP_SCHED, NO_HZ_FULL. Fedora's
>     patch-7.1-redhat.patch touches nothing under kernel/sched/, nor
>     itmt.c, amd-pstate or cpufreq. I cannot boot mainline or a patched
>     kernel on this machine.
>   - AMD Ryzen 9 7950X, SMT on, amd_pstate active with prefcore,
>     sched_itmt_enabled=Y. CPUs pinned at 4300 MHz, boost off.
>   - CPUs 4-7 have prefcore rankings 211, 216, 231, 221 and the same
>     amd_pstate_highest_perf (166): CPU 6 is not faster than the others.
> 
> Reproducer
> 
> Two threads each run a calibrated 1 ms CPU burst and block on an eventfd.
> A waker thread on CPU 2 busy-polls and writes each eventfd 10 us after
> that thread's burst ends. A handoff (waker's timestamp before the write
> to read() returning) of 0.5 ms or more counts as a stall.
> 
>     gcc -O2 -pthread -o asym_min asym_min.c
>     taskset -c 4-7 ./asym_min 1000 10 30 2
> 
> asym_min.c (195 lines):
> https://github.com/franz1981/itmt-delay-dequeue-repro/blob/main/asym_min.c
> 
> Results, 5 interleaved rounds of 30 s (results-final-min.txt):
> 
>     setting                      stalls per run         total
>     defaults                     212  49  48  76 214    599 of 294616
>     sched_itmt_enabled=0           1   0   0   0   0      1 of 295349

Since you say ITMT disabled actually solves this issue, I suspect there is a
race between the idle balancer moving the delayed task to a preferred CPU vs
a wakeup that also lands on the same CPU.

The only time load balancer looks at the asym priority is is for idle /
newidle balance and stacking is only possible from a race - back at OSPM
Vincent and I had a discussion if we should just block a delayed task on
idle migration, and also use the wakelist to offload the activation to the
remote ,idle CPU; that may make a difference here.

If it isn't too much trouble, could you please try the below changes
prepared on top of v7.4-rc1:

  (Lightly tested on top of v7.4-rc1)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1c93da75226e..6420e3d72904 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -994,6 +994,8 @@ struct task_struct {
 	/* Used for emulating ABI behavior of previous Linux versions: */
 	unsigned int			personality;
 
+	unsigned int			sched_remote_wakeup;
+
 	/* Scheduler bits, serialized by scheduler locks: */
 	unsigned			sched_reset_on_fork:1;
 	unsigned			sched_contributes_to_load:1;
@@ -1005,20 +1007,6 @@ struct task_struct {
 
 	/* Unserialized, strictly 'current' */
 
-	/*
-	 * This field must not be in the scheduler word above due to wakelist
-	 * queueing no longer being serialized by p->on_cpu. However:
-	 *
-	 * p->XXX = X;			ttwu()
-	 * schedule()			  if (p->on_rq && ..) // false
-	 *   smp_mb__after_spinlock();	  if (smp_load_acquire(&p->on_cpu) && //true
-	 *   deactivate_task()		      ttwu_queue_wakelist())
-	 *     p->on_rq = 0;			p->sched_remote_wakeup = Y;
-	 *
-	 * guarantees all stores of 'current' are visible before
-	 * ->sched_remote_wakeup gets used, so it can be in this word.
-	 */
-	unsigned			sched_remote_wakeup:1;
 #ifdef CONFIG_RT_MUTEXES
 	unsigned			sched_rt_mutex:1;
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04b62c16fa8c..fbaa47496cb2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3981,7 +3981,12 @@ void sched_ttwu_pending(void *arg)
 		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
 			set_task_cpu(p, cpu_of(rq));
 
-		ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
+		if (p->sched_remote_wakeup & WF_LB_MIGRATED) {
+			attach_task(rq, p);
+			continue;
+		}
+
+		ttwu_do_activate(rq, p, p->sched_remote_wakeup, &rf);
 	}
 
 	/*
@@ -4020,11 +4025,11 @@ bool call_function_single_prep_ipi(int cpu)
  * via sched_ttwu_wakeup() for activation so the wakee incurs the cost
  * of the wakeup instead of the waker.
  */
-static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
+void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
+	p->sched_remote_wakeup = wake_flags;
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cfc982205b98..b8c26a6ca82d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10617,6 +10617,7 @@ enum migration_type {
 #define LBF_ACTIVE_LB	0x10
 #define LBF_LLC_PINNED	0x20
 #define LBF_ACTIVE_LB_LLC	0x40
+#define LBF_FIRST_MIGRATION	0x80
 
 struct lb_env {
 	struct sched_domain	*sd;
@@ -11404,11 +11405,72 @@ static int detach_tasks(struct lb_env *env)
 			break;
 		}
 
+		/* First migration to an idle CPU */
+		if (env->flags & LBF_FIRST_MIGRATION) {
+			/*
+			 * If a delayed task is moving to an idle CPU,
+			 * block it here. It is okay to skip detach
+			 * accounting since imbalance from this move has
+			 * already been subtracted.
+			 */
+			if (p->se.sched_delayed) {
+				dequeue_task(env->src_rq, p,
+					     DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
+				continue;
+			}
+			/*
+			 * Prevent further wakeup on the dst_cpu
+			 * if it was idle by signalling pending wakeup.
+			 */
+			WRITE_ONCE(env->dst_rq->ttwu_pending, 1);
+		}
+
 		detach_task(p, env);
-		list_add(&p->se.group_node, &env->tasks);
 
-		detached++;
+		if (env->flags & LBF_FIRST_MIGRATION) {
+			env->flags &= ~LBF_FIRST_MIGRATION;
+			/*
+			 * Destination is idle; Let it do the enqueue.
+			 * Detach accountng in unnecessary since
+			 * imbalance is already subtracted.
+			 *
+			 * Note: It is necessary to check p->__state to ensure
+			 * the task cannot receive a concurrent wakeup else, it
+			 * is possible to deadlock like:
+			 *
+			 * Initial state:
+			 *
+			 *   p->__state = TASK_UNINTERRUPTIBLE;
+			 *   <p preempted>
+			 *
+			 *		CPU0				CPU1
+			 *		====				====
+			 * sched_balance_rq()
+			 *   # CPU3 is the busiest with task p
+			 *   detach_task(p)
+			 *     p->on_rq = TASK_ON_RQ_MIGRATING
+			 *   __ttwu_queue_wakelist(p, 1)	-> IRQ
+			 * 					  try_to_wake_up(p)
+			 * 					    if (ttwu_state_match())
+			 * 					      ttwu_runnable()
+			 * 						__task_rq_lock()
+			 * 						  !! Deadlock !!
+			 *
+			 * The remote enqueue should complete for wakeup to
+			 * proceed but the call function interrupt is queued
+			 * behind the IRQ doing the wakeup.
+			 */
+			if (sched_feat(TTWU_QUEUE) &&
+			    READ_ONCE(p->__state) == TASK_RUNNING &&
+			    env->dst_cpu != smp_processor_id()) {
+				__ttwu_queue_wakelist(p, env->dst_cpu, WF_LB_MIGRATED);
+				goto skip_enqueue;
+			}
+		}
 
+		list_add(&p->se.group_node, &env->tasks);
+		detached++;
+skip_enqueue:
 #ifdef CONFIG_PREEMPTION
 		/*
 		 * NEWIDLE balancing is a source of latency, so preemptible
@@ -13799,6 +13861,10 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 	ld_moved = 0;
 	/* Clear this flag as soon as we find a pullable task */
 	env.flags |= LBF_ALL_PINNED;
+
+	if (env.idle)
+		env.flags |= LBF_FIRST_MIGRATION;
+
 	if (busiest->nr_running > 1) {
 		/*
 		 * Attempt to move tasks. If sched_balance_find_src_group has found
@@ -13831,6 +13897,13 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 		if (cur_ld_moved) {
 			attach_tasks(&env);
 			ld_moved += cur_ld_moved;
+			/*
+			 * detach_tasks() above can set the "ttwu_pending" on
+			 * the destination to prevent concurrent wakeup on the
+			 * same CPU. Clear it here. Since rq->nr_running is
+			 * non-zero after attach, idle_cpu() will return false.
+			 */
+			WRITE_ONCE(env.dst_rq->ttwu_pending, 0);
 		}
 
 		local_irq_restore(rf.flags);
@@ -13870,6 +13943,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
 			env.loop	 = 0;
 			env.loop_break	 = SCHED_NR_MIGRATE_BREAK;
 
+			if (idle_cpu(env.dst_cpu))
+				env.flags |= LBF_FIRST_MIGRATION;
+
 			/*
 			 * Go back to "more_balance" rather than "redo" since we
 			 * need to continue with same src_cpu.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6c7c5633524a..ea216b06fd92 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2575,6 +2575,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 #define WF_CURRENT_CPU		0x40 /* Prefer to move the wakee to the current CPU. */
 #define WF_RQ_SELECTED		0x80 /* ->select_task_rq() was called */
 #define WF_TTWU_RQ		0x100 /* Wakeup completed through ttwu_runnable() */
+#define WF_LB_MIGRATED		0x200 /* Wakeup completed through ttwu_runnable() */
 
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
 static_assert(WF_FORK == SD_BALANCE_FORK);
@@ -3162,6 +3163,7 @@ static inline void __block_task(struct rq *rq, struct task_struct *p)
 	smp_store_release(&p->on_rq, 0);
 }
 
+extern void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags);
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
 extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
---

There is still chance of stacking but theoretically, it should reduce
the chances of stacking a delayed task on a busy CPU.

>     NO_DELAY_DEQUEUE              21   9  11  26  14     81 of 295201
>     defaults, SMT siblings
>     20-23 also allowed            16  27  15  13   2     73 of 295215
> 
> The median handoff is 3 us in every setting.
> 
> Trace
> 
> stackcheck.bt records, per wakeup, whether se.sched_delayed was set at
> try_to_wake_up() and whether select_task_rq_fair() ran. Two 30 s runs with
> the defaults (results-final-min-trace.txt):
> 
>                                                     run 1    run 2
>     worker wakeups                                  58592    58770
>       delayed, no select_task_rq_fair()               340      174
>     waits >= 0.5 ms                                   310      153
>       on CPU 6 behind the other thread                288      137
>       after a delayed wakeup, no CPU selection        280      139
>       other thread moved to CPU 6 by
>         active_load_balance_cpu_stop()                 30       12
> 
> In a third run (stackcheck-idle.bt), 3 of the 4 allowed CPUs were idle
> when the waiting thread was woken, in all 102 waits >= 0.5 ms.
> 
> The code path in 7.1.13:
> 
>     fair.c:dequeue_entity()
>         if (sched_feat(DELAY_DEQUEUE) && delay &&
>             !entity_eligible(cfs_rq, se)) {
>             ...
>             set_delayed(se);
>             return false;
>         }
> 
>     core.c:try_to_wake_up()
>         if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
>             break;
>         ...
>         cpu = select_task_rq(p, p->wake_cpu, &wake_flags);
> 
>     core.c:ttwu_runnable()
>         if (p->se.sched_delayed)
>             enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
> 
> Sequence, from the trace flags and the code above (A waits, B runs):
> 
>     CPU 6                                   CPUs 4, 5, 7
>     -----                                   ------------
>     A ends its burst and blocks while
>     not eligible: stays queued, delayed

So at this point, I would have expected B to have already been
moved by a newidle / idle balance. Reduced stacking from ITMT
disabled kinda points to the wakeup vs load balancing race.

>     B runs its 1 ms burst                   idle
>     the waker writes A's eventfd;
>     ttwu_runnable() re-queues A on CPU 6,
>     no select_task_rq()                     idle
>     B's burst ends, A runs ~1 ms late
> 
> A task alone on its cfs_rq is always eligible, so A can only be delayed
> while B shares CPU 6. How the two first end up there is only partly
> traced (active balance in 30 and 12 of the waits above).
> 
> Mainline (7.4-rc1) still re-queues a delayed task in place in
> ttwu_runnable(). I have not run it.
> 
> Related, not tested here
> 
>   - Mike Galbraith, "sched/fair: Dequeue sched_delayed tasks when waking
>     to a busy CPU" (tip sched/urgent, 2024-11-11; not in 7.1.13 or
>     7.4-rc1) and its V2 thread:
>     https://lore.kernel.org/all/bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de/
>   - Peter Zijlstra, "[PATCH v2 11/12] sched: Change ttwu_runnable() vs
>     sched_delayed" (2025-07-02, not merged):
>     https://lore.kernel.org/all/20250702121159.535226098@infradead.org/
>   - "sched/fair: DELAY_DEQUEUE causes ~25% pipe IPC regression on
>     Raspberry Pi 5" (2026-04), a different symptom, no ITMT:
>     https://lore.kernel.org/all/20260423080453.GQ3126523@noisy.programming.kicks-ass.net/
> 
> Questions
> 
>   1. Is this cost expected when a delayed task is woken on a busy CPU
>      while other allowed CPUs are idle? Here the busy CPU is not faster
>      than the idle ones, and each stall costs one full burst.
>   2. Is the ttwu_runnable() change in the threads above still planned,
>      and would it be expected to cover this case?
>   3. What else would be useful to trace or measure on this machine?
> 
> Notes
> 
>   - Tested on this machine only; Intel ITMT is untested. Which settings
>     matter elsewhere is a guess: the allowed CPUs relative to the
>     preferred-core ranking, SMT siblings, the waker CPU. scan.sh at the
>     link above tries several CPU sets without root.
>   - asym_stack2.c at the link above is an earlier, longer version of the
>     reproducer. It showed the same pattern at about 3x the stall rate
>     (results-final.txt); I don't know why the rates differ.
> 
> Tool use: an AI coding assistant (Claude Code, Claude Opus 5.5) wrote
> the scripts, ran the measurements on this machine and drafted this
> report; Codex helped with earlier analysis. I reviewed the method and
> the numbers against the raw files and can answer for them.

Thanks a ton for all the details. The only preferred core system I have
at the moment is my laptop (4C/8T) so I'll try to give your reproducer
a spin there and meanwhile, I'll check if I can borrow a 7950x
internally and test this out.

Thank you again for the report.

-- 
Thanks and Regards,
Prateek

