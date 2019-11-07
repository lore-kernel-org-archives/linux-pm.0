Return-Path: <SRS0=/bOj=Y7=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AC4C5DF61
	for <linux-pm@archiver.kernel.org>; Thu,  7 Nov 2019 03:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CFCD214D8
	for <linux-pm@archiver.kernel.org>; Thu,  7 Nov 2019 03:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="DVq4bSIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbfKGDR1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 6 Nov 2019 22:17:27 -0500
Received: from gateway36.websitewelcome.com ([192.185.184.18]:21473 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727751AbfKGDR0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2019 22:17:26 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 36AC840DBF885
        for <linux-pm@vger.kernel.org>; Wed,  6 Nov 2019 20:26:00 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id SYIYi85wAiJ43SYIYihaEq; Wed, 06 Nov 2019 21:17:26 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0e1qX27Ap8ajDLmuZXwZOfgehLgO/33J03C0zj3Kqnk=; b=DVq4bSIwsgmsIRc1uFEMPTBB3B
        0T99PELzm9lMsc/uAVu8qlx7USbWsv6442onIkbkgwCRNYa2ZlHQxJdCBX6i1KVsPYjKXhlFD6sG4
        EkGgemDID9w1s+TkHBAcem3zch+0NuWKR/2GTlerMynE8LgH8zmh+dakDJ9+1wROhgBhuJUySpisD
        FIdf8My4YZ4YQ70UXLWNUUvnk1n/42+f31nqPbEDf0veOBlc4790ox24NmQLdYv6PV7COkRqagPQv
        Q/21hAozKyOKDhNI3aLBBCuXxBPSppz75ATRS/J4yuAj9LtADQMlQQeeTrNjL8ineiiT1fiQv6BKw
        m2EyeYcg==;
Received: from [191.31.194.59] (port=34854 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1iSYIX-000Mrk-CG; Thu, 07 Nov 2019 00:17:25 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, lee.jones@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v6 3/5] devicetree: mfd: max14577: Add reference to max14040_battery.txt descriptions
Date:   Thu,  7 Nov 2019 00:17:08 -0300
Message-Id: <20191107031710.5672-4-matheus@castello.eng.br>
X-Mailer: git-send-email 2.24.0.rc2
In-Reply-To: <20191107031710.5672-1-matheus@castello.eng.br>
References: <20191105095905.GA31721@pi3>
 <20191107031710.5672-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.194.59
X-Source-L: No
X-Exim-ID: 1iSYIX-000Mrk-CG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.194.59]:34854
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 51
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

max77836 MFD has a fuel gauge that has a low SOC alert feature that is
described in Documentation/devicetree/bindings/power/supply/max17040_battery.txt.
Adding the reference to de documentation here.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 Documentation/devicetree/bindings/mfd/max14577.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max14577.txt b/Documentation/devicetree/bindings/mfd/max14577.txt
index fc6f0f4e8beb..04d790b1513c 100644
--- a/Documentation/devicetree/bindings/mfd/max14577.txt
+++ b/Documentation/devicetree/bindings/mfd/max14577.txt
@@ -5,6 +5,8 @@ Battery Charger and SFOUT LDO output for powering USB devices. It is
 interfaced to host controller using I2C.

 MAX77836 additionally contains PMIC (with two LDO regulators) and Fuel Gauge.
+For the description of Fuel Gauge low SOC alert interrupt see:
+Documentation/devicetree/bindings/power/supply/max17040_battery.txt


 Required properties:
--
2.24.0.rc2

