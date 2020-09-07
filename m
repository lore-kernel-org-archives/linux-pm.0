Return-Path: <SRS0=fmUR=CQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAC2C43461
	for <linux-pm@archiver.kernel.org>; Mon,  7 Sep 2020 10:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8156D205CB
	for <linux-pm@archiver.kernel.org>; Mon,  7 Sep 2020 10:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgIGKWV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:22:21 -0400
Received: from foss.arm.com ([217.140.110.172]:59922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728658AbgIGKWF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Sep 2020 06:22:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7337B106F;
        Mon,  7 Sep 2020 03:22:04 -0700 (PDT)
Received: from bogus (unknown [10.57.10.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B29C23F66E;
        Mon,  7 Sep 2020 03:22:02 -0700 (PDT)
Date:   Mon, 7 Sep 2020 11:22:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: arm_scmi: Constify scmi_perf_ops pointers
Message-ID: <20200907102200.GB17330@bogus>
References: <20200906230452.33410-1-rikard.falkeborn@gmail.com>
 <20200906230452.33410-2-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906230452.33410-2-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Mon, Sep 07, 2020 at 01:04:50AM +0200, Rikard Falkeborn wrote:
> The perf_ops are not modified through this pointer. Make them const to
> indicate that. This is in preparation to make the scmi-ops pointers in
> scmi_handle const.
>

Your ack needed to take this as series via {arm-,}soc

-- 
Regards,
Sudeep
