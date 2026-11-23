Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795400910;
	b=nNcY03IutoQ6rIYrLdQMtM4MUQS2D0cPkXMFBU7LgRPmRth9C05gnSr627pZjpzgvrsk
	 pDSZCryJvmcsfkdanOqD9/vxuxGlDbIbSQDvhVVgngkUuwam2kPtPrELkR46i1BwjZzT2
	 y8wyUUqp4vZgWuoJ4VYiR07uQzbss4nM9gJttaByo3RhIMW8KVpFHGw8lieZ0xKvo5yj8
	 2YXMvJx56IMUy0JhdZPyI1PIqJxYqGXBbUgxafAv1OxpIx/bpLTenLwfvmYS5KHCWs7aU
	 kFCbRbQ8lQ2Bc47WgL0LDJkDXiMWKSdEcPYU7MuCY0jkD5ZTAz2bOocv1lVRBZZLb2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795400910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Sl/jKCVgSD32LaFfQfoKkqKt/VZL+Shvp0SZIGxaeZI=;
	b=G+lgKr8H1BenzEHpBGtq8n9rOnYWb4L88i6+x9T3RqFdILzBfAzsdCw+422TShhmYlfL
	 z9mFmj016I/JavSF3ZB3QTF3qQL6mLoKOpwWWbO5s8U68SqPMTxLDf8Rz2d8dPgx2sEoX
	 vGpp0Na/lHRv85pPwvp/ImfuD/WD0lq03uwJjvcZkoC5U5izhJBAaN6xxJlpmoA5BtIZa
	 xpQ+zZM3t4NSxvJ7g3h8sljgN5WNaWFFDGPXL0u5gsBStUxtmyq8cFzuGjv6T666bEvPr
	 LQy7FK7dxrSjTb8JnhF6RPhuwjSwnbBGRek/nopJXC9gm1imaGSvpjodv8YVqpnn8sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NkHnYc8C;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3AA606A31E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 02:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC3AA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NkHnYc8C
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3282db206d3so8532814eec.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 18:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795400909; x=1796005709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Sl/jKCVgSD32LaFfQfoKkqKt/VZL+Shvp0SZIGxaeZI=;
        b=NkHnYc8CUqkuAR+TowFEkpv+JMo/jYm6MgCrAZoVYCGYXO53FaBRVwKXld+eDVJeRh
         vLL0Z653Z5+lD2/NcaVgyOSfNpKOpIRvjjzBQrWGhcFa1duZGU9U535sv1R1y+zzGKIi
         zcy0ybik9BFKVf1MV26saHmIFZc0VHPkKlgycOWtPLl4siReomtZRs9fZsFEribO5+pw
         GWCeKBkkhotP3FWS0ccMerw6Zh4FloKAt0gThBZjJNSSvV/QFXIP6IhWl/wVQkKAe7V6
         IvARRdsnNavMzUg6uqgNfO+SJVLTjPq5viFqhze2tmMurHbsUOnBk5COvMeV1TB42DPo
         cUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795400909; x=1796005709;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sl/jKCVgSD32LaFfQfoKkqKt/VZL+Shvp0SZIGxaeZI=;
        b=GTMde9plJpGzFJ35gsPiNUaW8Ml+4zYYcMDIqax8Q/pf80t+sE7CXN0BL4sYffoXbz
         5CnoOSx5fPNTVVhpoOv8XA48j70VQwU0y4l4GlvS82Fw3PJHWK9uVhdwUpAW7C6sw/7G
         lgufmaKuReKAvTZS8ry7Eih0l+xbFfGCsMCRueKeEZKBtnEvnaidlO6JkQgi0l93UH2O
         L8hxmyJ948WiRTTlstzsRsr62hPCWTinCv74/QJ51cX41VTKUb704tIXLvsq7MBgLzZp
         Qjr73HQrU1i41nTWHdMhN2b2/NOJvjp75rK1BRkEY2bCxwoNFpgabDM1qJkYILN0Xjtw
         +2jQ==
X-Forwarded-Encrypted: i=1; AL+hErFVsMvrseDfD5a6U12mvSBhzBlvnGch2D7ylQEUsLhOUNdlGL3u8tvb40EwuloOdfyB7OooYULWFQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9GpadUm/2bKJObQseP8CuLxyvNsMjABXm6ldTjf3zm5plq1EQZ
	jK7tHkEks1dWmHDY4E9o8rKYyDvmrPsfO9wdeKJ3xqUnPkNh+5lbMaQO
X-Gm-Gg: AZFdTZdCue7qwSW6W24o+yHwnL3gBNLq5N2O0+0cC2CQmvNV6YFwfpYkSGj2thvlGpQ
	fvMpXZW7BlwNddvDsvS44ig3rRnhyOOvGvP1F5N/8pCW77wm1BSDrBIKD/pDIDxkLN03NDJDAcM
	3Q68dLVIs/Eebsb2VO8E8yZz69KTRIHZzfC0cRt/vcWFD+Cg5b5e72rJisJmlZYb4i/xN2sdN2W
	cbHzRYEgYlnNfH6ebXI6CRMG/CiqingQqO2ioisOCdOmqivAufHdl2ANZooJ36clzOSMn+ow5MD
	RyuPU9rFqREFz26VM12QIgeKHSx4OTVTJwml171hc0A1gd3QfkMQnsS92vJBoZL2y510FKO8wlP
	RntwViPOPu7FuG3UBMvhxWPG82IH3mcWm71zBdcjbnTcOUI6EOosq4LZDyNWQNHG8TNmOWIbUmW
	c7jzAu2YmWzzfxrVISO4jflQOVRX2OJNbws/fSUD1YdpHsNZpaf6KDWqj9kro4LX9zJ4waiSMwU
	dfnGsK7E6J/8KVZfSr1IOOCRMGKknMQ6U/89NHmvh/sf7m5rCoPby7YxrYtcQZHEGUd4ahoCSjp
	KHusqI+OfVZHKkMNDrlq7w9MDU4qrVIQFj5pqzvIx+xklvfwBqRg2VHy3JjXVJE6FZhQPWw=
X-Received: by 2002:a05:7301:d805:b0:385:ce95:2e14 with SMTP id 5a478bee46e88-385ce953221mr9510209eec.30.1795400908908;
        Sun, 22 Nov 2026 18:28:28 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm35337348eec.10.2026.11.22.18.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 18:28:28 -0800 (PST)
Date: Sun, 22 Nov 2026 18:28:25 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Geert Uytterhoeven <geert@kernel.org>
Cc: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, Lee Jones <lee@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, mfd@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 2/4] input: keyboard: Enable compile-testing for
 KEYBOARD_ASUS_TRANSFORMER_EC
Message-ID: <awOkxOB_owPvollr@google.com>
References: <cover.1795355432.git.geert+renesas@glider.be>
 <8b0c54dbf722168d9272a4bde9ed4618c19e8afb.1795355432.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b0c54dbf722168d9272a4bde9ed4618c19e8afb.1795355432.git.geert+renesas@glider.be>

On Sun, Nov 22, 2026 at 02:56:31PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> The Asus Transformer's Mobile Dock multimedia keys driver builds fine
> when MFD_ASUS_TRANSFORMER_EC is not enabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thank you.

-- 
Dmitry
