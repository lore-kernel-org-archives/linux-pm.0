Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793786984;
	b=gJ6ZbQxp2bR9opCZMXFfWnUECB37+zvPTeAxltoygTEY5Yg94K94Pm7hdBHvJ8dJvHp7
	 UC02kQvlwrjIN1y49yRpCQ3TU5s6YTEi0S7YE85L9ZxlaZnSEOq8evDUqKugtapFVb/4+
	 yORs3P1QgmmJIPyqZwOrCAf5CPaSEwSBqRcsm2aHqm2qS6NBb71PQQ0KmoP6wYnGlUCCI
	 1ikfAG4D82pDwhvHfchB6efC0eYHKQW7045THuBAFyXhvVg1srqJTCtVpA3gvtFLbiX/j
	 CXUWH35obWsbkNS7fn+j5ofpomZc1vZjsn3WpJWj9nQGqdMe4Unvrhfbzr3uGOqnz1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GRB1e0g/RzNosgVh22Q4nbJS5JXGJ4/s7oJ6tqlGbYg=;
	b=BiuCdSOs7QVIWkXmKlT44ZBqXz9BuLuljUya1x34h/uxh6hqa6JOn5dIVfNlFXBPJVz4
	 8sd9zELOUp8DSnc3JD6EDExfXrF8ycM5xW/3kAWLEn7UaR3vt3NlW23jz6Hg9nyZcRTL0
	 wqmspO226Wmuo6u4junsAtxx4PEJaBVN3NMyZYfAdlIE5gVY7w58c4FOecfoNynRF1bTi
	 6l0WCtol/YK6iEifnYuLaH5MbH+KMGccqMIcab173D9GWNC8pdm3txbcFOZWn1jH9spUg
	 8cu5c4v2EDwj2DMorllmaEihFt8RShQ5ok7xvXjlVYBwVkh5uSCnnDojM1uYaMR7Omg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=tomeuvizoso.net;
	spf=pass smtp.mailfrom=tomeuvizoso.net;
	dkim=pass header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UcHCwjZk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CB6606A31B
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 10:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45CB6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tomeuvizoso-net.20260707.gappssmtp.com header.i=@tomeuvizoso-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UcHCwjZk
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f2049ea7aso41810585a.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 02:09:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793786977; cv=none;
        d=google.com; s=arc-20260327;
        b=cE+buhiJyEWoegOdq3f5+a7hCKeBqbr9AXFahcA7G7PfUC2R638mSiaq4NKppvOta0
         4bpUdp9H06Lbd+kJgpCa8W7lpY/bZLC7xvcZucTihXhGQ53gbBq/1gnv9Idv8xmi9wRR
         yyrIDL9zCrbASiLzH2clSl7Hq/9g/whz3LSi8va9LrpCIuAw7GPha2lHx1L4W7p2OHeF
         ZFGPB3kUlX6wVOx24iK/rIMv/6E/JYn+96C41areIP+MlID8SP+kYkoB6urtBmtjZSvH
         FJh+wrWNXe+2e8wPss5GzA1RpEW50EtVRKe/G4uXi4ok9VjXEqBLdLHWivxZDnOVNysn
         ylNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GRB1e0g/RzNosgVh22Q4nbJS5JXGJ4/s7oJ6tqlGbYg=;
        fh=c40ASOSDMV2MshRCyT+WN3Wwe5h4m8y+cu0jmqCFM9Q=;
        b=UqIYMBiR4tA3GNMh6nqT62mzeQIUbKSTL4ANUuL1yYU0K7LqHYkw2XFnAacNknhOGe
         QlU0VXYifVKAJ0LwQtbt2mn1JxauRaLuRuqzV2mksYHqzdS6vmQ8Lx89hQQnTWWLVN6+
         Xk2fMd6ensvt+/A4xj2nq67J6G1Dtklzcm8TOQo3UvL2PKqFP7MltmebOP1W7AzW12CS
         gxAEmD70gP7/wLOHzT3z9c+s5xqWc3Jx1h4xMZgtFRFrfXfI0MAk3t60wEagXBKBsd6w
         RQ17DX3xcEs8deTll0eJSaDdjETbO4lBoZYkVi/zxXxCjMnK/P2XUBWkZymD8B7rmYL/
         kURw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20260707.gappssmtp.com; s=20260707; t=1793786977; x=1794391777; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GRB1e0g/RzNosgVh22Q4nbJS5JXGJ4/s7oJ6tqlGbYg=;
        b=UcHCwjZkxJdU7FrRZcBt1CxKGPzG2AJoKdOEXy6bT0/6tI1dlsBE9UxkNQCTTl9iFg
         CzZsbKtm2Zhe8y6Iek5l+jWdVirGy65os5o0NtAw6vLC1uBwHyEz4DFZmAz9vXWKRjFA
         FyJ0geUDEQnCktWcgRKGpHC5iCBkdyErjWGE7xcafrhlinEyZSdvmGyMbMt14g/ishMR
         7aP+AcCLRYYxfJUen7AxTSj5XlIcIcy2Y4Oy1G37/F5M2NJirI03RNV9XL6KI1+WF1dP
         e/vZncP8FzVcOBM8lQiXqWisOGl+f+l9GXvsQbpEn30kZ99OtKtdpyJju075XZ2QyLUF
         sKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793786977; x=1794391777;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GRB1e0g/RzNosgVh22Q4nbJS5JXGJ4/s7oJ6tqlGbYg=;
        b=tEBWaSxSI29iT8naP+d5fSXP2C2Z+h1vaPLhN68V4Qey0G28HV+IDjyhX2ze2uzvtO
         yNRbtmaATOH1D5jsC0juRvBiyw3wfmppEvhh/CrQ0ZOmH5MdzFQiD8kmcG2/UbJNkC1o
         cF5lto91KV6Kp3lPQlVXhvd4rlIuP8lr7pF0l/qPfJ1Tp8RVtxFRS+xYVuSXwdyh2W9S
         5tC+TyVSSGR4b8eQGOpRyea5fulBi9tqAOYak6Onfjonvyxl7fJoUdhftBPlkB8Jqsoc
         UagEQrI/LbWN8eIO3DAFxQRQifU+vRasKHpOPGMcoFaiPlRYIeN6ardGjY15rbHcg6lS
         6zqQ==
