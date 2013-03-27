From: Jacob Shin <jacob.shin@amd.com>
Subject: [PATCH 0/2] cpufreq: ondemand: add AMD specific powersave bias
Date: Wed, 27 Mar 2013 17:37:19 -0500
Message-ID: <1364423841-6920-1-git-send-email-jacob.shin@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Jacob Shin <jacob.shin@amd.com>
List-Id: linux-pm@vger.kernel.org

This patchset adds AMD specific powersave bias function to the ondemand
governor; which can be used to help ondemand governor make more power conscious
frequency change decisions based on feedback from hardware (availble on AMD
Family 16h and above).

Hardware feedback tells software how "sensitive" to frequency changes the
workloads are. CPU-bound workloads will be more sensitive -- they will
perform better as frequency increases. Memory/IO-bound workloads will be less
sensitive -- they will not necessarily perform better as frequnecy increases.

This patchset was compared against ondemand governor without powersave bias
and did not show any performance degradation on CPU-bound workloads such as
kernbench and unixbench. While saving power on Memory-bound workloads such as
stream.

This applies to linux-pm's linux-next branch, on top of Viresh's 'Implement
per policy instance of governor' V4 patchset:

https://lkml.org/lkml/2013/3/27/348

Jacob Shin (2):
  cpufreq: ondemand: allow custom od_ops to be registered
  cpufreq: AMD "frequency sensitivity feedback" powersave bias for
    ondemand governor

 arch/x86/include/uapi/asm/msr-index.h |    1 +
 drivers/cpufreq/Kconfig.x86           |   10 ++++++++++
 drivers/cpufreq/Makefile              |    1 +
 drivers/cpufreq/cpufreq_governor.h    |    2 ++
 drivers/cpufreq/cpufreq_ondemand.c    |   32 +++++++++++++++++++++++++++-----
 5 files changed, 41 insertions(+), 5 deletions(-)

-- 
1.7.9.5


