Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576218;
	b=hvJq171t77ch1Ajz6IGzrBtG2zvAHZE/bwG1sW/+irKot3pu2NJc/kfgUqpEYKkFRoVF
	 KTtv2sWqTgxD+kHnSeQ0oCtD2H1bSkfu3xHO6kIVIhCg6bjK29WDeLuJ5bV0QUeuDpHdD
	 G0aPuvNhF+1LCAF042J+9f7xIti3E2aCiON8/dTUXHW30m496O2tuw1PGK6zf4h9I7+zZ
	 nBKltQ3UAsqIabtheLqPArqkdPTyfgDmywB3wkWUCIhnI2yA0l9gdCmTxVehdsW+GluAc
	 wGLdH/JG0rE0dZkBB7KW3xVfdbaU1odSq0agjbM11hlQ47QiA2zdTM932fRSKpPkSIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bPhouWL64Ss7xA+3PtWE37jW1mEzq4J5HXL5n/CanOg=;
	b=EktLRUFK3oBsX8NEK70CZ0vrpEXmPMNf8XTKl+j95EnYRx4xTP138xz4Eekbj9L8Z5G6
	 JI+7q2cxcehKNI4aYxfm9ZWRgzXa0wlk45lHOwKeuzsECYrSykKseE3lcKrmEEo0UCgN6
	 8ZPAx+kueE/qOk68eVfF6DcvKLiv2J2aOBnSnYgw/SwqI7umKryo0RiC/O07b1xQn0pf6
	 V6bMNu4ockRjLTsdZlrNep3pM9gy4/bivX2ZC2WdJG8fyWXhKx3RK3qsivDaqfGYogHBJ
	 p2JkQI78MZjONOY/QXqbiburt9tO6zW3w/chdQ4xC0KM4XvedyJDzFbFyf/5l4RIG/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gsx833mV;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02E606A8AF
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 13:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B02E606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gsx833mV
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so13695785e9.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 05:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794576217; x=1795181017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bPhouWL64Ss7xA+3PtWE37jW1mEzq4J5HXL5n/CanOg=;
        b=Gsx833mVHsC18NGzPWPM4Ukgyni+A4cjNY/b9YLRauqp+rhG7xq0PtIIF3bE3exkM6
         YOMRHU/uZG5LlQLSWMKDmE6wI95QsnP9uk+M2uFSPXMpW8Rmra6QhaWufL7xtKcO5QRt
         2bOUakzC6XSgEsZlgykAleWLqHdGdna94dSiqhvUk8jQYr/O+gidceODy5gAj7VvQXwH
         V7SEs6JU65QoZCQoPoX8h4AA+NXo6w1g0B+qs76eIzcc5o8YVSxenxtvypp3iEH3RRSN
         NgUJH7eHYYMS3yAePXFrb1WwEwuNTOjko4sW1qoB6WPO+1THGpU3dgZdVbeFPpJaST1/
         MK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794576217; x=1795181017;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bPhouWL64Ss7xA+3PtWE37jW1mEzq4J5HXL5n/CanOg=;
        b=1Vj2c1II4Pur03/qF45t6d4op+S/aJ7gkoQrwyNYpbcMllKlQt5xrCb4cgKw4dbExH
         4Zm48YVgFYnkPUaozGi8cD14uxG3KCswz+d0bW8E54PoXaLfsrtwFeVF8Hy9YXe7tfHC
         EI3UE8KDxvjY8S9lOuxp4MnjGrPKpJv+5SrOsnwoBpmbBCJfD17Ma604Iw3/L3YrMMhB
         oxmbYyb/ogBLd+3nXFfUo18qJzrdD5pFdcq6JGAO8FrZeLQRuUPQlqcOBBKdwTj2hDXL
         Y0tUip89ASiftLbbaWm2zeVNy9B73d3iNdaYTvBWjUE+ZbSqK31vQLVX/LlpafAzjd7n
         XKiw==
X-Forwarded-Encrypted: i=1; AL+hErHJ3zL4SfJxJ5DZ2K36FowsYcfYLfizK7IMJyO/UX3tK6TXE6hQSOQmhEeeh4fn7gdrBtp/2EOiXw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+d9F3lDa+Kg15Vb87CngpujP0IEm1vEoXNT34PE9+lyG4DB0rm
	eFft9c0VIylMUqwPcRC9emgtdqHlnocufsUfxSLBG9S+kQQmQS/dEgoI
