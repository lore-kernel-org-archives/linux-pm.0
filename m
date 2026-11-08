Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121490;
	b=J8LAdVcly4qUYkCPFO8vz0I+99VXZdMkw6+V76rQwc5ufrEcOMyRsNs9Vd+jKRhNRiCp
	 APjbAcnfzyD9p54z0qLgt1rAYnsfik1pO2vqHmcZxgyF4gt3ywwyZFVnRmP546mDuBrZD
	 oEPJbXPBiXFFLX04+a2//P3Y8tz8uBmpVjA9XKUy4SnyXJPf/oaUdqzNM9dkmnmiGb4/v
	 did+UjmJOCvIwjgVlNNilfkrhPeqyyMgQxtwBJVh0byrrvhMWvj5sAe4+WgH9ClM1RSzl
	 bSzRLeulC0TMo79CRuUa00H2ndiWo0Cd1y0NTz3gKJwYMQsZCy334BXj+y2h7tfoUVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121490;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=RZ8RxqpqPtXLtkqQ8uu7GqbITUoPwUdPcfQ3eLF9C0Y=;
	b=Zu8GJIiYd+uc9zbFbD3sk9xnEI+cm6AxLjnpgIJAK0jfvvu5ljB4twdz61qOD85hibRC
	 jYs/RF9qDw7uGHAw2kznq/VUkPixcyr6HNmQTmvMk+eLxJaM1YEVAT4idBmEcwAuTKNVM
	 KjQYUi9tSR9jqXvZqQwtoynRzpSSDTZs2pu74Pq0Sg6LGVQ6dMHh11JYdXb9bVDe6D2O8
	 cCvKSAbYgIqg+7wEsyuALnvH+iAQuGiAnybGAQdNUG/j8mNmhffcFQg6oTJOA5Z2zZkQj
	 ELwsarZqt3aAisp1x3ec7QxaHsz6SFh650wnYqHHj1ZhT5coOisSRCPoIpAVI7XUAoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=gF8gDtt2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FAoSMHWU;
	arc=none smtp.remote-ip=202.12.124.138
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E8A606A31C
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 07:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87E8A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=gF8gDtt2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FAoSMHWU
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 0391C1302AB9
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 02:04:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Sun, 08 Nov 2026 02:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794121479; x=
	1794128679; bh=RZ8RxqpqPtXLtkqQ8uu7GqbITUoPwUdPcfQ3eLF9C0Y=; b=g
	F8gDtt2AyXEhvH15cXZw4nuFgnFE0mqImQ8wb+iqj+zY8wqpwk5tk2jDM2KYNyJE
	1mtyH2plcTHjzGrOjDlgl/SScTv7N1zI3/hG3L9t7cm7+3S00oMWYqUx3PR8RCWY
	4oI0/daTpWGjp5zMjQAY7ljjAQP5yQ114GjlLIb5mTBzmAF0Inx9oReyD4rwd2bF
	0M9q48WCD0Qk9PjqBMkLbrDgwHL7C5AhtKx4+jVmGs25pXE1RleziDgR8wGkbH36
	cfPZi6PAE29txTcxojavPBzCzaS0/JAFKFyQfhuudcbLULAP5l63n/HLu+XDm2SL
	cWBiqjFN38cwwSAN2vI7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794121479; x=1794128679; bh=R
	Z8RxqpqPtXLtkqQ8uu7GqbITUoPwUdPcfQ3eLF9C0Y=; b=FAoSMHWUR7dujBsHi
	m4Isbj6w4hrzPH7ymtpDgqwYnUzC7/zBSWOXE74Ybn02TPSYBlP12KapR3iyJ1G1
	1zTGUv1E82/ybWYvxxI7evXnKbAoBgnaB/okKUxPPwugMQgdnlAF0OxpgCiZmBRr
	B1uk/Ef9fZBRG6KczWclzkidPQ08LPO0n1IeehHlJNVNwtxEw1CE2h3JzKf5TZhC
	lBBpomvaKujJTE9mVDMTE991KXF8gOt6UqqKLAZeMm3oFYwdR0E81zqazzIMX7Zg
	nngOb4it2J4yMYTfadVOVi5CzIS5PdRe069HiHGKRi2RWM1ytwqnbGq51zX2CfyL
	9Jf0g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121479; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:Q1Q6gcMF0c0071Qi5zqwMSCBvqQH7duRc5LiXcMxtHfHOF3
	LoEOqh6LZVwLvEigj/UvvUvYzwyG+cdkaZo8FPYgDout4JgFv/wAhSukB5cbe8Py
	SmasaWS1/65Jgbf6QMCeBkeTPWiJBD9lOfITsCyiHMvfvkaXktHjS9Je0A1rmy6H
	NbzVlppimEu32QHQJoEHN4yvnS0LmK9TW6waQ5ZizUndg9mXmMWNCrkkTSQDE8YX
	IuxARrfVGXWhspMQvrU6ArMnKs1q8pB2sqX/qdI5VmXjAvySBH569ojaIWGAURCA
	mrfbCzu0Wn8G5alDJJ7wcFa/051NXCQ9kYoxuvw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:PHwmtPat0dF7NtP1dql65wy0UbD0vgQGVZAO1EMeALc=:RZ8RxqpqPtXLtkqQ8uu7GqbITUoPwUdPcfQ3eLF9C0Y=;
