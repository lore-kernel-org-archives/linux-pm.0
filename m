Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCE2C4320E
	for <linux-pm@archiver.kernel.org>; Thu, 26 Aug 2021 11:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0523610C9
	for <linux-pm@archiver.kernel.org>; Thu, 26 Aug 2021 11:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbhHZL22 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 26 Aug 2021 07:28:28 -0400
Received: from foss.arm.com ([217.140.110.172]:44606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241887AbhHZL21 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Aug 2021 07:28:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69B081042;
        Thu, 26 Aug 2021 04:27:40 -0700 (PDT)
Received: from bogus (unknown [10.57.18.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B9D93F5A1;
        Thu, 26 Aug 2021 04:27:36 -0700 (PDT)
Date:   Thu, 26 Aug 2021 12:27:27 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 9/9] cpufreq: scmi: Use .register_em() to register
 with energy model
Message-ID: <20210826112727.67iz5lpawk6muo5u@bogus>
References: <cover.1628742634.git.viresh.kumar@linaro.org>
 <8158488baa1ea1aebd09c8d256db7420051d05ac.1628742634.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8158488baa1ea1aebd09c8d256db7420051d05ac.1628742634.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 12, 2021 at 10:05:22AM +0530, Viresh Kumar wrote:
> Set the newly added .register_em() callback to register with the EM
> after the cpufreq policy is properly initialized.
> 

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
