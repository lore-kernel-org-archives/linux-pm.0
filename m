Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794649516;
	b=b58IWCefT1ZIuEq1M0e4X2rEylfFRyxHiQgW5GtrpbBnLaDdemPtBwFHVaHTQZAPOhnB
	 7Y7dKW1qdtTH7hJc7NxShUE48L9C0hem+wkxsrQAhO7Ip/Y8DYjyg3H6IbAqgKGq2Zfyz
	 bBiW9kvzqkPc0VSICpnCglOEWt0Da0bgaxIyErRe3NDol2XiCUMYRRUCA9LB0aVKaT1Sy
	 zhc7rOLBhTk3wP4JmxkGTaUvgDMX3WuXuHTYih3C5j6PbL+Wv+8p+BT8Rrx6XPI0XfBFY
	 BRC+u4ETlV0PhPWxzp26/SC4AC4o2QmOA70zLvLQayZgGc3Emx38gVD+rsv4YkZQVnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794649516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=37e47cL8nK91UujMUai9IjESXvG2R6mAt8cHf2aHgUc=;
	b=4XpZ4KCvi+KAj2rhKTOWaqkgvSk/2wW9brig6/p1uc+V6pNG5uCblsyrM8DqBEsB9wzP
	 4v9XsGD8QPmI2Wg9qontzlGkgFlP4bCKTV3XEcZ+EP0rhonXLxilMgdTcp+AtS5rju9zQ
	 uNbEnEEvoAnOb17ukSzeTwsUuwJfPYsXL2x0ot6hDA4mFZLsa0kXCV1QlRVl4Gtkeo+W3
	 p56ZAcGyYAqMpEy/62gd6Povauz1wW7PK3o1/VFgp14n+rdl70IhfVNYkNEil5sKj9k0c
	 L8xCm31okwKForuULJsyjWOzs2uDA6pnPoU9Gnrf4lBvepfLN+1ZHSGTnn1DyYe5H1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F3hU3zVy;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3473606A32D
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 09:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3473606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F3hU3zVy
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso10559515e9.2
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 01:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794649514; x=1795254314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=37e47cL8nK91UujMUai9IjESXvG2R6mAt8cHf2aHgUc=;
        b=F3hU3zVyNcC+H+CmJ06ak6bPg38SHaqt0RdYZWvpTeDkcZ3evsgeSbmX3tYdIDTENR
         pNqCOrvqyIBnw49Cy9vBzNnMFGjKkVkGpvvtu+xrmmyi4/nKyJmiSDvpvGKzjOnN65zG
         M+NK1JOLclCliuCDw/6j3dnkQ1GRdZiN0hk1dM5TBSg+bqxy+SHDDWBBwSliFcSig+v3
         9yxpat0FUgG1ryVQ5Oi2Km3HpRRbaMiZTBgxASY0N2J22rmEJTSQ9WDoxZ5+5wW4iRug
         n7Q29sjNPJqK5kbn+YSavgQvOqbrlnKyKTOGrG6KIdjWdFuuBKKRonsB14GFJo1zMix0
         aH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794649514; x=1795254314;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37e47cL8nK91UujMUai9IjESXvG2R6mAt8cHf2aHgUc=;
        b=erp88Ctixf/No8jXKc9izDtNN1mmnpXSwPxDkwhpen5jyXnvvES/y6lJo18FX5+Ku5
         uhRuC7E5kgKsR+bLyUgoFHyWcqKZ/krn+/ddRvoGN3atZwQcrC66GKXY0K67ZOmM4IaA
         KuP3p03Xm2faK9EdkeknOpj9SbIjrIvvUNdm8RyCSvaYSXhHElhxguYUWs3xBLp97R/4
         XNKPXZZBthQX39EBmePFz1FAdnTePN0R8IHYF0eTGk9Mj6V8bOVfKmTJymRVQvCBaAqZ
         0NkzubOUMxxRcbVjbGBURIu9MHV9vrik/hPZZbvaVNFtOuLEIj0gYvYXNKN7CNU382zF
         rJ/g==
X-Forwarded-Encrypted: i=1; AL+hErFofyEnU4CIjr1jlXKe5YVVUBeHnoCWDJ9/MawQC32ry/q4pSFP9o+/YFTlWQkpeTL1pu1r6iL4eg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8CJamRtKxsSIFU+g/SV/6e64K0sTdYSaF/CsQqrMsnlKBbCB4F
	XLKmUsEWP7/PQUBea8XFT+aeQc8kSg/LxTxynEiLAUaqSz7rmM/qEYgu
