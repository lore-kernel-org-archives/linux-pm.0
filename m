From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/3] cpufreq: Minor cleanups
Date: Mon, 22 Feb 2016 16:36:41 +0530
Message-ID: <cover.1456139127.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32894 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbcBVLHE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 06:07:04 -0500
Received: by mail-pa0-f52.google.com with SMTP id fl4so89756880pad.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2016 03:07:04 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

Here are a bunch of cleanups for cpufreq-core.

Viresh Kumar (3):
  cpufreq: Relocate handle_update() to kill its declaration
  cpufreq: Rename __cpufreq_governor() to cpufreq_governor()
  cpufreq: Remove 'policy->governor_enabled'

 drivers/cpufreq/cpufreq.c | 80 ++++++++++++++++++-----------------------------
 include/linux/cpufreq.h   |  1 -
 2 files changed, 30 insertions(+), 51 deletions(-)

-- 
2.7.1.410.g6faf27b

