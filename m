Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90879C4338F
	for <linux-pm@archiver.kernel.org>; Tue,  3 Aug 2021 22:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7BB61037
	for <linux-pm@archiver.kernel.org>; Tue,  3 Aug 2021 22:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhHCWnC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:43:02 -0400
Received: from foss.arm.com ([217.140.110.172]:54866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhHCWnB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Aug 2021 18:43:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0552911FB;
        Tue,  3 Aug 2021 15:42:50 -0700 (PDT)
Received: from bogus (unknown [10.57.37.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25AE53F66F;
        Tue,  3 Aug 2021 15:42:47 -0700 (PDT)
Date:   Tue, 3 Aug 2021 23:41:45 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, cristian.marussi@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        nicola.mazzucato@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: arm_scmi: Fix error path when allocation
 failed
Message-ID: <20210803224145.zyr36sliwa7a67xf@bogus>
References: <20210803090744.12143-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803090744.12143-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 03, 2021 at 10:07:44AM +0100, Lukasz Luba wrote:
> Stop the initialization when cpumask allocation failed and return an
> error.
>

Good catch!

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
