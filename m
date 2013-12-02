From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V4 0/6] cpufreq: suspend early/resume late: dpm_{suspend|resume}()
Date: Mon,  2 Dec 2013 11:22:30 +0530
Message-ID: <cover.1385962528.git.viresh.kumar@linaro.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jhbird.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patchset moves cpufreq callbacks to dpm_{suspend|resume}() from
dpm_{suspend|resume}_noirq() for handling suspend/resume of cpufreq governors
and core. This is required for early suspend and late resume of governors as
there are drivers which want to change cpu frequency before suspending governors
and they want to do it before devices get suspended, as some of them might be
required to change frequency.

Following patch is already pushed for v3.13 as it was required for fixing some
bugs in there. And the remaining was decided to be pushed for v3.14.

commit 5a87182aa21d6d5d306840feab9321818dd3e2a3
Author: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Date:   Wed Nov 27 09:09:42 2013 +0530

    cpufreq: suspend governors on system suspend/hibernate

This is already tested by few people and so incorporating their Tested-by as
well.

For: v3.14.

Viresh Kumar (6):
  cpufreq: suspend governors from dpm_{suspend|resume}()
  cpufreq: call driver's suspend/resume for each policy
  cpufreq: Implement cpufreq_generic_suspend()
  cpufreq: exynos: Use cpufreq_generic_suspend()
  cpufreq: s5pv210: Use cpufreq_generic_suspend()
  cpufreq: Tegra: Use cpufreq_generic_suspend()

 drivers/base/power/main.c         |   6 +-
 drivers/cpufreq/cpufreq.c         | 137 ++++++++++++++++----------------------
 drivers/cpufreq/exynos-cpufreq.c  |  96 ++------------------------
 drivers/cpufreq/s5pv210-cpufreq.c |  49 +-------------
 drivers/cpufreq/tegra-cpufreq.c   |  46 ++-----------
 include/linux/cpufreq.h           |   3 +
 6 files changed, 79 insertions(+), 258 deletions(-)

-- 
1.7.12.rc2.18.g61b472e
