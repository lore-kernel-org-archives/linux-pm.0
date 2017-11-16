From: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Subject: [PATCH v3 0/2] Fix improper handling of SCI INT for platforms supporting only IOAPIC mode
Date: Thu, 16 Nov 2017 21:43:43 +0530
Message-ID: <1510848825-21965-1-git-send-email-vikas.cha.sajjan@hpe.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: tglx@linutronix.de, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kkamagui@gmail.com, mingo@kernel.org, Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
List-Id: linux-pm@vger.kernel.org

The platforms which support only IOAPIC mode and whose SCI INT >= 16,
pass SCI INT via FADT and not via MADT int src override structure.
In such cases current logic fails to handle it and throws error
"Invalid bus_irq %u for legacy override". This patch handles the above
mentioned case. While at it, also modify function mp_override_legacy_irq()
to use the newly introduced function mp_register_ioapic_irq().

This series is rebased on 'master' branch of
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

Changes since v2:
Addressed the review comments by Thomas Gleixner <tglx@linutronix.de> to fix the
broken Signed-off-by chain, code clean up and some comments removal.

Changes since v1:
Patch is split into 2, separating actual fix and code cleanup
as suggested by Rafael.


Vikas C Sajjan (2):
  acpi/x86: Fix improper handling of SCI INT for platforms supporting
    only IOAPIC mode
  acpi/x86: Reuse the mp_register_ioapic_irq() in the function
    mp_override_legacy_irq()

 arch/x86/kernel/acpi/boot.c | 61 ++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

-- 
1.9.1

