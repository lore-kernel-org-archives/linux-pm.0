Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D640B6D6
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777480004; cv=none; b=H2Rtlzx/hxc8BWUlj8ioOXjOeB1LFIBScvZj9TeACX4xAqBnEGAeyzHgMkamHG3r4ds4nlQxyG/KfKEQyt14oOWNEfktyDi5yIQV9EFgAacwRHD+UkV6HWJ9ADZoSEM5oCO6KUkI1pE1vcn7/Rv5UuMHoD9aLvR99Bf58gL7TyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777480004; c=relaxed/simple;
	bh=2gXgQk1zvRzCuD6/I5xshjxzSLuvwhLDL5ZyIjbxG5U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k5Vhai2MTaoPf9/F+pn1H1h5hO3p5peiTDmRwhoJMe7oQo4BiGTj9eGSM1uhdhS26lrmuzcUZxufrff2gBpW4Abbrj1N0IIEEyxkaEwxCklo4nTGl7VyS88NgRnsPRuzhx+tcqNzNh504FN27/8cUhUul+0A5F7UISyBRd8Ld2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiFmGPJS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiFmGPJS"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d43e09de5so3428f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777479995; x=1778084795; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gpqZ3+a3e+IW0wgilcrrSsFE8baGMm2gZVxtBkaZwTE=;
        b=LiFmGPJSAwCxoL/+D9ap6HspBoNyo/VpSSJEGEelC11a9ZGoAywfnEW5UDwhaG/jgF
         /67Bx+LpTU+B9qQtusR+RLTTQKc84RrEn9nxkfXLPK5YgcwOudAlcouDgJZm56wP5KNq
         QQygkd/uknz2XRWPqXwoXv3/xBVfxF4X2/ZtHdPICwtrGB8+YFItCUT4xPPdbSBSttrU
         o23ckPaS6iMHgqdKT9ziGpoqHmzekYYl2Xf3hw4Ceoc9qHydV4gxQBjPln+0qRKtxBsE
         Q/k1Y2enjtH353FwDKR9EiuX3x5AAr6a5z0GjO+9xkCq4Dt+QdEMWpeWyMPt24EnO5Aw
         OurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479995; x=1778084795;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpqZ3+a3e+IW0wgilcrrSsFE8baGMm2gZVxtBkaZwTE=;
        b=MlbgFHLxuTLwOfqM9s3n7AcSGj9Nei6S60K4H8OrfSPYuuTCf1xhYppiXVWdlHaFFQ
         mapAVQMFlgVtAYsBPY0Tt9+Oamk5+lJjgoW4S9FNWjwlp2WZVS3A1IA5fdAYv7N3ECm+
         vmPqQzFnDgsoSy6Pgagzg2QmwLr/YDiyt/4zPoc73z5CbyazscXQ9kxs8e3CphWQr65w
         8OdJr5GvrhynFIXXJ5F3yBbRkuaeZJTEnofIFC5LqacHem6vmhvB2hzNgKv5M0HYeF94
         ukV77InU2o2Gn6lFj1MUsEf7gnmxmE/X2yBDb9Ioq/lcZ2O6BivESxH+HiKgpv9B3Enb
         zLBA==
X-Forwarded-Encrypted: i=1; AFNElJ/DzzQrEm2BjCBKwwgXo3o0Qfok4MhEJNPy+CdmGquUaysfYc0gO0OyUR8ogkfMeVWU95TKs+wdKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDTtJ+ehSHL+nht5BSXwsPbcW+9snH8x6BK/6RkxrRCCflfEC1
	Lpk4GhwillhKFfEOaiasl3E9pCAhRaXsVQbnafrahph6Vre908PjfzDO
X-Gm-Gg: AeBDietRjzs+oLeqMsob6SpmruyKumP/RtTs5+vMi3FY05Zve3rTXpytN61k+Fr38ix
	4HGYVvcrDxnzYwLsH6FBw8tNkaZUyjGlspd+LoeM8X0BYdDurk/SgPdCnjlv6+rGoZDR46HtAv3
	20G+kjIs9Vn8kyWk7NyuiF99jtcUQfMnuFcs7ema6lb6bDRkkLpZOuhzJegZ5Vo2Res5gNoSvJ+
	nJt9DJg7hlBt49uCQUPmDl5ZX5OpntCzJYdsgpQKTWrYxM9WEIZ76Gqp9MtJYd6RKPCyzFd7M+D
	qAE2ZMoJNXJbRqVpH0gq6fcFynCuzvLOmKwPasKujot1nxCjfxL7VZAerlnA9V6tAF6nieiqJWt
	zXP8GIiJpcoNaO7BobDnuLI7HMYQ42BpVggLpnBdX7tEcI0PJFj64gV/jXBjbzWdKts8Ufw8btv
	U0YjufM9ko2geph/FHHBvEScE1j3m7hDC7LoHqCpAUpJjLLq/nKUww4PtMT1r4rWl0T8A=
