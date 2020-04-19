Return-Path: <SRS0=DIX0=6D=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D72C54F70
	for <linux-pm@archiver.kernel.org>; Sun, 19 Apr 2020 17:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53FFE21473
	for <linux-pm@archiver.kernel.org>; Sun, 19 Apr 2020 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587316104;
	bh=4dnweJR8iw+6MbqqYBMnNeW21tUFXwNVPyYkqIo4SVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i5/VPVZNL/zl++1u5JIYW2Dp/64gxtMUX8uHzcjPVGOfNJ5TzFuL4YiDdFjJdHe1Y
	 VzDxDIU4LUEfuXc+fCiUYW8qCxWg4tVcLANl5TuXqlLvTts7DTsPhsgP6LUDJhoplH
	 iJjz0WqHnDxCGXU9ku+LoFAgt7NJJyaEyIL+W2kU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgDSRIX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:08:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46748 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDSRIX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Apr 2020 13:08:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id z25so2505952otq.13;
        Sun, 19 Apr 2020 10:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qrg4Kn0uV5CkM2HSImaTMyKeQJqbbeo+iRjf1bdrad0=;
        b=aMYNuyAtOhT98a2aadT7jwrwzNWnHTBT00eL2Jb6oFCB8Csp68mzynuq+Upxi00Z09
         bDezMVfmbaxll2g9UmgjIlvKVjXQ9S5sx9lZIp9EyGKcd7k5ffaUFx6oqiXw9hE3D/Il
         tmmKv+gmAg8W2tUAtgPR3Hdof/i5J/ng4lqSadMkXMbASLjyFwMH9F0iWgtrhQi7aTu+
         /5IM5knLBBI/UzKcrDU/0oSEtcOZTJjgR7iKCMl2F6t67FQEPlvPnI96Ddt+HQTK/Hsd
         Rajdt3huZGSLCz/Wd+CdIR/XZ3pqsoINqoZ7E2uDwAgKxszSb7McslXsWKnjsEkkZOQn
         H5ug==
X-Gm-Message-State: AGi0PubCB2QTF5tZpACiuGEEvE5NlweCrtV4xkjZ3m7VJv6nIsd+loP0
        +gp4fwTUicHjzEcFzcgHzg==
X-Google-Smtp-Source: APiQypLaYTQQiTq4lbmbzauI24B6HAlyxCl7rv3Xs7I3W7EGTvoW/11+mJIDtPy2Q91CLPeIch7vLA==
X-Received: by 2002:a9d:6303:: with SMTP id q3mr6861606otk.296.1587316101203;
        Sun, 19 Apr 2020 10:08:21 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u205sm9661938oia.37.2020.04.19.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 10:08:20 -0700 (PDT)
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
Subject: [PATCH 06/17] clk: versatile: Only enable SP810 on 32-bit by default
Date:   Sun, 19 Apr 2020 12:07:59 -0500
Message-Id: <20200419170810.5738-7-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419170810.5738-1-robh@kernel.org>
References: <20200419170810.5738-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While 64-bit Arm reference platforms have SP810 for clocks for SP804
timers, they are not needed since the arch timers are used instead.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/versatile/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index 3465fb291998..5bdd5c98990b 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -9,7 +9,7 @@ config ICST
 
 config CLK_SP810
 	bool "Clock driver for ARM SP810 System Controller"
-	default y if ARCH_VEXPRESS
+	default y if (ARCH_VEXPRESS && ARM)
 	---help---
 	  Supports clock muxing (REFCLK/TIMCLK to TIMERCLKEN0-3) capabilities
 	  of the ARM SP810 System Controller cell.
-- 
2.20.1

