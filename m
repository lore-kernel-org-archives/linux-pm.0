Return-Path: <SRS0=DIX0=6D=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FD6C54FD2
	for <linux-pm@archiver.kernel.org>; Sun, 19 Apr 2020 17:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F0622240
	for <linux-pm@archiver.kernel.org>; Sun, 19 Apr 2020 17:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587316118;
	bh=YWozikrx1BzPa6MCZo4amvbL5VTaAmBxngKt29TVU64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SGTqhYDVmqdbHe8KZ+50xDRS2Vjo9kejPlKUNmkq0q5R7y+ZP5OVm9eyukSjSiFRJ
	 UsptJVHSmFnAFypvVX0SnN9p4v8t/fhbTv/v4s3GsYfhOKinU7oLLesWga3d3dlDnB
	 GID5F9LiSa5PqwA1vSVDvTy8D2M/lIHGzndnZghY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgDSRIh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:08:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46770 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgDSRIh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id z25so2506431otq.13;
        Sun, 19 Apr 2020 10:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=217EOOrFw1JguCx9/rRQyxEPzTa4GJD9mwcwW7ZPvKs=;
        b=isWEJd9aoVkWfU3+ZVtn9UHhggn9bxnanaijaQbv1U2D9xBzE83qVhaJsmjVvQjh39
         8rdTHlNvJVJ2HkB9Dnj739j+3pUdttY8nOE6x3xKPGYoIhPRy/UJ3lROtegeh0W6a9Gy
         0XSi2G7xxyvNWsYOyH6ZvaK1bE2EA+UIBfhtTY5paNfZ6IRKf6WJtL2vQiZfvgKRMvrZ
         /HmeezGGpr2dO6V8HqrHxp1thGNavCxRHUY/b3siKUjPRkykpEVkYltkSahcM/E2UJ6l
         RYflJyDm+H4JyNcYyvZG8nFlK8zPvHV0/0YFjxs13d/k5sjaHW0LAjd8IJk05ZrU+fti
         /fwA==
X-Gm-Message-State: AGi0PuYt7ouC+N+wgz5qAAmkS/evjMPma1WKOCNKZf0SQFtyUl+Qsa2b
        Vdmo/hcNcjvuvP15i0uDwZIVjGA=
X-Google-Smtp-Source: APiQypLTklldq06zQ7DWUiIK2HKqDOCjCs+VI4+8LpUA7eim5gCSTJk6qg/zaDS+25wQx2aPTMUM0g==
X-Received: by 2002:a05:6830:3104:: with SMTP id b4mr3045929ots.250.1587316115620;
        Sun, 19 Apr 2020 10:08:35 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:35 -0700 (PDT)
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
Subject: [PATCH 17/17] ARM: vexpress: Don't select VEXPRESS_CONFIG
Date:   Sun, 19 Apr 2020 12:08:10 -0500
Message-Id: <20200419170810.5738-18-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CONFIG_VEXPRESS_CONFIG has 'default y if ARCH_VEXPRESS', so selecting is
unnecessary. Selecting it also prevents setting CONFIG_VEXPRESS_CONFIG
to a module.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-vexpress/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 065e12991663..8391a5b3cd78 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -19,7 +19,6 @@ menuconfig ARCH_VEXPRESS
 	select POWER_SUPPLY
 	select REGULATOR if MMC_ARMMMCI
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select VEXPRESS_CONFIG
 	help
 	  This option enables support for systems using Cortex processor based
 	  ARM core and logic (FPGA) tiles on the Versatile Express motherboard,
-- 
2.20.1

