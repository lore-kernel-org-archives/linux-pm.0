From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.14-rc6
Date: Fri, 20 Oct 2017 01:12:36 +0200
Message-ID: <CAJZ5v0j4G7rWQSbWntZMdt4xW-gC+_yNykEH3+B1tdC=2wEv_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:54920 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbdJSXMh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2017 19:12:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.14-rc6

with top-most commit c97cc7dbce2fe6f46e137f4b040f915a0181ee85

 Revert "tools/power turbostat: stop migrating, unless '-m'"

on top of commit 33d930e59a98fa10a0db9f56c7fa2f21a4aef9b9

 Linux 4.14-rc5

to receive a power management fix for v4.14-rc6.

This reverts a problematic commit modifying the turbostat
utility that went in during the 4.13 cycle (Len Brown).

Thanks!


---------------

Len Brown (1):
      Revert "tools/power turbostat: stop migrating, unless '-m'"

---------------

 tools/power/x86/turbostat/turbostat.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)
