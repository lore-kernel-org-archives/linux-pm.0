From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI fixes for final v4.5
Date: Fri, 11 Mar 2016 15:23:01 +0100
Message-ID: <CAJZ5v0gwWNqo74ZwPZnjqRxivX7xanno4bSmMKoVOaEJ5m+zSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.5-final

to receive power management and ACPI fixes for final v4.5 with
top-most commit 5b3e7e0536bd6326798ab57d14a49b15ad7e3e3f

 Merge branches 'device-properties-fixes' and 'acpica-fixes'

on top of commit f6cede5b49e822ebc41a099fe41ab4989f64e2cb

 Linux 4.5-rc7

Two more fixes for issues introduced recently, one in the
generic device properties framework and one in ACPICA.

Specifics:

 - Revert a recent ACPICA commit that has been reverted
   upstream, because it caused problems to happen on user
   systems and the problem it attempted to address will not be
   relevant any more after upcoming ACPI specification changes
   (Bob Moore).

 - Fix crash in the generic device properties framework introduced
   by a recent change that forgot to check pointers against error
   values in addition to checking them against NULL (Heikki Krogerus).

Thanks!

---------------

Bob Moore (1):
      ACPICA: Revert "Parser: Fix for SuperName method invocation"

Heikki Krogerus (1):
      device property: fwnode->secondary may contain ERR_PTR(-ENODEV)

---------------

 drivers/acpi/acpica/psargs.c | 9 ++++-----
 drivers/base/property.c      | 8 ++++----
 2 files changed, 8 insertions(+), 9 deletions(-)
