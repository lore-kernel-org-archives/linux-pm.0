From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management updates for v4.8-rc3
Date: Thu, 18 Aug 2016 13:13:44 +0200
Message-ID: <CAJZ5v0hWFcwacHpHfaLWG1v_P8QzgfRwu48YqM0aYi8PJzpi_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33247 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbcHRLNr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Aug 2016 07:13:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.8-rc3

with top-most commit 6c16f42a4e01ef1543fb21e594c2b25d00697649

 Merge branch 'pm-sleep'

on top of commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d

 Linux 4.8-rc2

to receive power management updates for v4.8-rc3.

More hibernation-related material: one fix for a recent regression
in the core, one small cleanup of the x86-64 resume code and a
documentation update.

Specifics:

 - Fix a hibernate core regression resulting from uncovering a
   latent bug in its implementation of memory bitmaps by a recent
   commit (James Morse).

 - Use __pa() to compute a physical address in the x86-64 code
   finalizing resume from hibernation (Rafael Wysocki).

 - Update power management documentation related to system sleep
   states to remove outdated information from it and to add a
   description of a recently introduced hibernation debug feature
   to it (Rafael Wysocki).

Thanks!

---------------

James Morse (1):
      PM / hibernate: Fix rtree_next_node() to avoid walking off list ends

Rafael J. Wysocki (2):
      PM / sleep: Update some system sleep documentation
      x86/power/64: Use __pa() for physical address computation

---------------

 Documentation/power/basic-pm-debugging.txt |  27 +++++-
 Documentation/power/interface.txt          | 151 +++++++++++++++--------------
 arch/x86/power/hibernate_64.c              |   2 +-
 kernel/power/snapshot.c                    |  10 +-
 4 files changed, 108 insertions(+), 82 deletions(-)
