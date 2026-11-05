Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793867682;
	b=magWc4RTQ1U1RBro5Bvsqko393vDfd1t718yGdsXjk7uTqIt78vonse62Y6014j89mP/
	 1znVDYiSEcc0ThoAre0yL2Kj7J4KF1h2za7dBqmgcew0rUVyR//BlpoCuZoDAHCRZsxqb
	 JzkcB4dCm1lECa3Ab/tVgQ4oI/1O6MFOkcfO1r6N3OsUZ8dzGrFVuZkymVenzz/VM14/F
	 0dt7jzYpy8AkdOpBGw3ZOC56nSecTmvn97SARjt2d18MAIAYB+El+BdaRrnkRc2KuC07Z
	 Ww5T0cB/Z7qbrf4xfxFlwziJSKe67DdHdccfgvKHiCZgWMIdfZoC9q9WBLad7CyWMGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867682;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=LpdruonP+IIU8qNNX8B+h/AfZa+v1QCw6qBbN7dyYHw=;
	b=29vJfO/wJs/7dytzNNYf4mXDad/BTDjE8UETiisdbK7tLycoFU5gBwidez5mvwmjkk3U
	 ymtLYnU0pq2gJD1td+5FCrRPd+lH5e0UdwX+t1sNUUPM7zhcR7ZXyGzpcam0GS/34j4Av
	 fyffNO4HG9LmGFv6G3b8gQ9CMmf6gx5N41Mw0DG/pu6ARMm8ao3t+e385TKjSe/c867Uf
	 p9njZjv9c9rHGQNqydgLWueQZ0zwBlVHuCRfKbOOGr6/tMhOwSlhjCisRW2ZvSaCFNX3y
	 S0KL9GO3v+i7hGCTVQAHRbVhIBVkJmx0dXl1rqRl1tXtgx1o4OwQnJix4qrpWqydi9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WhCnMXBX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.63
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91AA606A31B;
	Thu,  5 Nov 2026 08:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A91AA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WhCnMXBX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImmzleKdxzZ+/isDkBuR7QSyJ4+r8oj0VuhPo2FIdKwM1iVVzo5c8Mh/5QJBK0EPj74dHH7SJWHpeCOFc98TgSq0TmEeFquourndKAcp3sjPtIlh0ZvhZu33OFhY6tXBLmqk4UdXTMmhI1IlHGyMG60AqC4N90i3rVRD6CHTMESDYv2tPdIrwxcbE9veMkEjXvZSaV8+/bgkbmYAX5Ufl7jVH0ekSXXQ3+gcKFtzEPZZ3UNcd2BH+H6nTceidgSnERJp+pRwFFpY4fuUgTzufw8XSUNxMacTv7Uz2ZCuvP0z3Km7iR/cSnEG9GwRnY9vmghgUaSsmoEM0CwHcBuKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpdruonP+IIU8qNNX8B+h/AfZa+v1QCw6qBbN7dyYHw=;
 b=LKKVLvEUMRDWQzDBvl3+NMFwBRx/RvFs8qAOVEQxOW8zsDkXzei4cz+GheT+sbgvbaVMHjPjM4hhV0jKHYsdyVweoyx+j8LMITFcVt75OmeckjDk5ZGTcsht7AoTcpZSGF47i2zJs42hwBWDwHi0LkXb6FESkopF4PcoHpwmLCknZD5urojJecsXNpZCRba2i9+QlPuO0XpTfSvzVxL3AG215dL88TGy1UqOhNY9WwAJ8es3pjm0yG8r94GVxAs7rXZvhCYbOJQzb22rG5R0hprwqM4pDOKIHS5Jb83xpaNiHL19hyFaPk+rst7VOGTSdOc/ycVnVumKPnMQlWBomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpdruonP+IIU8qNNX8B+h/AfZa+v1QCw6qBbN7dyYHw=;
 b=WhCnMXBXyFrRPvlDSLyIBpx+XZvQ88QuOS7NRvBtjXML2SrZFrc/ctt7BA9v92rGF4tSO1xdmkRGoiWpcJJv8zsFGMRgqPGCziaxFc0AcrU97iF0ZG23dysi5z6lOx5etlOaSMBRGQmFuLSgzSfsJFGi7uCk3UxUTsmJbkhFsRg=
