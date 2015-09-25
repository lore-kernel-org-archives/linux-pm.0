From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Voltage setting on chained regulators, how?
Date: Fri, 25 Sep 2015 11:07:24 +0200
Message-ID: <20150925090724.GH7858@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49527 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755487AbbIYJH3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2015 05:07:29 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

On i.MX6 we have the situation that the CPU is supplied by a SoC
internal linear regulator which in turn is supplied by an external
switching regulator:

---> Switching regulator ---> LDO ---> CPU

For energy efficiency reasons we want to minimize the dropout voltage on
the LDO.

Any idea how such a scenario could be implemented? The regulator
framework already has some idea of supply regulators, but it only takes
care of en/disabling the supplies and will not change the voltage on the
supplies. Should this be implemented in the regulator framework?  Some
first experiments brought me into a locking hell quite fast.

Another possibility of course would be to implement this completely in
the cpufreq driver and not bother the regulator framework. Looking at
drivers/cpufreq/imx6q-cpufreq.c the regulator handling code in there is
already complicated enough since in reality it's not one LDO but three
and we would have to add another two regulators to this driver.

For added fun ideally we want to put the LDOs in bypass mode instead of
configuring them for minimum dropout. The bypass mode doesn't work for
the 1.2GHz operating point though since the ripple on the switching
regulator gets too high. So we can't just statically configure bypass
mode but have to enable it dynamically based on the operating points.

Any ideas/input how to proceed?

Thanks
  Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
