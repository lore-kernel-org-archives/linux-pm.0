From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/3] cpufreq: dt: Minor fixes for 4.3
Date: Wed,  2 Sep 2015 14:36:47 +0530
Message-ID: <cover.1441184706.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35028 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbbIBJG7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2015 05:06:59 -0400
Received: by pacfv12 with SMTP id fv12so5170066pac.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2015 02:06:59 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

These are minor fixes for cpufreq-dt driver.

--
viresh

Viresh Kumar (3):
  cpufreq: dt: Check OPP count before marking them shared
  cpufreq: dt: Print error on failing to mark OPPs as shared
  cpufreq: dt: Tolerance applies on both sides of target voltage

 drivers/cpufreq/cpufreq-dt.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

-- 
2.4.0

