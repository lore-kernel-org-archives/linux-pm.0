From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL] turbostat fixes
Date: Sat, 24 Jun 2017 20:12:56 -0700
Message-ID: <1498360381-10293-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35454 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdFYDNI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Jun 2017 23:13:08 -0400
Received: by mail-qk0-f182.google.com with SMTP id 16so59173993qkg.2
        for <linux-pm@vger.kernel.org>; Sat, 24 Jun 2017 20:13:08 -0700 (PDT)
Received: from localhost.localdomain (pool-173-48-65-169.bstnma.fios.verizon.net. [173.48.65.169])
        by smtp.gmail.com with ESMTPSA id o76sm6158770qke.7.2017.06.24.20.13.06
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Jun 2017 20:13:07 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi Rafael,

Please pull these turbostat patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 3c2993b8c6143d8a5793746a54eba8f86f95240f:

  Linux 4.12-rc4 (2017-06-04 16:47:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

for you to fetch changes up to f7d44a8f3fd7f13770470a306a233acbaad5e96d:

  tools/power turbostat: update version number (2017-06-24 20:03:42 -0700)

----------------------------------------------------------------
Len Brown (5):
      tools/power turbostat: hide SKL counters, when not requested
      tools/power turbostat: if  --debug, print sampling overhead
      tools/power turbostat: stop migrating, unless '-m'
      tools/power turbostat: decode MSR_IA32_MISC_ENABLE only on Intel
      tools/power turbostat: update version number

 tools/power/x86/turbostat/turbostat.c | 94 ++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 17 deletions(-)
