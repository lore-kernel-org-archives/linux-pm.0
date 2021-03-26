Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45E1C433E2
	for <linux-pm@archiver.kernel.org>; Fri, 26 Mar 2021 03:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9519661A45
	for <linux-pm@archiver.kernel.org>; Fri, 26 Mar 2021 03:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhCZDNP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Mar 2021 23:13:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41681 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230239AbhCZDNI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 23:13:08 -0400
X-UUID: c939cf170a314260a3403d4213499dfd-20210326
X-UUID: c939cf170a314260a3403d4213499dfd-20210326
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <seiya.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2023297819; Fri, 26 Mar 2021 11:13:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 26 Mar 2021 11:13:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 26 Mar 2021 11:13:02 +0800
From:   Seiya Wang <seiya.wang@mediatek.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Seiya Wang <seiya.wang@mediatek.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 2/2] dt-bindings: cpufreq: update cpu type and clock name for MT8173 SoC
Date:   Fri, 26 Mar 2021 11:12:27 +0800
Message-ID: <20210326031227.2357-2-seiya.wang@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210326031227.2357-1-seiya.wang@mediatek.com>
References: <20210326031227.2357-1-seiya.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update the cpu type of cpu2 and cpu3 since MT8173 used Cortex-a72.

Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
index ea4994b35207..ef68711716fb 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
@@ -202,11 +202,11 @@ Example 2 (MT8173 SoC):
 
 	cpu2: cpu@100 {
 		device_type = "cpu";
-		compatible = "arm,cortex-a57";
+		compatible = "arm,cortex-a72";
 		reg = <0x100>;
 		enable-method = "psci";
 		cpu-idle-states = <&CPU_SLEEP_0>;
-		clocks = <&infracfg CLK_INFRA_CA57SEL>,
+		clocks = <&infracfg CLK_INFRA_CA72SEL>,
 			 <&apmixedsys CLK_APMIXED_MAINPLL>;
 		clock-names = "cpu", "intermediate";
 		operating-points-v2 = <&cpu_opp_table_b>;
@@ -214,11 +214,11 @@ Example 2 (MT8173 SoC):
 
 	cpu3: cpu@101 {
 		device_type = "cpu";
-		compatible = "arm,cortex-a57";
+		compatible = "arm,cortex-a72";
 		reg = <0x101>;
 		enable-method = "psci";
 		cpu-idle-states = <&CPU_SLEEP_0>;
-		clocks = <&infracfg CLK_INFRA_CA57SEL>,
+		clocks = <&infracfg CLK_INFRA_CA72SEL>,
 			 <&apmixedsys CLK_APMIXED_MAINPLL>;
 		clock-names = "cpu", "intermediate";
 		operating-points-v2 = <&cpu_opp_table_b>;
-- 
2.14.1

