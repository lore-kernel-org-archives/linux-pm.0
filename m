Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86DBC43217
	for <linux-pm@archiver.kernel.org>; Tue,  1 Nov 2022 17:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiKARKp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 1 Nov 2022 13:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKARKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2022 13:10:42 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F041DEE3;
        Tue,  1 Nov 2022 10:10:39 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A1HAMNO055321;
        Tue, 1 Nov 2022 12:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667322622;
        bh=rFwVgaNYWRw9eoQx6UvDT18p8B0eMO8pbL1DJXQsOks=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CEgzbahm/bEF6OiFJn+BgLOcO2PNlY8oi8U/SXzdFJ1InOTzAVujsRm/Vb7TSKwiH
         +qwYjIjAknrQIoS/du/QFoshv1MH6kf/jv/KHQ26jeeUNeMc5GVCb3YHeGYgKtqzp0
         bfHe/GUW+nfispZOaTCy6aJ9kix5nef5reb1cKWQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A1HAMYe087430
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Nov 2022 12:10:22 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 1 Nov
 2022 12:10:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 1 Nov 2022 12:10:22 -0500
Received: from maitri.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A1HAMwF106008;
        Tue, 1 Nov 2022 12:10:22 -0500
From:   Vibhore Vardhan <vibhore@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [5/5] arm64: dts: ti: k3-am625-sk: Add 1.4GHz OPP
Date:   Tue, 1 Nov 2022 12:10:22 -0500
Message-ID: <20221101171022.133322-6-vibhore@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101171022.133322-1-vibhore@ti.com>
References: <20221101171022.133322-1-vibhore@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The 1.4 GHz OPP requires supported silicon variant (T speed grade) and
also VDD_CORE to be at 0.85V.  All production revisions of the AM625-SK
have both so we can enable the 1.4 GHz OPP for it.  Any other boards
based on this design should verify that they have the right silicon
variant and the right power tree before adding 1.4 GHz support in their
board dts file.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 9b4dbae9d4aa..d3060147ad25 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -31,6 +31,15 @@ chosen {
 		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
 	};
 
+	opp-table {
+		/* Add 1.4GHz OPP for am625-sk board. Requires VDD_CORE to be at 0.85V */
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+		};
+	};
+
 	memory@80000000 {
 		device_type = "memory";
 		/* 2G RAM */
-- 
2.34.1

