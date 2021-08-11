Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EB0C4338F
	for <linux-pm@archiver.kernel.org>; Wed, 11 Aug 2021 02:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25D060EDF
	for <linux-pm@archiver.kernel.org>; Wed, 11 Aug 2021 02:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhHKCmm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 10 Aug 2021 22:42:42 -0400
Received: from foss.arm.com ([217.140.110.172]:40460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232142AbhHKCmm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Aug 2021 22:42:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67A4B6D;
        Tue, 10 Aug 2021 19:42:19 -0700 (PDT)
Received: from bogus (unknown [10.57.12.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF9FA3F40C;
        Tue, 10 Aug 2021 19:42:15 -0700 (PDT)
Date:   Wed, 11 Aug 2021 03:40:47 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Cristian Marussi <cristian.marussi@arm.com>,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] cpufreq: scpi: Use auto-registration for energy model
Message-ID: <20210811024047.4vq2da52dpegaho5@bogus>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
 <7809d747fecbaad46699a178f26288a015055b20.1628579170.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7809d747fecbaad46699a178f26288a015055b20.1628579170.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 10, 2021 at 01:06:54PM +0530, Viresh Kumar wrote:
> Use the CPUFREQ_REGISTER_WITH_EM flag to allow cpufreq core to
> automatically register with the energy model.
> 
> This allows removal of boiler plate code from the driver and fixes the
> unregistration part as well.
> 

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
