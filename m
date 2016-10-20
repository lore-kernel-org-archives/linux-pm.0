From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management fix for v4.9-rc2
Date: Fri, 21 Oct 2016 00:08:29 +0200
Message-ID: <CAJZ5v0hvQK+Tnb04Npj3KjhNPaXzyFVBgCh8haBi5zHu_mAV4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34130 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753788AbcJTWIb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2016 18:08:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.9-rc2

with top-most commit 350d32395bee1a21deec504a253b336e20d9f35a

 Merge branch 'pm-cpufreq'

on top of commit 1001354ca34179f3db924eb66672442a173147dc

 Linux 4.9-rc1

to receive an urgent power management fix for v4.9-rc2.

This fixes pointer arithmetic mess-up in the cpufreq core introduced
by one of recent commits and leading to all kinds of breakage from
kernel crashes to incorrect governor decisions (Sergey Senozhatsky).

Thanks!

---------------

Sergey Senozhatsky (1):
      cpufreq: fix overflow in cpufreq_table_find_index_dl()

---------------

 include/linux/cpufreq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
