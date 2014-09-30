From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/5]: ACPI / PM: Rework wakeup GPE handling for suspend-to-idle
Date: Tue, 30 Sep 2014 02:20:30 +0200
Message-ID: <1622293.rpSt5UtDk3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Robert Moore <robert.moore@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi,

This series is based on the pm-genirq branch of linux-pm.git which has been
included into linux-next for a few weeks.  That branch reworks the handling
of wakeup interrupts in general so that enable_irq_wake() can be used to
indicate that the given interrupt is to be used to wake up from suspend-to-idle
as well as from the other sleep states.  At the same time, using IRQF_NO_SUSPEND
with wakeup interrupts is not regarded as correct any more.

Along these lines, rework the handling of wakeup GPEs for suspend-to-idle so as
to make use of the new mechanism.

This has been tested on Toshiba Portege R500 with ACPI button wakeup and with
ACPI-based PCI Wake-on-LAN.

[1/5] Export dpm_suspend_late(), dpm_suspend_noirq(), dpm_resume_noirq() and
      dpm_resume_early() from the PM core.
[2/5] Rename local functions in the suspend core to better reflect their purpose.
[3/5] Rework ACPICA's acpi_hw_enable_wakeup_gpe_block() to disable all non-wakeup
      GPEs along with enabling the wakeup ones.
[4/5] Introduce acpi_enable_all_wakeup_gpes() in ACPICA (along the lines of the
      analogous function for runtime GPEs).
[5/5] Modify the handling of wakeup GPEs for suspend-to-idle.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
