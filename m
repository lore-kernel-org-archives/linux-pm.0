Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8174C432BE
	for <linux-pm@archiver.kernel.org>; Thu, 26 Aug 2021 11:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A41610A7
	for <linux-pm@archiver.kernel.org>; Thu, 26 Aug 2021 11:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbhHZL3h (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 26 Aug 2021 07:29:37 -0400
Received: from foss.arm.com ([217.140.110.172]:44646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241879AbhHZL3h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 26 Aug 2021 07:29:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29AC01042;
        Thu, 26 Aug 2021 04:28:50 -0700 (PDT)
Received: from bogus (unknown [10.57.18.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71B6F3F5A1;
        Thu, 26 Aug 2021 04:28:46 -0700 (PDT)
Date:   Thu, 26 Aug 2021 12:28:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Quentin Perret <qperret@google.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 8/9] cpufreq: vexpress: Use .register_em() to register
 with energy model
Message-ID: <20210826112837.63tcvpz76esez3hr@bogus>
References: <cover.1628742634.git.viresh.kumar@linaro.org>
 <b64eea485feb5cfb18e74e100dea49c917d4474a.1628742634.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64eea485feb5cfb18e74e100dea49c917d4474a.1628742634.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 12, 2021 at 10:05:21AM +0530, Viresh Kumar wrote:
> Set the newly added .register_em() callback with
> cpufreq_register_em_with_opp() to register with the EM core.
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
