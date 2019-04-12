Return-Path: <SRS0=8Vg7=SO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715E8C10F0E
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 11:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E912171F
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 11:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDLLN0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:13:26 -0400
Received: from foss.arm.com ([217.140.101.70]:58464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfDLLN0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Apr 2019 07:13:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 489FB15AB;
        Fri, 12 Apr 2019 04:13:26 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A12363F718;
        Fri, 12 Apr 2019 04:13:24 -0700 (PDT)
Subject: Re: [RFC 4/6] Add cpumask to track throughput intensive tasks
To:     Parth Shah <parth015@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-5-parth015@linux.vnet.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <08788b47-d15c-9529-aae6-3977f6aa32c2@arm.com>
Date:   Fri, 12 Apr 2019 13:13:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190322060621.27021-5-parth015@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/22/19 7:06 AM, Parth Shah wrote:

[...]

> @@ -7038,6 +7046,11 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>   	struct task_struct *p;
>   	int new_tasks;
>   
> +	if (!core_underutilized(cpu_util(rq->cpu),capacity_of(rq->cpu)))
> +		cpumask_test_and_set_cpu(rq->cpu, highutil_task_cpu_mask);
> +	else
> +		cpumask_test_and_clear_cpu(rq->cpu, highutil_task_cpu_mask);
> +

Shouldn't this update of the highutil_task_cpu_mask also be under the 
hood of turbo_sched_enabled()?

[...]
