From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 0/2] cpufreq: cpufreq-dt: Improvements for set_target()
Date: Fri, 17 Oct 2014 22:09:47 +0000
Message-ID: <1413583789-24294-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:64146 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbaJQWJ4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Oct 2014 18:09:56 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org

This patch series contains 2 improvements for set_target().

changes in V2:
  - rebase because of name change cpufreq-cpu0 to cpufreq-dt

Stefan Wahren (2):
  cpufreq: cpufreq-dt: Improve debug about matching OPP
  cpufreq: cpufreq-dt: Handle regulator_get_voltage() failure

 drivers/cpufreq/cpufreq-dt.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
1.7.9.5

