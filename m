From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v2 0/2] cpufreq: stats: clear statistics
Date: Fri,  4 Nov 2016 09:55:34 -0700
Message-ID: <20161104165536.20088-1-code@mmayer.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Markus Mayer <mmayer@broadcom.com>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

This series lets the user clear the CPUfreq stats by writing to a new
sysfs attribute.

Changes since v1:
    - add new cpufreq_freq_attr_wr_perm() macro for write-only
      attributes (because this is a separate commit, this patch has
      turned into a series)
    - remove the Kconfig option, compiling the code unconditionally
    - remove show_reset()
    - cpufreq_stats_clear_table() takes a struct cpufreq_stats * as
      argument rather than a struct cpufreq_policy *

For v1, see https://lkml.org/lkml/2016/11/3/581.

Markus Mayer (2):
  cpufreq: add new attribute type cpufreq_freq_attr_wr_perm()
  cpufreq: stats: clear statistics

 Documentation/cpu-freq/cpufreq-stats.txt |  6 ++++++
 drivers/cpufreq/cpufreq_stats.c          | 22 ++++++++++++++++++++++
 include/linux/cpufreq.h                  |  4 ++++
 3 files changed, 32 insertions(+)

-- 
2.7.4
