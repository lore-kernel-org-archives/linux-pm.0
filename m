From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 0/2] cpufreq-dt: support for cluster level clock
Date: Tue,  3 Mar 2015 21:03:35 +0800
Message-ID: <1425387817-11382-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:44683 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbCCNDs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2015 08:03:48 -0500
Received: by pdbft15 with SMTP id ft15so25972924pdb.11
        for <linux-pm@vger.kernel.org>; Tue, 03 Mar 2015 05:03:48 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@linaro.org>

Add support for cluster level clock domain for cpufreq-dt driver.

With this support, then cpufreq driver which using cpufreq-dt as
backend can easily apply on multi-clusters system with cluster
level clock domain.

The first patch has been back ported to 3.18 and tested on hikey
board, the second patch is only compiled successfully.

Leo Yan (2):
  cpufreq-dt: support cluster level clock
  ARM: mvebu: update cpufreq-dt's platform data

 arch/arm/mach-mvebu/pmsu.c   |  2 +-
 drivers/cpufreq/Kconfig      |  5 +++--
 drivers/cpufreq/cpufreq-dt.c | 14 +++++++++++++-
 include/linux/cpufreq-dt.h   | 16 ++++++++++++----
 4 files changed, 29 insertions(+), 8 deletions(-)

-- 
1.9.1

