Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F1BEB64D7
	for <linux-pm@archiver.kernel.org>; Fri, 16 Jun 2023 13:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjFPNxB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 16 Jun 2023 09:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFPNxA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 09:53:00 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5949B2702
        for <linux-pm@vger.kernel.org>; Fri, 16 Jun 2023 06:52:56 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686923574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nbku+YnB5H9MPK26K0KvbKk71EIPTIq7b5qzzY44c58=;
        b=jfBuzTqcE1ZKPnC3/UebYfv2CEcRJ0HXZvFJBw+b7/935cOM23ELTYkpev1RIOFEwVMTSF
        VqOOI82JUkGLIxKZsFQOZ4yMd1SA3LO2HWChQDx8L/muyA56waqExf8+ctgqqRJkHiAWR/
        Jzptt5XbJ9lVQBm2mbICBSnFI3cdW5EdzE9gOVFZDi2g+Wh+oqvKU8mibC0DaigZVyiKcb
        5TgCIoZBcmE7sTpAP/rFVKvKGcqzNHrCOEzuB1OxHjDZC7pCAyFljokX5mmD4xxEvKdGI6
        nQ8sD7eb/s6P3ExQ8ijtKL/JZQKx971Cw2XkOB8MwZr6FPBsBKRSI5BaCc2g3A==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4279C40009;
        Fri, 16 Jun 2023 13:52:53 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 0/2] Expose reset reason through sysfs
Date:   Fri, 16 Jun 2023 15:52:50 +0200
Message-Id: <20230616135252.2787679-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

Back in 2019, my colleague Kamel did try to upstream a small change in
the at91 reset driver, in order to expose the reset reason through sysfs
instead of expecting userland to grep through dmesg to get it. There was
basically no strong reason opposed to it, besides minor changes which
needed fixing. 4 years ago I am seeing again the need for such exposure,
so here is Kamel's patch with the minor comments addressed, as well as a
small cleanup just before.

Link: https://lore.kernel.org/lkml/00f4e9a2-f6bd-9242-cafd-9c0c4f4dc619@microchip.com/T/

Cheers,
Miquèl

Changes in v3:
* Made the series bisectable.
* Updated the date and kernel version for this new feature.
* Changed a few definitions as discussed with Sebastian.

Changes in v2:
* Collected Nicolas' Acked-by
* Dropped the Xtal frequency information (as this may change between
  platforms of course).

Kamel Bouhara (1):
  power: reset: at91-reset: add sysfs interface to the power on reason

Miquel Raynal (1):
  power: reset: at91-reset: change the power on reason prototype

 .../testing/sysfs-platform-power-on-reason    | 12 +++++
 drivers/power/reset/at91-reset.c              | 44 +++++++++++++------
 include/linux/power/power_on_reason.h         | 19 ++++++++
 3 files changed, 61 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-power-on-reason
 create mode 100644 include/linux/power/power_on_reason.h

-- 
2.34.1

