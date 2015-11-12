From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 0/1] last minute thermal build fix for v4.4-rc1
Date: Wed, 11 Nov 2015 19:43:10 -0800
Message-ID: <1447299791-9419-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36521 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbbKLDnU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2015 22:43:20 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hello Linus,

This is build fix on Rockchip driver for v4.4-rc1 that missed the
thermal pull request sent by Rui on Nov 10th.

Please consider picking the patch for fixing the build failure
on v4.4-rc1.

BR,

Eduardo Valentin

Caesar Wang (1):
  thermal: rockchip: fix compile error

 drivers/thermal/rockchip_thermal.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.5.0

