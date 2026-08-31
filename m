Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC63537C7
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160825; cv=pass; b=OHsIyvz4OjxwiHSskUxFOtk9HW9CKS8lu2VWSJM7eqkCk7Ibf07s7J7gwsMkxSfEcTSYEw18y3wkVHM++g7YP7jrFgqwXGWes+k6bGbkI2mfV7QtuGbsv5eno0KIHoLSP/I8RvfH1ujXIhoeTUII5eThM2QdFsGZTUn0/pfm9tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160825; c=relaxed/simple;
	bh=n9o2swquvhR29jn4mFjOtM91XSnruoxkyihW01u7frE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7RU+mlG4AOq7+5jDeUEQUVH0ABFCU3mKiNlPG0evYP+KSq2R75JmE60w4tKdcZHvttVpBQZy5w95UzfXbh6ElFMN9Dijq2rhy8MZEBSbQykIcn7Szf480T9IXvCPBc+I8dmoJhZSmMAeRxieAKXfXXxi23RE37debXpqt2qB4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b=oKkDKIrp; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="oKkDKIrp"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52fa9c055b5so42245331cf.1
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 00:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788160820; cv=none;
        d=google.com; s=arc-20260327;
        b=UkSW4t4TI+L+aUITUrHWG88rNSstAWgvrJdCNpk2DoFVOiOcOck7yY4tlFpTHlMSJL
         xP5NoCPuPwy12yQd9gxd62nhfXfcuP7SzrMgzuBMtrNnMyUWmRbGU7TGZqROvgdK+7og
         jXHgy7xhvX63efwkvFLQ15UF2je8HsLBTaC2NbQCHWZKsRwx4LN4AbrfVOlnphfNJf/n
         cnTNEAexWyxn0AElBIcRbz1H5j+CUM/43BvC+TJ3dyTlOUMOeV45XP+vjWa5t/k82e/Y
         47DQHuUmcxUJyerSYLhEzv//5a/ZSO9TlVaaGVPWJvdH98xDBFpWGe1XV69DZuFixr2J
         qDKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bFWfbb/gIctZHoo0CDVoZsBSY4wt/NAsN/U4bJzB5KM=;
        fh=rkze9pU9JuXrEU97atY/E5B/MP7GCRLYzlwj43IIS3U=;
        b=ID3hJ96V/7nTXzNo/owxGxGqIBd3u3SNCALEWNq7Sj1CnTs5VJVl+fe/sfSsH+VUa8
         Vk5z5CfOOCGkKFeYGhFInNfFbmJaP+G4qmZsl6brSa0M078rCz5pdYLnfrr1RP792dW6
         QTBzC8AmvECU8xbRtO2YjSg2L5wdFuf4RuGngPTiT0VgGFMamlEjhuf4zLlW8AJEtO3R
         Lem5m2qT1kXtWyq6ptmWD90gBuRBBbHyyrwe4dmqpZB4LYVKNvlCpwIfbX7d/p6k6e2J
         ID946d1o27xeN7EYTQZhSzsd8WXDHo+QdGBzo1qlf4VGDFWYAoDON9W0aSrP8mzvNITo
         7MHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1788160820; x=1788765620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bFWfbb/gIctZHoo0CDVoZsBSY4wt/NAsN/U4bJzB5KM=;
        b=oKkDKIrp3dd1z/MFoWMPTe92a7sYHI0OriCkfqNLgRX3fwZHkPBNKTcMznXcJjkL9K
         wMJEtNGO8lbxlMPrh/8IRYu60TTsZxxekMMRgzZpzMcfj5g8V1tiNmHhumSehIpPK9CX
         4QJwW/KbQgZfIZbQh4HDHG5JVq0j4umLIfx9WLA/n2VJA795VWThsG7ydtQyWgS/Fg5A
         QMjBRjlIZ+gNvZE4XphqIntjccUq/stBsE+F13cZ6fP/UwykeTYM46BoirNZ8V9mZhSM
         AfVZes2zycLMeNOsjbMDIyREnmFTowIpgyuk5lHpPUJzbjT1UEAyexVCNGqIARYvsRNI
         3Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788160820; x=1788765620;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bFWfbb/gIctZHoo0CDVoZsBSY4wt/NAsN/U4bJzB5KM=;
        b=BaUyn96TWqDYlj0PO4P34KmlA+WTzKx5xn1P+SrUZwLQj3bycvti4yui1npJ1DTJEU
         EcG5ifB0Agh9B4cQg3e0GHAkcw2c4gM8Fc/XMG4s+xbthhmXZfUlbXdTvlwh5DpJv62i
         ZcQsIVlC2sXEYso4c75LNhoyPnEf7BZjYAmkHTXapryBOm1CXj2zvJWA+wZyQ8vEapAM
         KwLj3ipTyEXZbGTFMWdhSsbP25QFs/0W+FWJ8BKPkg71oWEIfinYDcmfQNF3Reaa3+e/
         tx18Ws/54Tr0pbDmBxgUPqruYwjEHHDGbRj1VYF5d2RsRabRHO9WE6VbafrvijhIum8z
         7IQA==
