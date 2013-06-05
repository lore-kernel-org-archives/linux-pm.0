From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH v3 0/3] cpufreq: ondemand: Change the calculation of target
 frequency
Date: Wed, 05 Jun 2013 19:01:05 +0300
Message-ID: <51AF60C1.9050409@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Changes since v2:
	- Reorder patches 2/3 and 3/3
	- Fix typos in patch changelog

Changes since v1:
	- Use policy->cpuinfo.max_freq in the calculation formula
		of target frequency instead of policy->max
	- Split the patch into 3 parts

Stratos Karafotis (3):
  cpufreq: ondemand: Change the calculation of target frequency
  cpufreq: Remove unused APERF/MPERF support
  cpufreq: Remove unused function __cpufreq_driver_getavg

 arch/x86/include/asm/processor.h   | 29 ----------------------
 drivers/cpufreq/Makefile           |  2 +-
 drivers/cpufreq/acpi-cpufreq.c     |  5 ----
 drivers/cpufreq/cpufreq.c          | 12 ---------
 drivers/cpufreq/cpufreq_governor.c | 10 +-------
 drivers/cpufreq/cpufreq_governor.h |  1 -
 drivers/cpufreq/cpufreq_ondemand.c | 39 ++++++-----------------------
 drivers/cpufreq/mperf.c            | 51 --------------------------------------
 drivers/cpufreq/mperf.h            |  9 -------
 include/linux/cpufreq.h            |  6 -----
 10 files changed, 9 insertions(+), 155 deletions(-)
 delete mode 100644 drivers/cpufreq/mperf.c
 delete mode 100644 drivers/cpufreq/mperf.h

-- 
1.8.1.4

