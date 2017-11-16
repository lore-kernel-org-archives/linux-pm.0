From: Vikas C Sajjan <vikas.cha.sajjan@hpe.com>
Subject: [PATCH v2 0/2] Fix improper handling of SCI INT for platforms supporting only IOAPIC mode
Date: Thu, 16 Nov 2017 14:59:53 +0530
Message-ID: <1510824595-12287-1-git-send-email-vikas.cha.sajjan@hpe.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:33600 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdKPJ4H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Nov 2017 04:56:07 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, rjw@rjwysocki.net, rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kkamagui@gmail.com, mingo@kernel.org, Vikas C Sajjan <vikas.cha.sajjan@hpe.com>

The platforms which support only IOAPIC mode and whose SCI INT is
greater than 16, passes SCI INT via FADT and not via MADT int src override
structure. In such cases current logic fails to handle it and throws error
"Invalid bus_irq %u for legacy override". This patch handles the above
 mentioned case. While at it, also modify function mp_override_legacy_irq()
to use the newly introduced function mp_register_ioapic_irq().

This series is rebased on 'master' branch of
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

Changes since v1:
Patch is split into 2, separating actual fix and code cleanup
as suggested by Rafael.

Vikas C Sajjan (2):
  acpi/x86: Fix improper handling of SCI INT for platforms supporting
    only IOAPIC mode
  acpi/x86: Reuse the mp_register_ioapic_irq() in the function
    mp_override_legacy_irq()

 arch/x86/kernel/acpi/boot.c | 64 +++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 23 deletions(-)

-- 
1.9.1
