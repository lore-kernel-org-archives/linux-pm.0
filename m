From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v3 0/2] powernv/cpuidle Device-tree parsing cleanup
Date: Tue,  3 Jul 2018 14:50:54 +0530
Message-ID: <1530609656-13301-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, stewart@linux.vnet.ibm.com, benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org


Device-tree parsed multiple time in powernv cpuidle and powernv
hotplug code. 

First to identify supported flags. Second time, to identify deepest_state
and first deep state. Third time, during cpuidle init to find the available
idle states. Any change in device-tree format will lead to make changes in
these 3 places. Errors in device-tree can be handled in a better manner.

This series adds code to parse device tree once and save in global structure.

Changes from v2 :
 - Fix build error (moved a hunk from patch 1 to patch 2)
Changes from v1 :
 - fold first 2 patches into 1
 - rename pm_ctrl_reg_* as psscr_*
 - added comment stating removal of pmicr parsing code
 - removed parsing code for pmicr
 - add member valid in pnv_idle_states_t to indicate if the psscr-mask/val
are valid combination,
 - Change function description of pnv_parse_cpuidle_dt
 - Added error handling code.


Akshay Adiga (2):
  powernv/cpuidle: Parse dt idle properties into global structure
  powernv/cpuidle: Use parsed device tree values for cpuidle_init

 arch/powerpc/include/asm/cpuidle.h    |  13 ++
 arch/powerpc/platforms/powernv/idle.c | 216 ++++++++++++++++----------
 drivers/cpuidle/cpuidle-powernv.c     | 154 ++++--------------
 3 files changed, 177 insertions(+), 206 deletions(-)

-- 
2.18.0.rc2.85.g1fb9df7
