Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF9357CEA;
	Thu, 30 Jul 2026 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441816; cv=none; b=klDv7DdfRuR8PAq4imxdUzqdSMH16MH7bJuQgRa0smWUA5gk7E5MTexn3RIye7majvuVJrEpn87gtdqcjez+CM8iqNHYqmwM99n1FXOt17ZKLCT3sEwRTw8M/cwHFEeDSiB6xNdHPTefUHe0TxtNoX4B2zZRQnSedE1l12VKBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441816; c=relaxed/simple;
	bh=dLtz32A0i3ycOkl3rDtGNsShm5inYUtY92DizrMgpPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzIt2zbjIG9BD0MJaerl9HAPBbo25F54OBNNZKf4Vwza4KcyUughPuU7sZqG35feNFcdsB6og1uXWuGT6vPNWTcds9cBM+nBlKJ/dINg8Ln1RDmKQprHPomwqOr55xAzFZbsQHVRiSwYuUxgYo1iDADUy/F1pIl4eR2tk3sz7Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=IO4fdp3T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XJ0BX+Mc; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="IO4fdp3T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJ0BX+Mc"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 2036D13802F9;
	Thu, 30 Jul 2026 16:03:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 30 Jul 2026 16:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785441812; x=
	1785445412; bh=ME5rdnPgrhY0/be/K/GjmO32MBMw0cS1oPMnYYFOb4Y=; b=I
	O4fdp3T20fSQ9HJgSEliQBV9Z0sWMyuABmTt23FC9QxSbAShaKxIZ/FWt9XoMTHk
	1R1Qiu3GOPUT8rpoZuw+xVz6OSUSOjMxvYtO1W3mk09QwrT3+J3DbVolUAuX5Ql+
	0B8vs6YEwZQVXq3JjKC9eh+OADov0KteAHDcYW7tg/aDROK/6lK84fS+KQJRaxxs
	VGtmrIwcLPz2ZbixznSNDZ30oiFfczIsr/sP24i+1QPb+sW56/+VM6noK8cmT2hd
	p3emPsSmQdC7ClDUvNP+PrSLSCjn/cQuSCcF0Bu4lFM4GXFjB97vC5wy3Z4sjeZ/
	l4pc4Ys77Q5pDI4CeCNVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785441812; x=1785445412; bh=M
	E5rdnPgrhY0/be/K/GjmO32MBMw0cS1oPMnYYFOb4Y=; b=XJ0BX+Mcnf8MNElHP
	RMSXbFyOWeAt5n8YJai5xh2+L9GIjfccXFGqdT9jnZFBRenKzKPjkZJ1KVBQLnco
	L2ZcEy0zuYUkZyTAE+79iOREQW6udRMOO6Jqekl9GaklRi0k+u4TCbNOnduPjiuy
	bfqpjOTAajoNSamlszXvqiQqSbWLnskcwc414g9nE1tAp91rK29u+xreh+j0yRO4
	I27sf/ZTZcpcfv+qSOkx2/sLCQ3ZM0sHSD/13K6B/fwG2AY5U88No1sBbdJCx6mK
	Ba+jkXB5KIhbmUKs7xz36ql8P7aMnXvqsYwQiIV4YFodRGRuQii3h4vNCZ4qQM3n
	/aUBw==
X-ME-Sender: <xms:E65rajMFEgEAd4nmBVbnZhoNckmWD7iHEhHUTCIcN8iYieXIv9Spqg>
    <xme:E65rao4njDmDIWmQvEAkP49zezNvBk24xief7QDOzHxDpIBqQeWhQ-IyjTCcon07-
    4t-zUxl6CqD6Abf92M7qlwuLCdMdY3wgEoCpB4ArS5Mpk1-0OQHB0A>
