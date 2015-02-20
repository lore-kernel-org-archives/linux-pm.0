From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management updates for 3.20-rc1 #3
Date: Fri, 20 Feb 2015 22:05:42 +0800
Message-ID: <1424441142.2885.30.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20690 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754367AbbBTOGK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Feb 2015 09:06:10 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Linus,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive an urgent Thermal fix for v3.20 with top-most

4531fa1684bb883ee01f1a182900b1e15d461b34:

  thermal: exynos: fix: Check if data->tmu_read callback is present
before read (2015-02-20 21:57:02 +0800)

on top of commit 3d883483dc0a7261d73d8b1857a7387a1dd99eee:

  Merge branch 'fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
(2015-02-19 17:51:22 -0800)

This only includes one patch which fix a problem that all Exynos SoCs
will break at boot time. 

thanks,
rui

----------------------------------------------------------------
Lukasz Majewski (1):
      thermal: exynos: fix: Check if data->tmu_read callback is present
before read

 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