X-Forwarded-Encrypted: i=1; AKwUvBygJEQYMvY8T795n1bJ3G84sEWd2tLGUPf3dmFinycWtjO+VEu01+nWcJPGL6ko6l/3IlHF0u045Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/8s7IhXWWPhHjrzMf56IVAMzOUfMfa+2sYbJtzNk3Rqa/MqH6b
	eS9GFRq1m7TUnMzGwXRI74+UL4TdIC5ymqhEV3jyf4WRQA/I0r0n0b5jLZpmY3axPcALYX11Jqw
	0Rp1kvCSGbkYdiS2Ky9kIcpnwAPj9dtvBJY/gdRKmZQ==
X-Gm-Gg: AYBFou189AJc0xgKLNCf1vjzB3KLjo6/uoc7qwTBLP+GkYJvFvMT+GBfySunivCx09/
	nRHB6TdBPzT+FuOjEcwQ8oS8XVpx9fHKZJDyPma9w2TwGVM2iDkUUTKbjYbaLwrkwZiMD4xbiTf
	ch+PH5jz1Kdb+32ZzzBuNFWAqU/rgah92rlZdbObQwawzFyJ1fOEFF5YE367Gc1TzW+ZSXYvetA
	7lgjP73LSAy4C7vc5irQXCp1pOQviOBZZ2QTrpbMcI+hB/iI+XrrIo8Lr59eMh2d12sv74cHMLT
	ZtvA4tjo3J9G0CBy3DtSPQnmVVsn2AMjsuP0CH+J08HaozPMLK9pDujTqqa7NEk2ELHvggr0D6m
	ghMSPaH/+NG47aprJHpKTAa3fdYqPNkCi9zyChvUEkicbbMkpGkxF7AEk7VBHRd7jXkGnwCa0CC
	SCu+LgyZROYlAuPKC6DWc=
X-Received: by 2002:a05:620a:460b:b0:937:6de8:b40 with SMTP id
 af79cd13be357-944217194b4mr2663985585a.15.1793786977174; Wed, 04 Nov 2026
 02:09:37 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101082307.151957-1-gahing@gahingwoo.com>
