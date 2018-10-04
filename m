From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/4] OPP: Fix more bugs and improve error handling
Date: Thu,  4 Oct 2018 09:46:19 +0530
Message-ID: <cover.1538625101.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, niklas.cassel@linaro.org, d-gerlach@ti.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

Few more bugs have surfaced recently, few of which have been there
forever but came to light only after the recent changes in OPP core.

Dave already sent fix for one of them sometime back and as he isn't
around for a week, I picked up the patch, modified it and posting V2 of
it here.

Niklas already helped testing two of these on Qcom hardware where he
originally faced the issues.

--
Viresh

Dave Gerlach (1):
  PM / OPP: _of_add_opp_table_v2(): increment count only if OPP is added

Viresh Kumar (3):
  OPP: Improve error handling in dev_pm_opp_of_cpumask_add_table()
  OPP: Return error on error from dev_pm_opp_get_opp_count()
  cpufreq: dt: Try freeing static OPPs only if we have added them

 drivers/cpufreq/cpufreq-dt.c | 34 +++++++++++++-----------
 drivers/opp/core.c           |  2 +-
 drivers/opp/of.c             | 51 ++++++++++++++++++++++--------------
 3 files changed, 52 insertions(+), 35 deletions(-)

-- 
2.18.0.rc1.242.g61856ae69a2c
