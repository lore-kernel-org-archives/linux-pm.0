Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C69245FFB4;
	Mon, 21 Sep 2026 21:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027515; cv=none; b=cPY9UGfgB+imLqKpFUjr3Fjdj9SY7zDrt4ZXoyQgLHw2TzrAg2bwraz5NuT4AGvwpArvdYAqbBBJOBDi0ruuAnf+x+ovhafAXVeGZjAv4zDm1ynuV7Ts+vNvTTn6b9S0yRD1XX/EmIEKoLU5PN00r0EvjL8eybY9Ggxgia7I0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027515; c=relaxed/simple;
	bh=c95iOoxnskPFfNVJeXatbMnPBZZbvYWjgen2yl/uNUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mscfzm1HGmYAisG5B79cXIaoSRA2cs5qS21jJq3rxETsPtgAOCMt3BzNsHgzfa6VIx5CYFIgbstlEHdvRG+OLBuOqP0sSzlSIJbIuW67+xyl+W19IMRmURwZCcgXLL6DtmlT8WCiXqmmk/E2DQ7r/ilnmgDWp+OtwXkH7K5wbF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=YTN6YR/z; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="YTN6YR/z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=j4liZ14THFBbmN0BGtw1acIhCbedsr31KR7f3ynsmuI=; b=YTN6YR/z0jFiPpwVnyatzy/Yga
	b/ntgapdGubCzkXTkPBHOGR601vbC8lI95G16qLYg3n28RJjTlVIJKfHrZvwI4sHKm4FK/Q+1ukPZ
	Pi8CK0QzmBjm/fjsyLZo/zwgb8Wk24in9xxFJ8p6FtC5nmb99FmBecxo4nbJMQsFBI4jjXvHsVG8k
	UY3JXdVfgvZGfAAoTVJzuO/DRYOpjHDFCel/Ea1luhz1+Ii1H2qy5gB7hhwOymTILDedQSGLM8hRE
	lyJAbMfSYJlcMrhbibSOTdliNr0tlhfbCPbFc5gqMGCFAmTjZg4wEAu9yQdeucwA9d9M0a2SaH71v
	jEa23Bog==;
From: Heiko Stuebner <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject:
 Re: [PATCH v13 13/14] arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
Date: Mon, 21 Sep 2026 23:51:33 +0200
Message-ID: <119338490.nniJfEyVGO@phil>
In-Reply-To: <20260915104328.45901-14-gahing@gahingwoo.com>
References:
 <20260915104328.45901-1-gahing@gahingwoo.com>
 <20260915104328.45901-14-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi,

Am Dienstag, 15. September 2026, 12:43:27 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Jiaxing Hu:
> Add the two RKNN cores and their IOMMUs. Both cores are disabled by
> default; boards enable what they wire up.
>=20
> PD_NPU0 and PD_NPU1 are siblings under PD_NPUTOP and hold one core each,
> but the convolution buffer and the DSU sit above them: ACLK_RKNN_CBUF,
> HCLK_RKNN_CBUF and CLK_RKNN_DSU0 belong to the block rather than to either
> core, and PD_NPUTOP already lists all three. Add them to both core domains
> as well, so a core domain switching state has the clocks of the path it
> shares running, and give each core domain the BIU reset that the pmdomain
> driver now cycles once power is on.
>=20
> Each core lists both core domains, its own first, so that a core in use h=
as
> the whole block powered. Whether a single core can reach the shared path
> with the sibling domain off is not something this series establishes;
> listing both is the description that has been tested here. The IOMMU in
> front of each core lists that core's domain only.
>=20
> Label the outer PD_NPU node so a board can attach the NPU rail to the
> domain that gates the block.
>=20
> Clock the NPU inside the voltage its rail is given. CLK_RKNN_DSU0 clocks
> both cores and the CBUF they share, nothing in mainline sets its rate, and
> the block comes up at 786.432 MHz. Rockchip's OPP table for this NPU asks
> 800 mV of its 800 MHz step at the worst leakage bins, and nothing in
> mainline sets the rail either, so a board that follows this DTS runs the
> NPU above the step whose voltage it happens to boot with.
>=20
> On a ROCK 4D with both cores enabled and vdd_npu_s0 at the 750 mV its PMIC
> comes up with, two jobs in flight at once make the second core write sing=
le
> words of its output wrong: the right value with a bit of the accumulator
> set, always the same position in the array. Either core alone is exact.
> Four device trees, same board, kernel and userspace, four passes of 5400
> rows each, every row compared with the same multiply done one row at a
> time:
>=20
>   786 MHz, 750 mV    13 to 20 wrong rows a pass
>   594 MHz, 750 mV    0, 0, 0, 0
>   786 MHz, 800 mV    0, 0, 0, 0
>   786 MHz, 850 mV    0, 0, 0, 0
>=20
> 594 MHz is a divider off GPLL and sits between that table's 500 and 600 M=
Hz
> steps, both of which ask 725 mV at every leakage bin, so it is inside the
> voltage a board that describes no NPU rail already provides.
>=20
> The trade it buys is a core against a clock, and both halves are measured.
> The rate lives in the device tree, so the two clocks cannot share a boot,
> which means this comparison is across boots and has to clear the noise of
> one. Twenty readings of a single arm inside one boot, nothing changed
> between them, span 2.5%; across boots it can only be worse. So the 4.0 to
> 4.2% below clears that floor by under a factor of two, and the 26 to 37%
> clears it by ten. Five runs an arm, the arms alternating inside a boot,
> one warm-up a model discarded, medians of five:
>=20
>   decode tok/s      594 MHz   786 MHz
>   Llama-3.2-1B        17.85     18.60   two cores
>                       11.17     13.77   one core
>   SmolLM2-135M        41.46     43.12   two cores
>                       38.26     41.90   one core
>=20
> Losing 192 MHz costs 4.0 to 4.2% of decode with both cores running. Losing
> a core costs 26 to 37% on the 1B model, at either clock. The rate is the
> cheaper of the two by six to nine times.
>=20
> The two arms cross-check each other: the clock is worth 23% on ONE core
> against 4% on two. With both cores running the bottleneck is no longer the
> clock, which is why this configuration can afford to give up 192 MHz.
>=20
> A core is worth much less on a small model, 2.8 to 7.7% on 135M, where the
> second core's dispatch overhead is not repaid. TTFT moves by under 2%
> either way, so none of this says anything about prefill.
>=20
> An OPP table with the rail attached is the proper answer, and it wants
> driver support this series does not have.

please trim that commit message A LOT :-) .

You're just adding the nodes for the NPU cores, that does
not need a novel-sized commit message.


Additionally, please split this into two commits:
=2D Adding the resets to the power-domains
=2D Adding the nodes for the NPU cores (add pd_npu phandle here too)


Thanks a lot
Heiko



