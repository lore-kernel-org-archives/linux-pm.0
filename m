Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565201;
	b=buflCO/tYIIzmeCavwbIwvHSvjrNL3sedfyRFF4hygOVwPCOL/f3Nfb4dNj1HBM1NF9X
	 jscGZXq9+x+xtRpGNQOeZs6G4Cc2NDJk9fbiC7aHBn9KyGUSRpZCixT9aLfFDrCS6CGHd
	 7FbNFeupqujC7uGJmKdUq9No4sm8359R5UNxynjSxE0OZOcZ55uaSdPw9btMNaE/eOsJn
	 7woBXozcxF/fsbW+y/RNTDskyAiLwdFtV9CWRgRihC3jp2jqKIFIQfv82t1iIVWJcJ5ZQ
	 OwKBSdb/156ns7/R9ZpnpUk0leeUwjIOLowxMhFXOVIQLuEwAe2uVTbz86lTQ92vw0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GLPPAbg8ZJXtNBuP/olSVfNBE15bH+sF2xUL16ntd9E=;
	b=ru1IH8SoTdf5+hiUd29/D4vCbhKXZDVy2Txlg5IsergTnP8fRJTQoO73QKeCPrun/29P
	 LhtpBTC1n4pElquTU8/OdDeQDNeqUmOgMsqPffZ3bbG4eQnLodCMyr8ISnlYmkIkbqxrF
	 OtdI8igHDzJ7Wn8awrxASr19u9VVam/0t0mKsJLAUNXsh37/I8p1LgRq5QJRPB1A1HJO4
	 F5EmAwOoFyzXwQmsrIQywpVz8mWlRRy/LPjYqo93QwAaZKvRiktafyJAiS+EcUt1mrxqY
	 OjSHz7whmzZbCFQIjcBjrmIwjIPV+bsXXtyJCn0YvvpwL1S/tkVK+nFRGUWSZICPZ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="ZINEXKJ/";
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CA1606A693
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 00:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7CA1606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ZINEXKJ/
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso2027757eec.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 16:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795565200; x=1796170000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GLPPAbg8ZJXtNBuP/olSVfNBE15bH+sF2xUL16ntd9E=;
        b=ZINEXKJ/7u9zktdrlz6SNLUJveG3csKZZd0U7GFCzQrGmozhFUGvmul1SJyNyrAl07
         EvJo50x1fGHaxXQfDIYrKxj9oq2x25tZgUUTPN2kJ0b7PoMZ1x5B0fWx19hbll1FgAj/
         4sTlj1pth8dIRDrr70XK+wrEvuXJOKVDqnAjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795565200; x=1796170000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GLPPAbg8ZJXtNBuP/olSVfNBE15bH+sF2xUL16ntd9E=;
        b=FfTGQOc8E7kCN0vM0YP8YJxJ7DVEz82I/spZb52u8c3/9eUkCQIfqKtCVcPzd5WdVV
         PNE1mUNKsHpqcyF1R2fo6E6gaVNcM+a+fyGOjeY4BD/U1vmKf7J7goSIjim/FjY/9x2n
         uR8N6/735rmAuj/TKWbw2NlU1hOo8qD1d6tfe3izObCHrvJOhod6K2qrGXpTqNx8piol
         RgLg3OP5VpwUZAM/pn5/XsZnF5Lgawi/G6q6Di20tXw6KOB9kpGBL/F2SRQBKPnG+L7o
         CGoxUdG5l8ljFKDQ5CuhN++4kHYTxLNdSASdesoVARguQHwfii4BOnL1NOBYJtID+fRy
         kxKQ==
X-Forwarded-Encrypted: i=1; AL+hErH1i/nAWWIuArNPMp6spfHArf/60c+8HX8rA00O1p9LqCXB8dEonoCPB55cGC6w0KhCm0JDFvvTjw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8NtIxOOyVJpm4du/Tjvc+8OMiaZYrTJqRi1BRyc0BNmQjNRQVc
	4X8ecmdrGhT4ZCz8FG0xWBSFUwe8cDVwLnjNthF/m4Icg4W29ZvECj+vuCzhSsMxBw==
X-Gm-Gg: AZFdTZeWdCA4pGu/LohrYIlk95jPAxPzRrpVAup7ZNHcL3cWmj55KmngFJyzlpm+071
	iDnAO1FJPTV3MOvR8vrKsuIacsAtf1k/1nPaEFQfLmQSmHcSX+HtB7tk6VPbcMlqghEZqcaKlJf
	mjTFp0dwgHgGd7E+1Dd0qupFPfT1DEBeWK0Zg0GlIYqd2ftdgGGEPRmY2g7Jl5WFwazXqo9fRhr
	iXgbXUa/Zpc50UFy64C7qtPljOBQheY6baC34LwabxfsI/6areexl38mQjBKmY4BzLOuFPrsuwE
	40ryxY6YN5c7e2bcs9CvMoJGkCWwACbNhsb78Ylpb0BJcz0AKH/CKAoR0fEHQo7lFoMVG3NjeAu
	/Sq9LguoaPJb9ZGyWfoMoJta/LsIhikSQT8y+ciNV7eTPLYtyNlSuMuehaVH352BuCq3DAE00Ay
	q77kli3R19ucGWneerbHp3WS9k+n7kENSxSz911zp7LBr9EG7g5v/K+RmZc0dGYy587e+T3eY/V
	4IN/2R3UZ/AKdpqSky12vKzvpP/sXS6hMkWCMYvPabAiI6uBz3nb3qZyhk0avFqJ62BpWRApbfP
	dl5hrgvPFXzsuNjP1CULv25+wFv8fGhtAi+SwtLCWBshEVLudXXnFADxNxmdNaVzLIcT
X-Received: by 2002:a05:7301:182d:b0:386:b801:cd06 with SMTP id 5a478bee46e88-386b801cd3bmr5742665eec.40.1795565199973;
        Tue, 24 Nov 2026 16:06:39 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ea9b:d8a3:ba44:2d0a])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-38566cd4efesm50070598eec.12.2026.11.24.16.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:06:39 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	=?UTF-8?q?Jakub=20G=C5=82owacki?= <jglow@google.com>,
	linux-clk@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mariano Marciello <mmarciello@google.com>,
	google-soc@lists.linux.dev,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 7/9] arm64: dts: google: Add Laguna CPM mailbox array
Date: Tue, 24 Nov 2026 16:03:41 -0800
Message-ID: <20261124160343.v2.7.Iaf8214205f496225013f482f6e0035e89ac624f2@changeid>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261125000349.3385325-1-briannorris@chromium.org>
References: <20261125000349.3385325-1-briannorris@chromium.org>
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

Tested-by: Peter Griffin <peter.griffin@linaro.org> (Blazer/Frankel)
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

Changes in v2:
 * Move later in the series
 * Add Peter's Tested-by

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
2.56.1.831.g720f3f5937-goog