X-Received: by 2002:a05:6000:40cb:b0:43e:b0f8:c564 with SMTP id ffacd0b85a97d-4478e3d0bb9mr8002971f8f.9.1777479994786;
        Wed, 29 Apr 2026 09:26:34 -0700 (PDT)
Received: from vitor-nb.Home (dsl-43-224.bl27.telepac.pt. [176.79.43.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c7csm6729780f8f.26.2026.04.29.09.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 09:26:34 -0700 (PDT)
Message-ID: <c0fe43a2339c802e9ce5900092cd530a2ba17a6b.camel@gmail.com>
Subject: Re: [PATCH v1] pmdomain: ti_sci: re-sync TIFS with genpd on resume
From: Vitor Soares <ivitro@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Tero
 Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Ulf
 Hansson <ulfh@kernel.org>
Cc: Vitor Soares <vitor.soares@toradex.com>, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>,  Kevin Hilman <khilman@baylibre.com>,
 vishalm@ti.com, sebin.francis@ti.com, d-gole@ti.com, Devarsh Thakkar
 <devarsht@ti.com>, stable@vger.kernel.org
Date: Wed, 29 Apr 2026 17:26:32 +0100
In-Reply-To: <1fb0739e-b84f-42f1-9c96-88b5cc5866a8@ti.com>
References: <20260427074808.3244226-2-ivitro@gmail.com>
	 <1fb0739e-b84f-42f1-9c96-88b5cc5866a8@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Vignesh

Thank you for the review.

On Wed, 2026-04-29 at 10:03 +0530, Vignesh Raghavendra wrote:
> Hi Vitor
>=20
> On 27/04/26 13:18, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> >=20
> > When a device in a TI SCI power domain is on the wakeup path of a
> > wakeup-capable child, the suspend path skips genpd_sync_power_off().
> > No put_device is sent to TIFS and the domain's genpd status remains
> > ON.
>=20
> Correction of terminologies: TIFS is Root of trust component and is not
> usually involved in power management, that would be DM (Device Manager)
>=20

Thank you for the clarification. I will address this on v2. Also, I was thi=
nking
to replace put_device/get_device with ti_sci_pd_power_off/ti_sci_pd_power_o=
n if
that makes more clear the content.

> But to be really sure who is doing what, Could you provide an example
> and the platform on which you see the issue / external abort?
>=20

This was reproduced on our Toradex Verdin AM62P WB and the driver for our W=
i-Fi
module on the SDIO bus calls device_init_wakeup() during the initialization=
.

After enter in suspend, it show the following error resume path:


[   41.759341] Internal error: synchronous external abort: 0000000096000010=
 [#1]
SMP
[   41.843286] CPU: 0 UID: 0 PID: 933 Comm: rtcwake Tainted: G   M       O =
   =20
6.18.21-dirty #3 PREEMPT
[   41.852762] Tainted: [M]=3DMACHINE_CHECK, [O]=3DOOT_MODULE
[   41.857891] Hardware name: Toradex Verdin AM62P WB on Verdin Development
Board (DT)
[   41.865537] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   41.872492] pc : regmap_mmio_read32le+0x8/0x20
[   41.876941] lr : regmap_mmio_read+0x44/0x70
[   41.881120] sp : ffff800081fdb8e0
[   41.884428] x29: ffff800081fdb8e0 x28: 0000000000000000 x27: ffffa95bb64=
aa9c8
[   41.891563] x26: 0000000000000000 x25: 0000000000000000 x24: 00000000000=
00000
[   41.898697] x23: 0000000080000000 x22: ffff000002df5c00 x21: ffff800081f=
db9b4
[   41.905831] x20: 0000000000000100 x19: ffff000001286400 x18: 00000000000=
00000
[   41.912965] x17: 2d69696d67722f79 x16: 687020726f662067 x15: ffff00007fb=
74f40
[   41.920100] x14: 00000000000002ea x13: 000000000000031f x12: 00000000000=
00000
[   41.927234] x11: 00000000000000c0 x10: 00000000000009e0 x9 : ffff800081f=
db7a0
[   41.934368] x8 : ffff00007fb6ce00 x7 : 0000000000000000 x6 : 00000000000=
00000
[   41.941502] x5 : ffffa95bb57948d8 x4 : 0000000000000100 x3 : 00000000000=
00100
[   41.948636] x2 : ffffa95bb5795034 x1 : 0000000000000100 x0 : ffff8000802=
5d100
[   41.955770] Call trace:
[   41.958211]  regmap_mmio_read32le+0x8/0x20 (P)
[   41.962655]  _regmap_bus_reg_read+0x70/0xb0
[   41.966839]  _regmap_read+0x64/0xdc
[   41.970327]  _regmap_update_bits+0xf4/0x140
[   41.974509]  regmap_update_bits_base+0x64/0x98
[   41.978952]  sdhci_am654_runtime_resume+0x138/0x208
[   41.983830]  pm_generic_runtime_resume+0x2c/0x44
[   41.988445]  __genpd_runtime_resume+0x30/0x7c
[   41.992804]  genpd_runtime_resume+0xdc/0x2e8
[   41.997073]  pm_runtime_force_resume+0x68/0xf4
[   42.001517]  dpm_run_callback+0x8c/0x14c
[   42.005439]  device_resume+0x11c/0x34c
[   42.009188]  dpm_resume+0x178/0x1f0
[   42.012673]  dpm_resume_end+0x18/0x34
[   42.016332]  suspend_devices_and_enter+0x4a4/0x668
[   42.021123]  pm_suspend+0x170/0x2dc
[   42.024610]  state_store+0x80/0x104
[   42.028096]  kobj_attr_store+0x18/0x2c
[   42.031845]  sysfs_kf_write+0x7c/0x94
[   42.035508]  kernfs_fop_write_iter+0x130/0x1fc
[   42.039949]  vfs_write+0x200/0x370
[   42.043351]  ksys_write+0x6c/0x100
[   42.046752]  __arm64_sys_write+0x1c/0x28
[   42.050673]  invoke_syscall.constprop.0+0x50/0xe4
[   42.055378]  do_el0_svc+0x40/0xc4
[   42.058691]  el0_svc+0x40/0x15c
[   42.061834]  el0t_64_sync_handler+0xa0/0xe4
[   42.066015]  el0t_64_sync+0x198/0x19c
[   42.069680] Code: aa0603e0 d65f03c0 f9400000 8b214000 (b9400000)

>=20
> >=20
> > TIFS powers off the hardware during deep sleep regardless, since it
> > was never informed to keep the domain active. On resume, because the
> > domain's genpd status is ON, no get_device is issued. The driver
> > then accesses registers of a powered-off domain, causing a
> > synchronous external abort (AXI bus error, ESR 0x96000010).
>=20
> Hmm, if something is wakeup source, I would expect even TIFS/DM not to
> turn if off, else module wakeup wouldn't work.
>=20

I tested UART as a wakeup source and I couldn't reproduce this issue. My
understanding is that UART has its own TI SCI domain and device_may_wakeup(=
) is
true directly on that domain device, so the set_device_constraint fires
correctly and DM keeps it powered.

Here is my tracking of the issue:

Wi-Fi driver registers as wakeup source:
device_init_wakeup(mmc0:0001)

During suspend/resume.
dpm_suspend()
->genpd_suspend_dev(fa20000.mmc)
   ->ti_sci_pd_suspend(fa20000.mmc)
      ->ti_sci_pd_set_wkup_constraint(fa20000.mmc)
        device_may_wakeup(fa20000.mmc)  =3D false
        set_device_constraint never sent to DM


dpm_suspend_noirq()
->genpd_finish_suspend(fa20000.mmc)
  ->device_awake_path(fa20000.mmc) =3D true
  ->GENPD_FLAG_ACTIVE_WAKEUP =3D true
    genpd status =3D GENPD_STATE_ON
    skip power_off (ti_sci_pd_power_off)

On deep sleep entry, DM powers off fa20000.mmc independently.
It received no set_device_constraint nor ti_sci_pd_power_off.

I attempted to fix this by calling set_device_constraint when=20
device_wakeup_path() is true but it prevented the system from entering deep
sleep entirely.

[...]

Best regards,
Vitor Soares
