From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 10/10] cpufreq-dt: Add support for operating-points-v2
 bindings
Date: Thu, 09 Jul 2015 18:13:54 +0200
Message-ID: <3095426.xc9msIINgb@amdc1976>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <a486d730c2c2dacd387feee13a4c800fdc641077.1434369079.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45553 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbbGIQOH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 12:14:07 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NR802C71AFH64A0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 10 Jul 2015 01:14:05 +0900 (KST)
In-reply-to: <a486d730c2c2dacd387feee13a4c800fdc641077.1434369079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, Sudeep.Holla@arm.com, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com


Hi,

On Monday, June 15, 2015 05:27:36 PM Viresh Kumar wrote:
> Support for parsing operating-points-v2 bindings is in place now, lets
> modify cpufreq-dt driver to use them.

I believe that following patches:

* [PATCH v2 1/7] opp: add dev_pm_opp_get_turbo_mode_setting() helper
  (http://lkml.org/lkml/2015/7/9/420)

* [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
  (http://lkml.org/lkml/2015/7/9/421)

should be integrated into this patch series before patch #10 (the current
one) can be applied.

[ Please see http://lkml.org/lkml/2015/7/9/419 for more details. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

