From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL] cpuidle patches for Linux-4.10 merge window
Date: Thu, 1 Dec 2016 01:04:24 -0500
Message-ID: <CAJvTdKmYZcK54sNi9o3n8Q13v88HOwk2MgvthY_mCGfJVRJe1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35339 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755502AbcLAGE0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Dec 2016 01:04:26 -0500
Received: by mail-qt0-f175.google.com with SMTP id c47so211139866qtc.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2016 22:04:25 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

Hi Rafael,


Please pull these cpuidle patches.  They are unchanged since the
latest on the linux-pm list.

thanks!
Len Brown, Intel Open Source Technology Center


The following changes since commit 43c4f67c966deb1478dc9acbf66ab547287d530f:

  Merge branch 'akpm' (patches from Andrew) (2016-11-30 16:33:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git cpuidle

for you to fetch changes up to a2c1bc645e87346150516b3abf1933ed29d0f48b:

  x86/intel_idle: Add Knights Mill CPUID (2016-12-01 00:29:07 -0500)

----------------------------------------------------------------

Andy Shevchenko (1):
      x86/intel_idle: Add CPU model 0x4a (Atom Z34xx series)

Piotr Luc (1):
      x86/intel_idle: Add Knights Mill CPUID


 drivers/idle/intel_idle.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++

 1 file changed, 50 insertions(+)
