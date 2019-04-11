Return-Path: <SRS0=4kRr=SN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473EFC10F13
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 13:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2198E2133D
	for <linux-pm@archiver.kernel.org>; Thu, 11 Apr 2019 13:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDKNqu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:46:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43514 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfDKNqu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 11 Apr 2019 09:46:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0F5680D;
        Thu, 11 Apr 2019 06:46:49 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34A9C3F68F;
        Thu, 11 Apr 2019 06:46:49 -0700 (PDT)
Subject: Re: [RFC 2/6] Provide cgroup interface for manual jitter
 classification
To:     Parth Shah <parth015@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-3-parth015@linux.vnet.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <462cf628-1b0b-4f8c-251d-c0cff6af18fd@arm.com>
Date:   Thu, 11 Apr 2019 15:46:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190322060621.27021-3-parth015@linux.vnet.ibm.com>
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
>   include/linux/sched.h |  8 ++++++++
>   kernel/sched/core.c   | 46 +++++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/fair.c   | 15 +++++++++-----
>   kernel/sched/sched.h  |  2 ++
>   4 files changed, 66 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 903ef29b62c3..be8e8617e0cb 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -604,6 +604,14 @@ struct task_struct {
>   	unsigned int			flags;
>   	unsigned int			ptrace;
>   
> +	/*
> +	 * task_characteristics:
> +	 * 0 = unknown. Follows regular CFS policy for task placement.
> +	 * 1 = Throughput intensive high utilization task
> +	 * 2 = Jitter tasks. Should be packed to reduce active core count.

This is very similar to the ideas in [PATCH v8 00/16] Add utilization 
clamping support 
https://lore.kernel.org/lkml/20190402104153.25404-1-patrick.bellasi@arm.com 
. Task classification from userspace ...

[...]
