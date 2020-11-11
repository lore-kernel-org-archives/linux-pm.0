Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9F6C388F7
	for <linux-pm@archiver.kernel.org>; Wed, 11 Nov 2020 01:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73FEC221FB
	for <linux-pm@archiver.kernel.org>; Wed, 11 Nov 2020 01:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXeCtfA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbgKKBQT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 10 Nov 2020 20:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732876AbgKKBPx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:53 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823A8C0613D1;
        Tue, 10 Nov 2020 17:15:52 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 33so733369wrl.7;
        Tue, 10 Nov 2020 17:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=njgYqFZmwduGO+GquleWvDght0mh33I7xUspgeh67jo=;
        b=bXeCtfA98/UNq8kG6fsaFfAlykgvqMhX/TtP9upNgan30ndulVtJrJmVRrsIl0+tzq
         uOJl8xhqMychwiPwVAebJw0XJQ8pp03JH+DW6EzWywLjGp4L0ODEkj89FoRJuxnNoNZp
         IfzPXVKfrjRBKyR/C82qz+xmziaEVhOFZOzTidOKUc8bV0gA+syplSs9XvuCwEaJsF3u
         XZlG+cKxCK+x2/HytNEoJciSjKV53K/cifZOHqybAGIvr9xUbTH3Q4VHJcO4J1Tv4yok
         VQDMZEbrgVR29SYCvwNENLIy1WX4DODEMEaGNbQihM8Uy1N/Bm0PVBNEDxJR3F6GbnOl
         YoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=njgYqFZmwduGO+GquleWvDght0mh33I7xUspgeh67jo=;
        b=tRAbw+LZNi07Oqc6PbIpkUoLdOlb/7jRPlkZy1X0DAh0XHJM6Nz9Aal/bTx1FoklKq
         wBLRMKDxlk55HRPFiXIDmqapMdEvnNFAKpyCS58kL8HRX3z34LczlXj+foYK+IR436tj
         ea2VJt09xzgaDwvxC7DKTa1ADANxQthr/4k02Xy92MkklRf4AACvXl8rP42SRL4RX9me
         gNHpbcVI1iSuy+g/Wsh+Cz8Pn3Omjke7qwyZOPAkOYM1c/075I0SHJ9YaUbCFbnu3qsT
         30nPizNimBdqtKgXzk4LMzWMAF5/49fQwOZ5s/ohRYbqSnFM1iUA/oQg1VZyvwHufQ9N
         A+qA==
X-Gm-Message-State: AOAM531fmsC4vfblcGhdrMVyY85sGZt3fs/cTJhV+GWzebccBfGwQsWH
        cKxflDquKY1vIsNeDlur4lw=
X-Google-Smtp-Source: ABdhPJw4MqJiFxzd4OcnoL/bD/nC4sE7gL5oRMgQALKg+k+7EaNqfbBayRKC5nq949iJqlrpBS/RsQ==
X-Received: by 2002:adf:b190:: with SMTP id q16mr27761547wra.288.1605057351316;
        Tue, 10 Nov 2020 17:15:51 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:50 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v8 24/26] ARM: tegra: Add DVFS properties to Tegra20 EMC device-tree node
Date:   Wed, 11 Nov 2020 04:14:54 +0300
Message-Id: <20201111011456.7875-25-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111011456.7875-1-digetx@gmail.com>
References: <20201111011456.7875-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add EMC OPP DVFS table that will be used for dynamic scaling of memory
frequency/voltage. Update board device-trees with optional EMC core supply
and remove unsupported OPPs.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../boot/dts/tegra20-acer-a500-picasso.dts    |  7 ++
 arch/arm/boot/dts/tegra20-colibri.dtsi        |  4 +
 arch/arm/boot/dts/tegra20-paz00.dts           |  6 ++
 .../arm/boot/dts/tegra20-peripherals-opp.dtsi | 92 +++++++++++++++++++
 arch/arm/boot/dts/tegra20.dtsi                |  3 +
 5 files changed, 112 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra20-peripherals-opp.dtsi

diff --git a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
index a0b829738e8f..b4ed88802387 100644
--- a/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
+++ b/arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
@@ -1061,6 +1061,8 @@ map0 {
 	memory-controller@7000f400 {
 		nvidia,use-ram-code;
 
+		core-supply = <&vdd_core>;
+
 		emc-tables@0 {
 			nvidia,ram-code = <0>; /* elpida-8gb */
 
@@ -1450,3 +1452,8 @@ emc-table@300000 {
 		};
 	};
 };
+
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp@666000000;
+	/delete-node/ opp@760000000;
+};
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index 6162d193e12c..585a5b441cf6 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -742,6 +742,10 @@ sound {
 	};
 };
 
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp@760000000;
+};
+
 &gpio {
 	lan-reset-n {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index ada2bed8b1b5..52a81d888424 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -314,6 +314,8 @@ nvec@7000c500 {
 	memory-controller@7000f400 {
 		nvidia,use-ram-code;
 
+		core-supply = <&core_vdd_reg>;
+
 		emc-tables@0 {
 			nvidia,ram-code = <0x0>;
 			#address-cells = <1>;
@@ -662,3 +664,7 @@ cpu@1 {
 		};
 	};
 };
+
+&emc_icc_dvfs_opp_table {
+	/delete-node/ opp@760000000;
+};
diff --git a/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi b/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
new file mode 100644
index 000000000000..25b1ba73951e
--- /dev/null
+++ b/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	emc_icc_dvfs_opp_table: emc-dvfs-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@36000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <36000000>;
+		};
+
+		opp@47500000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <47500000>;
+		};
+
+		opp@50000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <50000000>;
+		};
+
+		opp@54000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <54000000>;
+		};
+
+		opp@57000000 {
+			opp-microvolt = <950000 950000 1300000>;
+			opp-hz = /bits/ 64 <57000000>;
+		};
+
+		opp@100000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <100000000>;
+		};
+
+		opp@108000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <108000000>;
+		};
+
+		opp@126666000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <126666000>;
+		};
+
+		opp@150000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <150000000>;
+		};
+
+		opp@190000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <190000000>;
+		};
+
+		opp@216000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <216000000>;
+		};
+
+		opp@300000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <300000000>;
+		};
+
+		opp@333000000 {
+			opp-microvolt = <1000000 1000000 1300000>;
+			opp-hz = /bits/ 64 <333000000>;
+		};
+
+		opp@380000000 {
+			opp-microvolt = <1100000 1100000 1300000>;
+			opp-hz = /bits/ 64 <380000000>;
+		};
+
+		opp@600000000 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <600000000>;
+		};
+
+		opp@666000000 {
+			opp-microvolt = <1200000 1200000 1300000>;
+			opp-hz = /bits/ 64 <666000000>;
+		};
+
+		opp@760000000 {
+			opp-microvolt = <1300000 1300000 1300000>;
+			opp-hz = /bits/ 64 <760000000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 8f8ad81916e7..6ce498178105 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -6,6 +6,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/soc/tegra-pmc.h>
 
+#include "tegra20-peripherals-opp.dtsi"
+
 / {
 	compatible = "nvidia,tegra20";
 	interrupt-parent = <&lic>;
@@ -664,6 +666,7 @@ emc: memory-controller@7000f400 {
 		#size-cells = <0>;
 		#interconnect-cells = <0>;
 
+		operating-points-v2 = <&emc_icc_dvfs_opp_table>;
 		nvidia,memory-controller = <&mc>;
 	};
 
-- 
2.29.2

