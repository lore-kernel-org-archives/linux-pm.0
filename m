From: Nathan Zimmer <nzimmer@sgi.com>
Subject: [PATCH v4 0/2] cpufreq: cpufreq_driver_lock is hot on large systems
Date: Fri, 22 Feb 2013 10:24:33 -0600
Message-ID: <1361550275-5716-1-git-send-email-nzimmer@sgi.com>
References: <51265E0F.6090209@sgi.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51265E0F.6090209@sgi.com>
Sender: cpufreq-owner@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nathan Zimmer <nzimmer@sgi.com>
List-Id: linux-pm@vger.kernel.org

I am noticing the cpufreq_driver_lock is quite hot.
On an idle 512 system perf shows me most of the system time is spent on this
lock.  This is quite significant as top shows 5% of time in system time.
My solution was to first convert the lock to a rwlock and then to the rcu.

v2: Rebase

v3: Read the RCU documentation instead of skimming it.  Also I based on 
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm+acpi-3.9-rc1
I assumed that was what you would prefer Rafael.

v4: Removed an unnecessary syncronize_rcu().


Nathan Zimmer (2):
  cpufreq: Convert the cpufreq_driver_lock to a rwlock
  cpufreq: Convert the cpufreq_driver_lock to use the rcu

 drivers/cpufreq/cpufreq.c | 286 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 211 insertions(+), 75 deletions(-)

-- 
1.8.1.2

