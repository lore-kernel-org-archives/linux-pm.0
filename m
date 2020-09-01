Return-Path: <SRS0=Ebod=CK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A60C433E6
	for <linux-pm@archiver.kernel.org>; Tue,  1 Sep 2020 13:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C162A206EF
	for <linux-pm@archiver.kernel.org>; Tue,  1 Sep 2020 13:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgIANuZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:50:25 -0400
Received: from foss.arm.com ([217.140.110.172]:41620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgIANaz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Sep 2020 09:30:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 700A31FB;
        Tue,  1 Sep 2020 06:30:37 -0700 (PDT)
Received: from bogus (unknown [10.57.5.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BFAC3F66F;
        Tue,  1 Sep 2020 06:30:34 -0700 (PDT)
Date:   Tue, 1 Sep 2020 14:30:28 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] firmware: psci: Extend psci_set_osi_mode() to
 allow reset to PC mode
Message-ID: <20200901133028.GA27090@bogus>
References: <20200901121226.217568-1-ulf.hansson@linaro.org>
 <20200901121226.217568-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901121226.217568-2-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 01, 2020 at 02:12:25PM +0200, Ulf Hansson wrote:
> The current user (cpuidle-psci) of psci_set_osi_mode() only needs to enable
> the PSCI OSI mode. Although, as subsequent changes shows, there is a need
> to be able to reset back into the PSCI PC mode.
>
> Therefore, let's extend psci_set_osi_mode() to take a bool as in-parameter,
> to let the user indicate whether to enable OSI or to switch back to PC
> mode.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
