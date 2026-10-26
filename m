Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051106;
	b=Dnn2+ozw4sUbOCe1e0ZEVP0ckQlvqjlAaM9SijSCZhPwZKqEcTYCsj2q0mTv1Fghn3+o
	 k1+wZa0aIDJq0h1BFl5Qd2tZN9v4WetHgHIhaahomHcqN7e8r3ZG+S0QrMzrPBDVz3GUf
	 NSNCw6R+esbq2GucckuAoGBLcOEtJMJSC9ShS644K/9TrZrYZuW1OaBn9/qYiL/Vp3F9n
	 QnpjhQj8E/Mn/BUjrFv0tuWMgkzfr3jIbtEjFebN30KOjbosHiPLR9NznVPgBG32Fv2ZA
	 3OHxp7eOdgtr54Dv7mqrw5kNQVncDy7ATVxQ8vO6kQV7eimL65dXM+ZbRd3qfr2FfNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kNTRPGjk+JRlFS0l8T9G1tIUTUomkJSdQSP0R5ccDUE=;
	b=kYgFAIOcH/I5SdBSLICSqLMzwOkGy9pt8Xz5HBdI6BkVN4vnr0Zt1SkukQCVs/0sOT82
	 /P+QJL8fHg3FmlHTVI3gFbi0jLehuuseFUztpRyfW9wnPI63obsF6ljTAEYds+RALx0du
	 3n+swvdv8RXRmr+f5QdDt9BUenQWKb2T5D2N/s2aDnD/wSWy+Nbm4oI3O//7Hw3tTZibK
	 oUVDNQ4nF3C5OmlhY/pHsSaxlUbrRuJtCA78G7VPEG6SkrZIUywRHLnd1vQRJ/FuaNycu
	 Rqn8DTHAyVIdC8hXt0XyFyFqpL/FBJ02gJmL4i0+7OdiH6IuQBq1xDnse86wcL0nDhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JbNZvUx3;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF0606A31D
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 21:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33CF0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JbNZvUx3
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535a54bed9so5389011eec.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 14:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793051105; x=1793655905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kNTRPGjk+JRlFS0l8T9G1tIUTUomkJSdQSP0R5ccDUE=;
        b=JbNZvUx33IFVpa/fHUpO0fFj60GvDrTkv2Lf0UHCYArCUiYDKzse/SwIFTwUg4xTJB
         kwTILExSh0hSwzeFIM/VIKL+P28Q2kpKNrretEhyLYIkfAPjiMOM0KAKlmCoA08nNeO8
         u9rR/JihRYzitUwBjRhsROadxot2/RXAyswoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051105; x=1793655905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kNTRPGjk+JRlFS0l8T9G1tIUTUomkJSdQSP0R5ccDUE=;
        b=FlLlkT2BAR8IFm80Uc9H6JAU6EI6bA76jmRVhxulkvrraw9u60Vj9bhh3Nty2ua+2R
         vr5EFhUO0rBx3W1S2eTL/1kPZ8WTjDx3RqKwHQTyID7f/LrnClsBwFGI3ZS0yUViGuDw
         G5+Ks/Iz1cUsQFL5B8Gh2OTrLOFAnOj0KmG9MeRD8khANrSuXPrZItUydyiGEVAlGYRY
         PtOAVIz4dzJ9/i8HKg+NSg+8wzRpQ+2ZK/6CBFaAOOt1k8rNtlla73TrHQ5rBZtAA+43
         KP+aEbG8vEIh3MlULp7Q3PIsAExe8bUG6+G+ASnik8hLHIEd6v4gmSRzdm/hi8g4RwmS
         uBYQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSyTkPYDGPlxifL+nNttEY5DRJZuF9WiC3jWcr4XFEO+cvVuX8jhTw8w0PbmNcQRSYKqsdd3Om7A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKLG1UbLXVa7kqjXlHcy/srcjAS1v4UawIHUNQiDf4jZFKRIpxk
	bcYHe5TLLwscGwvHWOVPiz6ETL1Ryh69KPaNlsgoJkILYEGL1w1Up3/c7uj/LJWT5A==
