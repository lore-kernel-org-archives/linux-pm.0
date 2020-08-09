Return-Path: <SRS0=aUbL=BT=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE97C433E1
	for <linux-pm@archiver.kernel.org>; Sun,  9 Aug 2020 10:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B402B206E9
	for <linux-pm@archiver.kernel.org>; Sun,  9 Aug 2020 10:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHIKLG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 9 Aug 2020 06:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgHIKLG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 9 Aug 2020 06:11:06 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11818206B2;
        Sun,  9 Aug 2020 10:11:02 +0000 (UTC)
Date:   Sun, 9 Aug 2020 11:11:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sumit Gupta <sumitg@nvidia.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, will@kernel.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, mirq-linux@rere.qmqm.pl,
        devicetree@vger.kernel.org, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v6 3/3] cpufreq: Add Tegra194 cpufreq
 driver
Message-ID: <20200809101059.GA22286@gaia>
References: <1594819885-31016-1-git-send-email-sumitg@nvidia.com>
 <1594819885-31016-4-git-send-email-sumitg@nvidia.com>
 <20200809004009.GA96704@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809004009.GA96704@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Aug 08, 2020 at 05:40:09PM -0700, Guenter Roeck wrote:
> On Wed, Jul 15, 2020 at 07:01:25PM +0530, Sumit Gupta wrote:
> > Add support for CPU frequency scaling on Tegra194. The frequency
> > of each core can be adjusted by writing a clock divisor value to
> > a MSR on the core. The range of valid divisors is queried from
> > the BPMP.
> > 
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> 
> If built as module:
> 
> ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!

The exporting of this arm64 symbol went in last night.

-- 
Catalin
