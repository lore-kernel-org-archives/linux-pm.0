From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI material for v4.6-rc2
Date: Sat, 2 Apr 2016 01:34:49 +0200
Message-ID: <CAJZ5v0h4umU5xBz_fAonmyq=zug9ROYvfg+2RFobyeJnKG7zLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.6-rc2

to receive power management and ACPI material for v4.6-rc2 with top-most
commit 8fbd4ade93dc67f035914cd4030f1c58797d9e59

 Merge branch 'acpi-processor'

on top of commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca

 Linux 4.6-rc1

Just one fix for a nasty boot failure on some systems based on
Intel Skylake that shipped with broken firmware where enabling
hardware-coordinated P-states management (HWP) causes a faulty
interrupt handler in SMM to be invoked and crash the system
(Srinivas Pandruvada).

Thanks!

---------------

Srinivas Pandruvada (1):
      ACPI / processor: Request native thermal interrupt handling via _OSC

---------------

 arch/x86/kernel/cpu/mcheck/therm_throt.c |  3 ++
 drivers/acpi/acpi_processor.c            | 52 ++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c                       |  3 ++
 drivers/acpi/internal.h                  |  6 ++++
 4 files changed, 64 insertions(+)
