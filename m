From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2] Disable the MSR T-state if it is enabled after resumed
Date: Wed,  8 Feb 2017 00:15:55 +0800
Message-ID: <cover.1486483294.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

Disable the MSR T-state if it is enabled after resumed back, because
generally we don't expect the throttling to be enabled after resumed
and should rely on other OS components to adjust the throttling state.

Chen Yu (2):
  ACPI throttling: Disable the MSR T-state if enabled after resumed
  x86/pm: Delete the quirk to save/restore extra MSR around
    suspend/resume

 arch/x86/power/cpu.c                | 38 +++++--------------------------------
 drivers/acpi/processor_throttling.c | 33 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 33 deletions(-)

-- 
2.7.4
