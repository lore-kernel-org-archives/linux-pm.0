Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775A7C433EF
	for <linux-pm@archiver.kernel.org>; Fri, 15 Jul 2022 08:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiGOIrb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 15 Jul 2022 04:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiGOIrb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jul 2022 04:47:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFE4E814AE;
        Fri, 15 Jul 2022 01:47:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B74171474;
        Fri, 15 Jul 2022 01:47:30 -0700 (PDT)
Received: from [10.57.11.112] (unknown [10.57.11.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 203983F792;
        Fri, 15 Jul 2022 01:47:28 -0700 (PDT)
Message-ID: <1198724e-d94f-0b7c-9c4a-90595f8426d2@arm.com>
Date:   Fri, 15 Jul 2022 09:47:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] cpufreq: schedutil: Move max CPU capacity to sugov_policy
Content-Language: en-US
To:     rafael@kernel.org
Cc:     viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org
References: <20220711124229.16516-1-lukasz.luba@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220711124229.16516-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

gentle ping.

On 7/11/22 13:42, Lukasz Luba wrote:
> There is no need to keep the max CPU capacity in the per_cpu instance.
> Furthermore, there is no need to check and update that variable
> (sg_cpu->max) everytime in the frequency change request, which is part
> of hot path. Instead use struct sugov_policy to store that information.
> Initialize the max CPU capacity during the setup and start callback.
> We can do that since all CPUs in the same frequency domain have the same
> max capacity (capacity setup and thermal pressure are based on that).
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   kernel/sched/cpufreq_schedutil.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)

The patch got Ack from Viresh.
Could you take it?

Regards,
Lukasz
