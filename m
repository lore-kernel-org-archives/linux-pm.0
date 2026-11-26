Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680722;
	b=nF4zpahmkVCcgWprF7TW2AYseJMXajklPvMXvMl9l8K+lWz1NbZHpYAq5ApZfYmfBptM
	 s6uxK9sr5Uzbynf7j4BEK6DO9Y0UQC63+5bY/R0EpcrEtufg2JMkDTsC13C1Q806QmjFP
	 TTilXGDu9qKcvLYNQYv4X70WfputFywozqHVFktR3Wkqhyn7Q+TZL7WKnavDRiF9Fm0Cp
	 0VbisprUZh0TnkKHgj8ZAcvwepZf2svyCRznlzn1YOxLcOY1OZ6cB8qdSQC8xhlMt5yf7
	 ueYA2KI13yRWGJ5ZWluc8nHKx0smMZ5kH18eOZVvBqR8PNHfMhg62S+hmk77dwwWDbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LIceXVfgUW/+K3E1yyCM/bErBx0QHF8gu29sHeG+Asc=;
	b=QwilEXne6Nd1AoNtRV5XcdIMXSfivD+pvkBPnXwFrx4n/GvFhYZVwL9RsDmi9reoMeyP
	 hDIP6CaB7XCimA1kSkmA3WSqydJQUdoypVdk8+5MqUjtD/ML0isJ6xir/t8HeZHYgOBk7
	 eH/4E4G1SSqCkgvONMBUa7X/qoCIHyu7YSq7dNi/J+ekDrkYGlgAXLIqHcIY2kX9q2Pv0
	 HICn62FAZ47Ftvu+tWq3CIuPYgf/7GLUvBiQJUEwLV1uJ4N0mmPhwCVfi8KEQzYbpLrye
	 oUVR++3sOUQbuyi7iIzb3jT0zrX/YrsWdTdp2PHkfqFiM9y/W4N36M/5U6+nKlHLN6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BbdbSX7w;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6395606A333
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 08:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6395606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BbdbSX7w
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso3273502a91.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 00:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795680721; x=1796285521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LIceXVfgUW/+K3E1yyCM/bErBx0QHF8gu29sHeG+Asc=;
        b=BbdbSX7wwOQQL4prnHw0pE68+2q09ukaAXLRXVlrVhcC2deoQ3y8C8Y1C7zm4PYR/A
         Mr9vkicwYcpS/g2rcx4VkXLPC7CDXJGmahGx+LbrO4BTgZv/G0tZrQfQCgH5eKjf5xN7
         GXqhP4Fn7Ay1WVekMz2wMJdONbsI3Mw7YLYPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795680721; x=1796285521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LIceXVfgUW/+K3E1yyCM/bErBx0QHF8gu29sHeG+Asc=;
        b=YatbaiVIDpQG6UO7pr1Ta23Tdmdd+fxaH6T9NaJzrOPpW0+88EUsjoDacoR0V7Oez3
         xWE16dQw//MHNvcxhD5cTXwY9izDp2Wlra3pZzhM6KNKjo/Y97fu6DFonrdmNAQ7N79F
         uYkl1M+wcehfV5bhKPyR19uUUhXIT/pH0eZwS92EmWjxD9kY1/OwBR39mCX0YMy/xLG2
         vc3RzDIRbKaRldu+VJdTcrS7D492ntGKH0vbiwjDR0A7VOeAsHAN63sFGN/5HjzyslZd
         Ta11FQXavjnprgpCPvCCF2hv05j8iBLw+6BU9NXvUHPEuquvbledOeVpUCtj0uOhkH6l
         +57w==
X-Forwarded-Encrypted: i=1; AL+hErH81XRXiz1Y9xDr9cCJbJALy6E4F2tbbpcY+F12CgX6nobpr90tcjBPrF3ek7LJ/JPH4EMgneljYQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/5Wt26oIMYCUCz4yF4wuX2A1xBcNyv6bYdgkUW1uYc0zFlFmD9
	CN9Ay4c3I03j4h2FrQaZKlLdAxUXXkoZYEsFptQk/42FVM5wBOjx3m64lVWU6CRKcA==
