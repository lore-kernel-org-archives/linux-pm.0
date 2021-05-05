Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0010C433B4
	for <linux-pm@archiver.kernel.org>; Wed,  5 May 2021 11:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7BC6112F
	for <linux-pm@archiver.kernel.org>; Wed,  5 May 2021 11:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhEELpH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 5 May 2021 07:45:07 -0400
Received: from foss.arm.com ([217.140.110.172]:43060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhEELpH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 May 2021 07:45:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06D1F31B;
        Wed,  5 May 2021 04:44:11 -0700 (PDT)
Received: from bogus (unknown [10.57.61.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C77A3F70D;
        Wed,  5 May 2021 04:44:09 -0700 (PDT)
Date:   Wed, 5 May 2021 12:44:06 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        Sudeep Holla <sudeep.holla@arm.com>, swboyd@chromium.org,
        agross@kernel.org, robh+dt@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7280: Add cpu OPP tables
Message-ID: <20210505114406.dawq5xvhnc6ifetb@bogus>
References: <1619792901-32701-1-git-send-email-sibis@codeaurora.org>
 <1619792901-32701-3-git-send-email-sibis@codeaurora.org>
 <20210504144215.svmrmmsy4jtoixzv@bogus>
 <1fc9fb8d9a94909ff9b7b76d598bd266@codeaurora.org>
 <20210505084908.3lynedmblmqagr72@bogus>
 <20210505113724.fpzcizgytf55msfa@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505113724.fpzcizgytf55msfa@vireshk-i7>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 05, 2021 at 05:07:24PM +0530, Viresh Kumar wrote:
> On 05-05-21, 09:49, Sudeep Holla wrote:
> > No my main concern is this platform uses "qcom-cpufreq-hw" driver and the
> > fact that the OPPs are retrieved from the hardware lookup table invalidates
> > whatever we have in DT.
>
> Not exactly.
>
> It disables them all, and then call dev_pm_opp_adjust_voltage() and
> enable them again. This is how it started initially. Though the driver
> also works if the DT doesn't have the table, in that case it calls
> dev_pm_opp_add() for all the OPPs.
>

Ah OK, if it is handled in the driver, I will shut up then 😄. I did a
quick look at it but couldn't understand the connection, so I started
and continued the discussion. Thanks for the confirmation. I am fine if
it is handled.

--
Regards,
Sudeep
