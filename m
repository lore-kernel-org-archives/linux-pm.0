From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v5.1-rc8
Date: Wed, 1 May 2019 10:39:19 +0200
Message-ID: <CAJZ5v0i73At_cTv2FJEgSzcqnWUuVnDY-cyX5XWDGFw1f9fnQA@mail.gmail.com>
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
 acpi-5.1-rc8

with top-most commit 2c2a2fb1e2a9256714338875bede6b7cbd4b9542

 Revert "ACPICA: Clear status of GPEs before enabling them"

on top of commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b

 Linux 5.1-rc7

to receive an ACPI fix for 5.1-rc8 (or final 5.1).

This reverts a recent ACPICA change that caused initialization to
fail on systems with Thunderbolt docking stations connected at the
init time.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPICA: Clear status of GPEs before enabling them"

---------------

 drivers/acpi/acpica/evgpe.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)
