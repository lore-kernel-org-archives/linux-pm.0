From: Nathan Zimmer <nzimmer@sgi.com>
Subject: [PATCH v3 0/2] cpufreq: cpufreq_driver_lock is hot on large systems
Date: Wed, 20 Feb 2013 17:56:21 -0600
Message-ID: <1361404583-5557-1-git-send-email-nzimmer@sgi.com>
References: <1360116290-23849-1-git-send-email-nzimmer@sgi.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.179.30]:46753 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751038Ab3BUABu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Feb 2013 19:01:50 -0500
In-Reply-To: <1360116290-23849-1-git-send-email-nzimmer@sgi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nathan Zimmer <nzimmer@sgi.com>

I am noticing the cpufreq_driver_lock is quite hot.
On an idle 512 system perf shows me most of the system time is spent on this
lock.  This is quite significant as top shows 5% of time in system time.
My solution was to first convert the lock to a rwlock and then to the rcu.

v2: Rebase

v3: Read the RCU documentation instead of skimming it.  Also I based on 
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm+acpi-3.9-rc1
I assumed that was what you would prefer Rafael.

Nathan Zimmer (2):
  cpufreq: Convert the cpufreq_driver_lock to a rwlock
  cpufreq: Convert the cpufreq_driver_lock to use the rcu

 drivers/cpufreq/cpufreq.c | 286 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 211 insertions(+), 75 deletions(-)

-- 
1.8.1.2

