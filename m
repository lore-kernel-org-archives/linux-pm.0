Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794748827;
	b=4xYGvt81RhkOor1lgt8NQEGBO3kCsIzIxQEUtkrmsbYc/EOiTkBJt520yhg70Fx86TVL
	 BnB/mtbYWyGx426zG1EFfCNnSP5iWiVJJNLmvu6wOefIrfYp4PI9aPF+QVBGnKxCiC6rT
	 BOmS6ADLMFuWDy14phKmjrUvYcgBnDd/0MusoouUScYokV6xQsssDGuWOr83B+Gfddxl6
	 tS4fmVFka+ufmx480QvhAzhq8WM9UCnnKhytoYUswMxey63E2rYaQg5F5rqBt5mxamCrc
	 2SFfgWDzIIJPbTbFJXgMC0XJxXRwHmh7s1XTp7WyvmdYmsxsyCHwySgc4KmU+m5y8Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794748827;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/rYsyjftvDCPeS9SbbyhKVYUDY9LVQRgCngM6FVnSFQ=;
	b=XpZHKfXxk+1eKJ8PfYzndsgqcWm/c63FVrAiLHWeuEjzCEGMn8Z6hLBe1PFgI4qz9wlq
	 IU+O2tEjn6f7x/XM7DUtKcd6th0hgkAbVukVzAHCtsy7nm+nX1A0LTaEPKw0kyklNb7hc
	 jd87oqVadBRN0sihDOfT6n+iIZfmBviNq4DWRt+9AlR0RQBI+rJJLPmDsEsoG3vYv2u7c
	 7w9im0ZwOwWLJlQutZP/dNiYaXZkYat6EbIyNErHAdelluhCwJd8VlPJEUIpbAqey6Zdu
	 DIR6D7SD5sGxhYlnFZDJRNiWyFHbJsaTred3Kxbh9VEY2ZPrzTM3D5FZ6/5gJl578lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYyWL4GB;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C45606A31D
	for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 13:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8C45606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYyWL4GB
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so2822077c88.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 05:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794748826; x=1795353626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rYsyjftvDCPeS9SbbyhKVYUDY9LVQRgCngM6FVnSFQ=;
        b=zYyWL4GBuf0DsAdvhYGsk1HKtQ4dzGXDITV2wnSBhAUnJTmKOesAjxxSywEZ2hHpzq
         llR+jTI4Z1JZxjB9Zs0fQVKGcq7BQFZZHAXztEp/1F0X6UaDtEtWTPCGHc89IEy566yp
         KA62XuLoFmxtWbwk/nye62TtvNTJZWospqclUElyMRJjlHq5ON5zlaLp3WAxDHFfiefR
         xCc5jg/iosd6Uivwmng7ZT2W/KXXSPREMO6aEKpdQDmj6tLVYqjK0ys3pGi9AjM8db0U
         5fifSAbg1/WkWX0MF0Ed+a6jZRero+oWYiNrPY0Jdu0dBlXkIjwPEWAEbIcliiwPxzni
         Vp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794748826; x=1795353626;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/rYsyjftvDCPeS9SbbyhKVYUDY9LVQRgCngM6FVnSFQ=;
        b=KyQ77RKK0MHTh4K+ZLL0Gh/1rNxxcA7WFdNft+MLfI9DjFJ3hW4gt1vxAdpDP0ctpn
         fvMHv+D+yM+ItogiSgwsytQbeUgaLnt5wQU+wi85t4WT78XbT/7wEEN6zC9I3fMGJ6Mp
         ERrouyjJsaOUJ6+wLGHt4ksLq7bYqDgMUhyk8/AujFfpJruN/mGJ8lE8U6/nAdHqZMlT
         EisCeCqyfkLV9iQC+p7sN1asHUSjx534EO7unlUJfHCuxrSbakYyadVq2YRZNc44Xj+c
         /j6HjHQuWzTUF6BI0dOdymE47IKIJE6qrfSG8XfeOzF/YMVs0eD2WtQziVlsDhHb0Tuf
         RiDQ==
X-Forwarded-Encrypted: i=1; AL+hErHoARfGtA0Pvbn29zsgV3dStTLEgXI92kJ4pI4WBYTz+3IoQeiLZ92/gUenziIOc3e87BBe0onCDw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/TL+nUKIDkBcJGX8DaaplH+Lc9bP9zbDQTwITr4TNCAs7ONwbh
	JNI/k4q7kt2NdpXEqkco/h5+WbhGyJwdOnUMVAmqorWNpn90vE/GDm/7
