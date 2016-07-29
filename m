From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.8-rc1
Date: Fri, 29 Jul 2016 22:58:23 +0200
Message-ID: <CAJZ5v0gEmpHAcfW3V8tb33dozPenVsfBXdJhV12H4nMogArZ1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34909 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693AbcG2U6Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jul 2016 16:58:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-urgent-4.8-rc1

with top-most commit e148d0f85cc3e9f2802c7fcf451098c6d19b535b

 Merge branch 'pm-sleep'

on top of commit 6453dbdda30428a3c56568c96fe70ea3612f07e2

 Merge tag 'pm-4.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive an urgent stable-candidate power management fix for v4.8-rc1.

Fix a nasty (and really hard to debug) memory corruption during
resume from hibernation on x86-64 (that leads to a kernel panic
most of the time) due to the use of a stale stack pointer value
in FRAME_BEGIN (Josh Poimboeuf).

Thanks!

---------------

Josh Poimboeuf (1):
      x86/power/64: Fix hibernation return address corruption

---------------

 arch/x86/power/hibernate_asm_64.S | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