X-Gm-Gg: AZFdTZc1nM1j1VFzS1OtI6/XWYNpNVkmPrFdxtnn7/oZtME3tEQR2YCuMGzNHFGtR+P
	CGfWTFzgzXkgzpVJVMmkMcE193lL6ohtWfGsb/Kbrk7kUeoNqCklfZiWa+ossPYzhNDZgg5bBYD
	qfMInChIbujPyDrbaXt9+OO1X//TCTnFbs/apQ9neKs1pHoL3oPkoBuUHBvMR65ZV7dOlkTyz5E
	Sz1/u3C15sjaWFZvWedUoyVwgfAJ5DJZzxYvuANYr/RTxACoyhIWxVyGIfknNYEuF/H2ZgbXXY7
	3N5hrzh6XEplfqjF6qnLL9BaqLspgwACVSGD4vEALGCKO52o96mwQSQcjOqQLhgNTMX6k55AmS5
	omTON4oeo2CTjkf8jcGopfJy2nO72caXokSXV9VSWoCoc+8uuJ0YSxaoF0VAb8PuI0D+H6ylpuC
	EVXIkjoPjFDl5M9ct2AZ4g6KgCOzgwXzwTMAe9xAeafaZdqS6pTqAi6yjUmsHUoMMBK15G0PHhj
	NExWqprGAJKFkqBzse7uUtDjBsawFy+Z8FiWetFQOuHp7Ri7TfRsexUDclubt6W36OedHkCLalS
	07sIi96bnRVvPZNlP0gRqkS2bD8YFRMIA+YEaTu/ZHUMZms9iq3SNADczXl+
X-Received: by 2002:a17:90b:4a4f:b0:3a0:cca0:4a8c with SMTP id 98e67ed59e1d1-3b41c8e0c68mr13193599a91.7.1795680720910;
        Thu, 26 Nov 2026 00:12:00 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:418f:e7d0:882d:ceec])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b405ec698dsm34037852a91.14.2026.11.26.00.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 00:12:00 -0800 (PST)
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
Subject: [PATCH v2 0/2] iio: adc: rzt2h: Make POWER_SEQUENCING dependency optional
Date: Thu, 26 Nov 2026 16:11:52 +0800
Message-ID: <20261126081155.501493-1-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
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

Hi folks,

This is v2 of making the POWER_SEQUENCING dependency for RZT2H_ADC optional.

Changes since v1:
- Added blank lines before return statements in patch 1 (Bartosz)
- Collected Biju's Reviewed-by tag on patch 1
- Link to v1:
  https://lore.kernel.org/all/20261123113755.3033436-1-wenst@chromium.org/

Commit bdfc454e8567 ("iio: adc: rzt2h: Add support for RZ/V2H(P) SoC")
in the IIO tree added power sequencing support to the rzt2h_adc driver
and made rzt2h_adc select POWER_SEQUENCING. When combined with the
in-flight USB core power sequencing integration [1], this introduces a
recursive Kconfig dependency:

	error: recursive dependency detected!
		symbol USB depends on POWER_SEQUENCING
		symbol POWER_SEQUENCING is selected by RZT2H_ADC
		symbol RZT2H_ADC depends on IIO
		symbol IIO is implied by HID_MCP2221
		symbol HID_MCP2221 depends on USB_HID
		symbol USB_HID depends on USB

Since RZ/T2H and RZ/N2H do not use a power sequencer, rzt2h_adc does not
strictly require POWER_SEQUENCING at build time and can use an optional
dependency instead. However, rzt2h_adc calls pwrseq_{enable,disable}()
unconditionally in its runtime PM callbacks with adc->pwrseq == NULL on
RZ/T2H and RZ/N2H, whereas the !CONFIG_POWER_SEQUENCING stubs currently
return -ENOSYS even for a NULL descriptor.

Patch 1 aligns the pwrseq_{enable,disable}() stubs with the core
implementation so they act as no-ops (returning 0) when desc is NULL.

Patch 2 switches rzt2h_adc from selecting POWER_SEQUENCING to an
optional dependency on it.

Patch 2 relies on patch 1 at runtime when POWER_SEQUENCING=n on RZ/T2H
and RZ/N2H. On v1, Bartosz noted he would "prefer to pick up patch 1/2
and provide an immutable branch to the IIO subsystem".


Thanks
ChenYu

[1] https://lore.kernel.org/all/20260916075745.3549953-1-wenst@chromium.org/


Chen-Yu Tsai (2):
  power: sequencing: Allow desc=NULL in enable/disable stub functions
  iio: adc: rzt2h: depend on POWER_SEQUENCING instead of selecting it

 drivers/iio/adc/Kconfig         | 2 +-
 include/linux/pwrseq/consumer.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.56.1.839.g22a8290db9-goog

