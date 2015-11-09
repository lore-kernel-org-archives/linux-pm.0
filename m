From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.4-rc1 #4
Date: Mon, 9 Nov 2015 11:54:46 -0800
Message-ID: <20151109195444.GC10824@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36701 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbKITyt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2015 14:54:49 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hello Rui,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus
  
to receive fourth Thermal-SoC Management updates for v4.4-rc1 with top-most

86b48e6aab3c0ed103eed4b0c34c8dcf26ee1fdb:

  thermal: rockchip: fix compile error (2015-11-09 11:40:38 -0800)

on top of commit e35dbb4d4b4499e8a013564f0753dabc1c49e9d9:

  thermal: exynos: Directly return 0 instead of using local ret variable (2015-11-04 11:10:39 -0800)

Specifics:
- Build fix on rockchip driver, as reported by linux-next.


Yes, it is a single patch. But it is a build problem that can be easily
fixed. Fee free to pull or apply directly, whatever it is easier for
you.

BR,

Eduardo Valentin
----------------------------------------------------------------
Caesar Wang (1):
      thermal: rockchip: fix compile error

 drivers/thermal/rockchip_thermal.c | 1 +
 1 file changed, 1 insertion(+)
