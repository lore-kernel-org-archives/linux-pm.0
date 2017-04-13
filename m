From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL PATCH 0/7] turbostat fixes
Date: Wed, 12 Apr 2017 20:08:46 -0400
Message-ID: <20170413000853.21648-1-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33598 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755421AbdDMAJ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 20:09:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi Rafael,

Please pull these turbostat patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit e3942ed8c66bcff496abee5182422cd542962d9e:

  tools/power turbostat: version 17.02.24 (2017-03-01 00:14:26 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to 5f9bf02a58f0f62d111994805212d0a775499862:

  tools/power turbostat: update version number (2017-04-12 20:03:50 -0400)

----------------------------------------------------------------
Doug Smythies (1):
      tools/power turbostat: turbostat.8 add missing column definitions

Len Brown (6):
      tools/power turbostat: bugfix: GFXMHz column not changing
      tools/power turbostat: show missing Core and GFX power on SKL and KBL
      tools/power turbostat: enable package THERM_INTERRUPT dump
      tools/power turbostat: update HWP dump to decimal from hex
      tools/power turbostat: fix impossibly large CPU%c1 value
      tools/power turbostat: update version number

 tools/power/x86/turbostat/turbostat.8 |  2 ++
 tools/power/x86/turbostat/turbostat.c | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 13 deletions(-)
