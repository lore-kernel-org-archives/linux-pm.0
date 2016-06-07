From: chris@lapa.com.au
Subject: [PATCH 0/2] max8903: Add device tree support and logic fixup
Date: Tue,  7 Jun 2016 14:02:21 +1000
Message-ID: <1465272143-55839-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36227 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbcFGEC3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2016 00:02:29 -0400
Received: by mail-pa0-f68.google.com with SMTP id fg1so13150926pad.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Jun 2016 21:02:29 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org
Cc: Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

This patch set adds device tree support for the MAX8903 battery charger
and also cleans up the logic with the dc_valid, dok and dcm pins.

I verified these patches work on a board I have here, which uses the
DC power side (not the USB portition) of the MAX8903.

Chris Lapa (2):
  max8903: adds support for initiation via device tree.
  max8903: cleans up confusing relationship between dc_valid, dok and
    dcm.

 .../devicetree/bindings/power/max8903-charger.txt  |  28 ++
 drivers/power/max8903_charger.c                    | 287 ++++++++++++++++-----
 include/linux/power/max8903_charger.h              |   6 +-
 3 files changed, 250 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt

-- 
1.9.1

