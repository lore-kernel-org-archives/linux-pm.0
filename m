From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] cpufreq: imx6q/thermal: imx: move CPU cooling device
 from thermal to cpufreq
Date: Wed, 13 Dec 2017 15:41:01 +0200
Message-ID: <1513172461.2879.14.camel@nxp.com>
References: <20171115092332.9320-1-bst@pengutronix.de>
         <20171116114918.GS25384@dragon> <2436262.8Qovylrth1@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2nam02on0084.outbound.protection.outlook.com ([104.47.38.84]:14937
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753051AbdLMNlI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Dec 2017 08:41:08 -0500
In-Reply-To: <2436262.8Qovylrth1@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bastian Stender <bst@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Shawn Guo <shawnguo@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, kernel@pengutronix.de

On Wed, 2017-12-13 at 02:00 +0100, Rafael J. Wysocki wrote:
> On Thursday, November 16, 2017 12:49:18 PM CET Shawn Guo wrote:
> > 
> > On Wed, Nov 15, 2017 at 10:23:32AM +0100, Bastian Stender wrote:
> > > 
> > > The cooling device should be part of the i.MX cpufreq driver. So move
> > > it there.
> > > 
> > > Use of_cpufreq_power_cooling_register to link the cooling device to the
> > > device tree node provided.
> > > 
> > > This makes it possible to bind the cpufreq cooling device to a custom
> > > thermal zone via a cooling-maps entry like:
> > > 
> > > 	cooling-maps {
> > > 		map0 {
> > > 			trip = <&board_alert>;
> > > 			cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > 		};
> > > 	};
> > > 
> > > Assuming a cpu node exists with label "cpu0" and #cooling-cells
> > > property.
> > > 
> > > Signed-off-by: Bastian Stender <bst@pengutronix.de>

> > I'm fine with the patch, but I would invite Leonard to take a look.

> Given no response, what should I do?

Sorry for keeping you waiting. I don't much about the "cooling device"
infrastructure so I don't have much to add, I guess I assumed a reply
wasn't required?

Looking at the code you are removing "thermal_cooling_device *cdev;"
from imx_thermal_data but kept "cpufreq_policy *policy". Isn't that
unused now?

Also, your code only adds the cooling device if certain devicetree
properties are present. Shouldn't your patch come with imx6*.dtsi
changes, or make the capacitance value default to zero somehow?
Otherwise the effect of the patch on most boards would be to disable
cpufreq cooling.

--
Regards,
Leonard
