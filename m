From: Nathan Zimmer <nzimmer@sgi.com>
Subject: [PATCH v2 linux-next 0/2] cpufreq: cpufreq_driver_lock is hot on large systems
Date: Tue,  5 Feb 2013 20:04:48 -0600
Message-ID: <1360116290-23849-1-git-send-email-nzimmer@sgi.com>
References: <74F10842A85F514CA8D8C487E74474BB2D2F925E@P-EXMB1-DC21.corp.sgi.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.179.29]:35802 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754258Ab3BFCFX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Feb 2013 21:05:23 -0500
In-Reply-To: <74F10842A85F514CA8D8C487E74474BB2D2F925E@P-EXMB1-DC21.corp.sgi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@sisk.pl
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, Nathan Zimmer <nzimmer@sgi.com>

I am noticing the cpufreq_driver_lock is quite hot.
On an idle 512 system perf shows me most of the system time is spent on this
lock.  This is quite significant as top shows 5% of time in system time.
My solution was to first convert the lock to a rwlock and then to the rcu.

v2: Rebase to linux-next

Nathan Zimmer (2):
  cpufreq: Convert the cpufreq_driver_lock to a rwlock
  cpufreq: Convert the cpufreq_driver_lock to use the rcu

 drivers/cpufreq/cpufreq.c | 150 +++++++++++++++++++++++++---------------------
 1 file changed, 83 insertions(+), 67 deletions(-)

-- 
1.8.0.1

