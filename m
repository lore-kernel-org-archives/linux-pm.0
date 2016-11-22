From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management fix for v4.9-rc7
Date: Tue, 22 Nov 2016 15:38:18 +0800
Message-ID: <1479800298.2360.20.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:53530 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751328AbcKVHiV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 02:38:21 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive the latest Thermal Management fix for v4.9-rc7 with
top-most commit ec638db8cb9ddd5ca08b23f2835b6c9c15eb616d:

  thermal/powerclamp: add back module device table (2016-11-21 20:54:40
+0800)

on top of commit b58ec8b5824717875b844a9e8cc62fc6eb5fd289:

  Merge tag 'arm64-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2016-11-07
10:16:23 -0800)

We only have one urgent fix this time.
commit 3105f234e0aba43e44e277c20f9b32ee8add43d4 (thermal/powerclamp:
correct cpu support check), which is shipped in 4.9-rc3, fixes a
problem introduced by
commit b721ca0d192754deccb89fb01c77e41e6fd91ad9 (thermal/powerclamp:
remove cpu whitelist). But unfortunately, it breaks intel_powerclamp
driver module auto-loading at the same time. Thus we need this change
to add back module auto-loading for 4.9.

thanks,
rui

----------------------------------------------------------------
Jacob Pan (1):
      thermal/powerclamp: add back module device table

 drivers/thermal/intel_powerclamp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)