Received: from DM6PR06CA0081.namprd06.prod.outlook.com (2603:10b6:5:336::14)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 08:34:37 +0000
Received: from CY8PEPF00000059.namprd21.prod.outlook.com
 (2603:10b6:5:336:cafe::48) by DM6PR06CA0081.outlook.office365.com
 (2603:10b6:5:336::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 08:34:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000059.mail.protection.outlook.com (10.167.247.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Thu, 5 Nov 2026 08:34:36 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 02:34:36 -0600
Received: from [10.136.35.83] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 5 Nov 2026 02:34:33 -0600
Message-ID: <99366157-08b9-411f-b180-fa61bc5f5002@amd.com>
Date: Thu, 5 Nov 2026 14:04:27 +0530
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
To: Francesco Nigro <nigro.fra@gmail.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, "Mike
 Galbraith" <efault@gmx.de>, Mario Limonciello <mario.limonciello@amd.com>,
	Huang Rui <ray.huang@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
References: <20261103154603.1893325-1-nigro.fra@gmail.com>
 <5af4860d-096a-4e9d-a3b3-0b8277924146@amd.com>
 <20261105081245.81773-1-nigro.fra@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261105081245.81773-1-nigro.fra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000059:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db08bed-f418-4338-f5c8-08df3b17a04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|261102123227099003|13003099007|261009223027099003|261028144727099003|261022113327099003|261022105027099003|11063799006|4143699003|56012099006|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	+1gqIZ/5eqtPf6CYIXYWGf4RSv9c1Y+VPXQHAFsPP++bNwF2YFebx1J9UXz8Rb6UIQkmaYjx/+0NWANZ7vSyB62XM0FdfkC0QDkKmoOzQWREY3EuW5f4/cY2PJe9aNexgjGXy/MIOmk42ujw8KcqbMlvvwLL/b3ULZmBwNDqD4h4wo1047koWRMlKuVopVFiVzZdZbauZdzZ+WxywP9f0BBFATdYKrNrb6rX/4ACTwRX8G2IvJlq+un9oys0G6fupr7WfUqmgpEO5uFSqolYGJexLtOk8lxMrUBPkIPNKMBt75A3cyRsNVlhlmEi+RZi7Z0aGnwGiCAOsfDGkUtdUK2TAhDoxCVyCHOfV0eENbguf7AewOZ4pFujXwmUBSuRa0J5BYNRvUB2lFYkgi+sTFzAQvLG2YPfiCgFH5nSOzK5Jj9O8X6hPIddJUZ3FyJ4uNQeq2rEL3nMiE748BNYatDIt4unNLxunfTJ+mvCZt9Rpk+GKzq2T1+7wbwL1aH6igiBPLQeyQdRFpyy7R8dWoGI+W1FwhkLnOvBz40mdTpEdFhnq4kbHCukv0fn0eHbBuxgcQcnGu3cGd7nzzVfGW+7d9hxyIKhEa3zo29O6n4jAUS65vfI3zizsgVQ6RkHruv82sXY9ctB8+nEwwClmhKueu2J7RukIG7H7sz9pNLJxeiae3JMnnPExLBzPvHDYwRql73rMnfiXARBegEXDg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(261102123227099003)(13003099007)(261009223027099003)(261028144727099003)(261022113327099003)(261022105027099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GEXw75chppsEbWg9fhPFdYlkBEqTm7uDE9YYITf3GDFSLGev4kaw6KQRuk4IR5l4oA6ELW/yWF92d++wHkRJr2ZOx73qfO7mUMEnKv+c0ARkJV+k9bBibuBXtVxxDS25Zk6OYzvl2m0ZgXwnQpyq/fvEwoRU5uKrf31U8DRW2EqOwiCn4HM5wviAFxTWxqDwICI5Hd6iIlQ03Dk64WmvQ8HAZU0y2T6RGhlB8t6vRqcVxywpIM4ARDryXp2peWe1+tLUFs3ACEGVXY2gMwKw/rx21FDHH0lc4OZ7lzU5qh+0E1nwpX5JMCEEKV3fOEgRpVzj1xrCBccDNF3BO6eUWFoHgliG1iioPLmwLufM5LU7/PfXYBPhMCLxZ+s2d42PUFozzvHKNR7xxE8rl+WXBM7gQpSGBIlRSTZfOUbD4afEcOpUKPLIrZgX5PAjAUIp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 08:34:36.8624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db08bed-f418-4338-f5c8-08df3b17a04b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000059.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648

Hello Francesco,

On 11/5/2026 1:42 PM, Francesco Nigro wrote:
> [You don't often get email from nigro.fra@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Thu, 2026-11-05 at 09:41 +0530, K Prateek Nayak wrote:
>> Hello Francesco,
> 
> Hi Prateek,
> 
> thanks a lot for looking into this, and for the patch.
> 
> This is a corporate machine, so I can't promise I will be able to boot
> a patched kernel on it, but I will try.

No worries I'll try it on my end over the coming weekend.
 
>> Since you say ITMT disabled actually solves this issue, I suspect there is a
>> race between the idle balancer moving the delayed task to a preferred CPU vs
>> a wakeup that also lands on the same CPU.
> 
> perf sched shows a race like that, but the task moved is the running
> one, by active balance. One example (perf sched timehist, trimmed; ms):
> 
>     .654334  [6]  worker 482   awakened: migration/7
>     .654337  [6]  worker 482   blocks

I'm having a hard time understanding why asym_active_balance() would
trigger before worker 482 blocks - also I'm assuming at this point
482 is the only task on the CPU so it shouldn't get delayed since
single task on CPU is always eligible.

>     .654338  [7]  worker 481   preempted while running
>     .654341  [7]  migration/7  migrated: worker 481 cpu 7 => 6
>     .654341  [2]  waker        awakened: worker 482
>     .655572  [6]  worker 482   ran 1.006 after 0.224 sch delay
> 
> Does your change cover the active balance path too?

I think I was missing the other part of allowing a delayed task to
migrate with the following diff:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b8c26a6ca82d..71dd82394006 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11133,14 +11133,16 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	/*
 	 * We do not migrate tasks that are:
-	 * 1) delayed dequeued unless we migrate load, or
+	 * 1) delayed dequeued unless we migrate load / migration to idle CPU, or
 	 * 2) target cfs_rq is in throttled hierarchy, or
 	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
 	 * 4) running (obviously), or
 	 * 5) are cache-hot on their current CPU, or
 	 * 6) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
 	 */
-	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
+	if ((p->se.sched_delayed) &&
+	    (!(env->flags & LBF_FIRST_MIGRATION) &&
+	     env->migration_type != migrate_load))
 		return 0;
 
 	if (lb_throttled_hierarchy(p, env->dst_cpu))
---

This should allow for an idle CPU to see a delayed task and block it
even if it is has not yet hit the "migrate_load" threshold but it
still doesn't explain why the active balance gets triggered before
blocking.


>> So at this point, I would have expected B to have already been
>> moved by a newidle / idle balance.
> 
> Not here: in 270 of 286 waits of 0.5 ms or more, neither worker left
> CPU 6, and CPUs 4, 5 and 7 were idle for at least 98 % of the wait.
> 
> Trace summary and excerpt:
> https://github.com/franz1981/itmt-delay-dequeue-repro/tree/827b6b2

Thank you! Give me a wee bit more time to trace this path and I'll get
back to you by next week. Thank you again for all the data.

-- 
Thanks and Regards,
Prateek

