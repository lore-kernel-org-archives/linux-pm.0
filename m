From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI CPPC fixes for v4.10-rc1
Date: Wed, 14 Dec 2016 15:03:37 +0100
Message-ID: <CAJZ5v0jphnwgtcyr5a58mMBp1N0_8pyUB7WKS5M-WB4evqgwsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Tim Chen <tim.c.chen@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-urgent-4.10-rc1

with top-most commit cc31e9b718dafd8a1bdc593234ddbbf4faa2511c

 Merge branch 'acpi-cppc'

on top of commit a67485d4bf97918225dfb5246e531643755a7ee1

 Merge tag 'acpi-4.10-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive two ACPI CPPC fixes for v4.10-rc1.

One of them fixes a crash in KVM encountered by Sebastian in
linux-next and introduced by a recent intel_pstate change that
caused the driver to use the ACPI CPPC code and uncovered a
missing NULL pointer check in it.

The other one fixes a possible use-after-free in the same code
area.

Thanks!

---------------

Rafael J. Wysocki (1):
      ACPI / CPPC: Fix per-CPU pointer management in acpi_cppc_processor_probe()

Sebastian Andrzej Siewior (1):
      ACPI / CPPC: Fix crash in acpi_cppc_processor_exit()

---------------

 drivers/acpi/cppc_acpi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)
