From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpu cpu0: dev_pm_opp_get_max_volt_latency: Invalid regulator (-6)
Date: Wed, 4 May 2016 18:50:41 +0530
Message-ID: <20160504132041.GB2573@vireshk-i7>
References: <5729F3C6.4040302@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34154 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbcEDNUp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 09:20:45 -0400
Received: by mail-pa0-f41.google.com with SMTP id r5so24953181pag.1
        for <linux-pm@vger.kernel.org>; Wed, 04 May 2016 06:20:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5729F3C6.4040302@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Sebastian Frias <sf84@laposte.net>

On 04-05-16, 15:06, Mason wrote:
> Hello,
> 
> I'm using next-20160428
> 
> I've enabled the generic cpufreq-dt driver.
> 
> I'm hitting this dev_err in drivers/base/power/opp/core.c
> 
> 	reg = opp_table->regulator;
> 	if (IS_ERR(reg)) {
> 		/* Regulator may not be required for device */
> 		if (reg)
> 			dev_err(dev, "%s: Invalid regulator (%ld)\n", __func__, PTR_ERR(reg));

This check is always going to pass and looks stupid, yeah I wrote it :)

Sent a separate patch to get it fixed.

-- 
viresh