X-Gm-Gg: AYBFou2uHCJogyi44LFsdlU11RozavDPd6I0UVP7xEr3ImdlE459dLNkhvh9ioq5XZV
	jtlCq6kDr3wJ2ixN2FbkJmxE+YlRs2ASGWzSTJ+8MyRngUGzOWu4YfRbGnltzU2d/vrTHfvXdL4
	y1EZej53H03yuGuVAUzfhwG7jl+24gYXnZkKHuxm7uXFS4KQdR9ziadOTT2y5jVwXCDg+mmQqMs
	sKLfIv/ijhf5HYx3UxTGAoYYq992YEpwDb/psHG25DD8RFywbsQ5gx0gGTISDN54g5rDzqEWWvc
	NcxOi3aBr9Vao5393IARs6MA/H7HD1L2F5Gthm0ewWLvo/RqpPzOUXgG98DOEh8i2IUOkr0YMpa
	wctxqwYtlyaDXGCSRqtUht4vkqO4N9WgsBmHTuERbMqqgOwLCI5OBtIcRAn47o5tpF/dDQQMqWG
	dssusUwEJ9e9pcGKoWQoL8Fm5Mnozz/7YSJwgs5YFxWVL6hxdqP4KdWfJJwleNdRpUV/jkIakSo
	VD1iPVTjOagGruuWTt7mvEjCfwxA3I3BbD3c19tsgEqqPsRfE7ZDoKN7epv7z+PNGu0huRwY5Q8
	w+Dz6CeP8nsyB6gZAr2GqjWE2/frzzz+7Nzm0L/oV73rhk6AaSWWdhFiQnYJIdSA1PbpB7oxPeY
	=
X-Received: by 2002:a05:600c:8010:b0:4a7:9025:5c3b with SMTP id 5b1f17b1804b1-4bb55a6a5f0mr53609575e9.19.1794576216701;
        Fri, 13 Nov 2026 05:23:36 -0800 (PST)
Received: from vlw-PC.. (static.18.103.245.188.clients.your-server.de. [188.245.103.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e284339sm136419825e9.5.2026.11.13.05.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 05:23:36 -0800 (PST)
From: Vladimir Bely <vlwwwwww@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: heiko@sntech.de,
	ulfh@kernel.org,
	finley.xiao@rock-chips.com,
	zhangqing@rock-chips.com,
	abel.vesa@oss.qualcomm.com,
	tomeu@tomeuvizoso.net,
	royalnet026@gmail.com,
	sebastian.reichel@collabora.com,
	shawn.lin@rock-chips.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 09/16] pmdomain: rockchip: add optional per-domain power-on settle delay
Date: Fri, 13 Nov 2026 16:23:22 +0300
Message-ID: <20261113132323.159015-1-vlwwwwww@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-10-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com> <20261108065917.135194-10-gahing@gahingwoo.com>
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

On Sun, Nov 08, 2026 at 07:59:10PM +1300, Jiaxing Hu wrote:
> The NPU power domain is switched off when the driver probes, so the first
> power-on goes through this wait even when the bootloader left the NPU on.

[...]

> +	[RK3576_PD_NPU]		= DOMAIN_RK3576_R("npu",  0x0, BIT(0),  BIT(0), 0,       0x0, 0,       0,       0,       0,    false),

Hi Jiaxing,

(reply to https://lore.kernel.org/all/20261108065917.135194-10-gahing@gahingwoo.com/ )

This probe-time power-off hangs a board that does not enable the NPU.
I hit it with v14 as Armbian carries it on 7.3.3; v16 has the same
DOMAIN_RK3576_R("npu", ...), so I expect the same there, but I have not
run v16.

Board: FriendlyElec NanoPi R76S. Its DTS has no domain-supply on pd_npu
and the NPU nodes stay disabled. vdd_npu_s0 is RK806 dcdc-reg2,
regulator-boot-on, no consumers.

On about every second boot the SoC hangs hard ~30 s after start: no
oops, no answer to SysRq over the serial console, only the watchdog
gets it out. The last console line is "vdd_npu_s0: disabling" from
regulator_late_cleanup(). The kernel without the series (7.2.8) does
not hang. 10 boots each, no hang, with any of:

  - regulator_ignore_unused
  - regulator-always-on on vdd_npu_s0 only
  - the NPU enabled as in your ROCK 4D patch (domain-supply and
    npu-supply on vdd_npu_s0, cores and MMUs okay)

PMU registers after boot (regmap debugfs of 27380000.power-management):

               NPU not enabled   NPU enabled as on ROCK 4D
  0x110 req    0x000013e0        0x000013fe
  0x128 idle   0x000313e0        0x000313fe
  0x214 pwr    0x0000003e        0x000001fe
  0x230 stat   0x003e4181        0x01fe4181

With the NPU not enabled, nputop/npu0/npu1 (bits 6..8 at 0x214) are
still powered and their idle requests (bits 1..4 at 0x110) are not set,
while pm_genpd_summary lists npu, nputop, npu0 and npu1 as off-0 from
early boot.

My reading: rockchip_pm_add_one_domain() powers the parent "npu" domain
off at probe because of need_regulator, but the children U-Boot left on
are neither idled nor powered off first, and genpd then treats them as
off, so nothing cleans them up. When vdd_npu_s0 is cut later, the bus
hangs on those NIUs. I have not dumped the PMU on a kernel without the
series and have not tested a kernel fix, so this is a report rather
than a diagnosis. Idling and powering off the children that are on
before the parent at probe, or skipping the probe power-off when there
is no domain-supply, look like possible directions.

This would hit every RK3576 board that does not enable the NPU, which
is most of them.

More detail: https://github.com/gahingwoo/linux-rk3576-npu/issues/4
I am happy to test patches on the R76S; it has a serial console.

Thanks,
Vladimir