X-ME-Received: <xmr:E65rahTiJhWcSS7q6ZKyLAyNSc5setBrfjKteiVlJudPldyD9kQOS_jC_kd9iyf6JGBTNVapnA>
X-ME-Proxy-Cause: dmFkZTFggSoutQfaJn5J9CXYs+2T9O+qUNzDoP/Df/4+w10qzQUI/6UdY9dbXZu+be1N0D
    BXT1DGshPjsUP/N2O2hDbe77McKEo1+0zJH5EYC5FuIrQq8sthsA/rsVI1TlYldF7Ps+ho
    3Y00mC4ieRhPOMbf2WXgI+rGRU52MmtEad50PuS+D8DX9QncdSZJfbPrVT+YlZE1iS9yrZ
    yPU2EdJzCQfXd2/wgFWxc6wPmdGOFq2eErPtNufJB45LyhtktoHBlw7g8iQnivyE6bYIgz
    xPUO7vmxzyU6IfV0C7vBMgrPdUFHftIVYsTeEPpMQsl6ElAcKfpxBFZC6Ro2fZfxxvwckb
    TtWKbZh7vl1UGhCDN1IOqDv4wihGtjeEtCeSKUo6xC3yaPwOv0A4ywMR+9qzlBoOeAwLre
    gHB1qskJAxy843d1o8rwZoFI2ZsJybBONXRKJugEczvQYcbSTw8nuyTmOxCYnlYPfiCCPL
    vK7NYoi0GFA8QkuSGMrhooDyEnCxxJ01nfbW8ImAnOjpw013FIQ/g2amcbXMghFlOWCEmr
    THLjU6JZ63nF8ddW3ATqGY9lfwSsQsSRH85UkbQ1wKXXT4oNpBG88kL37pf4RTokY2FyGE
    mvvAZQqwLOoO+ggBXV9SqXFxjxeYR9r6xIjyinRil6UvJfRfn+dCAgk6PVhg
X-ME-Proxy: <xmx:E65ratA-6rFYxNvUNTeUtpzS2HQakXgCMgxMR4gyYKCCFmklPbU8-w>
    <xmx:E65rapF6L2hGmY9RILxId8WkgId7M9-a7V8SVh7WIZFlo53Rvj0HzQ>
    <xmx:E65ravDjsE7u4PtFui26EeJ19wedhpYtrLW9InKSoduBzT1p3IQdlw>
    <xmx:E65rapWBD_enw6dXSNUrFCK_zero_doIaGaA5A_-7sY-u_1aaV0NgQ>
    <xmx:E65ramWLFgt3Sc3cXfWmLAPiqezl0lCLKpxrO2KA4bKH-ul_L8dEIMpv>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 16:03:29 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: heiko@sntech.de
Cc: tomeu@tomeuvizoso.net,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [RFC PATCH v2 2/8] pmdomain/rockchip: add optional per-domain power-on settle delay
Date: Thu, 30 Jul 2026 23:32:38 +1200
Message-ID: <20260730113239.1417912-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3322194.D8ZAKjAxdT@diego>
References: <20260718031146.3368811-3-gahing@gahingwoo.com> <3322194.D8ZAKjAxdT@diego>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Heiko,

Thanks for looking.

Understood on the naming. The suffixes describe the fields the macro
sets, so a variant that also carries a wakeup delay should say so. In v3
I will add

  DOMAIN_M_O_R_G_W(..., g_mask, delay, wakeup)

and leave DOMAIN_M_O_R_G with its current signature, with DOMAIN_RK3576
switched over to the _W form. That also keeps the diff off the macro
every other SoC goes through, which is nicer than what I sent.

One note while I am there: DOMAIN_RK3576 is DOMAIN_M_O_R_G's only
in-tree user, so after this the plain form has no callers left. I will
keep it as you asked; say the word if you would rather it just gained
the parameter after all.

I will also drop the stray whitespace hunk that crept into this patch,
an unrelated blank line removal in rockchip_do_pmu_set_power_domain().

v3 is not out yet. The RK3576 inference bug is still open and I would
rather not respin the series twice, but this is on the list for it.

Thanks,
Jiaxing
