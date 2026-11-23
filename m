Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433888;
	b=atfdGhcUfpfOVk6mFcj6FiuENf8UAm1lgmv/uS0jX4N/CS2ZgHdzPDVzUlJddFJw3jvj
	 7pG+3y8BXFZMI8pWrmDje8R1xHda8+qJc3w9pNKckh8ccd2gFpQ3hcd0s1tOSPQY2yMpo
	 9WvONji1gQFQ/gx+42B1UF1a0nTpoBPTQnepDT2xKFc9UfifyT4vq5rPTqiLZnT3h2e5X
	 HmMCKuZA2Q97h8vAu7q4mNsShuH/6Wdy8Naq1bt9UexyCyKh7TA/XCQSnT2ncf2bNEdQm
	 UtmOpV/47IEuBrwzzWmVwXPDpc5wowwNcvXwWEfTbCXvhY+YXd0Dn8xoz29EzNdcq0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433888;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Khejrep24yyzWEzO9hkzlnH2dbaJOCBXw2GKcHL6sSY=;
	b=xpzt30RqitwgjATuvDaEwRdRkCzT42OTC7b8YHy5r+OZbVAKDA5n4h2niCUrFurL24zC
	 GF1X4L0udZzAAGlkJ9p6ljCBwfRw6qnDAuy2lz/sPbUfBhIF61XG+unBwLjZLIuinYTyn
	 qxnrfbT35sKZwALCq/q893d6eazkGCH04t3nRFdtpkk38DRP45/ux3cInkgG8OW1scsRf
	 fpH99RtpG0wppFxPZw3HWD0FE6nxBtGmHQsMtvFJFfWngDzTa0X24VJnbrTj8WqEkBE6E
	 wyHAtc8fz4ncC7JYh1MTC2OE2VFBFj4uaJPORWCOjc4RgXxKlmJdnwhli1F8grQUZbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jbwLwmRe;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBD606A327
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 11:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3DBD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jbwLwmRe
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdd9d0c9bbdso1748826a12.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 03:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795433887; x=1796038687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Khejrep24yyzWEzO9hkzlnH2dbaJOCBXw2GKcHL6sSY=;
        b=jbwLwmReAKQaVzUeDss8ILk/irYQPtopTRHAEKOe0NAE1MqbTcPOn5e3Oumo6x/hs2
         Xg6czQO/GvobpeNaiQhKfpfd2fdafZIofzRqva571GhAf1MctcvfdDrAmDmsY+//qlui
         rlFPW3Q4x/V/wd2l3OApWrJ864LrtLJaL9wOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795433887; x=1796038687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Khejrep24yyzWEzO9hkzlnH2dbaJOCBXw2GKcHL6sSY=;
        b=FpuWb8wKVcMoEPtGOcjt2UIpS73yjWFk2Hj6q/TfUCqKyZKEqWN9iHRWAR2mk6Y1qz
         v9d5kFrDtbR016NGNU5UVBTDokGJMGn5f74Vs6faSqYt7rJU9Gyb8te7oifmls7FTVfX
         ptO0IVyY+KtL81yAGG23Qx+1IEy4bCkRwh8OrXuiE3dksPmXxWCzF1jCrll1B+NcRRm7
         4S+AC1medybuwOHaizF2ze4FT3XU4Idkguc6DD2EELB7lMftXt1KPYizUChmQ1ZeCkmd
         04eyH2GSXHkEH1wwgTED1dX++uA/W4xnZNuY5l8oP7hTAa+SExU19HWRMo51nhTUFBvG
         JRpw==
X-Forwarded-Encrypted: i=1; AL+hErEhmHIOjfa3nI475e0khBkfrjX70mhaIhGKwNQSJRbgXSNlhWMjd3PdlIGY6Fbm1NXZm7x+kB4Sag==@vger.kernel.org
X-Gm-Message-State: APuU4Z8MxueKP7FWmxdUwWssLgipWVjwmmpJcX7ztPI4sD/T7Mtcwmks
	gXtykJx+2ECW7wPHVjBx1sP+RdrZ0WKkQZTobEPZaRIflaPpMWGkaqGa9o2ogRJmng==
X-Gm-Gg: AZFdTZfdNU57sgu9nUFIcBp3HQdMQDYgTTyG305kobOOH4KL18Oy6qIf4K7bjkFP8b2
	XbxR02mGZtqSj6wg4PcZGvbt+kcmhZLx9rbzjCHQBEdEawEGRsD216f3ZT34nh2P9WxlRlSLotv
	l7pZOagzNFcfV2hhmDvpoHQDPIZNpPEx2ks3/yIqV99Zs+vSPIplyjjWyjcFQb3//L1vQidUVJg
	IWDcjY1Ov9FrERcdAkX7GLCBzIO+UqEwKn7529zcSk8O/S892dVBcDnIAgX2LKhfwGMwhiFHqm0
	Fg4cBAwmbcJDP1kK9zHVtHh1sHNrsrpKZApj+LQCEfQK6ipbDFG0HyOVJAQYuTshAIoyCyRsZHK
	QXJxe5VWXGz7KZMM+4XXwJsvJB0rfOATaxJkMwNjed5g3Sv+2u4EyKc+y5tja1ogbu21wWPHgeb
	9MQKZlTcU2yoFDuw4OcttzYdsUwtfM4k3cuTO3TOkh90q72vmfsE5UJKCHCwgE48U24FDhgL3n9
	u28fUWwiaBhUUk2U/TMVnXJeUw0qluvGZHcifvOyXzRsO+lj7GBWdQZTtgA69p4fRm9xlKb0nXK
	sMYxnKxc8iJRBYKd4APwiMr6QvP3EczC3Tmj5V/zeN+/jr4q3LpRtgD3XxqG
X-Received: by 2002:a17:90b:3a45:b0:3ad:ce24:acfa with SMTP id 98e67ed59e1d1-3b41c8fed61mr10151391a91.20.1795433887289;
        Mon, 23 Nov 2026 03:38:07 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:ceb5:5e59:832f:d16b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b405ffa98esm20358101a91.17.2026.11.23.03.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 03:38:06 -0800 (PST)
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
Subject: [PATCH 0/2] iio: adc: rzt2h: Make POWER_SEQUENCING dependency optional
Date: Mon, 23 Nov 2026 19:37:52 +0800
Message-ID: <20261123113755.3033436-1-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
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
and RZ/N2H, so both patches should ideally go in together via the IIO
tree with Bartosz's Acked-by, or via an immutable branch from the
pwrseq tree.


Thanks
ChenYu

P.S. This cover letter was drafted by LLM. I think it did an OK job.
The patches I wrote myself.

[1] https://lore.kernel.org/all/20260916075745.3549953-1-wenst@chromium.org/


Chen-Yu Tsai (2):
  power: sequencing: Allow desc=NULL in enable/disable stub functions
  iio: adc: rzt2h: depend on POWER_SEQUENCING instead of selecting it

 drivers/iio/adc/Kconfig         | 2 +-
 include/linux/pwrseq/consumer.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.56.1.831.g720f3f5937-goog

