From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL]  Thermal management updates for v4.8-rc6
Date: Thu, 08 Sep 2016 10:46:05 +0800
Message-ID: <1473302765.2307.17.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:33571 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751647AbcIHCqJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Sep 2016 22:46:09 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to receive the latest Thermal Management updates for v4.8-rc6 with
top-most commit 87260d3f7aecba9a5fadc6886c338b2a8fccfca9:

  thermal: rcar_thermal: Fix priv->zone error handling (2016-09-06
20:46:06 +0800)

on top of commit c6935931c1894ff857616ff8549b61236a19148f:

  Linux 4.8-rc5 (2016-09-04 14:31:46 -0700)

Specifics:
We have only one patch this time, which fixes a crash in rcar_thermal
driver. From Dirk Behme.

thanks,
rui

----------------------------------------------------------------
Dirk Behme (1):
      thermal: rcar_thermal: Fix priv->zone error handling

 drivers/thermal/rcar_thermal.c | 1 +
 1 file changed, 1 insertion(+)
