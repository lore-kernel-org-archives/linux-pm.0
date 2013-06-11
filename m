From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 0/3] cpufreq:boost: CPU Boost mode support
Date: Tue, 11 Jun 2013 11:03:25 +0200
Message-ID: <1370941408-29304-1-git-send-email-l.majewski@samsung.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16894 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab3FKJEV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jun 2013 05:04:21 -0400
In-reply-to: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>

This patch series introduces support for CPU overclocking technique
called Boost.

It is a follow up of a LAB governor proposal. Boost is a LAB component:
http://thread.gmane.org/gmane.linux.kernel/1484746/match=cpufreq

Boost unifies hardware based solution (e.g. Intel Nehalem) with
software oriented one (like the one done at Exynos).
For this reason cpufreq/freq_table code has been reorganized to include
common code.

Important design decisions:

- Boost related code is compiled-in unconditionally and disabled by default
The cpufreq_driver is responsibile for providing low_level_boost callback

- struct cpufreq_driver has been extended with boost related fields

- Boost sysfs attributies are seen only when cpufreq driver supports them.
They will not show up until either cpufreq_driver defines low_level_boost 
callback or device tree's cpufreq "boost_mode" attribute is defined.

- No special spin_lock for Boost was created. The one from cpufreq_driver
was reused.

- Low level boost trigger function (*low_level_boost function callback) is
necessary to "glue" together acpi-cpufreq boost with software based one.



Tested at: HW: 
	Exynos 4412 3.10 linux 
	Exynos 4210 3.10 linux
Compile tested x86_64 defconfig (acpi) - help with HW (Intel Nehalem) test
 needed


Two patches were abandoned (comparing to v1):
[PATCH 1/5] cpufreq: Define cpufreq_set_drv_attr_files() to add per CPU sysfs attributes
[PATCH 5/5] cpufreq:boost:Kconfig: Enable boost support at Kconfig

For detailed changelog please look into relevant patches

Lukasz Majewski (3):
  cpufreq:boost: CPU frequency boost code unification for software and
    hardware solutions
  cpufreq:acpi:x86: Adjust the acpi-cpufreq.c code to work with common
    boost solution
  cpufreq:exynos:Extend Exynos cpufreq driver to support boost
    framework

 drivers/cpufreq/acpi-cpufreq.c   |   72 ++++++++++++++------------------------
 drivers/cpufreq/cpufreq.c        |   69 ++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/exynos-cpufreq.c |   49 ++++++++++++++++++++++++--
 drivers/cpufreq/freq_table.c     |   57 ++++++++++++++++++++++++++++--
 include/linux/cpufreq.h          |   12 +++++++
 5 files changed, 209 insertions(+), 50 deletions(-)

-- 
1.7.10.4