X-Forwarded-Encrypted: i=1; AHgh+RpyQAUCi10/kZe3hMHPKlVuDDrcoFx9appo2JS53gwYDflUwTQVFnYkBN6nhPq9EOqSVp9Q1N5RLg==@vger.kernel.org
X-Gm-Message-State: AFuF++n5auiA61umgpX6oKVsuAZC+a06T12jefyrS6L9/qOMX3G+U9Di
	3QimFk5aZ+2HwRLDduEJrli+6KjMor34WBeMgsisDGssL5yLJGorFwS0WXtamOrcN4CuEpFrVn2
	+6PY46PCiL38wfj5TrG/EcgGUyZcwsQoybxhP+rPNxg==
X-Gm-Gg: AR+sD13Wx8je9qgEdazdslkkIpGxJT5BfQuD86ZOjhKvH9UH/gqf2vlXTVSJviujaT5
	w/QYg8wZNgI1i2I5U35zye5nNi23AEFeQMWoUkHfkFNcXD1spa5tGvpM5lEEEIBxYHDsJMTcPru
	bv1Ci/ZhRjyzLGA7pchoBcrEAhmvQTVwiPw1EgOYLyVxym8Cuu+iouocv2jpdkgK13/5M45rVCI
	0Bw2TvukXeJZmL38VM62ZrRT64kPHR7Hum7SDX24V4mQ7SRWNpM5K61wkh6tLFd2P5EHlzJ35pz
	zoyrTDOKfFaAovao1/b8uo9wIn1jnGQHv6K4+Q68ddQq
X-Received: by 2002:a05:620a:1d02:b0:939:619:c6eb with SMTP id
 af79cd13be357-93936c7a141mr714176285a.8.1788160820472; Mon, 31 Aug 2026
 00:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831040804.24111-1-gahing@gahingwoo.com>
In-Reply-To: <20260831040804.24111-1-gahing@gahingwoo.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 31 Aug 2026 09:20:09 +0200
X-Gm-Features: AcwNN1Uwr5NzEhJ7J-T4GkpAbcQEn3hzAH0qQngAbR_wX7Qh73vwn6zU-qNzhjg
Message-ID: <CAPsqS2TGXOCOL8BzaJ4NaJqtuKid7vhRdJq-80ngGxhNN_UWCw@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] accel/rocket: RK3576 NPU (RKNN) enablement
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org, 
	p.zabel@pengutronix.de, ogabbay@kernel.org, zhangqing@rock-chips.com, 
	royalnet026@gmail.com, u.kleine-koenig@baylibre.com, 
	chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 6:08=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> Based on Igor Paunovic's "[PATCH v2] accel/rocket: request the core
