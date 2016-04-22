From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PULL] ARM: cpuidle: changes for 4.7
Date: Fri, 22 Apr 2016 10:30:05 +0200
Message-ID: <5719E10D.5020008@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38380 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbcDVIaJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 04:30:09 -0400
Received: by mail-wm0-f46.google.com with SMTP id u206so14990465wme.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Apr 2016 01:30:08 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: jszhang@marvell.com, lorenzo.pieralisi@arm.com, andy.gross@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Rafael,

please pull the following changes for 4.7.

  * Constify the cpuidle_ops structure and the types returned by the 
functions using it (Jisheng Zhang)

Thanks !

   -- Daniel

The following changes since commit c3b46c73264b03000d1e18b22f5caf63332547c9:

   Linux 4.6-rc4 (2016-04-17 19:13:32 -0700)

are available in the git repository at:

   http://git.linaro.org/people/daniel.lezcano/linux.git cpuidle/4.7

for you to fetch changes up to 5e7c17df795e462c70a43f1b3b670e08efefe8fd:

   drivers: firmware: psci: use const and __initconst for 
psci_cpuidle_ops (2016-04-20 10:44:32 +0200)

----------------------------------------------------------------
Jisheng Zhang (4):
       ARM: cpuidle: add const qualifier to cpuidle_ops member in structures
       ARM: cpuidle: constify return value of arm_cpuidle_get_ops()
       soc: qcom: spm: Use const and __initconst for qcom_cpuidle_ops
       drivers: firmware: psci: use const and __initconst for 
psci_cpuidle_ops

  arch/arm/include/asm/cpuidle.h | 2 +-
  arch/arm/kernel/cpuidle.c      | 6 +++---
  drivers/firmware/psci.c        | 2 +-
  drivers/soc/qcom/spm.c         | 2 +-
  4 files changed, 6 insertions(+), 6 deletions(-)

