From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/2] cpufreq: cpu0: Improvements for cpu0_set_target()
Date: Sat,  4 Oct 2014 20:26:02 +0000
Message-ID: <1412454365-17804-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:63607 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbaJDU0Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 4 Oct 2014 16:26:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, shawn.guo@freescale.com, Stefan Wahren <stefan.wahren@i2se.com>

This patch series contains 2 improvements for cpu0_set_target().

Stefan Wahren (2):
  cpufreq: cpu0: Improve debug about matching OPP
  cpufreq: cpu0: Handle regulator_get_voltage() failure

 drivers/cpufreq/cpufreq-cpu0.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
1.7.9.5

