From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/2] ACPI: Low power idle constraints check
Date: Tue,  8 Aug 2017 15:41:13 -0700
Message-ID: <1502232075-23832-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-pm@vger.kernel.org, mario.limonciello@dell.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lukas@wunner.de, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

This patchset enables debugging of low power idle. This is done by checking
all the required constraints on wake.

v2
- Changes as suggested by Lukas Wunner.
- Using pm_debug_messages_on attribute to prevent constraints check to
save some cycles on wake.

Srinivas Pandruvada (2):
  PM / sleep: Export the setting of pm_debug_messages_on
  ACPI / Sleep: Check low power idle constraints for debug only

 drivers/acpi/sleep.c    | 162 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/suspend.h |   6 ++
 kernel/power/main.c     |   5 ++
 3 files changed, 173 insertions(+)

-- 
2.7.5
