From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [GIT PULL] Samsung Thermal fixes for v4.0-rc2
Date: Mon, 02 Mar 2015 11:43:47 +0100
Message-ID: <20150302114347.449271df@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:24616 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbCBKnx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2015 05:43:53 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Dear Eduardo,

Please find my first pull request for Samsung Thermal fixes targeting
v4.0-rc2.

Changes:
- Exynos7 power down detection mode fix
- Fix for cpufreq cooling device regression
- Updating MAINTAINER's entry for Samsung Exynos Thermal 



The following changes since commit
5912e264d9eec512598d8faf33440630a3aee989:

  Merge branch 'tmon-fixes' of .git into next (2015-02-28 14:07:03
  +0800)

are available in the git repository at:


  git@github.com:lmajewski/linux-samsung-thermal.git
  github_linux-samusng-thermal/fixes

for you to fetch changes up to 93c537affd5d2a7b2fcea4a1d608b011841d3c04:

  MAINTAINERS: Add entry for SAMSUNG THERMAL DRIVER (2015-03-02
  10:06:09 +0100)

----------------------------------------------------------------
Chanwoo Choi (1):
      thermal: exynos: Fix wrong control of power down detection mode
for Exynos7

Lukasz Majewski (2):
      cpufreq: exynos: Use simple approach to asses if cpu cooling can
be used MAINTAINERS: Add entry for SAMSUNG THERMAL DRIVER

 MAINTAINERS                          |  8 ++++++++
 drivers/cpufreq/exynos-cpufreq.c     | 21 ++++++---------------
 drivers/thermal/samsung/exynos_tmu.c |  3 ++-
 3 files changed, 16 insertions(+), 16 deletions(-)


-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
