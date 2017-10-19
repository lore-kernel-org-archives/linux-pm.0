From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 0/2] cpufreq: arm_big_little: make function arguments and structures const
Date: Thu, 19 Oct 2017 12:59:13 +0200
Message-ID: <1508410755-13666-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-pm@vger.kernel.org

Make some function arguments as const. After this change make the 
cpufreq_arm_bL_ops structures const.

Bhumika Goyal (2):
  cpufreq: arm_big_little: make function argument and structure const
  cpufreq: arm_big_little: make cpufreq_arm_bL_ops structures const

 drivers/cpufreq/arm_big_little.c       | 6 +++---
 drivers/cpufreq/arm_big_little.h       | 4 ++--
 drivers/cpufreq/arm_big_little_dt.c    | 2 +-
 drivers/cpufreq/scpi-cpufreq.c         | 2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

-- 
1.9.1
