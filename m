From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 10/10] cpufreq-dt: Add support for operating-points-v2
 bindings
Date: Wed, 15 Jul 2015 08:29:22 +0530
Message-ID: <20150715025922.GD18084@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <a486d730c2c2dacd387feee13a4c800fdc641077.1434369079.git.viresh.kumar@linaro.org>
 <3095426.xc9msIINgb@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34686 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbbGOC71 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2015 22:59:27 -0400
Received: by pacan13 with SMTP id an13so15702430pac.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2015 19:59:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3095426.xc9msIINgb@amdc1976>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 09-07-15, 18:13, Bartlomiej Zolnierkiewicz wrote:
> I believe that following patches:
> 
> * [PATCH v2 1/7] opp: add dev_pm_opp_get_turbo_mode_setting() helper
>   (http://lkml.org/lkml/2015/7/9/420)
> 
> * [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
>   (http://lkml.org/lkml/2015/7/9/421)
> 
> should be integrated into this patch series before patch #10 (the current
> one) can be applied.

Hi Bartlomiej,

I haven't tried for the complete support yet, I will take care of
boost frequencies as well, but not in this series.

-- 
viresh
