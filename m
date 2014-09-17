From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH RESEND 0/2] Update smb347 charger driver.
Date: Wed, 17 Sep 2014 11:47:22 +0900
Message-ID: <1410922044-4170-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:8817 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbaIQCr3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Sep 2014 22:47:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org, pavel@ucw.cz, Jonghwa Lee <jonghwa3.lee@samsung.com>

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

