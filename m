Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745277;
	b=vBLqtkZN70tzdTxUT1tY0HqN/kZzjm3eeCysiRt+HRRnd8XyXe5mk2wj9cLOLgFje25h
	 x5iFWn6C1QYd/SrGXqzC3NI6QizaEUQUeg8Y14FmKV5OSgKzdWMOeom4HynKk2mtuHgz2
	 pdFW6Tv+hvsZxeYH2qgcP6/RJwdoqfxKs9rdNztrsz8RST6i6oHceJivoTzEV6YXqU7Mg
	 /F2zQ/UB0w0AB7kaVJ+o/Y5AG92Q8+ElKZhBa/XVEnNAqvNk36YbTGywEBy/N44vEk6m1
	 AG8G8vq2HDoAnYqr0NeDLSGzIjmp3/spsQlEIHVUSA9fi++5FxUMyLfVnICsAtFUmNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745277;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=mUVAYeIeS0pGb++9O7IAV5dyWYaWTCaE2wpCDRchVW4=;
	b=G1bzErhOTgFChrlqkScGdz31sy8r5yqPyogpHpfkOMWDpkrRBzfLK2AqldG79RNuT6mJ
	 Iu8dOIeBe0Ygfo++u4RrfpyeH4lBMI0OxYzvhoscE6Z92lAXpnPY6E0u9dyGZx0QX37bd
	 vg8VF/GEEfb/vcmgQsA/OtsMddIpV1QhmF7LvkFy2gLcSYFR2kRIULEE72vAOZakls8EO
	 Jb4y+e9WQ6JkT0YjlERM4xQET7rW7R3lWyNV4AI9qB3B3kRno/4TZL85cct5HAp3jolHS
	 d3GQArgEDyxzKsE3gMldXbc6r/c+OlA99+224Y0MA//unq4I32eSb195PaTbSFL2aNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=VjdJDFys;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D438606A31B;
	Tue,  3 Nov 2026 22:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D438606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=VjdJDFys
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=mUVAYeIeS0pGb++9O7IAV5dyWYaWTCaE2wpCDRchVW4=; b=VjdJDFyskLCLPZlvGcegvYUdtF
	+OTeh3I0nCog7bs/WfDEV64J1B5qA7R1NWQ8hZWr256a6gHP3zQxK4CvdVfM2HopgnLlIF0hutX6P
	1IE5pccn3hwjD2EhdDExhb/EtmNTXPuOYI2LERzqMeo+zXX+V6mbgRO7J1ehgqzQr60hncPg0oY6H
	eyZ8S/WMRM80RLeUWRR+RN58B3frtNwnUjiSKKyFffCP1Vt0UjEYUx5LTGQUYYg2sUEU+QRaEV6Cw
	5+bqAhJzyAC6wOn0AfHdBdjjQvxQsg9QGWRYWEnC7k6zo7mJ2JrH14y5Ua/RbrxzTiFqjAagRdV1l
	/2XSHJzQ==;
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
Subject:
 Re: [PATCH v15 09/15] pmdomain: rockchip: add optional per-domain power-on
 settle delay
Date: Tue, 03 Nov 2026 23:34:12 +0100
Message-ID: <1846076.jNaZZp9DzI@diego>
In-Reply-To: <20261101082307.151957-10-gahing@gahingwoo.com>
References:
 <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-10-gahing@gahingwoo.com>
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

Am Sonntag, 1. November 2026, 09:23:01 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Jiaxing Hu:
> The RK3576 NPU domains need a short settle time after the idle request is
> released before the registers behind the domain answer. Without it the QoS
> writes that rockchip_pmu_restore_qos() issues land while the domain is
> still coming up, and the NPU throws an async SError on the first cold
> power-on.
>=20
> Give rockchip_domain_info an optional delay_us and wait for it between
> releasing idle and restoring QoS. Rename DOMAIN_M_O_R_G to
> DOMAIN_M_O_R_G_W for the settle delay it now carries; RK3576 is its only
> user, so the old spelling is not kept around.
>=20
> The macro also takes the regulator argument DOMAIN_M_O_R and DOMAIN_M_R
> already have, and RK3576_PD_NPU passes true, so
> rockchip_pm_add_one_domain() powers that domain off at probe and the delay
> runs on the first power-on even when a bootloader left the NPU up.
>=20
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>


Reviewed-by: Heiko Stuebner <heiko@sntech.de>


