From: Paul Bolle <pebolle@tiscali.nl>
Subject: PM / OPP: ARCH_HAS_OPP
Date: Mon, 28 Jul 2014 14:47:12 +0200
Message-ID: <1406551632.5397.17.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:52651 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752328AbaG1MrO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Jul 2014 08:47:14 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Simon Horman <horms+renesas@verge.net.au>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

Mark,

Your commit 78c5e0bb145d ("PM / OPP: Remove ARCH_HAS_OPP") landed in
today's linux-next (ie, next-20140728). It removes the Kconfig symbol
ARCH_HAS_OPP and ten select statements for that symbol.

After that commit there are still nine select statements for that symbol
left in linux-next. (These select statements are now actually NOPs.) The
peculiar thing is that these nine statements are all found in Kconfig
files also touched by that commit.

Anyhow, are patches to remove these pointless select statements queued
somewhere?


Paul Bolle

