Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F14C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 16:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9C3206DF
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 16:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfDJQjj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:39:39 -0400
Received: from foss.arm.com ([217.140.101.70]:57788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731199AbfDJQji (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Apr 2019 12:39:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40642374;
        Wed, 10 Apr 2019 09:39:38 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B8673F59C;
        Wed, 10 Apr 2019 09:39:37 -0700 (PDT)
Subject: Re: [RFC 6/6] Providing TurboSched as config option
To:     Parth Shah <parth015@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
References: <20190322060621.27021-1-parth015@linux.vnet.ibm.com>
 <20190322060621.27021-7-parth015@linux.vnet.ibm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <84e0894c-b38c-3e14-998f-71b23670baf2@arm.com>
Date:   Wed, 10 Apr 2019 18:39:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190322060621.27021-7-parth015@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/22/19 7:06 AM, Parth Shah wrote:
> Signed-off-by: Parth Shah <parth015@linux.vnet.ibm.com>

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 06e440d3ea2f..2484fa8c49d0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -54,6 +54,7 @@ unsigned int sysctl_sched_rt_period = 1000000;
>   
>   __read_mostly int scheduler_running;
>   
> +#ifdef CONFIG_TURBO_SCHED

This one takes sysctl_sched_rt_runtime away from a non 
CONFIG_TURBO_SCHED build like arm64 defconfig.

...
   MODPOST vmlinux.o
kernel/sysctl.o:(.data+0x14d0): undefined reference to 
`sysctl_sched_rt_runtime'
kernel/sched/core.o: In function `dl_bandwidth_enabled':
/opt/git/kernel_org/kernel/sched/sched.h:282: undefined reference to 
`sysctl_sched_rt_runtime'
...

[...]

--- 8< ---

@@ -54,13 +54,13 @@ unsigned int sysctl_sched_rt_period = 1000000;

  __read_mostly int scheduler_running;

-#ifdef CONFIG_TURBO_SCHED
  /*
   * part of the period that we allow rt tasks to run in us.
   * default: 0.95s
   */
  int sysctl_sched_rt_runtime = 950000;

+#ifdef CONFIG_TURBO_SCHED
