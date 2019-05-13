Return-Path: <SRS0=BJcq=TN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCFAC04AB1
	for <linux-pm@archiver.kernel.org>; Mon, 13 May 2019 07:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22E4206A3
	for <linux-pm@archiver.kernel.org>; Mon, 13 May 2019 07:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfEMH5X (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 May 2019 03:57:23 -0400
Received: from shell.v3.sk ([90.176.6.54]:59018 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbfEMH5X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 May 2019 03:57:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D96F21041D6;
        Mon, 13 May 2019 09:57:19 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pZzf3EVeswrj; Mon, 13 May 2019 09:57:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 07E781041DF;
        Mon, 13 May 2019 09:56:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PHMD5Jjn_DQx; Mon, 13 May 2019 09:56:47 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 45F881041D3;
        Mon, 13 May 2019 09:56:45 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v7 09/10] ARM: export arm_pm_restart
Date:   Mon, 13 May 2019 09:56:40 +0200
Message-Id: <20190513075641.1277716-10-lkundrak@v3.sk>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190513075641.1277716-1-lkundrak@v3.sk>
References: <20190513075641.1277716-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OLPC XO 1.75 laptop is rebooted with a command to the Embedded
Controller. The EC driver should be a module, since most people don't nee=
d
it to be compiled in.

The EC driver can't use register_restart_handler() because handlers
registered with it are executed in atomic context and the XO 1.75 reboot
dance needs to block: the reboot is initiated by poking a GPIO ofter
which we need to wait for the EC to initiate a SPI transfer and finish
it.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v4:
- Clarify why we need this

 arch/arm/kernel/reboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index 3b2aa9a9fe26..71016cf19b86 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -22,6 +22,7 @@ typedef void (*phys_reset_t)(unsigned long, bool);
  * Function pointers to optional machine specific functions
  */
 void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
+EXPORT_SYMBOL_GPL(arm_pm_restart);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
=20
--=20
2.21.0

