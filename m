Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com [165.173.180.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1475047DD6B;
	Wed,  9 Sep 2026 21:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988576; cv=pass; b=Yp9rn4qrp7IdT4EZd8DELF7S9gjTvrhpkl1a8dK9g4/otCfyKF/3v1ttVSSB7szBxrzL4HuH8i8+G7qh9YyA67zbTVFXdoV2v9RAX8lXYbm+3e/nKtXy4XMZrUOGcVV1cc1E9oFvEp9UuXGdvAZXzgADSst3gnpCk/T6mwXgqJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988576; c=relaxed/simple;
	bh=+/lyS4IjT5VajSutT8aMAGgG+Q6bvhffu2NTaVlBCLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwP52qxVoexVRxIXj7kCxKmkcqPMoH6/aA0R5j+3UqzFAuOCkE7lMGXf7SoxIwVSUgaZyJIgrWsB8ujFhVeVwtK0MHSQL/NMTrj2mT8s7yIpCgoKOfbjyj2fTF3DDiVjivpBCxSZn51dAUARLH7q3b7FDG/4kSgbqdQUb9BkzJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Ufm6uUXP; arc=pass smtp.client-ip=165.173.180.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Ufm6uUXP"
ARC-Seal: i=1; a=rsa-sha256; t=1788988572; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XqAZfbYC4dNnGqOBa4nK+o7vBWm2eBUCRjocXLEIX0JvEm2YNr9HngBVYCw1DszKDcWQLq7toQXEqmLCyVsamWjGboYlXfoSEOyP7+YzbBCqfESMjXHaKnMwVLcFiWvX9tNbdjHcayQbwaYeQWTnaQKHaI3js/1on6t+yp7YT+g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788988572; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/2TKgYNy9a36YFHmKUwsRyXDkpayq9yZPoXSVmoxukA=; 
	b=LqtmoUWAbOUK6jEz8y3ieP4oxwb1nZvvNTfI/JNPkap2OPXZynlki/kQwvyiYYTnH9UAOS0HfLOWqY/YJKlwZcF+X6Ld/NU2n+z0ywAAZCESkNn83hPAy3votvAgRoYopAQB+8YUpTrnS9+iuENwyw2PD2cKCoj5/zeGe6otLyE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788988572;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=/2TKgYNy9a36YFHmKUwsRyXDkpayq9yZPoXSVmoxukA=;
	b=Ufm6uUXPRjydtVPV3ZENV7DyhnWy70T9qvPJckCVc/4kkXctCRmGSMNUnCRPtMr1
	kEHtSC1hXmL0taRs9dWGTO244mhCmt6m8+6gz304BSj1vWkImW3mDvjUC6uxwtWGjDO
	uT9DvyZvJZcuhAB9zYMywmBlWvb2s/+hO9cEk+RU=
Received: by mx.zohomail.com with SMTPS id 1788988570120371.1740588564028;
	Wed, 9 Sep 2026 14:16:10 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 4557C183377; Wed, 09 Sep 2026 23:16:06 +0200 (CEST)
Date: Wed, 9 Sep 2026 23:16:06 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Stanislav Zaikin <zstaseg@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/3] dt-bindings: soc: qcom: add
 xiaomi,taoyao-pmic-glink compatible
Message-ID: <aqHLuHr-Vf3gtz2T@venus>
References: <20260821123711.1579539-1-zstaseg@gmail.com>
 <20260821123711.1579539-2-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ssj47hpacxsb424s"
Content-Disposition: inline
In-Reply-To: <20260821123711.1579539-2-zstaseg@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.982.46
X-ZohoMailClient: External


--ssj47hpacxsb424s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v3 1/3] dt-bindings: soc: qcom: add
 xiaomi,taoyao-pmic-glink compatible
MIME-Version: 1.0

Hi,

On Fri, Aug 21, 2026 at 02:37:09PM +0200, Stanislav Zaikin wrote:
> Add the compatible string used by Xiaomi 12 Lite 5G (taoyao) so its
> battery manager can be matched to a device-specific variant in
> qcom_battmgr.
>=20
> Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.y=
aml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> index 16ad4f5698fc..8ca057c4e3e6 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> @@ -41,6 +41,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,sm7325-pmic-glink
> +              - xiaomi,taoyao-pmic-glink
>            - const: qcom,qcm6490-pmic-glink
>            - const: qcom,pmic-glink

Is the implementation compatible with qcom,qcm6490-pmic-glink? The
driver does not bind that compatible, so I can't tell. Maybe some
Qualcomm people can answer this question. Please send new version
without the RFC tag, so that DT binding maintainers review this
patch series.

Greetings,

-- Sebastian

--ssj47hpacxsb424s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqhzJUACgkQ2O7X88g7
+pra/A//YdrIMPDBwyFfX/LPEpngZQBw4Ot0UE0/F5g2K/ujFs3y3DrAbpf/pRbX
reyLRpriTfJdRGRepi7cpdYUqpaXsbLX8K1DIGmpbhCd/vD+JmPmQuZ6aKH8u/ii
QFC3Qaa1enFc/Quayt7jekaPKd5o83uWkHBNVSguc2DXLqIOeMZ1wp2KpvSzwKMw
MJPh4X3WLa1lCKf1d7FkO7vvMiLzBu3VSfmxBpSbwTGmuMQorG5qpimXjYRBaFdD
TowTwwMDIk1P7hUr6h8XvFss6F0TaacNs40xOSjuePF3Wt3AcghUYVCpSkvJSRLX
LLn4TCpd1f8Gf/rRqN2r4LKbGpr+/aFCT/Nbl2Zm3Vc15n/p0Z+aHxbDsFwUArkL
m/fSdakz+IULkKeSCgmlMYb3UHKuZ8OWzP6dbt9S2HOdsSb76f0cX3LwolBOCrn1
si4aCX+894PGlYf5j/8PD4vLkQdzzQa9vI/M4AD/Q60londOIatweDGfNReg5v7x
wz3T2y7XSN4n3I2DP8MevOA16+1AiffLmFbbby919DjD/eyUO2gHDInohx3olEqo
mVCEgCNBISMjPzNck0IVW2coc2ngsL8a405VgDpuyssUB2GAi9X8HLXlDpvbBqbf
MjubHsrY5/boxUXVx64+qrT+1e8mrW6sZtvvSN1R94DUmUwGI/Q=
=kn/B
-----END PGP SIGNATURE-----

--ssj47hpacxsb424s--