X-Gm-Gg: AYBFou2XdXyyn8AwLikPXahIP5R/6rBtD8mR2GvwBinin1BsnCfcFoKsoLIs/tp/H0I
	lhjPzYoSDdep2Is2VMnhGih2TOXIdfMeSU2/8JsBcSmnpqtQGylH0ENZFNFSunIPOaRRitQWbSb
	KBVNZHZvYhkihVgoBj6Ofso2OCr2KLpcKMmXNotrnNxX062ksWO5rCUphrh9de+suQ9VxxjoVzH
	h/XxPsgeZ6fuRDeAF8fp3LjMhcdVaUSuSUxvEnSjpeWZXJMhXxATyMP+fq7hmLVRmVvKxTBFn8u
	SHqy5nVKi8EynFcPx05Vx03DX7tRWfiIlLKK3sIGO7Ct9co3b0LiZinI8C32yNF6EdaB3JV3xGF
	6gDrsypXifOQLW++/7LQrk7YTONT4jT3ieAWFiR4zlamw/AQ7kWfiVIgwe5Mm4Zj8CcGXp5ah+y
	N/R3s5nsIvtQDU5IYKIZGn0E2VLk39zxGi3YrRNMbL6nS7Qu81bLlBiEzq6gewGjihKvtdmboco
	xd6qvRkbbzYAQo9Cw8dDqHqE1ZfXA9uZLAgRFtC/fEpNcMAqP8WjW34xF4MSyoqG4lhS3CijMWH
	+NXblPxPYlOsLc+LqL3pUTmMf/v3Fs1cp18BNvWULF44pKeXuCtIDZssl2a3+eRV0dPy
X-Received: by 2002:a05:701a:c9c1:20b0:1ae:e7c4:9a15 with SMTP id a92af1059eb24-1b51828ef74mr4571335c88.3.1794748825692;
        Sun, 15 Nov 2026 05:20:25 -0800 (PST)
Received: from [192.168.35.213] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d3e37sm28084123eec.24.2026.11.15.05.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 05:20:25 -0800 (PST)
Message-ID: <9f85f4a5-ee4a-4c0e-b902-abea050bb204@gmail.com>
Date: Sun, 15 Nov 2026 22:20:20 +0900
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: chanwoo@kernel.org
Subject: Re: [PATCH v2 0/8] PM / devfreq: rockchip-dfi: cleanups
Content-Language: ko
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com
References: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/2026 5:32 AM, Sebastian Reichel wrote:
> This adds proper handling of the RK3588 clocks required for DDR memory
> monitoring, which involves adding them to the clock driver and the DT
> bindings first. The change is done in a backwards compatible way by
> marking them as CLK_IGNORE_UNUSED and using optional clock get in the
> DFI driver. The series also applies a few cleanups to the DFI driver
> while at it. This is done in preparation for RK3576 support, which
> will also come with some DFI specific clocks.
> 
> As everything is done backwards compatible, patches do not need to
> be merged together. So Heiko can take the Rockchip specific patches
> and Chanwoo Choi can take the DFI driver patches.
> 
> Changes in v2:
> - Link to v1: https://patch.msgid.link/20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com
> - DT binding: Do not specify maxItems in the generic part as it has a list
>   of items
> - DT binding: Only set minItems/maxItems for specific SoCs
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Nicolas Frattaroli (8):
>       dt-bindings: clock: rk3588: add PCLK_DDR_MON_CH clocks
>       dt-bindings: devfreq: event: rockchip,dfi: add clocks to rk3588
>       PM / devfreq: rockchip-dfi: move to per-variant const structs
>       PM / devfreq: rockchip-dfi: add NO_INTERRUPT perf capability
>       PM / devfreq: rockchip-dfi: use bulk clock APIs
>       clk: rockchip: rk3588: add PCLK_DDR_MON_CH gate branches
>       PM / devfreq: rockchip-dfi: make RK3588 use its clocks
>       arm64: dts: rockchip: add dfi clocks on RK3588
> 
>  .../bindings/devfreq/event/rockchip,dfi.yaml       |  70 +++++++--
>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |   4 +
>  drivers/clk/rockchip/clk-rk3588.c                  |   8 ++
>  drivers/devfreq/event/rockchip-dfi.c               | 160 ++++++++++++++-------
>  include/dt-bindings/clock/rockchip,rk3588-cru.h    |   4 +
>  5 files changed, 184 insertions(+), 62 deletions(-)
> ---
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> change-id: 20260917-rockchip-dfi-cleanup-feae6eefae9c
> 
> Best regards,
> --  
> Sebastian Reichel <sebastian.reichel@collabora.com>


When I tried to apply them, there is conflict on devfreq-next branch.
I'd like you to resend this series on based on devfreq-next and [PATCH v2 0/7] PM / devfreq: rockchip-dfi: RK3576 support.

-- 
Best Regards,
Chanwoo Choi
Principal Engineer, Samsung Electronics
