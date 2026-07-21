Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902946AA93;
	Tue, 21 Jul 2026 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648354; cv=none; b=DuVG4+kvKgSXkNF9K8tnP7Xz1bLS48Iln9uxbx/Nuy7KEEMudUPHQNabLN5/sam+JXHn9IkzxdIB4hR168rzv9SiEREZBUR4E1es9shJ0iqZJwHzF0CoXjMCozp1wnVlO0+RlTOxcntRQwAOt6QoqHEEtuFR022mYcQPN+8Xuno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648354; c=relaxed/simple;
	bh=cz+yaxPCKGydsCShz+e64g051Q//+9R/77njKWpmjQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyfPIPxqUn+lYbI/Hox6plqUEMgSlKGV9BoLw9DpxyW8T7RT1Om1uh9koO6n5i18OpPjXzswiU0YhU8rxcVJ3wN9144WMK13WjCmU8op8kyhSOULOrexaqzjjrW7JgImuQIv7u8iMAMn5eYhTXfVKBR+dSRDBnLCeHQ6dn9x4Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWsHDJRC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWsHDJRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1221C1F00A3A;
	Tue, 21 Jul 2026 15:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784648353;
	bh=hLQWPFMCTeHsHxMG2mIadddYhi94/3UwmE2L3HrNJbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VWsHDJRC6YHuuimgcQEchBVC8lxQKFw/4AI0Vf4OFV+Qmo8pig0CJlRKR+wdQ4myQ
	 j9xW2WnYc8zvnmxtHMNkMaebW+c2W3ssd/TFUmxhbaQNa6oYDJooYPg39GLvIQeWsX
	 aBKwwm+i9oN3+8jNGlzU1pXlJbi9tI62ejBlCSU22ri5fM27ECFsUIRR8cTg424vWM
	 e1Q5jBKX+KQ33s9ozKVr1SL2hw0n/Xtke8LrrEqGM1R4fnlAwDoitf3+KTsEFY85nE
	 480QvD1tcxzJBFZy2HAPkInRsUaAnPrs6ooy4u+QBCgLC/yFbMFmTKiVNoHmttP2T3
	 qmVWkn2TnpF7g==
Date: Tue, 21 Jul 2026 16:39:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
	mfd@lists.linux.dev
Subject: Re: [PATCH v2 2/4] dt-bindings: mfd: syscon: Allow syscon compatible
 for Loongson-2K0300 chip id
Message-ID: <20260721-unearned-triage-841b68880057@spud>
References: <cover.1784619512.git.zhoubinbin@loongson.cn>
 <bab36775095bb85827676b2db917e6cb9527b325.1784619512.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GK7sGhgenbKn2aR3"
Content-Disposition: inline
In-Reply-To: <bab36775095bb85827676b2db917e6cb9527b325.1784619512.git.zhoubinbin@loongson.cn>

--GK7sGhgenbKn2aR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 08:24:21PM +0800, Binbin Zhou wrote:
> The Loongson-2K0300 SoC exposes its chip ID registers through a syscon
> interface. Add the specific compatible `loongson,ls2k0300-chipid-syscon`
> to the allowed list of syscon bindings so that it can be referenced from
> the thermal node via a phandle.
>=20
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Document=
ation/devicetree/bindings/mfd/syscon.yaml
> index e22867088063..c5b2e28f6ced 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -76,6 +76,7 @@ select:
>            - hpe,gxp-sysreg
>            - loongson,ls1b-syscon
>            - loongson,ls1c-syscon
> +          - loongson,ls2k0300-cphipid-syscon

You've spelt both of these wrong, "cphip" instead of "chip".

pw-bot: changes-requested

Thanks,
Conor.

>            - lsi,axxia-syscon
>            - marvell,armada-3700-cpu-misc
>            - marvell,armada-3700-nb-pm
> @@ -189,6 +190,7 @@ properties:
>                - hpe,gxp-sysreg
>                - loongson,ls1b-syscon
>                - loongson,ls1c-syscon
> +              - loongson,ls2k0300-cphipid-syscon
>                - lsi,axxia-syscon
>                - marvell,armada-3700-cpu-misc
>                - marvell,armada-3700-nb-pm
> --=20
> 2.52.0
>=20

--GK7sGhgenbKn2aR3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCal+SmAAKCRB4tDGHoIJi
0jPVAQCvJHInKelqh3513UPi1ZsC7cbxUrsaq0g/JroEIrahzwD+IiLXI9AFi2iA
p+pjuAzP3h8rH+Xb6lKhUUdZurMyKgg=
=+rX3
-----END PGP SIGNATURE-----

--GK7sGhgenbKn2aR3--
