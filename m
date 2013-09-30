From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2 RESEND 0/3] cpufreq/ondemand support for Xserve G5 & iMac G5 iSight
Date: Mon, 30 Sep 2013 23:44:30 +0300
Message-ID: <1380573873-14448-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:55122 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab3I3UpS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Sep 2013 16:45:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Hi,

This is a resend of the v2 patchset:

	http://marc.info/?t=137797013200001&r=1&w=2

No changes except rebasing. Any chance to get these into v3.13?

Aaro Koskinen (3):
  cpufreq: pmac64: speed up frequency switch
  cpufreq: pmac64: provide cpufreq transition latency for older G5
    models
  cpufreq: pmac64: enable cpufreq on iMac G5 (iSight) model

 drivers/cpufreq/pmac64-cpufreq.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
1.8.4.rc3