In-Reply-To: <20261101082307.151957-1-gahing@gahingwoo.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Wed, 4 Nov 2026 11:09:25 +0100
X-Gm-Features: AclHuK8sSyrPUh77ae7umfCvxuLdQ-s4Z2b2nFvZD8O11RHz5Wmhve3hcOyzmnA
Message-ID: <CAPsqS2SOj-+VQxsFvMQ1Hqcep55J0yT++76QZ8or4a9kmF7Bdw@mail.gmail.com>
Subject: Re: [PATCH v15 00/15] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org, 
	p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com, 
	royalnet026@gmail.com, abel.vesa@oss.qualcomm.com, 
	sebastian.reichel@collabora.com, sidong.yang@furiosa.ai, 
	u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com, 
	diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl, 
	jeff.hugo@oss.qualcomm.com, rfoss@kernel.org, dri-devel@lists.freedesktop.org, 
	linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 9:31=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> wr=
ote:
>
> This adds the RK3576 NPU to accel/rocket.
>
> v15 is v14 rebased onto next-20261030. v14's 12/15 no longer applied
> there, because Sidong Yang's regcmd validation added two defines in the
> spot where 12/15 adds its own. Nothing else changed, and the tags carry
> over.
>
> Leonard Lausen has the series running on a NanoPi M5 and posted a board
> patch on top of it:
> https://lore.kernel.org/all/20261019090348.378183-2-leonard@lausen.nl/
>
> On Sashiko's two points about v14 9/15, I measured a CM5-IO. U-Boot
> hands over with the NPU domains on, and the power domain driver still
> probes. The NPU QoS is saved before its first power-on, so it is not
> zeroed. The domain whose QoS does get zeroed is the GPU, on mainline
> without this series, and that fix went out on its own:
> https://lore.kernel.org/all/20261101055633.101309-1-gahing@gahingwoo.com/
>
> 1/15 is the patch that carries Igor Paunovic's name. It is also part
> of his DVFS series, so whichever lands first, the other drops it.
>
> Ulf offered to take 7, 9 and 10. 1 to 5, 11 and 12 go through accel,
> and 13 to 15 through rockchip. 15/15 needs 9, 10 and 12 to 14 first.
> Without 9, 10 and 13, the ROCK 4D takes an SError at boot when the NPU
> domain powers on.
>
> Link to v14: https://lore.kernel.org/all/20260924102135.92217-1-gahing@ga=
hingwoo.com/

Hi,

Could you please add a GET_PARAM IOCTL to this series for userspace to
query the hardware version? I think I would return an enum that
matches the NPU DT compatibles one to one. Then userspace can have a
hardware database indexed by that value with sram, register map, etc.

Regards,

Tomeu

> Igor Paunovic (1):
>   accel/rocket: request the core clocks by name
>
> Jiaxing Hu (14):
>   accel/rocket: take the completion register writes under job_lock
>   accel/rocket: wait for a running IRQ handler before resetting a core
>   accel/rocket: let the core suspend after a reset
>   accel/rocket: factor the completion tail out of the IRQ handler
>   dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
>   dt-bindings: power: rockchip: allow resets in a power domain node
>   dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
>   pmdomain: rockchip: add optional per-domain power-on settle delay
>   pmdomain: rockchip: cycle an optional power-domain reset on power-on
>   accel/rocket: select the per-core clock and reset counts from match
>     data
>   accel/rocket: add RK3576 NPU (RKNN) support
>   arm64: dts: rockchip: add NPU core domain clocks and resets to rk3576
>   arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
>   arm64: dts: rockchip: enable the NPU on rk3576-rock-4d
>
>  .../bindings/iommu/rockchip,iommu.yaml        |  28 ++++
>  .../npu/rockchip,rk3588-rknn-core.yaml        |  47 +++++-
>  .../power/rockchip,power-controller.yaml      |   8 +
>  .../boot/dts/rockchip/rk3576-rock-4d.dts      |  22 +++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  86 +++++++++-
>  drivers/accel/rocket/rocket_core.c            |  32 +++-
>  drivers/accel/rocket/rocket_core.h            |  11 +-
>  drivers/accel/rocket/rocket_device.c          |   7 +-
>  drivers/accel/rocket/rocket_drv.c             |  42 ++++-
>  drivers/accel/rocket/rocket_drv.h             |   2 +
>  drivers/accel/rocket/rocket_job.c             | 157 +++++++++++++++---
>  drivers/pmdomain/rockchip/pm-domains.c        |  89 +++++++---
>  12 files changed, 467 insertions(+), 64 deletions(-)
>
>
> base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
> --
> 2.43.0
>
