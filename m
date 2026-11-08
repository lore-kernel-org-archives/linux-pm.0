Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121466;
	b=eX1FWvFthElT5BSBXPqhRY0TVSZhQTH5uwcWqY2j6YL73v53RaqwZkXkGNwXzsFz77nB
	 XdGa3wk7aEX319jfFPmuso+UphAqXKfow582eXW8qvpyM42/liihda9PK7RJxFnAzqELL
	 GG7PFe1jHfx9xoaKiKS1CSyofVVfbxWoTXKwHPQl6hQw1btbEKmSj8TlyT30XabvKy84M
	 sBhy8aSoIKB+mMMcT0XlWfS1fLJfGcsR3Ettn+yZKm1qvZD0hNO0wAdl4sUT8oDTYBOCw
	 pNrhgDOevv8VOn4k3LLOyjENpmSAtS596zCmtZDdl30EbBwO32LwP9Ldtzugtg73FUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121466;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=7r/PwOZ5Pf0uzaRyPIbMznuBoyLrmINqOVvG3RmngNc=;
	b=B9vayfXS5dYjYHQiXxqUAs6sy0g1nVurkLVdcz9HiChdTFn4IepSbFiNA4p81C0sJL0o
	 4PeW8ZrvGFZu2zUJN+zYyxMaVmJaNEq6bMqbnb6waYjONHwuFksWk/9P1k6gnIZnQH+FJ
	 Us0iEOnZPN6rztdKsMm5fAxoUUxID/K6EXPvWJoOXSO5c71zDRjGIT6nn73LIXDhnLWss
	 hNuTqAIV8aZs3St+Or4tS3P1FOUN52c7RWtsd+bozwqs71mpbKYOojJHeuIQmWu6JUld+
	 TyHkIOwW27oFckWxYumfymXoidMaSiddfF0seAt1KpGCKrz+1+qzVJK0OT+B9WnSPDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=T+KaQRey;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OuEGEdxz;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E2E606A31C
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 07:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71E2E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=T+KaQRey;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OuEGEdxz
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F3EB91D00193
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 02:04:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 08 Nov 2026 02:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794121461; x=
	1794207861; bh=7r/PwOZ5Pf0uzaRyPIbMznuBoyLrmINqOVvG3RmngNc=; b=T
	+KaQReyzzYjQP+htiwkooZQkJGrs577QZLRdMoRxTb+DcDeDAQyOha7ddizh/Veb
	nAmkabD72MCShBF06r+tRjaIP35YPO+ADbPs78VUNXwzn6kQFZyF4M2BJRqS0y+T
	aRg8miEv/OuOaxlLplsPmhhGokaaZe4La4T2ZHZR2HUoypV5+Uq/6hYAtkZ0ha7v
	/KKRcE+yEXcllrf9EVBZHV+HLUz9kDiUtVLqRDMq4uiCNYD6PBLPDvOwhctU6UwY
	PoMqJeUcS6ScafTA5dhpq5acuk/CqfCbEHZ9aRRuvhnxSe3S95oS9Q3vYYhV3E2Y
	2ZDMPpIdw40/4P+ZKrvbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794121461; x=1794207861; bh=7
	r/PwOZ5Pf0uzaRyPIbMznuBoyLrmINqOVvG3RmngNc=; b=OuEGEdxz7eqYtKpNX
	ftMIXlrX7x+RiQfYy/YLuT+RowWErgdXrXfuBKygIBE4wBJqjhdeWu/6a5mE2JuV
	IrmEHIGQT1zOtNUdk7hse1e/m9wbH4EicwCcHzGYre+rX7A5GMHK8nBM9uUs1neS
	CSGVLXP5wRKK2wd/lgcuxGFbFMn9DridOhCkgCj0qa5cCwCm3Nj3Ed/AeLz7HbC/
	ft84m9sMja8wi7iatlF9EjURYU7roMvTgrQW8L7rbLdHq8x8h3x8x/lYsFX/xYmb
	OHcgfz98naA7LoYY82mSPN55mJKXrGBSTvbLHCigGVUefQW73Nb+PwYsuTaRPMYY
	Rh8OA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121461; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:mxM5MdrYbwieAzDWtAX/TSfM82BY79GEtVE6i/5PjBK7Bi7
	BA0i+mXFT2vXw/iLkeNUxy3BBUAssevmQs88F/bFiytlfZ2+9zyBVhWgqguzuQUV
	i4E2W57QkyRYAJ2Pkxw+47Y0QJqmREMevsdVjsronyTA1sSDifZYc7nN+gISDtrS
	gobtKY2SDjFf8VPuULEGDQJiZeL3uPj0Vv6xlni/JZ3HS2393xO0Wx0Df5bll0rR
	b6H+BgMtZhJZabqcn+/bJcMF+8ZkJmt//Wv6iAGhjAkc2O5Il29O3/8HXxnIMtHJ
	HrFfLSL0gveoOhWqtjdXJ3BdPv1IqLGIOrwk1mg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:46820ibfAwLP77XC8IoBo57A2NjGRQHXMONE8H3p7t0=:7r/PwOZ5Pf0uzaRyPIbMznuBoyLrmINqOVvG3RmngNc=;