X-ME-Sender: <xms:Bh_waoHjMjH9rdgZPk0naIHH5zeTHsUWQ1gWyJVmuhwYPJCAoP9fPQ>
    <xme:Bh_watxEjCcEudc_9uYX8_3kqYS2Oh_tesyPWyBCBckXDmzCjTvWPa1hZWd9xoF0V
    epto-mY6ySnVxnXoRT7_pLdNRiyPUlpK96ln3F8LttRUZU01PKCKOU>
X-ME-Received: <xmr:Bh_wapZERSoz7jRVeIhKQatR7AjjAs8u3Ug8ttonC2keB6f_3UOhOxwfnC3NLeKCJ3GIIaY5>
X-ME-Proxy-Cause: dmFkZTGFrF9gbXLYK57uxfZb1bQmjwR88m5VJ3LeQ7NQGYG1ObiBENpJjk+SxbTOoy2Z2O
    oKHwECRp3KS9jz7dDXznSf0ApUhoJsyilamEIdtEYTXT10k2VMjwh1zf0cCss0F0U7et5q
    L+zOCc3HzDw5Xb8dRMNNSgRoLf8s8gmdw0zdOLPrclPF3+buMgXTngk72aEbrLF22hnWgA
    VTZOp0VJBWYDhR/uABWc6oI0e0YlG+k3JEp3i4IsBNKCJV8sn1xzPbHcY5M/PywatYwjQk
    mSiyzFHruIdZcWT8k1yuaF/RAaV2sqpoWiKHEvJK1TBYApnym0EbdVB7c741b+jRJy/rXR
    0fs+ib2N9bpAbYdcCy3wdG/dDRPzcqwQtZLAnM0q2ppIj37havxdw0noBYd2aGjOG4hW0a
    NmO8w2kyv30tTZknQr2+k1TQFU8XbYfbSfZmI7mJkkHCl3fDmaNsdHh/9C3X0sGIR6tsDU
    2sqb/y4hRf+3sbrBB0Razqxoh0cdEQSielLoNE7Br7H5QxN4iWHrw51qoZ3KrFOqlkzJqs
    a6VH4Z/rwz4HrIJtdfEPIHz9d9+poSKTtO4KXQ0u9Bmz9arT6L/aJYCLzAXUb2OZUj2Ptq
    M5a8Mak4f1pKJKdoUb9gRX1dtVQZYyhvDn5hmMkwpskKLj0hnIoWw7g84CIw
X-ME-Proxy: <xmx:Bh_wagkUukZt1evp60Wz3mcD6K-idNfXMEjvvdSOwFTwPVqigPafPQ>
    <xmx:Bx_waukCauVj9Nl87oGoNoCkO5lYNY31knt6tLv6Ynj6RlZ20FiY3Q>
    <xmx:Bx_wajOKDADVAVEdTO5Cm2VXH9bY7wfICoVdhzRa0AAsnPqo3zopUA>
    <xmx:Bx_waoqeZr-C9HwljvpFikWi6oaTkLqKo6X0bPS2Iq13zebK7HqFLQ>
    <xmx:Bx_wavpwQCJEHa-6bvfZz0o1Q2FIVPD3mKDrJHWx4p1qI-cGpL9_EGyM>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:04:29 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v15 03/15] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Sun,  8 Nov 2026 20:04:08 +1300
Message-ID: <20261108070408.136140-2-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3654048.cLl3JjQhRp@diego>
References: <20261101082307.151957-4-gahing@gahingwoo.com> <3654048.cLl3JjQhRp@diego>
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

Hi Heiko,

On 3/15 you're right. With synchronize_irq() added, the original comment
already describes what happens, so v16 no longer changes it.

In 4/15 the code no longer uses pm_runtime_put_noidle(), so only the last
part of that comment changes to match.

I've shortened the commit messages of 3/15 and 1/15 in v16. 1/15 is
Igor's patch, so the change is marked in its tag block; Igor, say if you'd
rather keep your text.

On the power domains in 14/15: I tested each core with only its own power
domain. With both cores running the results are correct, so v16 uses one
power domain per core and drops the driver code that handled more than
one.

On the IOMMU clocks in 8/15: I tested different combinations. With only
aclk and iface the IOMMU reset fails, and without either one of the CBUF
clocks it does not work either. With all four clocks it works, and the
npu clock is not needed, so v16 lists four.

Thanks,
Jiaxing
