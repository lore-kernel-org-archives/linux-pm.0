From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v2 0/4]  max8903: Add device tree support and logic fixup
Date: Fri, 10 Jun 2016 22:32:46 +1000
Message-ID: <1465561970-18377-1-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: k.kozlowski@samsung.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris@lapa.com.au>

This patch set adds device tree support for the MAX8903 battery charger
and also cleans up the logic with the dc_valid, dok and dcm pins.

I verified these patches work on a board I have here, which uses the
DC power side (not the USB portition) of the MAX8903.

Chris Lapa (4):
  max8903: adds documentation for device tree bindings.
  max8903: adds support for initiation via device tree.
  max8903: cleans up confusing relationship between dc_valid, dok and
    dcm.
  max8903: remove unnecessary malloc failed message print out.

 .../devicetree/bindings/power/max8903-charger.txt  |  30 +++
 drivers/power/max8903_charger.c                    | 284 ++++++++++++++++-----
 include/linux/power/max8903_charger.h              |   6 +-
 3 files changed, 248 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt

-- 
1.9.1
