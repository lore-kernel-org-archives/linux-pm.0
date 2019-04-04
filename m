From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v5.1-rc4
Date: Thu, 4 Apr 2019 22:30:24 +0200
Message-ID: <CAJZ5v0g=1Cdme_bigvg9JtxREs=e-kkpRo5-7HUuGEiy1bw0gA@mail.gmail.com>
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
 acpi-5.1-rc4

with top-most commit b59fb7ef5240c301ca8b5b70d4298c0f053bb0c3

 Merge branch 'acpica' into acpi

on top of commit aa9aaa4d61c0048d3faad056893cd7860bbc084c

 ACPI: use different default debug value than ACPICA

to receive an ACPI fix for 5.1-rc4.

This prevents stale GPE events from triggering spurious system
wakeups from suspend-to-idle (Furquan Shaikh).

Thanks!


---------------

Furquan Shaikh (1):
      ACPICA: Clear status of GPEs before enabling them

---------------

 drivers/acpi/acpica/evgpe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
