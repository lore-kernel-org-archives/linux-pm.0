Return-Path: <SRS0=DIX0=6D=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D5CC54FCB
	for <linux-pm@archiver.kernel.org>; Sun, 19 Apr 2020 17:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A4121473
	for <linux-pm@archiver.kernel.org>; Sun, 19 Apr 2020 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587316110;
	bh=C5VGZ3DiWWPmJZySKJGbExqFh+rjsoFWpTaoqyg6fdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OrBCQLieNBSoDcfeTX3MaFiPIq3Fm7jBMgiVwV1xUSvFnstmxY2H3SvP9gi0cNTxF
	 cfof904iOsDjBqpzt230tpl2qjVw1x8QAknFsNEysVzFI1SFUw1Czv67U7aVF7T5dJ
	 dpe94gtNiI/UM3dgkHB89IRnaM+bbxznG8Gh1BXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgDSRI3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:08:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36705 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgDSRI2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id b13so5968636oti.3;
        Sun, 19 Apr 2020 10:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HpigmDdLGgTxwi4cNTPUYj5dEoa36081Zy4k4zJz1VY=;
        b=tzgMgP0PqnQmZXmPe+hp7yD0Y18xWNPesvnQMHSb83PgEpPyAmPaz30em887uAsUVt
         AtICtiYkFe6AZPhyYlNYB2G2tGvrRDtd6nNx9Lr/dlFQ9ir8POT6vZgN4u1zU0QOen9K
         TWITdWPNAD6CoE5uCE6N6zEOpcVLz2hcRNd6AO2nDsXEJ+9HliZltSqkMyctaV1k+i2l
         b1Dup0HAI/98nGsrFApW+y3MEjzT6WKSoKCXGvhBkHo1cpvBEFPsVHk63GrIfqedMMh0
         DgPPdyCToeBGDIAYI3lGfB+zG+wD7PsQx7ZArR7ufcl3paUfOzEA7hFC/wIMgqomAnoE
         NWxQ==
X-Gm-Message-State: AGi0PuZjnemgMwtJiOZFWcc8R3LmN3gqVPGOaBo8pgEUYrlg9ITlypIc
        kCviW+sC6LYBHqgQmhxWxw==
X-Google-Smtp-Source: APiQypJgZQt1Jy5vrd9fOU0cBVwNlY4pfSaPWLayv3NzXhAUoYJ3R81Cc7lBObtyZw4FxEChoAE4fA==
X-Received: by 2002:a05:6830:1495:: with SMTP id s21mr6391348otq.38.1587316108297;
        Sun, 19 Apr 2020 10:08:28 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:27 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 11/17] mfd: vexpress-sysreg: Use devres API variants
Date:   Sun, 19 Apr 2020 12:08:04 -0500
Message-Id: <20200419170810.5738-12-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the managed devm_gpiochip_add_data() and devm_mfd_add_devices()
instead of their unmanaged counterparts. With this, no .remove() hook is
needed for driver unbind.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/mfd/vexpress-sysreg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 90a4eda2ba2b..9fb37fa689e0 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -140,9 +140,9 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 	bgpio_init(mmc_gpio_chip, &pdev->dev, 0x4, base + SYS_MCI,
 			NULL, NULL, NULL, NULL, 0);
 	mmc_gpio_chip->ngpio = 2;
-	gpiochip_add_data(mmc_gpio_chip, NULL);
+	devm_gpiochip_add_data(&pdev->dev, mmc_gpio_chip, NULL);
 
-	return mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
 			vexpress_sysreg_cells,
 			ARRAY_SIZE(vexpress_sysreg_cells), mem, 0, NULL);
 }
-- 
2.20.1

