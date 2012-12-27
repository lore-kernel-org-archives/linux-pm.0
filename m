From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH v6 0/5] cpufreq: handle SW coordinated CPUs
Date: Thu, 27 Dec 2012 15:55:37 +0100
Message-ID: <1356620142-8680-1-git-send-email-fabio.baltieri@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:51252 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab2L0O4V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Dec 2012 09:56:21 -0500
Received: by mail-wg0-f54.google.com with SMTP id fg15so4514188wgb.9
        for <linux-pm@vger.kernel.org>; Thu, 27 Dec 2012 06:56:19 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Fabio Baltieri <fabio.baltieri@linaro.org>

Hello Rafael,

this is the v6 for the cpufreq SW coordinated CPU bug fix, that I was
holding for -rc1 as agreed.

Differences from v5:
- removed dangling special case in dbs_timer_init
- rebased on top of v3.8-rc1

Would you consider this set for -next?

Thanks,
Fabio


Fabio Baltieri (4):
  cpufreq: star/stop cpufreq timers on cpu hotplug
  cpufreq: ondemand: call dbs_check_cpu only when necessary
  cpufreq: conservative: call dbs_check_cpu only when necessary
  cpufreq: ondemand: use all CPUs in update_sampling_rate

Rickard Andersson (1):
  cpufreq: handle SW coordinated CPUs

 drivers/cpufreq/cpufreq_conservative.c | 46 ++++++++++++++--
 drivers/cpufreq/cpufreq_governor.c     | 98 +++++++++++++++++++++++++++++++---
 drivers/cpufreq/cpufreq_governor.h     |  2 +
 drivers/cpufreq/cpufreq_ondemand.c     | 62 ++++++++++++++++-----
 4 files changed, 185 insertions(+), 23 deletions(-)

-- 
1.7.12.1

