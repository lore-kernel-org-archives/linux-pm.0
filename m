From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH 0/3] powernv/cpuidle Device-tree parsing cleanup
Date: Tue, 19 Jun 2018 10:34:25 +0530
Message-ID: <1529384668-27548-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Device-tree parsed multiple time in powernv cpuidle and powernv
hotplug code. 

First to identify supported flags, secondly, to identify deepest_state
and first deep state, Thirdly , during cpudidle init to find the available
idle states. Any change in device-tree format will lead to make changes in
these 3 places.

This series adds code to parse device tree once and save in global structure.

Akshay Adiga (3):
  powernv/cpuidle: Parse dt idle properties into global structure
  cpuidle/powernv: Change platform init to avoid reparsing dt
  powernv/cpuidle: Use parsed device tree values for cpuidle_init

 arch/powerpc/include/asm/cpuidle.h    |  16 +++
 arch/powerpc/platforms/powernv/idle.c | 214 +++++++++++++++++++++-------------
 drivers/cpuidle/cpuidle-powernv.c     |  49 +++++---
 3 files changed, 182 insertions(+), 97 deletions(-)

-- 
2.5.5
