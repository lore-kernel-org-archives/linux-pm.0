From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI updates for v4.12-rc3
Date: Mon, 22 May 2017 21:50:10 +0200
Message-ID: <CAJZ5v0gqGiwK9XDn7HNyxwgyM28xXES+x4GASF9HCk=ZeL4d5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34063 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbdEVTuL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2017 15:50:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.12-rc3

with top-most commit e3170cc04d7ccf0e644ee3e3263e2df7a7685936

 Merge branches 'acpi-button' and 'acpi-tools'

on top of commit 08332893e37af6ae779367e78e444f8f9571511d

 Linux 4.12-rc2

to receive ACPI fixes for v4.12-rc3.

These revert a 4.11 change that turned out to be problematic and
add a .gitignore file.

Specifics:

 - Revert a 4.11 commit related to the ACPI-based handling of laptop
   lids that made changes incompatible with existing user space
   stacks and broke things there (Lv Zheng).

 - Add .gitignore to the ACPI tools directory (Prarit Bhargava).

Thanks!


---------------

Lv Zheng (1):
      Revert "ACPI / button: Remove lid_init_state=method mode"

Prarit Bhargava (1):
      tools/power/acpi: Add .gitignore file

---------------

 Documentation/acpi/acpi-lid.txt | 16 ++++++++++++----
 drivers/acpi/button.c           |  9 +++++++++
 tools/power/acpi/.gitignore     |  4 ++++
 3 files changed, 25 insertions(+), 4 deletions(-)
