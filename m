From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management and ACPI fixes for 4.0-rc
Date: Fri, 13 Mar 2015 22:18:47 +0100
Message-ID: <CAJZ5v0gTC9yu_b=DVr8vaDwnhEfjy-p4MY8w9KrQGG41sNVqHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34076 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbbCMVSt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 17:18:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.0-rc4

to receive power management and ACPI fixes for v4.0-rc4 with top-most
commit b176023392360f28c0c8964a10effbc9a1f36c04

 Merge branch 'pm-tools'

on top of commit 9eccca0843205f87c00404b663188b88eb248051

 Linux 4.0-rc3

Just two fixes, one for an ACPI LPSS driver issue introduced during
the 3.17 cycle and one revert of a recent commit that sort of broke
the cpupower tool.

Specifics:

 - Fix an ACPI LPSS (Low-Power Subsystem) driver issue causing the
   8250_dw driver to confuse an LPSS clock with another one it is
   supposed to handle due to the lack of identification allowing it
   to tell those clocks apart (Heikki Krogerus).

 - Revert a recent commit that was supposed to improve the usability
   of the cpupower tool, but clearly did the opposite (Josh Boyer).

Thanks!


---------------

Heikki Krogerus (1):
      ACPI / LPSS: provide con_id for the clkdev

Josh Boyer (1):
      Revert "cpupower Makefile change to help run the tool without
'make install'"

---------------

 drivers/acpi/acpi_lpss.c      | 5 ++++-
 tools/power/cpupower/Makefile | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)
