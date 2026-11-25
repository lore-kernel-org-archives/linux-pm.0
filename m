Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565206;
	b=NSRwInu9ATxp+fpewsKZ5yo5smvp6Mq0xMRcs37JUOPUzYd2b0AkylWl2fIEQAFG9a7N
	 OGgpfgGARuc2STkLb4GHDDi6/W+bO94ZzS4Qxucf8MiaF218HqlI7LCShemcLR1gCsylR
	 +U/+tblbSCMtBlQcCJG3sEdMu9RXeu4UCiqspJ4eiijt9hl6oZviTnofp4gStoJtWXQ0H
	 tGnZw+C/6zYtrttmTN1WbuiMJF4oemyDDeKEXjgaNP42V3+AHYF6ZzdcVe8XSEP7iI+7S
	 WUyNG8QiTOJbQzr6Wt9fpCdllqE/GgzUqCW5YKVHf+5xYhMqf8nQaFnHuYlzoVN4wBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q+Bz0VKoiK6RD2cJswo+cvuH31ipsGl+WNFDwagvNvA=;
	b=f4ASxWnu/lbLbwe29VvXDNPm65+5C55Wqj6V1Vz3yRkpVCNq7t1gwtnowVaoZVexcFCl
	 Q6DggwbFGGGbzmWDViWPk04W7Pcw3Kh09sVUDbkTtowvoK9VRTcuPs3QB4pGLiYtWYkvU
	 tlu7cT4iEActHIxCmajD88R5y8EeFWy8bKUvYMRLzeOHEJ/7070Apq3wYREIqAc2PB/Nr
	 TQkzZ4Zi409uqOW4KQfHPvq/dPCeKnl1j7yKHNa35WzN3YTdgaReijrx0w/bKOvXJvPR0
	 2LcSsPKsAt4ulh6xdi58Vw2ufr8xJt1Eb/Z+ZqgZYoXe8dU/K9JTuICX/PW2prgyuMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="TXyC/36H";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19285606A33F
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 00:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19285606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=TXyC/36H
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3866a784546so6816060eec.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 16:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795565205; x=1796170005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q+Bz0VKoiK6RD2cJswo+cvuH31ipsGl+WNFDwagvNvA=;
        b=TXyC/36HfrOvLWoyI8DqOI7OLOp3GQOBIz3kN6GF1wGrkIdv3iBBhqcHBRmcl6G4Ps
         LhZ+8mBlicdnwE820z2jq1yHE7ngXWdAY2YvDUo0+cV3l3MSa7TksytvkiDH5uLp+0ll
         nsWBisS3ZIeC8hqIRaAcFhhA8RMXWRdSuZ2Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795565205; x=1796170005;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+Bz0VKoiK6RD2cJswo+cvuH31ipsGl+WNFDwagvNvA=;
        b=tDARsrPVOK9kDfhwk8zV/HeWre3t6DrDLG+DtiTPw0bh+wl+YwbKTV0gS3vYQ7SyYw
         PQHhDg3mYtoVTC+JTM+TcwNBU9Q08NJcKR0436kVc9qxScXj1iC8cfG5DTPT8HpRymkG
         HsdXaHVC7AM0eFVX8b4pzpxjMX1oA0vnZYGp9eVXSqhYpJwsolMDWV/Z+qFBYiqrGrLX
         99hPNfMi2GFue03Nzh8WblmlNynXYzZkykUxJxBXApJ+E/uwSHEgrKDQ7avT3TOx6EKW
         QSqDvmDFPGEMAKHDXSlHzw/d/YZly/a2NYhvFXe23a1Khas+IQI0IYXu4ptR53+xyNDF
         L7eA==
X-Forwarded-Encrypted: i=1; AL+hErFp8B6oM1lLe0jl/Kr7zgRhcH7638WvYtJi4gQGKA6nH6GPXsD03WDDp73oMU2mhUPIl1Vb6vg6FA==@vger.kernel.org
X-Gm-Message-State: APuU4Z90iOZ0VqMRpqkxdroL4RzmTypI/yg4wmT/rtHkSYImvxkYFUhY
	GgE6plqP9VPEgHToL/Gxri7uZ0uVTVKktxvlwh9bf+uyAKuGOZsYt+wUGPB6StilCA==
