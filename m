From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 198601] New: Conservative governor is broken in 4.14.14
Date: Sun, 28 Jan 2018 10:48:41 +0000
Message-ID: <bug-198601-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:36596 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751637AbeA1Ksm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jan 2018 05:48:42 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 5215128903
        for <linux-pm@vger.kernel.org>; Sun, 28 Jan 2018 10:48:42 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=198601

            Bug ID: 198601
           Summary: Conservative governor is broken in 4.14.14
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.14.14
          Hardware: IA-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: t.artem@mailcity.com
        Regression: No

This is happening under Intel Core i5 2500. I'm running a single instance of
the `flac` utility (which has now been running for 10 minutes already).

Under the ondemand governor:
3986.1MHz
4058.03MHz
3847.3MHz
3929.33MHz

Under the conservative governor:
1700.09MHz
1700.09MHz
1700.15MHz
1700.1MHz

For some reasons the conservative governor refuses to increase CPU cores
frequencies above 1700MHz. I'm _not_ using Intel's pstate driver:

CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_PROCFS_POWER=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=m
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_HED=y
CONFIG_ACPI_BGRT=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_PNPACPI=y
CONFIG_ATA_ACPI=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_UCSI_ACPI=m

-- 
You are receiving this mail because:
You are the assignee for the bug.
