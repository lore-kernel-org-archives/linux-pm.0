From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v3 0/7] max8903: Add device tree support and misc fixes
Date: Fri, 17 Jun 2016 15:00:19 +1000
Message-ID: <1466139626-51434-1-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>
List-Id: linux-pm@vger.kernel.org

From: Chris Lapa <chris@lapa.com.au>

This patch set adds device tree support for the MAX8903 battery charger.
It also cleans up logic with dc_valid, dok and dcm pins as well as
fixing up validity checking of gpios.

I verified these patches work on a board I have here, which uses the
DC power side (not the USB portition) of the MAX8903.

Changes v2 -> v3:
 * Seperate requesting of gpio's into its own commit
 * Fixed up validity checking of GPIO's
 * Remove dc_valid and usb_valid from device tree
 * Remove some unncessary init to psy_cfg.num_supplicants and psy_cfg.supplied_to
 * Reorder patches so device tree implementation is final patch

Changes v1 -> v2:
 * Seperate DT bindings documentation into its own commit
 * Add maxim prefix to DT compatible field
 * Add gpios suffix to gpio's in DT
 * Remove malloc failed error message

Chris Lapa (7):
  max8903: adds documentation for device tree bindings.
  max8903: store pointer to pdata instead of copying it.
  max8903: cleans up confusing relationship between dc_valid, dok and
    dcm.
  max8903: adds requesting of gpios.
  max8903: removes non zero validity checks on gpios.
  max8903: remove unnecessary 'out of memory' error message.
  max8903: adds support for initiation via device tree.

 .../devicetree/bindings/power/max8903-charger.txt  |  25 ++
 drivers/power/max8903_charger.c                    | 278 +++++++++++++++------
 include/linux/power/max8903_charger.h              |   6 +-
 3 files changed, 227 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt

-- 
1.9.1
