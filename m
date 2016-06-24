From: Chris Lapa <chris@lapa.com.au>
Subject: [PATCH v5 0/7] max8903: Add device tree support and misc fixes
Date: Fri, 24 Jun 2016 12:26:05 +1000
Message-ID: <1466735172-13372-1-git-send-email-chris@cpdesign.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33468 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbcFXC0V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 22:26:21 -0400
Received: by mail-pa0-f68.google.com with SMTP id ts6so7771915pac.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 19:26:21 -0700 (PDT)
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
In-Reply-To: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chris Lapa <chris@lapa.com.au>

From: Chris Lapa <chris@lapa.com.au>

This patch set adds device tree support for the MAX8903 battery charger.
It also cleans up logic with dc_valid, dok and dcm pins as well as
fixing up validity checking of gpios.

I verified these patches work on a board I have here, which uses the
DC power side (not the USB portition) of the MAX8903.

Changes v4 -> v5:
 * Changes compatible field from max8903_charger to max8903 in 1/7 and 7/7
 * Improves DT documentation to include direction and state for each gpio

Changes v3 -> v4:
 * Fixed formatting, such as multiline strings and indentation mistakes
 * Moved gpio setup code into max8903_setup_gpios() in 3/7
 * Fixed typo in 5/7
 * Renamed of_node to np in 7/7

Changes v2 -> v3:
 * Separate requesting of gpio's into its own commit
 * Fixed up validity checking of GPIO's
 * Remove dc_valid and usb_valid from device tree
 * Remove some unncessary init to psy_cfg.num_supplicants and psy_cfg.supplied_to
 * Reorder patches so device tree implementation is final patch

Changes v1 -> v2:
 * Separate DT bindings documentation into its own commit
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
  max8903: adds support for initiation via device tree

 .../devicetree/bindings/power/max8903-charger.txt  |  25 +++
 arch/arm/boot/dts/dairytest-servo.dtsi             |  36 ++++
 drivers/power/max8903_charger.c                    | 239 +++++++++++++++------
 include/linux/power/max8903_charger.h              |   6 +-
 4 files changed, 240 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/max8903-charger.txt
 create mode 100644 arch/arm/boot/dts/dairytest-servo.dtsi

-- 
1.9.1