X-Gm-Gg: AYBFou06qTsO0vF9ReAehwZP9peWDamHvleAnIbbTuFIFN9quEd2HhpHtTz+mGEQI25
	B5dXHd49GleV+JOsgiWoBeKpdBBrHiND/T9/L+WHw6XG4Y4odECoyc2SHX/KxrKdJcBjJg5POjx
	/Zflq/P5ZuW0+P0JKHKDEcUY3OvNrvX58caDg3LTfpdV3Yo2Ii0D08hmVZc1BxfGQjgejMm4c8x
	7ehUQi8mhfEKnyYukNq4a4mjz1s17jJAmezEN/xRCuUEFvmZ374gUSGtZgcr3CmQUqu49AXlW0W
	hS8X17SZVKfhE1elie0tvZ4hQ0FTRQyT8srzy4F7pUq1AZ02sHjXFk7fGLUe30jhvmTbzubVkmF
	kAE2XhJ7wwcf8s5nz0zDeDG6ADqmqZy/1wCwr0JgaVXz+dWh7DVUg5ZU+B6DI6RNFB/LrrscbPx
	VVY1A2pK6dNeuFSNOvhZUu+6IS9sDIbwA3Yae51ytQUYBkBTPV9m6vzps7cXlXK+V9fX7Gge2fu
	1cgg866+5Ofy2P9Vne/0EPh5uUf4IxQH84w6/WlW+1JAgeIsS5P8ids3jqv2aASiCDU3Je1pTCE
	RfXMt4IkRI86nMNQ1UJtHFUvonJcPe59/fms8VLnaoh3abN6yXAZm5opVIE+QHfUagek2R3hUlg
	=
X-Received: by 2002:a05:600c:4ecd:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4bb5599a73fmr120286225e9.0.1794649513834;
        Sat, 14 Nov 2026 01:45:13 -0800 (PST)
Received: from vlw-PC.. (static.18.103.245.188.clients.your-server.de. [188.245.103.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5faf05f8sm45787065e9.10.2026.11.14.01.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 01:45:12 -0800 (PST)
From: Vladimir Bely <vlwwwwww@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: ulf.hansson@oss.qualcomm.com,
	ulfh@kernel.org,
	heiko@sntech.de,
	finley.xiao@rock-chips.com,
	shawn.lin@rock-chips.com,
	sebastian.reichel@collabora.com,
	leonard@lausen.nl,
	abel.vesa@oss.qualcomm.com,
	tomeu@tomeuvizoso.net,
	linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v17 1/3] pmdomain: rockchip: switch off the subdomains of a regulator domain at probe
Date: Sat, 14 Nov 2026 12:45:00 +0300
Message-ID: <20261114094505.401228-1-vlwwwwww@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <733b921576828ca70a3f5048691400130f8a5dbc.1794615323.git.gahing@gahingwoo.com>
References: <cover.1794615323.git.gahing@gahingwoo.com> <733b921576828ca70a3f5048691400130f8a5dbc.1794615323.git.gahing@gahingwoo.com>
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

On Sat, Nov 14, 2026 at 04:04:59PM +1300, Jiaxing Hu wrote:
> Mark a regulator domain and every domain below it as off when it is
> added, and once the subtree is complete, switch it off from the leaves
> up. If a subdomain fails to switch off, leave its parents on and warn.

I tested this patch on the board I reported the hang on, a FriendlyElec
NanoPi R76S (RK3576), and it fixes it.

What I ran: Armbian's 7.3.4 edge kernel (armbian/build main, which
carries v14 of the RK3576 NPU series, so PD_NPU already needs a
regulator there) plus this patch as armbian/build#11366 carries it.
The code is the same as this 1/3 (I compared the diff). I did not
test 2/3 and 3/3 of v17.

DT: the R76S DT with the NPU disabled, i.e. no domain-supply on pd_npu,
which is the case that hung. No regulator_ignore_unused, no
regulator-always-on. Serial console attached, warm reboots, PMU read
from the regmap debugfs about 42 s after the kernel started, after
regulator_late_cleanup() has turned vdd_npu_s0 off.

Without the patch (Armbian 7.3.3, same DT): hung on 3 of 4 boots; on
the boots that survived, NPUTOP, NPU0 and NPU1 were still powered and
not idled while genpd listed them off.

With the patch: 11 of 11 boots, no hang. "vdd_npu_s0: disabling" is
in the log on every boot, and every boot reads

               without     with this patch
  0x110 req    0x000013e0  0x000013fe
  0x214 pwr    0x0000003e  0x000001fe

so the three subdomains are idled and off before the rail goes away.
(Bit 9 of 0x214 is clear because the GPU is in use on this board.)

With the NPU enabled on the same kernel, rocket probes both cores and
an LLM runs on them, with identical output on two runs.

Tested-by: Vladimir Bely <vlwwwwww@gmail.com>

Thanks for the quick fix,
Vladimir
