Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787742;
	b=XyaXbqR1uO7hH8ivhluHEtSo/HwGYbLhsuJYcyp3ZvLW5llewvsQbrGYVd0UkWHBiOZA
	 yvzbE8WfCJVHHh57Eu7qKsCIL9fukSy0f8ZR0XT86AeC++CDKJ5lzGheZrN5pWXPls1BC
	 I+ObNUImFqNSSob+GNJMWgtatJFh9s0y4n2YgZcK8/i/CsOygNPG4BfbiITAb7Xbgkspc
	 qPn4tqqorgEkTem7QDqzR1cgAk/1p3n1t+wkYgJV7XSr+gSatp1eOuNdXcVbtDWpz74PB
	 Eh3b+eqqtVrMyOKLSM+muA5THgbd/g1n1DLqBb4RX2w5e5N8GiZjuu3s2N0yY/TZqbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787742;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=BvEDid5g6QRjHn3Z1Wkrnwm5AtJ8RllZNkH2qZNru5c=;
	b=Jrx86wTH9LBo7Gw1nZlzdX7xF2nHsKlF0A1fwSeBAGK3OWDwbE8Emq5hjusPLyk4VETK
	 QQwBEti5xqvyk5qjvNPOBwzaJ3UC7Ax+Jy0dfCyh7mNkATdW8Ck/Wji5HWNEQrXSAKuh1
	 dVTdT6JIZfu+k423TjjWn5bJHRaeY1FT8+GHKwKcHA8ZcMk153lbdY6dKjm+0daoESDn1
	 YMV+L3HL51XViL6bzS+xYQzKNxmM7aRaEuK/vqEbzZ7ziALnFaYgLPq3vEvZK7PayPq3/
	 H+FamnMGScotvfMjMgAnpgRP3fSravHlp+l+fRH1xYX2vuQWspTCGLHCVsU9nK2TiPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=mnpXecqY;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33068606A332;
	Wed,  4 Nov 2026 10:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33068606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=mnpXecqY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=BvEDid5g6QRjHn3Z1Wkrnwm5AtJ8RllZNkH2qZNru5c=; b=mnpXecqYVSy9/XQTnCwe/QAZAT
	oO5u9hSGJdyjtMfzeKLmcnySDE7Pfz7vhog/jVLohqgjCNPJB/gaqxJYvQqOah+IGy7rTskfqua9Z
	Z71031F7JJC5OpNCUvjRL8w3G8oBL5t8D32sJMZx8fk6wMt83Nubl7nAPZX27fkdWACnPS5NWTCPt
	C/Lq3OYdR04M2QtVUCc7LoOJboS0YKoelxMlb23u8m6CFaYZT+DtJU3eVSqFbCP83H0lUMHQuCdqU
	T1Bu3zDGMij+udBlOhcK79QncRyN+sKcZ3uZ/iHhrpUccsz8pfP38qBskRoD1lolhDyy0DYiI1KQJ
	HDXRPhDg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v15 01/15] accel/rocket: request the core clocks by name
Date: Wed, 04 Nov 2026 11:21:46 +0100
Message-ID: <2231008.VsPgYW4pTa@diego>
In-Reply-To: <3188623.WAvfycf1tz@diego>
References:
 <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-2-gahing@gahingwoo.com> <3188623.WAvfycf1tz@diego>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 3. November 2026, 23:42:19 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Heiko St=C3=BCbner:
> Am Sonntag, 1. November 2026, 09:22:53 Mitteleurop=C3=A4ische Normalzeit =
schrieb Jiaxing Hu:
> > From: Igor Paunovic <royalnet026@gmail.com>
> >=20
> > rocket_core_init() hands core->clks to devm_clk_bulk_get() without ever
> > setting the .id members. The rocket_core array is allocated with
> > devm_kcalloc() in rocket_device_init(), and rocket_probe() only fills in
> > .rdev, .dev and .index, so all four clk_bulk_data entries are requested
> > with a NULL con_id (unlike core->resets, whose ids are set a few lines
> > above).
> >=20
> > clk_get(dev, NULL) ends up in of_clk_get_hw(np, 0, NULL), and
> > of_parse_clkspec() only consults "clock-names" when a name was passed, =
so
> > the index stays 0 for all four entries. Every entry therefore ends up
> > holding a handle to the *first* clock of the DT "clocks" property, i.e.
> > ACLK_NPUn. Nothing fails: probe succeeds and the driver believes it owns
> > four different clocks.
> >=20
> > The consequence is that rocket_device_runtime_resume() prepares and ena=
bles
> > the AXI clock four times, while hclk, pclk and - most importantly - the=
 NPU
> > compute clock ("npu", SCMI_CLK_NPU on RK3588) are never prepared or ena=
bled
> > by this driver at all. The NPU still works only because the Rockchip
> > power-domain driver sets GENPD_FLAG_PM_CLK and its attach_dev() callback
> > walks the device node with of_clk_get() and adds every clock to the pm_=
clk
> > list, so genpd happens to keep the remaining clocks running. The bug is
> > therefore latent today, but it means the driver holds no reference to t=
he
> > clock that actually feeds the NPU, which stands in the way of any future
> > frequency scaling (OPP/devfreq) work.
> >=20
> > Found on an Orange Pi 5 Plus (RK3588) by reading the live clock tree:
> > /sys/kernel/debug/clk/clk_summary shows four "fdab0000.npu" consumer
> > handles on aclk_npu0 (and likewise on aclk_npu1/aclk_npu2 for the other=
 two
> > cores), while hclk_npu0, pclk_npu_root and scmi_clk_npu have no
> > "fdab0000.npu" consumer at all - their only consumers are the
> > "npu@fdab0000" handles created by the power-domain driver via of_clk_ge=
t().
> >=20
> > Set the ids explicitly, in the order mandated by the binding
> > (Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml):
> > aclk, hclk, npu, pclk. After the change the driver holds one handle per
> > distinct clock and clk_bulk_prepare_enable() covers all four.
> >=20
> > Note that this is a user-visible tightening for out-of-tree DTs: the old
> > NULL-id requests resolved by index and succeeded no matter what
> > "clock-names" contained, while the named requests fail probe with -ENOE=
NT
> > when one of the four names is missing. That is the right outcome for
> > in-tree users - the binding requires exactly these four clock-names and
> > rk3588-base.dtsi carries them on all three cores - but a DT that relied=
 on
> > the permissive lookup goes from silently running on the wrong clock han=
dles
> > to not probing at all, so record the change here where git log will find
> > it.
> >=20
> > Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU=
")
> > Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
> > Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
> > Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS,=
 NanoPC-T6 Plus
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > Reviewed-by: Jiaxing Hu <gahing@gahingwoo.com>
> > Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
>=20
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>=20
> nit: the commit description could be way shorter, for that small change.

note-to-self: also part of the DVFS series




