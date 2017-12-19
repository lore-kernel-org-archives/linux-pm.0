From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] cpufreq: imx6q/thermal: imx: move CPU cooling device
 from thermal to cpufreq
Date: Tue, 19 Dec 2017 11:30:24 +0100
Message-ID: <1513679424.2890.16.camel@pengutronix.de>
References: <20171115092332.9320-1-bst@pengutronix.de>
         <20171116114918.GS25384@dragon> <2436262.8Qovylrth1@aspire.rjw.lan>
         <1513172461.2879.14.camel@nxp.com>
         <7cf13171-fe53-e9f1-12a1-fba428fbc4d4@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58473 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933348AbdLSKaa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Dec 2017 05:30:30 -0500
In-Reply-To: <7cf13171-fe53-e9f1-12a1-fba428fbc4d4@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bastian Stender <bst@pengutronix.de>, Leonard Crestez <leonard.crestez@nxp.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, kernel@pengutronix.de, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>

Am Dienstag, den 19.12.2017, 11:22 +0100 schrieb Bastian Stender:
> Hi Leonard,
> 
> On 12/13/2017 02:41 PM, Leonard Crestez wrote:
> > On Wed, 2017-12-13 at 02:00 +0100, Rafael J. Wysocki wrote:
> > > On Thursday, November 16, 2017 12:49:18 PM CET Shawn Guo wrote:
> > > > 
> > > > On Wed, Nov 15, 2017 at 10:23:32AM +0100, Bastian Stender
> > > > wrote:
> > > > > 
> > > > > The cooling device should be part of the i.MX cpufreq driver.
> > > > > So move
> > > > > it there.
> > > > > 
> > > > > Use of_cpufreq_power_cooling_register to link the cooling
> > > > > device to the
> > > > > device tree node provided.
> > > > > 
> > > > > This makes it possible to bind the cpufreq cooling device to
> > > > > a custom
> > > > > thermal zone via a cooling-maps entry like:
> > > > > 
> > > > > 	cooling-maps {
> > > > > 		map0 {
> > > > > 			trip = <&board_alert>;
> > > > > 			cooling-device = <&cpu0
> > > > > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > > > > 		};
> > > > > 	};
> > > > > 
> > > > > Assuming a cpu node exists with label "cpu0" and #cooling-
> > > > > cells
> > > > > property.
> > > > > 
> > > > > Signed-off-by: Bastian Stender <bst@pengutronix.de>
> > > > I'm fine with the patch, but I would invite Leonard to take a
> > > > look.
> > > Given no response, what should I do?
> > 
> > Sorry for keeping you waiting. I don't much about the "cooling
> > device"
> > infrastructure so I don't have much to add, I guess I assumed a
> > reply
> > wasn't required?
> > 
> > Looking at the code you are removing "thermal_cooling_device
> > *cdev;"
> > from imx_thermal_data but kept "cpufreq_policy *policy". Isn't that
> > unused now?
> 
> Yes, you are right. Will send v2.
> 
> > Also, your code only adds the cooling device if certain devicetree
> > properties are present. Shouldn't your patch come with imx6*.dtsi
> > changes, or make the capacitance value default to zero somehow?
> > Otherwise the effect of the patch on most boards would be to
> > disable
> > cpufreq cooling.
> 
> Good point. I guess the cpu nodes in imx6*.dtsi should get
> cooling-min-level/cooling-min-level/#cooling-cells properties, right?
> This would achieve the old behavior.

Sorry, but this breaks DT stability. Your driver code must work
correctly with older DTs where those properties aren't present.
Changing driver code and dts in lockstep is not an option.

Regards,
Lucas
