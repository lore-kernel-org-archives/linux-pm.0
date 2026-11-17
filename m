Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794895578;
	b=lhYVaTqAp3xKE7SCbzGaNBO8SavQkidKR6md9DqdshqBo04vR+KDUowMpp1mcpJQeIfX
	 K2lfaGZoweS+URd3PAkPN3VkGd98Y6ZITIuQEMuhrFToiIIY4eHaBwXgmuunwy0BOH16v
	 h64QAIWofi3UuFr1QXS8U46m/mDnjFgdnmbY9huXODMPRddeE1XUS8pkID7LnIUIf/8NM
	 7OBNGOLi5hK06ig71mJKSkoDPlJ+CLwb5FN19nPSmBfuxRihF9huup4CEK6bhwh4y/nXm
	 dbF0kDaZoEq5zrJKvnE64hrVcv3fQSmlVjOwtEbYLl45nkA+FqYr4HXWyV2LY3xeYgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794895578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=L5HQEogAdp/4jA7w2UsfMfPzuR6qmlgb42NC9n7phLY=;
	b=oMSKwDMblx3kPh+f2cYZJR5/aaNb5s2nx9BmMB9SXm50pOWWlOlrVDEKVQ7E5TZJT1nY
	 TtrJu79ePO+oM2wZLvGRm2u82h/Cht2BN/1OCsVUaPPKUTpfNfy/rcdfgJO7Qnd1HYpYx
	 cNuyApM2rFv9FXhdIA8nL8EaEgY0PyNqHWSerwux1Yw2tKIyQYaWnKRxCSkGFZs/k6c0b
	 LoL76/ta+lt8J/Nr2NA8HXay8V7wN/jnw7IuFYVy68OCgX/9FCJjQoZ8fnUSDwC6+zWru
	 Qo+DeZF/LH6sQv+t1j9hDx1z31ZhwOEZWOsLQ93uaufjyLQLmvrmt6VTegGfXU6nqJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kdZQ7pNY;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F24606A32A
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 06:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95F24606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kdZQ7pNY
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-886e61fa30fso1812225b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 22:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794895577; x=1795500377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L5HQEogAdp/4jA7w2UsfMfPzuR6qmlgb42NC9n7phLY=;
        b=kdZQ7pNYSU5yK2H9f3vmy46m99eGyCqQ0pzIxGYPEmGV8jzOQKEZ6R9an9qcxffvgg
         F43Cp4UfXZky2tLTxvXxqY93CQpvOK1T8N+COEoE/zcYwmD/yM9eO7N4qcyYtC4odqCZ
         aXBMQ6RS6FIpRMeRLJSR6C3uazGJRsunnB15mGasUnRb+sCDY+Pa483c/GfbTCaodfvo
         uFuyY5XiLw24QckdxpUz8itjhcbR+GBXbL5mGW7sato7PmAdcIamYYxqKwcItiqTHevY
         o4a9Dfil5ndxuih4YEwO/Hnwm3TQfy5BSijWBJOihtUFSTb79/wVVSB9Uj+naiBZRfI+
         bLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794895577; x=1795500377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L5HQEogAdp/4jA7w2UsfMfPzuR6qmlgb42NC9n7phLY=;
        b=sBRknPVGM5TFScZ2x/x+luC5Bo2CgDJdgjsZa5aIIOCpUcsWrDFAJXQ39nlL1wNik8
         uO9y9UrhubyWbqVutDwVhHJPzORAYjLdfz8MsDV6PEwiyg1SnjjNZE2AJQMM+DlFarq2
         f5FjOETlnxrGGMfouYTWAXt6bwJa4SSLtS0Tp+d3F5k3GUfQ0Irt5HgQtK0HcizF6bz9
         NqGRv7MAaqWrPLwpIsJB/PhMkkJOJRyNBx8VukaQ5K1GsisHtqQUXzq8uv+wkUPAphmj
         skT01MKJBuIl5ctSUUrOX9lOZoDe4205Z7n5HNsYs1uSTjklCdZMhsNd9QgwhMDjOv1B
         B1Vw==
X-Forwarded-Encrypted: i=1; AL+hErHfEDaehAIN03cmeV7/otIPTKgE0QvrcQz4pF428wyz5BBt6spvIzBrQSsrxtJ7sqnY7JHbZa/4+g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+C+wDwDnrT0ydqSeoN3Vl7cIwNsQjgo+nHwcM8HzsL9yAAICDs
	4BvZavCjQHR6epfKsljzM2cfp56tkR5DLqfWAyvwmENCr/D7VF/MBdDQ
X-Gm-Gg: AYBFou2tnK/2hzRlwfD6oksKeDpj1YSxdSB4CmMllcq3mq5djK2ymf9hPQrkIPLPk7g
	w5v80CSH9KUC/JgveWxSm5jLzI0jlN4lt2Gz4Q4OtyUJ8h7NfbxuH15tXGLWtDqWx6QhCwC0IHi
	p/bDWClAbxfji+m3yxIWzJRqePxxl4O5Q9Idy6ibOKOXuwvN593s0taBAUITXJ4LQZYFkUb2oL/
	QHbMTCu1EMTTGE/VoKE0wXxwgU/MNdaNB84o/KuRHdoWT14iQdD6ugNmA+tCGwREm0OMrMQqbfo
	RnKbWvwECvpB3ihgyLiYr0flkEZcqJo76MYPwMS9ARLAxk/WRJmet1CoC9fdCsnKNbW91UKkXk8
	Lbb4bD1ZBrO2LKKEhoHABoqzfTa48pq0mbjFzADLDJsz+YMeEJy0mx/B3nkcxQXlDqJOwpQI68m
	wzLI6M9FMQT6plY6WENMZ5AUHoEtIbl/Yx1K8VrmNRp3N+DLvIJ70uUkwx1E0/tQ03KREUgJL4n
	kUK+8eEByJE2NOUDTOJnmJ92BX48fIVhWDEjxDU6lcK459J6utfKknV4wpcSx8eeeLTuNNnaBLj
	HUXnUv/lc2W32rHpu1WE5XwWMEcXcGsGrPxSpKPplI6oQOQoa1+YLVxmYRzAD28gFRGkZUtwREN
	F173pc+fg908=
X-Received: by 2002:a05:6a20:6a0f:b0:3e2:95fb:8d03 with SMTP id adf61e73a8af0-3f7a7fc6dcdmr10376493637.69.1794895576986;
        Mon, 16 Nov 2026 22:06:16 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm4464623b3a.13.2026.11.16.22.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 22:06:16 -0800 (PST)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH 4/4] arm64: dts: nuvoton: ma35d1: Add thermal zone
Date: Tue, 17 Nov 2026 14:05:01 +0800
Message-Id: <20261117060501.2611071-5-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117060501.2611071-1-zychennvt@gmail.com>
References: <20261117060501.2611071-1-zychennvt@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the SYS block as the thermal sensor provider and add a thermal
zone with a critical trip point for the SoC.

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index 7228ad4735b5..986f3cc4176b 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -63,6 +63,21 @@ gic: interrupt-controller@50801000 {
 			      IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	thermal-zones {
+		soc-thermal {
+			polling-delay = <1000>;
+			thermal-sensors = <&sys>;
+
+			trips {
+				soc_crit: soc-crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
@@ -86,6 +101,7 @@ sys: system-management@40460000 {
 			compatible = "nuvoton,ma35d1-reset", "syscon";
 			reg = <0x0 0x40460000 0x0 0x200>;
 			#reset-cells = <1>;
+			#thermal-sensor-cells = <0>;
 		};
 
 		clk: clock-controller@40460200 {
-- 
2.34.1