X-Gm-Gg: AYBFou1yL1TO4TOUmXRhJOrqnuJcfGrV1hDYrEkAS7JPrESh3xjR5iHVgm7ExOjSCHL
	ya90sbkl+XcydkZyA7Nyw8i9h2EqsJPXn2kshkQNgXODrZQLi35gkLXnqCI2LAD6OjnXKIPei95
	9/2kOz5ZLo1T3O6VAgbnNl4btazOTa9IQjRigOCuE8gR5OSzw3gHwjF1VKAJudDkszBEUKrnbS2
	sbdOEq416mDYtfBPMP8n5VxSBZIGVnl/dsREVMpqgm/bGpm4wJo4l8wZavoOtdKSIkt72fb2Qyr
	birmIo6NL4dtyf8JkmQRIse3lSdBe0t0255YOTkDHtks5F+gD0InUwyUeymINxjH5FUb0NcmU0N
	0DrwuGGwSORsj0B9YBBPWSYrWFw54mHUZ6+msfS+dI2yBrbHYTk6A8kTm/f6FU7kg3jMb2zOSFx
	/aMEFf68+MArXJEArMDpq/gljbz/cUY8J5Qa+flbilamZTn64/YYWlBW49kgzF6Hr0SdnUxpWx8
	qGpdXHWcRJkyz5cI7uUgT01rJ7gLIuH8yozFAIUQLVweGvTC7km9pscSfEODVGcEGsESPJahTvh
	dxTTBrHF7CNuoJaV4wI=
X-Received: by 2002:a05:7301:2295:b0:361:1dd6:531b with SMTP id 5a478bee46e88-369e84943damr11389869eec.26.1793051105135;
        Mon, 26 Oct 2026 14:45:05 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36a03bea5d4sm8375063eec.6.2026.10.26.14.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:45:04 -0700 (PDT)
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
Subject: [PATCH 1/9] arm64: dts: google: Add Laguna CPM mailbox array
Date: Mon, 26 Oct 2026 14:43:39 -0700
Message-ID: <20261026144346.1.Iaf8214205f496225013f482f6e0035e89ac624f2@changeid>
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

These are the request and response channels used for communicating with
the Central Power Manager (CPM) found on the Google Tensor SoC known as
Laguna.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Based on WIP bindings from:

  https://lore.kernel.org/all/20261023165211.v2.3.Ia186a29119b4b5c409815b755e0c2c3965b0495f@changeid/
  [PATCH v2 3/4] dt-bindings: mailbox: goog-mba: Add goog-mba mailbox bindings

which is part of this series:

  https://lore.kernel.org/all/20261023235408.3063350-1-dianders@chromium.org/
  [PATCH v2 0/4] mailbox: Improve the mbox core then introduce the goog-mba driver

The binding is still under review, but I include this anyway to help
prove out a working solution. This patch should not be accepted until
the binding is settled.

 arch/arm64/boot/dts/google/lga.dtsi | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/google/lga.dtsi b/arch/arm64/boot/dts/google/lga.dtsi
index 3e670e524c4c..6ceb9ea6a100 100644
--- a/arch/arm64/boot/dts/google/lga.dtsi
+++ b/arch/arm64/boot/dts/google/lga.dtsi
@@ -365,6 +365,36 @@ soc: soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 
+		cpm_ap_ns_mba: mailbox-array@5240000 {
+			compatible = "google,lga-mailbox-array";
+			reg = <0x0 0x05240000 0x0 0x00010000>,
+			      <0x0 0x05250000 0x0 0x00010000>;
+			ranges = <0x0 0x0 0x05260000 0x00020000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			cpm_ap_ns_req_mba: mailbox@0 {
+				reg = <0x00000 0x1000>;
+				interrupts = <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				#mbox-cells = <0>;
+
+				google,tx-payload-words = <4>;
+				google,mba-queue-mode;
+			};
+
+			cpm_ap_ns_resp_mba: mailbox@1000 {
+				reg = <0x01000 0x1000>;
+				interrupts = <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				#mbox-cells = <0>;
+
+				google,rx-payload-words = <4>;
+				google,mba-queue-mode;
+			};
+		};
+
 		gic: interrupt-controller@5880000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0x05880000 0x0 0x10000>,
-- 
2.56.0.307.g5fe7bd680c-goog

