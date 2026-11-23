Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433897;
	b=k/9YEwRU0kKiEVF0xUM+78synzfXHVFkNGvqqqUF9fpHTVdYrQxySmS2AS7ZR9fWcWCu
	 DOdiEs6oI6K8NucuwcW+YSmsfduuvjiVprj8v6+lclXMSb/DwRWDwuxeyfZXmf8jwROoN
	 /e6eXHDcR2g6sP9rZ6FPMHWtdv/zY6mRLe9vupDT6pAKz/FNQKPeLCDd2KP83nDjFyfNp
	 rZpfwJ6UqGT3UYRu0ffr4vKGFWQa5/cMQ+97+H0UZUsYIbY5pyDL9+cY+LdjfiQw0DsIT
	 gRM8YFCmlTOSoUPJdxy9ufJREqKi7xByqbwGYEA1+kyxBsaZp4AYU8tkciDGUWTajbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433897;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NxNZWpxJZ312FfsXfTrSW/vQmMkh0MVWaFRbIlwW5IE=;
	b=4CXKqbbIopjXRNxXByJStUr0vb6E/TPEFrWk/6kzf8b81uc/WdPuQpPXZ1qF6R0p/8sm
	 UpNgEN1TX8ldtwZuegn0x4BHazMuf7/VjfRjSLK5YXNY+D48aJmA/TeHPSjEpahLROi7+
	 WSnkdvPXTXZpNL4nFGNosVczFoKbvFetFm+RLWyDh7TkqQBmJm2JCB+IDJbf+z9y6MRcD
	 DOlNTjkw4P1L5HsY8BuZWR7a3soDktB3CaPTkgYzPYyFbMOLRogYZFHmQQBoA77AeoeBr
	 vNLsf5BAOD9syNxbsf7bOTisnrN3pW5TGiTgRt6drgDDR38DHaSPQn1AKtAWjrZsTZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fG+IFkil;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B569606A327
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 11:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B569606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fG+IFkil
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b2f59de176so2546272b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 03:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795433896; x=1796038696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NxNZWpxJZ312FfsXfTrSW/vQmMkh0MVWaFRbIlwW5IE=;
        b=fG+IFkilVhSgMPY3zBEvk6ihKTl85EQl2ZoU6FNnB0nVWZwBnAgAbYWJUcSoAIYQoe
         sJHnIIj1eR2NNGVfRtmEOun93SG+SblUh8Y1Ukgzv0LnkSKOSC9mzRonEUq/T+atLWFb
         uOH077SZIKELKZDDTxL1JoWNR8oXur5dYHv70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795433896; x=1796038696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NxNZWpxJZ312FfsXfTrSW/vQmMkh0MVWaFRbIlwW5IE=;
        b=WnpFnz1nvNWnB6UaF3f4n7oSnA9GAnsrYqlmrPj6/EA1DCr40Mi2Lc62qoBtOIK0Lw
         DKvKspJ7Cj9mL3VQ10JWiygFvkFw3ncujvl1mZVkOrX9VHsvBcL3I7Ea3/62WqPXb3h1
         Zxx0UIOZln2JI6Ccgt7ui/77SZlR4zLanKG+tmRwcP4mJa+TA6x8uDHT1JtiQVNJPks0
         iRl5bTQbtLiu5KjzUi75JbNsctS2rCCl7PydaKoF5oeMHMXOXTpWK0iJ1R8J9Ur7ivff
         4qDMTsIBlmi3+zIExUiMCZLOQz6MoYTSroUB/zIRA7l6kw9kPAlHdYkCbzSVx9u4Sqss
         E0/g==
X-Forwarded-Encrypted: i=1; AL+hErFMM5royViSv2wmEMUmX+xhP+e7wDdUiYLDdUpEcm7hyrL1Q0HlEqa3T9sUxPPnLFtznkNS3otanw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/QSgDPk+557VUVN146u8O+suEP+6mZ4xyH5mIuEMpOchJdcUvq
	67nVI4ognyut+hGeKuuFo9BBgSaloj/dZSTS/PUBBgUoHwPEHQSwNfZQULXGkVojbQ==
