From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 0/2] Hibernate runtime-resume fixes
Date: Wed, 23 Mar 2016 00:11:20 +0100
Message-ID: <cover.1458641423.git.lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

I stumbled across these two issues while implementing runtime pm for
Thunderbolt. Unfortunately hibernate is not working on my machine
(no swap partition) so I could not test the patches beyond verifying
that they compile. I merely had the impression that this is wrong
when reading the code. Somebody please double-check if the patches
are legitimate. If they are not then I apologize for the noise.

Best regards,

Lukas


Lukas Wunner (2):
  PM / sleep: Clear pm_suspend_global_flags upon hibernate
  ACPI / PM: Runtime resume devices when waking from hibernate

 drivers/acpi/sleep.c     | 1 +
 kernel/power/hibernate.c | 1 +
 2 files changed, 2 insertions(+)

-- 
1.8.5.2 (Apple Git-48)

