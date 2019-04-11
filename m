Return-Path: <SRS0=4kRr=SN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B33C10F13
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 16:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113BA2133D
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 16:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDKQBd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:01:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45528 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfDKQBd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 Apr 2019 12:01:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A42180D;
        Thu, 11 Apr 2019 09:01:32 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A240E3F68F;
        Thu, 11 Apr 2019 09:01:31 -0700 (PDT)
Subject: Re: [RFC 5/6] Improvise cgroup interface for classifying jitter from
 WOF tasks
To:     Parth Shah <parth015@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-6-parth015@linux.vnet.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <52dc3a49-60c0-476f-4a01-c805861458cc@arm.com>
Date:   Thu, 11 Apr 2019 18:01:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190322060621.27021-6-parth015@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/22/19 7:06 AM, Parth Shah wrote:
> Signed-off-by: Parth Shah <parth015@linux.vnet.ibm.com>
> ---
>   kernel/sched/fair.c  | 40 +++++++++++++++++++++++++++++++++++++---
>   kernel/sched/sched.h |  2 ++
>   2 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7ecf5ed0b391..c7be5803a37c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -27,9 +27,15 @@
>   /*
>    * Maintain cpumask to track the core occupying throughput intensive tasks,
>    * which are usually high utilization tasks.
> + *
> + * WOF(Workload Optimized Frequency) tasks are manually classified(task_type=2)

This contradicts with patch 2/6:

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 903ef29b62c3..be8e8617e0cb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -604,6 +604,14 @@ struct task_struct {
  	unsigned int			flags;
  	unsigned int			ptrace;

+	/*
+	 * task_characteristics:
+	 * 0 = unknown. Follows regular CFS policy for task placement.
+	 * 1 = Throughput intensive high utilization task
+	 * 2 = Jitter tasks. Should be packed to reduce active core count.
+	 */
+	long long unsigned		task_type;

> + * high utilization tasks which may get benefit of higher frequencies, because
> + * of higher Instructions per seconds metric. >    */
>   static struct cpumask __highutil_task_cpu_mask;
>   #define highutil_task_cpu_mask ((struct cpumask *)&__highutil_task_cpu_mask)
> +static struct cpumask __wof_tasks_cpu_mask;
> +#define wof_tasks_cpu_mask ((struct cpumask *)&__wof_tasks_cpu_mask)
>   
>   /*
>    * Targeted preemption latency for CPU-bound tasks:
> @@ -5184,6 +5190,16 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>   		flags = ENQUEUE_WAKEUP;
>   	}
>   
> +	/*
> +	 * If TurboSched feature is enabled and task is of WOF type(=1)
> +	 * then mark it on the rq
> +	 */
> +	if (turbo_sched_enabled() && p->task_type == 1)

... and with the code here.

[...]
