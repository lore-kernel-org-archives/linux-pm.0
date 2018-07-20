From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI fix for v4.18-rc6
Date: Fri, 20 Jul 2018 10:01:51 +0200
Message-ID: <CAJZ5v0hBVRAQCbD33RYRCBL-Qmx2OW1x4tqiLo5C_r5Qjvbp5A@mail.gmail.com>
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
 acpi-4.18-rc6

with top-most commit 2c4d6baf1bc4f7729773ffcee9ba2a9781578633

 ACPI / EC: Use ec_no_wakeup on more Thinkpad X1 Carbon 6th systems

on top of commit 9d3cce1e8b8561fed5f383d22a4d6949db4eadbe

 Linux 4.18-rc5

to receive an ACPI fix for 4.18-rc6.

This extends the recently added suspend-to-idle quirk for Thinkpad
X1 Carbon 6th to other systems from that family which turned out to
need it too (Robin Johnson).

Thanks!


---------------

Robin H. Johnson (1):
      ACPI / EC: Use ec_no_wakeup on more Thinkpad X1 Carbon 6th systems

---------------

 drivers/acpi/ec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
