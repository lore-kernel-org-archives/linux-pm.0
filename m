From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [GIT PULL] Samsung Thermal for v4.1 merge window
Date: Thu, 09 Apr 2015 18:09:17 +0200
Message-ID: <20150409180917.4d177432@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Dear Eduardo,

Please find my pull request for Samsung Thermal targeting v4.1 merge
window.

The following changes since commit
96d927aa14deb1c4bf6bfd758776ad942463865d:

  thermal: cpu_cooling: Fix power calculation when CPUs are offline
  (2015-04-07 11:01:22 -0700)

are available in the git repository at:

  git@github.com:lmajewski/linux-samsung-thermal.git next

for you to fetch changes up to 8e256d78739e5f47ed79a9c7fdb7d5346526dd85:

  thermal: exynos: Add the support for Exynos5433 TMU (2015-04-09
  17:34:10 +0200)

----------------------------------------------------------------
Chanwoo Choi (1):
      thermal: exynos: Add the support for Exynos5433 TMU

 drivers/thermal/samsung/exynos_tmu.c | 187
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/thermal/samsung/exynos_tmu.h |   1 + 

2 files changed, 186 insertions(+), 2 deletions(-)


Test HW: Odroid U3.
Build GCC: 4.9.2
SHA1: 8e256d78739e5f47ed79a9c7fdb7d5346526dd85

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