X-ME-Sender: <xms:9R7warW_aBtQ5oYDsl2yhWV2q1ejLybMi0tLip9KiqZiMYZ7mTi2aw>
    <xme:9R7wagC_QVxIq8l__Ko7l3mlmB8_9Dq5YNBylvtejLGzsTLzWDlNwd4ufpmfN1j5U
    OWUEvaecBDJmgrtqCM-392f563SDcnApH_ckPvADVfNxdBx1ojaXX73>
X-ME-Received: <xmr:9R7wauqddniTRJCVJSKORveiw2lcpQ-DPZ4yq4uWlpgm9oIeWkdP0aRj3_rCAmA0syx5-N3Y>
X-ME-Proxy-Cause: dmFkZTE5NwZyd+ayTW5ihGeNQbl/O97mnCf1OvUw/2ZR6E1IltWJneehUG6lk211J8bNJD
    GXJcI3YZAXRTrSK5sFTlbLrxzALRC4/6lE7XOctvroRrxMX83re1MlqThq6OcFmRxLDIeg
    dPCIoY08hWRgpTEOmeQAgr6Hi8Hlw66W3366qbyMNTuQvlUyucz9MwwrNSeHDrR4V+rZ6p
    c0CmZtStyiRIxl7LZ2wOt1R6dxPekaPzd2JrKFAURgPeOZIDlHjlK5E6ILvTQRx5g4acrU
    benuNqZX04E55T+WlvMPFZHgoTh9KI7gGDaRJvvN55diSFD3RWkTgRJnSKwwWUx3YOF8MI
    mlM0Mb+S9sikxkM1SmWMu3AfV8neUwrN68FrnpcyLg57ZRbIw4o8oG7BB0Z+PPItlW/ccF
    vIDCMadNqOG6FICc7JJRJiMAG7l2eKFEOo1XlnflshFhIYIhktbQjch7rjC+vf2Tdu2je6
    VEcLBP0K1Jt5/E0s8Fmnvi0AaDr/ur2TS/niWGFXS0vEMh5D7Om9r0fhBqnjaXiBaozDgX
    nwH9XUOajxrr5cBXE6ek49oaVbh4DhRJLDF+4QmtbrzdSHo1kPyNxL6LDeVxtOc0NfwcSc
    QVOaXlt6mULoT9aAb9zV2snHJaxDlOdnC7Af8oAu/mgzzbYvOWsNq3rEsY4g
X-ME-Proxy: <xmx:9R7was2Ubhmtujr67kHdoFipgpbNea6X9kMZKS_pGBV8Rm-dfnFM1g>
    <xmx:9R7wal3upHR_4krVWQP7LKCYdVLmc7TsvWyX2nBSxaDfEDWyHvFSYQ>
    <xmx:9R7wapcCnZI-NIHe9WFcUu_NwfquyqfF4vlHZy4uY4h_YWXp3M1gSA>
    <xmx:9R7wah65Q6cYlvkVBmXXCuv67ZuqMYxTBhwhR4kP8qZRF8fhcgLxTw>
    <xmx:9R7wajVhC7wEjjn-KXdFosYgeezmVww20KXxwvQhRmgJadL3CXAW0MMQ>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:04:11 -0500 (EST)
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
Date: Sun,  8 Nov 2026 20:04:07 +1300
Message-ID: <20261108070408.136140-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104125529.3229301-1-tomeu@tomeuvizoso.net>
References: <20261101082307.151957-4-gahing@gahingwoo.com> <20261104125529.3229301-1-tomeu@tomeuvizoso.net>
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

Hi Tomeu,

The cover letter, commit messages and most of the code comments I sent
were written by an LLM. That's my fault and I take responsibility for it.

For v16, which I'm sending with this mail, I've rewritten the cover
letter, commit messages and comments of the accel/rocket patches myself:
I write them in Chinese first and use an LLM to translate them into
English. I've also removed the long comments the series added. I've read
coding-assistants.rst and generated-content.rst.

On GET_PARAM: I agree to add it. v16 adds it as 13/16, returning a
hardware version enum that matches the NPU DT compatibles. Would it be
fine to start the enum at 1, with RK3588 = 1 and RK3576 = 2, and leave 0
unused?

Thanks,
Jiaxing
