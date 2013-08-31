From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 0/3] cpufreq/ondemand support for Xserve G5 & iMac G5 iSight
Date: Sat, 31 Aug 2013 20:23:49 +0300
Message-ID: <1377969832-27699-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:47318 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501Ab3HaR0K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2013 13:26:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Hi,

This is a second version of the patch set sent earlier
(http://marc.info/?t=137461124900005&r=1&w=2) to enable ondemand on
Xserve G5, and also to enable cpufreq on the final iMac G5 (iSight) model.

I changed the second patch to so that it only adds the new latency value
for PowerMac7,2/PowerMac7,3/RackMac3,1.

The only other changes are ACKs from Viresh Kumar to patches 1 & 3.

A.

Aaro Koskinen (3):
  cpufreq: pmac64: speed up frequency switch
  cpufreq: pmac64: provide cpufreq transition latency for older G5
    models
  cpufreq: pmac64: enable cpufreq on iMac G5 (iSight) model

 drivers/cpufreq/pmac64-cpufreq.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
1.8.3.2

