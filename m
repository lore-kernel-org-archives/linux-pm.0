From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management updates for v4.17-rc3
Date: Fri, 27 Apr 2018 07:25:34 -0700
Message-ID: <20180427142531.GD30803@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

Please consider pulling these fixes on Thermal SoC
management for v4.17-rc3.

This has only a couple of fixes on exynos driver that
were causing emergency shutdown. 

Here is what kernelci has to say about it:
Full Boot Summary: https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v4.17-rc2-106-g5a6de8f70639/
Full Build Summary: https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.17-rc2-106-g5a6de8f70639/

However, keep in mind that the above kernel CI results
are on top of my previous branch, which was based on
latest linus/master.  I have rebased my branch on top of 
v4.17-rc2 specifically so you don't have merging issues. 

BR,


The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

for you to fetch changes up to c8da6cdef57b459ac0fd5d9d348f8460a575ae90:

  thermal: exynos: Propagate error value from tmu_read() (2018-04-27 06:17:30 -0700)

BR,

Eduardo
----------------------------------------------------------------
Marek Szyprowski (2):
      thermal: exynos: Reading temperature makes sense only when TMU is turned on
      thermal: exynos: Propagate error value from tmu_read()

 drivers/thermal/samsung/exynos_tmu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)
