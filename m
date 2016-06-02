From: chris@lapa.com.au
Subject: [PATCH 0/2] max8903: Add device tree support and logic fixup
Date: Thu,  2 Jun 2016 16:44:55 +1000
Message-ID: <1464849897-21527-1-git-send-email-chris@lapa.com.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Chris Lapa <chris@lapa.com.au>
List-Id: linux-pm@vger.kernel.org

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
