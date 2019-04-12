Return-Path: <SRS0=8Vg7=SO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E85C10F0E
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 13:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD8B20818
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 13:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfDLNIv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:08:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60656 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfDLNIv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 12 Apr 2019 09:08:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1E35374;
        Fri, 12 Apr 2019 06:08:50 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9889C3F718;
        Fri, 12 Apr 2019 06:08:49 -0700 (PDT)
Subject: Re: [RFC 5/6] Improvise cgroup interface for classifying jitter from
 WOF tasks
To:     Parth Shah <parth015@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-6-parth015@linux.vnet.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8de36526-806a-810f-9f5e-393dddb523be@arm.com>
Date:   Fri, 12 Apr 2019 15:08:45 +0200
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

[...]

> @@ -6236,7 +6259,15 @@ static int select_non_idle_core(struct task_struct *p, int prev_cpu)
>   	struct cpumask *cpus = &highutil_task_mask_copy;
>   	int core, smt;
>   
> -	cpumask_copy(cpus, highutil_task_cpu_mask);
> +	/*
> +	 * Prefer jitters to be pulled on core occupying WOF tasks
> +	 * If such tasks are not running then use long code path to find
> +	 * non-idle core with spare capacity
> +	 */

I'm struggling to grasp what you mean by ' ... long code path to find 
non-idle core with spare capacity' here?

We're here in:
select_task_rq_fair()->__select_idle_sibling()->select_non_idle_core()

What is the 'long code path'? In case select_non_idle_core() can't find 
a CPU, select_idle_sibling() is called but IMHO that's the original 
fastpath operating on the LLC domain.

It can't be the slow path find_idlest_cpu() because that's only called 
in case __select_idle_sibling() isn't called.

[...]
