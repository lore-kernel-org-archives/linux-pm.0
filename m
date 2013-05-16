From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/3] CPUFreq Fixes for 3.10-rc2
Date: Thu, 16 May 2013 10:39:55 +0530
Message-ID: <cover.1368679353.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Here are few more fixes for 3.10-rc2.

Viresh Kumar (3):
  cpufreq: Add EXPORT_SYMBOL_GPL for have_governor_per_policy
  cpufreq: governors: Move get_governor_parent_kobj() to cpufreq.c
  cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT

 drivers/cpufreq/cpufreq.c          | 19 +++++++++++++++++--
 drivers/cpufreq/cpufreq_governor.c |  8 --------
 include/linux/cpufreq.h            |  1 +
 3 files changed, 18 insertions(+), 10 deletions(-)

-- 
1.7.12.rc2.18.g61b472e

