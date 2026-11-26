Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680731;
	b=UWKh5LRqntGkUiNnXOgvRHLLK+RTAbAtS139AG3xKG8zNp9Mo68SsSsN+WddlQd4WsAA
	 A78E2OkqK9E1BsLA+WWEp6Mv78dIjGOXtqC8b95uzGOYLd5tosJW+LPxHsb6MAuliRgTd
	 Y9LiMen2sHczs/MYKNjNX40ny1IiWqYetpQbfqMsqr88eTe6cQavAaWmIaqLDTqDRqCP/
	 wdLmeko62joj/ceytDhXzMvVr8N4Jj2OTi2XbWQERGlB9RGIDNP3Cre8rDDCqLWs3mmlG
	 HsGAMyhYuUsB9J7m9HMfDqPs12lEZBXaChhyLFtnIoOEytGyoxdbUyZlIrTVHJ2JZlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kdVRaDN/T7vzdcCEg4HnPSMiNJ7B8TDs5/yJohuuJeU=;
	b=tN1gqtX6lkzJvERjg2V9T4ZOVwOXoLIXd0rwqBjrKxkcxqJCAks9Je2QU7cYD3P/5J9o
	 Ty6h6HiZIu5XDUbERkRlwLu2Pe+tWu9hmL1AM4jMcz1DtMqFzfBvzwhOZXQArBwaffyiT
	 dvXR7S/AbdZRw4GCZU1RUk1kqWepxfYHuu6Pbh+k8Yg7/hBX62v/Ahu7n44P96KgNRTYJ
	 SnQktycsUBHrlE2JhDWs5hdyYONExIKYxuzm8ABZ1QxbI2yW25It725XEb+Na0uwMjddo
	 /MbvzSiD2w5EevRs0WzF3BIvP5sf8mZSpkiSQzE6VO9cmCyJ/05CmDncbnZcH4pVRng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dERc6wBt;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBE606A31C
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 08:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BBBE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dERc6wBt
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc751eddf25so4372416a12.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 00:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795680730; x=1796285530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kdVRaDN/T7vzdcCEg4HnPSMiNJ7B8TDs5/yJohuuJeU=;
        b=dERc6wBtCSnHzaDqt96zRmZ2vdHqF9+v0cSfmz5negKeazrLKeu+xbEzVSkLChR8Kb
         WhL9JcSes56BAz7atdGPm8u6ROTAAp6puz1OyS/d4Kj0uTtEjxvpumqeXcV1S9d7gi+t
         39pM5d2r3TB9TsjItygBA3Xj9jRtafYy08wdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795680730; x=1796285530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kdVRaDN/T7vzdcCEg4HnPSMiNJ7B8TDs5/yJohuuJeU=;
        b=eV8fLxJf2F3ZRGthRuE6BSy7XJPBZXKqrWj+pE8tW9E9AtK5xpYFsJ7A+9I94zQkjT
         zpb9alqsXzJr/mWe05SNR+/Gpuwr24MfQeb3st5aHMsBJndQPZ1tGGMIJ4Y/cnV0yz9E
         fRi/xIk03m9X2JejCe6Aa3gxfwct0tPZQL1xF3D+CP6k5mzeMmCrxXKVaY9csNeWnxyr
         PJNXhtj5Awr3OFG1Ra2FFUTmtRXxj/lVS0djFc7KSPW1nZWV6v7Y7+2/2LRrgFtPXRN3
         OvoWqINVlhaPMJRRbIeh2wKwBNzZSUQ8Z5wk7hNOW9ZP5sCKdOAyusvbJVvfT8Im/Wux
         r9NQ==
X-Forwarded-Encrypted: i=1; AL+hErGXSmYsJ5wcnJBSBCmDC984a8uJvb7UsdYgO88HP0Dm3HKgRn6YNHKAOSclsNAgjQTZ1RzjfvISUA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8QjgR3+X6RlLTssj5IvRfUYwLhMEJVYilHKgDtue47ysbvb9/0
	8N6Cm5ZhKNxRFpAVyuxegPpvND4NltkolLoZVGg8YMXRLX25bFKOi33y4Y/iM7HOzQ==
X-Gm-Gg: AZFdTZf1ysPCQAu08T0oaXWbxpfaV26pcd1OIdTtyHwiDabW01CLJZbIKHnXA4pDSMt
	INZ7UTiW/0a+XTXs1TYBM0peMvznSC6JmNBBhrMCu061y5BMdvxIXjWkjVfwcHcG2u1DeTFbPqk
	sl7zTYG3t+z7iknL6ytntxeu2tGzDg2YThLqAqkHtLBTfnRCG8tv/FzUJurvD0/BUtvAvqzocV6
	vUtHpOZcouKGUZMHeFS1igOeJZ/rvLdpUb6SvKiKTivsbsHqmrq6EwhdYP6/TR2sncvQllVFhan
	nekXKmAQQ845x5CtL5ZphMknL3sg8SVZwsxwaStO4MHlodM2oc3JgoE1ZZMfm+bups1mBmKgfLP
	4swlwhDXchx1iAG5yG2pbpu9lc2KdM897yN6kVzx+sRJbRpMp3aDBXcvxqU4kewI7ZCQPid0ccy
	i3Mpgi6cD1Tl8GwoH1a7TUX4A849XhYO/k62Fl8uD9TiTKX5n2UVVdjDaNxXhVH2i2MIbio2io5
	xMH0R2FhODvMSZD+YQ1V/PT5Iee7FTXvLbVHfV+HSg6shsckOA0UdBQRvmMj+jGUgGUKgKaAgjX
	Oacbrrpw+EiIzE+Df/1eQoMFMQs/FnWDvk53Ob47QnreFL9P268Sudf7Ux+j
X-Received: by 2002:a17:90b:498c:b0:3ab:be66:ddbe with SMTP id 98e67ed59e1d1-3b41c902f3emr18704680a91.28.1795680729913;
        Thu, 26 Nov 2026 00:12:09 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b44b7a8c64sm14084752a91.3.2026.11.26.00.12.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 00:12:09 -0800 (PST)
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
Subject: [PATCH v2 2/2] iio: adc: rzt2h: depend on POWER_SEQUENCING instead of selecting it
Date: Thu, 26 Nov 2026 16:11:54 +0800
Message-ID: <20261126081155.501493-3-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261126081155.501493-1-wenst@chromium.org>
References: <20261126081155.501493-1-wenst@chromium.org>
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
2.56.1.839.g22a8290db9-goog

