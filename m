Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99922C2D0E4
	for <linux-pm@archiver.kernel.org>; Tue, 24 Nov 2020 16:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53DD0206D9
	for <linux-pm@archiver.kernel.org>; Tue, 24 Nov 2020 16:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgKXQ4e (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 24 Nov 2020 11:56:34 -0500
Received: from foss.arm.com ([217.140.110.172]:43486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbgKXQ4e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 24 Nov 2020 11:56:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28D651396;
        Tue, 24 Nov 2020 08:56:33 -0800 (PST)
Received: from bogus (unknown [10.57.54.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 843E93F71F;
        Tue, 24 Nov 2020 08:56:31 -0800 (PST)
Date:   Tue, 24 Nov 2020 16:56:24 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Dietmar.Eggemann@arm.com,
        cristian.marussi@arm.com, morten.rasmussen@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Add power_scale_mw_get()
 interface
Message-ID: <20201124165624.glxnmlxavq4bhppm@bogus>
References: <20201124104346.27167-1-lukasz.luba@arm.com>
 <20201124104346.27167-2-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124104346.27167-2-lukasz.luba@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 24, 2020 at 10:43:45AM +0000, Lukasz Luba wrote:
> Add a new interface to the existing perf_ops and export the information
> about the power values scale.
> 
> This would be used by the cpufreq driver and Energy Model framework to
> set the performance domains scale: milli-Watts or abstract scale.
>

Looks good to me. I saw this after I sent pull request this afternoon.
In case you want to take it via PM tree:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