X-Gm-Gg: AZFdTZdm0OV7W7Y5Rf/cTSIZMcMbmUxEy8nbyxi2DzeXDeQsHlnV11ujaagtAzSplFq
	ntf8lhItguxKZSo1UDIVZKopDV7dUS//U+eTFr4tWvpXm3u79FhMQ9ZQItCjN+CbnivM+1ldEml
	jXtvJrdZmEapW92AJVSzQY2ap4vLbuDhekVuQaPi4zwEpoe2e8BHURG2WOy8u7jYFwmhmeSuQ1s
	UibwMiTHYAA3Mqp/YsbHLVTpddvfVgr/X4a8Hw60ixEuOvMU5ZZVesd+AtR9uYHwZ6cglqox8r3
	X6pjEs/dqNpKOsXzzT2WIFqPrh+7rCWQGNMhO07vb1M++34FiiLmzMsmotqzraEwblLt17D0FzL
	HJHPQam8PUfKlCRv6slu14tHCvjS/OjjolipJ4Tlcxqzk10AhwvZzxhfpRCOs2+Ps9gk9ZEhlig
	jUDb8WKl0xsa4gO+TReZfETQZLTRHN7MWXcWAtuZu/WJpLMlTfhcD0E9cXkl2BE6L0H+qARfgdO
	2RUrtZbwgTinznXzAAEH6mUroHo9ilWRZFnzFQaG54HWwxCJqTqsipe7FvOqWUarzFH+MkDmkTn
	b8n37LXVUuPwBGrU+hDPt0s49cTQ+Spzad+6zyvhIVEjaf4nQsK0bDmwXtVd
X-Received: by 2002:a05:6a20:748b:b0:3f8:c7b1:688b with SMTP id adf61e73a8af0-4014d4579b7mr11406956637.34.1795433896023;
        Mon, 23 Nov 2026 03:38:16 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:ceb5:5e59:832f:d16b])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cde6cea770asm5097982a12.3.2026.11.23.03.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 03:38:15 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] iio: adc: rzt2h: depend on POWER_SEQUENCING instead of selecting it
Date: Mon, 23 Nov 2026 19:37:54 +0800
Message-ID: <20261123113755.3033436-3-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123113755.3033436-1-wenst@chromium.org>
References: <20261123113755.3033436-1-wenst@chromium.org>
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

Commit bdfc454e8567 ("iio: adc: rzt2h: Add support for RZ/V2H(P) SoC")
recently added usage of the power sequencing API to the rzt2h_adc
driver, and directly selects POWER_SEQUENCING.

This new Kconfig select causes a recursive dependency when combined with
the in-flight power sequencing integration into the USB core:

	error: recursive dependency detected!
		symbol USB depends on POWER_SEQUENCING
		symbol POWER_SEQUENCING is selected by RZT2H_ADC
		symbol RZT2H_ADC depends on IIO
		symbol IIO is implied by HID_MCP2221
		symbol HID_MCP2221 depends on USB_HID
		symbol USB_HID depends on USB

Power sequencing is not needed for RZ/T2H and RZ/N2H, whereas RZ/V2H(P)
and RZ/V2N do need it. But it is not a strict build time requirement
for the driver. Change it to an optional depends on.

This also requires a change to the pwrseq stub functions so that the
pwrseq_{enable,disable}() calls in the driver still work without a
power sequencing descriptor with POWER_SEQUENCING=n.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1d6ed49041ab..7874d0e78e9e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1631,7 +1631,7 @@ config RZT2H_ADC
 	select IIO_ADC_HELPER
 	select IIO_BUFFER
 	select IIO_KFIFO_BUF
-	select POWER_SEQUENCING
+	depends on POWER_SEQUENCING if POWER_SEQUENCING
 	help
 	  Say yes here to build support for the ADC found in Renesas SoCs:
 	  - RZ/N2H
-- 
2.56.1.831.g720f3f5937-goog

