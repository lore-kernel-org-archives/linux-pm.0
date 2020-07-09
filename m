Return-Path: <SRS0=XwW7=AU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05181C433E0
	for <linux-pm@archiver.kernel.org>; Thu,  9 Jul 2020 09:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E762074B
	for <linux-pm@archiver.kernel.org>; Thu,  9 Jul 2020 09:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgGIJFi (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGIJFi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 05:05:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1228BC061A0B;
        Thu,  9 Jul 2020 02:05:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6D7732A5F19
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, dianders@chromium.org,
        heiko@sntech.de, maz@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] dt-bindings: devfreq: rk3399_dmc: Add rockchip,pmu phandle
Date:   Thu,  9 Jul 2020 11:05:29 +0200
Message-Id: <20200709090529.1404999-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Rockchip DMC (Dynamic Memory Interface) needs to access to the PMU
general register files to know the DRAM type, so add a phandle to the
syscon that manages these registers.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
Following the discussion in [1] and after having [2] accepted, this
patch is a RESEND of a patch [3] that has already all the acks but for
some reason and my bad, I lost the tracking, didn't land. The patch adds
documentation for an already property implemented in the driver, so
resend the patch again. There is a slighty modification, the rockchip,pmu
property has been moved to be optional as is not really required.

Thanks,
  Enric

[1] https://lkml.org/lkml/2020/6/22/692
[2] https://lkml.org/lkml/2020/6/30/367
[3] https://patchwork.kernel.org/patch/10901593/

 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index 0ec68141f85a..a10d1f6d85c6 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -18,6 +18,8 @@ Optional properties:
 			 format depends on the interrupt controller.
 			 It should be a DCF interrupt. When DDR DVFS finishes
 			 a DCF interrupt is triggered.
+- rockchip,pmu:		 Phandle to the syscon managing the "PMU general register
+			 files".
 
 Following properties relate to DDR timing:
 
-- 
2.27.0

