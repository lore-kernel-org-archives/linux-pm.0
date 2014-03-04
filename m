From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [RFC v3 0/5] cpufreq:LAB: Support for LAB governor.
Date: Tue, 04 Mar 2014 11:27:27 +0100
Message-ID: <1393928852-22725-1-git-send-email-l.majewski@samsung.com>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Thomas Abraham <ta.omasab@gmail.com>, thomas.ab@samsung.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Despite this patch set is working and applicable on top of 3.14-rc5, 
please regard it solely as a pure RFC.

This patch provides support for LAB governor build on top of ondemand.
Previous version of LAB can be found here:
http://thread.gmane.org/gmane.linux.kernel/1484746/match=cpufreq

LAB short reminder:

LAB uses information about how many cores are in "idle" state (the core 
idleness is represented as the value between 0 and 100) and the overall 
load of the system (from 0 to 100) to decide about frequency to be set.
It is extremely useful with SoCs like Exynos4412, which can set only one
frequency for all cores.

Important design decisions:

- Reuse well established ondemand governor's internal code. To do this
  I had to expose some previously static internal ondemand code. 
  This allowed smaller LAB code when compared to previous version.
	
- LAB works on top of ondemand, which means that one via device tree
  attributes can specify if and when e.g. BOOST shall be enabled or if 
  any particular frequency shall be imposed. For situation NOT important 
  from the power consumption reduction viewpoint the ondemand is used to 
  set proper frequency.

- It is only possible to either compile in or not the LAB into the kernel. 
  There is no "M" option for Kconfig. It is done on purpose, since ondemand 
  itself can be also compiled as a module and then it would be possible to
  remove ondemand when LAB is working on top of it.

- The LAB operation is specified (and thereof extendable) via device tree
  lab-ctrl-freq attribute defined at /cpus/cpu0.


Problems:
- How the governor will work for big.LITTLE systems (especially Global Task
  Scheduling).
- Will there be agreement to expose internal ondemand code to be reused for
  more specialized governors.

Test HW:
	Exynos4412 - Trats2 board.
Above patches were posted on top of Linux 3.14-rc5
(SHA1: 3f9590c281c66162bf8ae9b7b2d987f0a89043c6)

Lukasz Majewski (5):
  cpufreq:LAB:ondemand Adjust ondemand to be able to reuse its methods
  cpufreq:LAB:cpufreq_governor Adjust cpufreq_governor.[h|c] to support
    LAB
  cpufreq:LAB:lab Add LAB governor code
  cpufreq:LAB:Kconfig Add LAB definitions to Kconfig
  cpufreq:LAB:dts:trats2: Add DTS nodes for LAB governor

 arch/arm/boot/dts/exynos4412-trats2.dts |   29 ++
 drivers/cpufreq/Kconfig                 |   28 ++
 drivers/cpufreq/Makefile                |    1 +
 drivers/cpufreq/cpufreq_governor.c      |    7 +
 drivers/cpufreq/cpufreq_governor.h      |   12 +
 drivers/cpufreq/cpufreq_lab.c           |  457 +++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq_ondemand.c      |   24 +-
 7 files changed, 550 insertions(+), 8 deletions(-)
 create mode 100644 drivers/cpufreq/cpufreq_lab.c

-- 
1.7.10.4

