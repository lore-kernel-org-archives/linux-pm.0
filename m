From: Nathan Zimmer <nzimmer@sgi.com>
Subject: [PATCH 0/2] cpufreq: cpufreq_driver_lock is hot on large systems
Date: Mon,  4 Feb 2013 16:45:11 -0600
Message-ID: <1360017913-25667-1-git-send-email-nzimmer@sgi.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, Nathan Zimmer <nzimmer@sgi.com>
List-Id: linux-pm@vger.kernel.org

I am noticing the cpufreq_driver_lock is quite hot.
On an idle 512 system perf shows me most of the system time is spent on this
lock.  This is quite signifigant as top shows 5% of time in system time.
My solution was to first convert the lock to a rwlock and then to the rcu.


Nathan Zimmer (2):
  cpufreq: Convert the cpufreq_driver_lock to a rwlock
  cpufreq: Convert the cpufreq_driver_lock to use the rcu

 drivers/cpufreq/cpufreq.c | 139 ++++++++++++++++++++++++++--------------------
 1 file changed, 79 insertions(+), 60 deletions(-)

-- 
1.8.0.1

