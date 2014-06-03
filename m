From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH 0/2] Update smb347 charger driver.
Date: Tue, 03 Jun 2014 10:47:00 +0900
Message-ID: <1401760022-16621-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:61114 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbaFCBrK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jun 2014 21:47:10 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N6K00F3RKYK8ND0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 03 Jun 2014 10:47:08 +0900 (KST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, Jonghwa Lee <jonghwa3.lee@samsung.com>

This patch set updates smb347 driver to support dt-binding and smb358 chip.

Jonghwa Lee (2):
  power: smb347-charger: Support devicetree binding for smb347 driver.
  power: smb347-charger: Support Summit SMB358 charger IC.

 .../bindings/power_supply/smb347_charger.txt       |   58 +++++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/power/smb347-charger.c                     |  242 +++++++++++++-------
 3 files changed, 214 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/smb347_charger.txt

-- 
1.7.9.5

