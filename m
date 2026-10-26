Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051128;
	b=PZLG0hbeO2njHe+d8A1bNcETiUAEPYoVbpavqQsCwTmdEtqlf0FldEWcWJ5DJ2QGwCyn
	 Dx0QjKutSUmXFGxlTTmDU3553k4Orzal9tj44IoISHG7ndFTcIz37HGhF5hgxQQSMas7+
	 iIYB9bWIKtz6SHdG9VoKrU/6oaaQjHlrQQ4pztsoWOxyp6Ww8Uz9YxxdERjnuMHZKdfQ4
	 FFsj4sWZLpwXhBIehbbkkdToqokECC6ELGg1YZd5bVjxAK6l5HLMsBPpQIciCzFdzrCSZ
	 oxeon7IZxkQ56rcy5NSPFjg92sImTkCCOCLgBduKuQVEa2pCpJ7YOApXfdCTnCaioDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vYe8GiP6hKBNXwq/bmbj0sq6IXWr6LLeCLyGCfiUVAo=;
	b=GgrM0ZTw1l/rgc43oj45IDdc0KGIRGKbnhjHiFNg0UE8SkDxKeD/gO9HgMCLZZTqDXIB
	 6TyS9X48UDmuVSPcxcFFudOW9b+hpbh6IONUctijNAFUqlMcI4OTQsANVBGBetdV9WmKr
	 M5cNXNvd2shyOOD3JweFNsYJKNm0/SOG3a4HNlPNaMDMUS317bo+vwd9350M38FShwtor
	 Ecf92QPfVCxOVOj3IfKyKmog8FAsB4a3xoJBlHcx80K0PgfzDvYDAskpJiS4bv5OyUlgt
	 AC/nZzGOokpRvjnU0866oHmPTw02onZiaWckQe04BkBJwgOeMzxx4O21r1OvvWtagQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WcLnrBjF;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B3A60A2639
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 21:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40B3A60A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WcLnrBjF
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36661f953e4so6478782eec.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 14:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793051126; x=1793655926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vYe8GiP6hKBNXwq/bmbj0sq6IXWr6LLeCLyGCfiUVAo=;
        b=WcLnrBjFahP4hj117P1H8KOoO7McgOsldZ7VnLKpBz14+p8egeKZglizlEryKv+lFi
         8ETonFbWRyuNR223HvqZyNsz87YT+Jfc5DLfseqwwn+QOI6EHCOsS5VXdhpO/oBlWf12
         tndMKrs8kvUKVhYnBi+E1amNaUwFFI1lUQ/R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051126; x=1793655926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vYe8GiP6hKBNXwq/bmbj0sq6IXWr6LLeCLyGCfiUVAo=;
        b=xkSbAFcoXkdFgC8J09siNG2dMqfcSAmqxwcNKela3kLXRay6OFpGMB6Lkq086IOgwc
         duCMbLgSxK6EWfONQcHfi8CUgxK7o5+Btig39jDQgNw3Mg00FZ7ne90irtVP7aziCrR9
         kkq5tK4s+pY6A29fobsrGkBlExNJQbGe/0eY9vg7JNVdXy1t66TjolAMRZFReuzaNZLk
         NUKzbqj/dO2t1JkgACUHuS9Y//AJGsSBGeowy+isY7pgf8aEQAT/TJ2PXgb7OSOVECKL
         Tiup0PjsW89g93gsgGH9Ois3wRy5FdyUEoAAlchtmQUDC/vZ3aA74CT51TUxyr/efNX9
         yNUw==
X-Forwarded-Encrypted: i=1; AKwUvBxfCVPHW16thPMUmo2pYabcmGz3fGswnAxliJjUL+dwSFnSSF/R226UtS8WZRA1+q6E91MxQNBeSw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLdJFUxkIGSqLc/02Vrm7rrxS4GVYZxH7vj2G+JAQZtklzBPpK6
	2fAvYomiXV2AkOWcfd84I/03XLDZKIq/sXDwfGo2eyDg8s6oa+RR6Lb7goFIImx+jQ==
