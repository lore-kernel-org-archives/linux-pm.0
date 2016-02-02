From: Mason <slash.tmp@free.fr>
Subject: Plain DFS (no voltage scaling)
Date: Tue, 2 Feb 2016 22:11:03 +0100
Message-ID: <56B11B67.3090600@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:29855 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934321AbcBBVLL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Feb 2016 16:11:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hello,

I plan to enable the on-demand governor on the tango platform:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/tango4-smp8758.dtsi

I found the cpufreq-dt binding doc:

https://www.kernel.org/doc/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
https://www.kernel.org/doc/Documentation/devicetree/bindings/opp/opp.txt

Something is not clear to me:

If my platform cannot scale the voltage, what information
should I put in the voltage part of the DT?

Regards.
