From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 0/2] cpufreq: do some cleanup
Date: Sat, 16 Feb 2019 10:55:25 -0500
Message-ID: <20190216155527.11839-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

The informations come from the coccinelle tool.

drivers/cpufreq/longhaul.c:854:2-3: Unneeded semicolon
drivers/cpufreq/pcc-cpufreq.c:271:2-3: Unneeded semicolon

Yangtao Li (2):
  cpufreq: pcc-cpufreq: remove unneeded semicolon
  cpufreq: longhaul: remove unneeded semicolon

 drivers/cpufreq/longhaul.c    | 2 +-
 drivers/cpufreq/pcc-cpufreq.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.0
