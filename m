From: Mason <slash.tmp@free.fr>
Subject: cpu cpu0: dev_pm_opp_get_max_volt_latency: Invalid regulator (-6)
Date: Wed, 4 May 2016 15:06:14 +0200
Message-ID: <5729F3C6.4040302@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:20858 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbcEDNGd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 May 2016 09:06:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Sebastian Frias <sf84@laposte.net>

Hello,

I'm using next-20160428

I've enabled the generic cpufreq-dt driver.

I'm hitting this dev_err in drivers/base/power/opp/core.c

	reg = opp_table->regulator;
	if (IS_ERR(reg)) {
		/* Regulator may not be required for device */
		if (reg)
			dev_err(dev, "%s: Invalid regulator (%ld)\n", __func__, PTR_ERR(reg));

Apparent call stack:
dev_pm_opp_get_max_volt_latency()
dev_pm_opp_get_max_transition_latency()
cpufreq_init()

Relevant commit
655c9df961751  PM / OPP: Introduce dev_pm_opp_get_max_volt_latency()

My platform's DT

		cpu0: cpu@0 {
			compatible = "arm,cortex-a9";
			next-level-cache = <&l2cc>;
			device_type = "cpu";
			reg = <0>;
			clocks = <&clkgen CPU_CLK>;
			clock-latency = <1>;
			operating-points = <1215000 0 607500 0 405000 0 243000 0 135000 0>;
		};

(My platform does not support voltage scaling.)

Is this error relevant to my platform? (I don't think so.)
Is there a way to mute the error on my platform?

Regards.
