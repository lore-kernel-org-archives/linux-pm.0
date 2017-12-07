From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.15-rc3
Date: Thu, 7 Dec 2017 18:23:44 +0100
Message-ID: <CAJZ5v0h0V28r3CwU4OCDpq9pAePABgjytsFzZ4mrTgeH_GTNyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.15-rc3

with top-most commit 1ecbd7170d6579a1ee389a37bf1f0437ea01a388

 ACPI / CPPC: Fix KASAN global out of bounds warning

on top of commit ae64f9bd1d3621b5e60d7363bc20afb46aede215

 Linux 4.15-rc2

to receive an ACPI fix for 4.15-rc3.

This fixes an out of bounds warning from KASAN in the ACPI
CPPC driver (George Cherian).

Thanks!


---------------

George Cherian (1):
      ACPI / CPPC: Fix KASAN global out of bounds warning

---------------

 drivers/acpi/cppc_acpi.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)