X-Gm-Gg: AZFdTZdFs8BcfnZbXYhV4bKmSN/pYHXxjeEEVUKOuk2IZyhU4ZeLwapULU4OawlprIB
	W5hrGgo767j/lNqV9ZjCwbhki3IfJ7iVfkevB6KhLbRAIfcqZWFKuNz0gsd8V4vi3QM5GJwBNrq
	m36gKc6eyQB06SrnbwBOMAdTZnq/XVKv1hjcu+B+QDbnQzau/P/Zt/U275X39rm3+8rjlu7qCbR
	21KXUNLFGA4ea0fNcISiByc6mLjyrNzogwhDrlvSDalw5K9NqY7PWXWaOxKCliRHwJ5X5NUL2Ma
	zklPikngp06BY3WczSM0H7fji/ai5O7ieHP/LT2VVcf2McgUSpwCCS/Om/HPoPy6UkI9ZptFARz
	VRlUxobZjVsXccqU3JNxCeuF5/JX5QN5VWGjRcvAy5iCNvnoZtJdndUYEIAO5oGdlnEwT6RdN5K
	LoALQlbbpEfFkFB3wpTca0AL/NyGkrgujB2sIvQEMmBygDx3zapnU76TunhptouJJLEO7Y0/3KX
	zIPOVAg+9c4gGnp1LNwen87pgku8mV6RVM5P/4wQZmG3pLXsNob3ZWYbyVVgbDibvkwfU5ieppW
	Apl+OnzGUKP8JTPX/0Xb4uvedMS2p0JtWl52S1Av47ue6OE3FKsJVNaHUJxbW6ZRRHGENeLEQN0
	fh9fhxN4imAffbg==
X-Received: by 2002:a05:7301:4201:b0:385:b8f4:755d with SMTP id 5a478bee46e88-385b8f47ad3mr16518134eec.20.1795565205307;
        Tue, 24 Nov 2026 16:06:45 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ea9b:d8a3:ba44:2d0a])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-385665f21aesm59676267eec.4.2026.11.24.16.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:06:44 -0800 (PST)
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
Subject: [PATCH v2 9/9] MAINTAINERS: Add entries for CPM drivers used on Tensor SoCs
Date: Tue, 24 Nov 2026 16:03:43 -0800
Message-ID: <20261124160343.v2.9.Ibb4a0adecf127291198c372da631ff62b483a795@changeid>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Google Tensor SoC known as Laguna introduces a variety of new
drivers, with Google-designed IP. Add entries to the GOOGLE TENSOR SoC
SUPPORT entry to cover the new drivers that interface with the Central
Power Manager (CPM).

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 MAINTAINERS | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 84b47bbc0d74..ae2b8e8e004d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11509,18 +11509,26 @@ C:	irc://irc.oftc.net/pixel6-kernel-dev
 F:	Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 F:	Documentation/devicetree/bindings/mailbox/google,lga-mailbox-array.yaml
 F:	Documentation/devicetree/bindings/phy/google,lga-usb-phy.yaml
+F:	Documentation/devicetree/bindings/power/google,*
 F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	Documentation/devicetree/bindings/usb/google,lga-dwc3.yaml
 F:	arch/arm64/boot/dts/exynos/google/
 F:	arch/arm64/boot/dts/google/
+F:	drivers/clk/google/
 F:	drivers/clk/samsung/clk-gs101.c
+F:	drivers/irqchip/irq-google-*
 F:	drivers/mailbox/goog-mba*
 F:	drivers/phy/phy-google-usb.c
+F:	drivers/pmdomain/google/
+F:	drivers/reset/google/
+F:	drivers/soc/google/
 F:	drivers/soc/samsung/gs101-pmu.c
 F:	drivers/phy/samsung/phy-gs101-ufs.c
 F:	drivers/usb/dwc3/dwc3-google.c
-F:	include/dt-bindings/clock/google,gs101*
+F:	include/dt-bindings/clock/google,*
+F:	include/dt-bindings/power/google,*
 F:	include/linux/mailbox/goog-mba-message.h
+F:	include/soc/google/
 K:	[gG]oogle.?[tT]ensor
 
 GPD FAN DRIVER
-- 
2.56.1.831.g720f3f5937-goog