X-Gm-Gg: AYBFou07mDkT+gIU9dTmwg8g48q+Cb6iVcwsctrUVvfOR6yv7+3hliTt8I1ssKbj2gZ
	9G+sUWlmBuICRJuiHCtGbOJGN3mf0VUBu2z1rrzG1tzxtztH2jnhWGNngKVBiDLugQLNnuL51Po
	T2Rq5veobYEyo4GMlZdWV69qHGZwcihrw41FaEmuGoy9xcAWs17l6hxe3j4cth5cL0VdYcCft80
	Hf43bCzohZ8tZEKIM2x03G8aHDIs9KS0QhaeEBpV6oldztvPYk3xC8jmue7+Fyrg04hROVd7RHo
	AKlJiKSRa+utEukaC2gZQDT+CVdW5J9cQ/W1T+NVn2k7OHIF6NhpsMoOO4Rxe1inLvq3KRh0xBS
	JvO8oygk2LxwYWlYkmoRI77wHtitcDcXFlj+Xk2rGYBQtr5aJcbSsWxD/bfH2jAasOSP9kDctq6
	eduOwQoSTSBqdfzrThqD6ijrvh5IY9MR7SNYfa2PQHTyVvI8JANIWA6qbab37qleqz1+R7w4/eZ
	IdnJK/kHypqYhbh/zSIsPWw268ANQLD/fF/BfrFI2Fm4pgcxUzaAbnbfRnkvHPygR3jDUUMFCNc
	tiS5HBEiaSGgT2WTXIbe
X-Received: by 2002:a05:701b:290b:b0:192:74cf:1db2 with SMTP id a92af1059eb24-1993505e004mr10316882c88.11.1793051126391;
        Mon, 26 Oct 2026 14:45:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36a002a486csm13039391eec.22.2026.10.26.14.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:45:25 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	linux-arm-kernel@lists.infradead.org,
	Mariano Marciello <mmarciello@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-clk@vger.kernel.org,
	=?UTF-8?q?Jakub=20G=C5=82owacki?= <jglow@google.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 8/9] arm64: dts: google: Add Laguna CPM node
Date: Mon, 26 Oct 2026 14:43:46 -0700
Message-ID: <20261026144346.8.I4778aeffbdc796147efa8114431efcb201063b59@changeid>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261026214359.3122870-1-briannorris@chromium.org>
References: <20261026214359.3122870-1-briannorris@chromium.org>
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

The Central Power Manager (CPM) is a co-processor on the Google Tensor
SoCs, as used on Pixel phones. CPM supports power-management and a
number of other features.

The Application Processor communicates with CPM over a pair of mailbox
channels. CPM provides clock, power-domain, reset, and interrupt
services, so we include the appropriate cell-definitions for those.

Because this also adds clock, reset, and power-domain support, we add
them to the UART node at the same time.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 arch/arm64/boot/dts/google/lga.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/google/lga.dtsi b/arch/arm64/boot/dts/google/lga.dtsi
index 6ceb9ea6a100..83b2361c5f00 100644
--- a/arch/arm64/boot/dts/google/lga.dtsi
+++ b/arch/arm64/boot/dts/google/lga.dtsi
@@ -7,8 +7,13 @@
 
 /dts-v1/;
 
+#include <dt-bindings/clock/google,lga-cpm.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq-cpm-google.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/google,lga-cpm.h>
+#include <dt-bindings/reset/google,lga-cpm-reset.h>
+#include <dt-bindings/soc/google,lga-lpcm.h>
 
 / {
 	#address-cells = <2>;
@@ -356,6 +361,16 @@ abl@be000000 {
 		};
 	};
 
+	cpm: cpm {
+		compatible = "google,lga-cpm";
+		#clock-cells = <2>;
+		#power-domain-cells = <1>;
+		#reset-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		mboxes = <&cpm_ap_ns_req_mba>, <&cpm_ap_ns_resp_mba>;
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 		ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
@@ -423,9 +438,14 @@ lsion_cli16_uart: serial@db62000 {
 			reg = <0x0 0x0db62000 0x0 0x100>;
 
 			clock-frequency = <200000000>;
+			clocks = <&cpm LGA_LPCM_LSIO_N LSION_CLI16_UART_CLK>,
+				 <&cpm LGA_LPCM_LSIO_N LSION_CLI16_CFG_CLK>;
+			clock-names = "baudclk", "apb_pclk";
 			interrupts = <GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&cpm LGA_PD_LSIO_N_CLI_GPIO>;
 			reg-io-width = <4>;
 			reg-shift = <2>;
+			resets = <&cpm LGA_LPCM_LSIO_N LSION_CLI16_UART_IC_CFG_RST>;
 
 			status = "disabled";
 		};
-- 
2.56.0.307.g5fe7bd680c-goog

