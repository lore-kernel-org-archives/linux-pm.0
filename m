Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795433892;
	b=nINnkXk/FdenmuKc0XYVCXuARe2SeAXzFN5kylmxXfUG2332qaMU1Lm3Op+lDTMbzIrF
	 e3Cdnn00NiSBBZfW1hqUvxd7LsqHg7QBdNXD/u54BG9jMb1qI7yZF5vQmN9y5Td0E0uIi
	 Q+ldC63FARDi8SId0eqrlWlVEGNsmjeAlvjnnCpjrqB9HJLzVz+PvDUQQWPzjlmBTd6ti
	 kZhSsmrCvdQXkLscfXAN0vPDKSiHzPE3ngmgfvnZjvLzDvMHL8NSCBXwFQhGMJz+vtqh6
	 5efWR/T+hmpTJAFqp0gdrEDvlvXGMfkWucRS16ZIKgzxBFqfdolzdwnJYVixUUoPftQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/uf72jF94qcU3idbI2020NJhdWUqwDd/ONaRN+2ot6c=;
	b=3ehmiJ/NitK5OcM2oTypn/92ADfv1p74B8Y4FGZYwFkQYwZplb4HmPU6KXs5qsBs7y7J
	 8Xf1vDUTjTSatlKNaj5mLQ612L/gtSb1OG3xbHXxwwZQHoRZ14x58jtop4k/1wbriKQUd
	 uDSr9V3iDjunhq5nTqu0QQsozexTWNCAXYsginb6RvY6AA+hIePZa46qGzczOe1MLGIHg
	 /a+uF5DiJtMp2Ufa2OrFOQjFcJ8GXSUYgX0EbXnmh6dRMC0ulEkJ7OzRw8LCiRu+3BGPG
	 4KOsqq07xD8nUzWt8r0sdGfbFSJYwEQamS6udyZ+/1FzXhBIHe/x9deVEc/nHRx1nSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ti3mIkkI;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35097606A327
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 11:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35097606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Ti3mIkkI
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc751eddf25so2196068a12.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 03:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795433891; x=1796038691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/uf72jF94qcU3idbI2020NJhdWUqwDd/ONaRN+2ot6c=;
        b=Ti3mIkkItoB1uzyh3L5WUUEz+MtHiX4+XGUoA2+v/RpWcSXi7L1Ty6bHeK6o3xuPxY
         F0Vj8jV9huA+/e/GdDSaQ0QFMvfDLlD5sLa9ctfzj4JZhFXCaI8qjWqF3ZbPtWmEjB+o
         ayR82fZrSNujQsZw7/zhxzwakgyVVhzzQVmc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795433891; x=1796038691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/uf72jF94qcU3idbI2020NJhdWUqwDd/ONaRN+2ot6c=;
        b=f93VmwOrmE6kihztMiCDMM3gitNANh1lwrzHOV4jKcDuc117K9J7HCwRyZFvXtUkzB
         zVUqlTqFOao+yxRffY0jAZrFOFDABP+HdtYxSB/4NiL9l0f4U/AGi6evux9A1v4GXTew
         O9e9ARq3Ad8PcNXHBHwSdfUHyy/DhplRTDPNRji/TwJVnY4DjBF7fUq1byheiREU8xdl
         wZAU4NjM9sPWmUEZbFQ/oWkLex6XRSkjINIBaFEbxHiZj2SPbXSRUN7T+oU8wh9uVhZ9
         ubvhJiOis/CgXBOwMzLTRHvfHgnpMH/7eheX7MFSaqtIB6NAkvTpWqPBZErbfCWdENRb
         0Nnw==
X-Forwarded-Encrypted: i=1; AL+hErFZ6yyQFV/HMVjSJ38wv77fCQonbznO019G+sl22InTRnyekBWpcylqshAFOpgMQdaSG3sgknkuCg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9iKjlpDaKhmvf36KKvabcsU9q/XGKCD9JMKbRFiFxRT34WvfDi
	3lu09256Ov2ML8IbtB+WC3X4VEMQKIaSxWCJSR3qqBsiO2fRzsit4aM3e9axBDZgEhzukWTkcjS
	x1b7DzA==
X-Gm-Gg: AZFdTZeW/I6fzlSin9VXURQBkEvu3Cey/V+N5ShLUJ5ER5Gmue9i+YutYXWejU88PIM
	2dMLkXujy6+S38gZYfNB6NUlpx+sYzEyF6ALTvCIM4a7gVLpzh3WtEXS470+EzJh/QCkS5YUYfX
	+gp2o9E0oMkgY/MdT/kNJSFYHt7vu1wSCa+qcF8jTTYL/Qh3u5Rk7f6dE2TZZTIW/Ta6afL1ryU
	vDdw52zbTDoqI+3pV8CZbu65WV3r/aV2AGFuxRDn7v7EDQfnIcgzmsV9QgWPkhQY+AVxdRzNy4j
	2jhukHSyk1xX7hW/ZHflEorgeU6nJpPFHguQG9nR+ZqIlLr0jbj0pjwi+/pX9RKhVMV2iXbIdDE
	jdC2L/HviuJrStczf+9nymzGcDF2UU/rvRrjKtPMbAfdoKmTgKxC4TXEx913FIJm1ktw7tmcj7B
	m0a0uRGul+7VkKrdA5OFZLLkSScNoHln+hWSyLGvFSKvPUCWvBHmzrmNEALOYEylGjvNhUPAvnI
	BwmYIn8pZy5+GNVoRw6SiCSQAIbMZU1VygtcSi16Nknz6EVTCiv4OUQkWmLbtVozHyLW2jJSnbz
	A55dSk9NYpfSWpNSw7kWBoXn6To6kKY0hIgK/84NG/Z904nc+Z12pEBOX0KT
X-Received: by 2002:a17:90b:5109:b0:3b4:aed:d423 with SMTP id 98e67ed59e1d1-3b41c95ce8amr10439138a91.57.1795433891643;
        Mon, 23 Nov 2026 03:38:11 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:ceb5:5e59:832f:d16b])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b41ad8ef99sm18165446a91.12.2026.11.23.03.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 03:38:11 -0800 (PST)
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
Subject: [PATCH 1/2] power: sequencing: Allow desc=NULL in enable/disable stub functions
Date: Mon, 23 Nov 2026 19:37:53 +0800
Message-ID: <20261123113755.3033436-2-wenst@chromium.org>
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

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 include/linux/pwrseq/consumer.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consumer.h
index d24b5af3e49b..5b3c61e963eb 100644
--- a/include/linux/pwrseq/consumer.h
+++ b/include/linux/pwrseq/consumer.h
@@ -54,11 +54,15 @@ devm_pwrseq_get(struct device *dev, const char *target)
 
 static inline int pwrseq_enable(struct pwrseq_desc *desc)
 {
+	if (!desc)
+		return 0;
 	return -ENOSYS;
 }
 
 static inline int pwrseq_disable(struct pwrseq_desc *desc)
 {
+	if (!desc)
+		return 0;
 	return -ENOSYS;
 }
 
-- 
2.56.1.831.g720f3f5937-goog

