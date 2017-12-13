From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: imx6q/thermal: imx: move CPU cooling device from thermal to cpufreq
Date: Wed, 13 Dec 2017 02:00:05 +0100
Message-ID: <2436262.8Qovylrth1@aspire.rjw.lan>
References: <20171115092332.9320-1-bst@pengutronix.de> <20171116114918.GS25384@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61288 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752944AbdLMBAr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Dec 2017 20:00:47 -0500
In-Reply-To: <20171116114918.GS25384@dragon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Bastian Stender <bst@pengutronix.de>, Leonard Crestez <leonard.crestez@nxp.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, kernel@pengutronix.de

On Thursday, November 16, 2017 12:49:18 PM CET Shawn Guo wrote:
> On Wed, Nov 15, 2017 at 10:23:32AM +0100, Bastian Stender wrote:
> > The cooling device should be part of the i.MX cpufreq driver. So move
> > it there.
> > 
> > Use of_cpufreq_power_cooling_register to link the cooling device to the
> > device tree node provided.
> > 
> > This makes it possible to bind the cpufreq cooling device to a custom
> > thermal zone via a cooling-maps entry like:
> > 
> > 	cooling-maps {
> > 		map0 {
> > 			trip = <&board_alert>;
> > 			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > 		};
> > 	};
> > 
> > Assuming a cpu node exists with label "cpu0" and #cooling-cells
> > property.
> > 
> > Signed-off-by: Bastian Stender <bst@pengutronix.de>
> 
> I'm fine with the patch, but I would invite Leonard to take a look.

Given no response, what should I do?

Thanks,
Rafael
