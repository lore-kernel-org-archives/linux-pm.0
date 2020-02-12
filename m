Return-Path: <SRS0=mnou=4A=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDF3C2BA83
	for <linux-pm@archiver.kernel.org>; Wed, 12 Feb 2020 11:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EA720675
	for <linux-pm@archiver.kernel.org>; Wed, 12 Feb 2020 11:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgBLLpE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:45:04 -0500
Received: from foss.arm.com ([217.140.110.172]:59914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgBLLpD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Feb 2020 06:45:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C93730E;
        Wed, 12 Feb 2020 03:45:03 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2F583F68F;
        Wed, 12 Feb 2020 03:45:00 -0800 (PST)
Subject: Re: [PATCH v3 2/7] arm64: trap to EL1 accesses to AMU counters from
 EL0
To:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, rjw@rjwysocki.net
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Steve Capper <steve.capper@arm.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
 <20200211184542.29585-3-ionela.voinescu@arm.com>
From:   Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Message-ID: <fe7cc5d0-fd1f-ad36-2e56-bafe94d52ac4@arm.com>
Date:   Wed, 12 Feb 2020 11:44:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200211184542.29585-3-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/02/2020 18:45, Ionela Voinescu wrote:
> The activity monitors extension is an optional extension introduced
> by the ARMv8.4 CPU architecture. In order to access the activity
> monitors counters safely, if desired, the kernel should detect the
> presence of the extension through the feature register, and mediate
> the access.
> 
> Therefore, disable direct accesses to activity monitors counters
> from EL0 (userspace) and trap them to EL1 (kernel).
> 
> To be noted that the ARM64_AMU_EXTN kernel config and the disable_amu
> kernel parameter do not have an effect on this code. Given that the
> amuserenr_el0 resets to an UNKNOWN value, setting the trap of EL0
> accesses to EL1 is always attempted for safety and security
> considerations. Therefore firmware should still ensure accesses to
> AMU registers are not trapped in EL2/EL3 as this code cannot be
> bypassed if the CPU implements the Activity Monitors Unit.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Steve Capper <steve.capper@arm.com>
> ---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
