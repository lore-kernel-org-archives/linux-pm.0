Return-Path: <SRS0=4kRr=SN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A34C10F13
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 15:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9DC2082E
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 15:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfDKPyM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:54:12 -0400
Received: from foss.arm.com ([217.140.101.70]:45370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfDKPyL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 Apr 2019 11:54:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CF0180D;
        Thu, 11 Apr 2019 08:54:11 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6E8B3F68F;
        Thu, 11 Apr 2019 08:54:10 -0700 (PDT)
Subject: Re: [RFC 4/6] Add cpumask to track throughput intensive tasks
To:     Parth Shah <parth015@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-5-parth015@linux.vnet.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <505b6e2f-86fa-cd51-e071-695d1f1da17c@arm.com>
Date:   Thu, 11 Apr 2019 17:54:08 +0200
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
> WOF tasks indicates the workload optimized frequency tasks which has

You should explain what WOF stands for before you it. I think its only 
done in the next patch.

[...]

> @@ -6225,10 +6232,11 @@ static const int core_cap_mf = 16;
>    */
>   static int select_non_idle_core(struct task_struct *p, int prev_cpu)
>   {
> -	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +	struct cpumask highutil_task_mask_copy;

Don't put struct cpumask on the stack.

[...]

