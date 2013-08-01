From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 0/2] SoC specific trip points and alarm interrupt for imx_thermal
Date: Thu,  1 Aug 2013 18:33:10 +0200
Message-ID: <1375374792-32326-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59805 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab3HAQdc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2013 12:33:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Shawn Guo <shawn.guo@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, kernel@pengutronix.de

Hi,

After trying Siarhei Siamashka's cpuburn[1] on a consumer rated i.MX6Q
without any cooling implements, I feel like the 2 second polling interval
is not fast enough for sudden outbursts of high CPU activity.

Here is a first shot at using the alarm value comparator interrupt to react
to trip points more quickly (in this version hardware triggers measurements
at 10 Hz). For safer testing I've also made the passive trip point user
configurable.

regards
Philipp

[1] http://ssvb.github.io/2012/04/10/cpuburn-arm-cortex-a9.html

