Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680726;
	b=iv3sRCGYhwzy6iipTZesyr2p67Azygmdn6JoDodf9t/I99knvpLR9QtDDoVKdevH0hK9
	 aRy0q9Xt/r+AMjv2oV2u0aonWze4gZQonwi0GSx+kR3N5jJy3EyUERQ+CiWqAUZS8dNz4
	 pQo5WxPMMxVrar6/N7Cr8OQgoLkJLE8cCMqhCjYkQQkcHKy06zVI+p+lEJwJUNGGHkuJF
	 DZM/VGlp5P1wT9oeXyMyo+ojCxdj6R+ZbjLj5bnbyHUmV0HraOjdF8uu6Gc1aVgEoiJWe
	 TThyEkSLciTZudjq710geK/5kNB54tYj7Glj8Ov1OlEasIdhbyHn6z3Md2qwhi+cFhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VJsy/GSRtmcR74bos01CYEf3wwJKYnv2p00XkER8pUA=;
	b=V0kTK0g9m27coM1C4SJpfJZ7PyOUXqmjz2v72JuOgoPJOJ1IcLm0iB8P9MZBppVusCiq
	 4vUbKb7zw1QetJyClhkwOyR9mCCAqVabp4S+d3m0fTR3A95Pr1xqkDMjj6heU8B0upaSn
	 /yhNIUE2rbXP5VXz5P+IA4K7u1MkoIqtlOdio+7of5Kzoxg9K9jEWvfYythIcOdupoQf8
	 30SbQ2gn+G6vhxeHZbJ41wHa/ua0pAGcNIhHBux1LKBhD9/Upq2y5PKyTKiArkN7+pU0u
	 nmMJSRWqQzm8PnPlwtiVCAgrUMwKJCtI7N6cfmn77Pq5H5K0wwLSWe4sv1yLI7+Gz2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=afNMj56i;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C61606A32D
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 08:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C61606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=afNMj56i
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b6b22be970so2672141b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 00:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795680725; x=1796285525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VJsy/GSRtmcR74bos01CYEf3wwJKYnv2p00XkER8pUA=;
        b=afNMj56idSUsA8/GA/AHUpfpy019tdDHMdLysmAmbyTWWrURWFDGPWMCvEgLuvEzAu
         2cNy/qGrKZj7x9oV4EKwSjgkLbIhCYpMY2/nkynFBAzrqDzXH5sUyTjax3FLn7U+Cyt1
         RkA7UNcS9jByW7XfK1M7oDDXG9IKgNYMvIT/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795680725; x=1796285525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VJsy/GSRtmcR74bos01CYEf3wwJKYnv2p00XkER8pUA=;
        b=N/FLGmQ/E9ytT8X4fN5eIaC9sHOIuMBx7nVn7M7Uj7kN2biHgUNu+8wiwlwtkcVz4R
         ZDSrdsRwOyoB7+CStpDdiUvfnOw+typtyBHEAAXIr504tZVugxbwE69j4ughfxf1cLwO
         0sMcEBLGIjL8cIVDIBsRra6PCWWfg66j4VPVeU1rlUEwHaJce96tuANyOsNZWsRc1L9w
         Gc00VN0IB/C0l3B6UAQuV2JHOUQMr4Heq8hpMEP7EbRHRZ67HbX+vJnfesHOL1mRv4a8
         qF7RRYSTjgrKSi/WZpFPQ4S/vvi8RWaaIn32Rr1bj0k0jBXJKlo63pNRhOh+QDs3fLKh
         xbBw==
X-Forwarded-Encrypted: i=1; AL+hErGUai3gQWsmS8227qjbTEyJ5WYWizYSwQPfjd4QeXQ824AxPM18hP6b+uZ9/jZlqs9mwf2UQbNt8w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+knKbOhrQrINAFB53r+vkJhCaxeqTEWN/RjKQFVoEB/2B6KWKe
	exYxXkpX7DyiG8hGTqeuGUzXA4A+DBl4Gktm+JvRjfue8tWfvhcxw7mA2kbEI+oF7w==
X-Gm-Gg: AZFdTZfMz3/5x0+kEnwIdO65yrXWnQ5jyUaJAokZfeRcT2J/leT9GeW9ilvQU+8HNAI
	BX0OdNat7Lm8lLv8iBT1gzHuu+vy0dRbg6PaVjXEV0gxhAgOiqDAq11HDN9PLMD6E0yM7eQh0uU
	MquGpsbRx9vMoo5EByHOcN2uExoKa1FvDmIlYCtXOpYf0PDQ78vwr9lAox5Djs705aFkfn1bQi0
	HMYFTJuC55qa9UhFGJF7+5mnrQgGr5mRlGSFQ0Lcg9yG0JqfO/inC17JX7P1SQBNAhK4t5GTHvj
	5iyK/BCAHe2ywxFoJ7zY0Q+yNMH/KffTzRGibCoPN7UNeVmyMULkvOlqTHM0Rs+AHbTwMzALDHT
	qUFRzh2FUu9ILHebYjN5DsgHKkCV6XXoI8bUnJUPGn32/cSBRWb7I5B84eHuQ3YbDpeiIeguPuh
	U5mW7UPx8rzlFe2S7UGOKO27Ak8zYM6A5ST1FgCdyynR47TpriTr7GJ9gBpj1rf73+OOxz/+syB
	V3rjZ/g4HyRkeJNQICsdmQhNZupzn45cObSVMRdAMfwtjpeTNDtwmpmc3zaRNrjqQ4WM4/v77Qk
	VlJComElmjtsghN0i5ZLTnAsG7DTsRgvBuk1+XfrMhFvbpAY6mWTBlwGy1RN
X-Received: by 2002:a05:6a21:8982:b0:3e2:4350:1528 with SMTP id adf61e73a8af0-4014a274c36mr19665217637.7.1795680725481;
        Thu, 26 Nov 2026 00:12:05 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-8cbe173453dsm7079649b3a.25.2026.11.26.00.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 00:12:05 -0800 (PST)
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 1/2] power: sequencing: Allow desc=NULL in enable/disable stub functions
Date: Thu, 26 Nov 2026 16:11:53 +0800
Message-ID: <20261126081155.501493-2-wenst@chromium.org>
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

The non-stub versions of pwrseq_{enable,disable}() are no-ops when
the descriptor is NULL; however the stub versions always return -ENOSYS.

This would require more code to deal with on the consumer side if the
power sequencer is only needed for a subset of the supported devices.
One such example is the rzt2h_adc driver. Only one of its two supported
hardware blocks requires a power sequencer. The driver could be built
without power sequencing support and the other supported hardware block
would still work (provided the Kconfig dependencies are changed).

Align the pwrseq_{enable,disable}() stub functions so that they also
return success on NULL descriptors, acting as no-ops like their non-stub
counterparts.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Added blank lines before return statements (Bartosz)
- Collected Biju's Reviewed-by tag
---
 include/linux/pwrseq/consumer.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index b69117ad3fa7..d3f5f37603d6 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -47,11 +47,17 @@ devm_pwrseq_get(struct device *dev, const char *target)
 
 static inline int pwrseq_enable(struct pwrseq_desc *desc)
 {
+	if (!desc)
+		return 0;
+
 	return -ENOSYS;
 }
 
 static inline int pwrseq_disable(struct pwrseq_desc *desc)
 {
+	if (!desc)
+		return 0;
+
 	return -ENOSYS;
 }
 
-- 
2.56.1.839.g22a8290db9-goog

