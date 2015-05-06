From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH RFC 0/5] ACPI / core : few cleanups and updates for LPI
Date: Wed,  6 May 2015 15:31:25 +0100
Message-ID: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47696 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbbEFObo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 May 2015 10:31:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <ahs3@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Hi Rafael,

I am working on adding Low Power Idle(LPI) states support that was
recently added in ACPI 6.0. Before introducing the LPI support, here
are few updates and cleanups/reorganisation so that LPI support can be
added to processor_idle module to co-exist with C-state. Few of these
changes also help in enabling ACPI_PROCESSOR on ARM64 which is currently
disabled and few others are just to be consistent.

Regards,
Sudeep


Sudeep Holla (5):
  ACPI / containers : add support for ACPI0010 processor container
  ACPI / processor: always compile perflib if CONFIG_ACPI_PROCESSOR
  ACPI / sleep: move acpi_processor_sleep to sleep.c
  ACPI / processor_idle: replace PREFIX with pr_fmt
  ACPI / processor_idle : introduce ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE

 Documentation/memory-hotplug.txt |   2 +-
 arch/ia64/Kconfig                |   1 +
 arch/x86/Kconfig                 |   1 +
 arch/x86/include/asm/acpi.h      |   2 -
 drivers/acpi/Kconfig             |   3 +
 drivers/acpi/Makefile            |   2 +-
 drivers/acpi/container.c         |   1 +
 drivers/acpi/processor_idle.c    | 119 +++++++++++++++++----------------------
 drivers/acpi/sleep.c             |  37 ++++++++++++
 include/acpi/processor.h         |  33 +----------
 include/linux/cpufreq.h          |   4 ++
 11 files changed, 104 insertions(+), 101 deletions(-)

-- 
1.9.1