> clocks by name", as v6 through v9 were.
>
>   https://lore.kernel.org/linux-rockchip/20260729130743.128876-1-royalnet=
026@gmail.com/
>
> Tested on a Radxa ROCK 4D, on next-20260814. The tree is byte identical
> to v9, so that is the same test rather than a new one.
>
> This adds the RK3576 NPU to accel/rocket, which today supports RK3588
> only. The RK3576 carries two cores of the same RKNN block, wired up
> differently. Two extra convolution buffer clocks, two power domains per
> core, one reset rather than two, no NPU SRAM rail, and a PC_TASK_CON
> that packs the task number into sixteen bits rather than twelve.
>
> What changed since v9
>
> No code. Every patch's diff is byte identical to its v9 counterpart, and
> below the --- the only change anywhere is 5/13's git note. Above it, six
> commit messages each gained one trailer line and nothing else. Six tags,
> that note, and the base-commit trailers back where v8 had them.
>
> The note first, because v9's cover letter said 5/13 carried it and the
> posted mail did not. Rob Herring's bot asked on v8 for the dependency to
> be recorded in the patch rather than only in the letter, v9 said it was
> there, and it was not: my send script never passed --notes. Igor
> Paunovic noticed while applying the series and said so before v10 rather
> than after, and he had the cause right. Nothing was lost in a rebase;
> the flag was missing. The script now regenerates with --notes and
> refuses to send unless exactly one patch carries a Notes block.
>
> Igor also ran the 19 August protocol again on v9 as posted, on RK3588,
> an Orange Pi 5 Plus with all three cores bound, PROVE_LOCKING=3Dy and
> DEBUG_ATOMIC_SLEEP=3Dy, and a local test-only patch lowering
> JOB_TIMEOUT_MS to 2 ms so healthy jobs cross the timeout. Two passes per
> kernel at console loglevel 8 and 4, serial captured on a second machine.
>
>   v9, two passes         12 and 11 induced resets, all recovered,
>                          48 of 48 within 1 on both, including the
>                          inference after a forced autosuspend and
>                          resume. No MMU faults, no lockdep hits,
>                          nothing on the console.
>
>   without 1 and 2/13,    8, 10, 12, 8 and 15 induced resets, all
>   five runs in the       recovered. Four runs clean. In the
>   same session           remaining one the inference after autosuspend
>                          reported success and returned a constant
>                          buffer, all 48 output channels at 0x80,
>                          which is not this model's output zero
>                          point, while the CPU reference varied
>                          normally. Zero kernel messages, zero
>                          lockdep hits, nothing on the console.
>
>   1, 2 and 3/13 only,    13 and 13 induced resets, all recovered,
>   two passes             oracle 48 of 48 throughout, including after a
>                          forced autosuspend and resume. On the 1+2 arm
>                          a round that ends in a timeout leaves the
>                          affected core runtime-active even through a
>                          forced autosuspend; with 3/13 applied the same
>                          sequence leaves all three cores suspended.
>                          That arm is where 3/13's Tested-by comes from.
>
> A job that signals completion while its output buffer is never written
> is the silent form of the race 1/13 and 2/13 close, and across 102
> induced resets in nine runs that day it appeared only on the arm without
> them. It is a better statement of what those two patches are for than
> anything my own logs have caught, which has always been the loud form:
> a message, a wrong answer, something to look at.
>
> The tags, and where each came from:
>
>   02/13  Tested-by: Igor Paunovic   # RK3588, three cores, induced
>                                     # reset, differential base,
>                                     # JOB_TIMEOUT_MS=3D2
>   03/13  Tested-by: Igor Paunovic   # RK3588, three cores, induced
>                                     # reset, JOB_TIMEOUT_MS=3D2
>   06/13  Acked-by: Conor Dooley
>   07/13  Acked-by: Conor Dooley
>   08/13  Reviewed-by: Abel Vesa
>   09/13  Reviewed-by: Abel Vesa
>
> The two Tested-by comments are not the same string, and that is how they
> were given. 1/13, 4/13 and 5/13 keep the tags they had; Igor checked befo=
re
> testing that 1/13 is byte identical to v8 1/12 up to the base-commit
> trailer and 4/13 identical to v8 3/12, so those tags still describe what
> was tested.
>
> The bindings are unchanged since v9, where dt_binding_check was clean on
> all three with dtschema 2026.6 and yamllint 1.38.0, and CHECK_DTBS was
> clean on all 13 rk3576 and all 48 rk3588 dtbs.
>
> Two things I raised in v9 and would still rather hear about than guess
> at. 8/13 does three things: it adds the settle delay, renames a macro,
> and gives RK3576_PD_NPU a regulator, which also makes every RK3576 board
> force that domain off at probe. I asked whether it wants splitting;
> Abel Vesa's Reviewed-by may be the answer, but nobody has said so, and I
> would rather split it than have it merged on my silence. And 12/13 gives
> each core both NPU domains, which is the description that has been
> tested here rather than the topology; if it should be one domain per
> core, 5/13's minItems has to change with it. That one has had no reply
> at all.
>
> Nothing else moved.
>
> Jiaxing Hu (13):
>   accel/rocket: take the completion register writes under job_lock
>   accel/rocket: wait for a running IRQ handler before resetting a core
>   accel/rocket: let the core suspend after a reset
>   accel/rocket: factor the completion tail out of the IRQ handler
>   dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
>   dt-bindings: power: rockchip: allow resets in a power domain node
>   dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
>   pmdomain/rockchip: add optional per-domain power-on settle delay
>   pmdomain/rockchip: cycle optional power-domain resets on power-on
>   accel/rocket: select the per-core clock and reset counts from match
>     data
>   accel/rocket: add RK3576 NPU (RKNN) support
>   arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
>   arm64: dts: rockchip: rk3576-rock-4d: enable NPU
>
>  .../bindings/iommu/rockchip,iommu.yaml        |  28 +++++
>  .../npu/rockchip,rk3588-rknn-core.yaml        |  47 ++++++-
>  .../power/rockchip,power-controller.yaml      |   8 ++
>  .../boot/dts/rockchip/rk3576-rock-4d.dts      |  13 ++
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  82 +++++++++++-
>  drivers/accel/rocket/rocket_core.c            |  28 ++++-
>  drivers/accel/rocket/rocket_core.h            |  11 +-
>  drivers/accel/rocket/rocket_device.c          |   7 +-
>  drivers/accel/rocket/rocket_drv.c             |  28 ++++-
>  drivers/accel/rocket/rocket_drv.h             |   2 +
>  drivers/accel/rocket/rocket_job.c             | 119 ++++++++++++++----
>  drivers/pmdomain/rockchip/pm-domains.c        |  75 +++++++----
>  12 files changed, 385 insertions(+), 63 deletions(-)
>
>
> base-commit: 4477a78374a57c3809b172ad30cceabda48c47c6
> prerequisite-patch-id: 46ebb679e93d3d25393e8cbf8fc3c955bcc01bd4

Hi Jiaxing,

I want to get soon to review this and the other pending rocket series,
and in the meantime something that could help this moving would be to
get a review from Sashiko.

As you can see in [0], Sashiko is not reviewing this series because it
doesn't not understand yet prerequisite-patch-id. Can you please
resubmit the series with Igor's (presumably) patches bundled in it?

[0] https://sashiko.dev/#/patchset/20260831040804.24111-1-gahing%40gahingwo=
o.com

Thanks,

Tomeu
