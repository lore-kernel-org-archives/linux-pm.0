From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management updates for v4.2-rc6
Date: Sat, 08 Aug 2015 15:07:40 +0800
Message-ID: <1439017660.14585.13.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59822 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165AbbHHHHr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 8 Aug 2015 03:07:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive the latest Thermal Management updates for 4.2-rc6 with
top-most commit 8bf93f2476cede84e6d7e7de5da9a55aeb196f9e:

  Merge branch 'fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
into for-rc

on top of commit 74d33293e467df61de1b1d8b2fbe29e550dec33b:

  Linux 4.2-rc5

Specifics:

- Fix an error that "weight_attr" sysfs attribute is not removed while
unbinding. From: Viresh Kumar.
- Fix power allocator governor tracing to return the real request. From
Javi Merino.
- Remove redundant owner assignment of hisi platform thermal driver.
>From Krzysztof Kozlowski.
- A couple of small fixes of Exynos thermal driver. From Krzysztof
Kozlowski and Chanwoo Choi.

thanks,
rui
----------------------------------------------------------------

Chanwoo Choi (2):
      thermal: exynos: Add the dependency of CONFIG_THERMAL_OF instead
of CONFIG_OF
      thermal: exynos: Remove unused code related to platform_data on
probe()

Javi Merino (1):
      thermal: power_allocator: trace the real requested power

Krzysztof Kozlowski (2):
      thermal: exynos: Disable the regulator on probe failure
      thermal: Drop owner assignment from platform_driver

Viresh Kumar (1):
      thermal: remove dangling 'weight_attr' device file

Zhang Rui (1):
      Merge branch 'fixes' of
git://git.kernel.org/.../evalenti/linux-soc-thermal into for-rc

 drivers/thermal/hisi_thermal.c       |  1 -
 drivers/thermal/power_allocator.c    | 26 ++++++++++++++++----------
 drivers/thermal/samsung/Kconfig      |  2 +-
 drivers/thermal/samsung/exynos_tmu.c |  5 ++---
 drivers/thermal/thermal_core.c       |  1 +
 5 files changed, 20 insertions(+), 15 deletions(-)






