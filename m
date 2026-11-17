Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955279;
	b=EOJ3OJ+msAO9onw8w6HzFKS6HlTZLaDxHYc7DLRenu3OkTjoh6Ql0Eq5x4NyIrTBRn1G
	 7PbtQtkhTS5AL1p/lb7yO8o4+JOAcRxuNkGnm1g3efrCvY0tLnUeVUbVCidJ+unoNmNFg
	 SVGWrB5TnLVP8Vp5lPo1dx17ogCwJQcKEA7duRUj/qxrRwdeggzodOFD+WSul0gyfBI9n
	 3Iy8Vf3J45S6NNf988rGU/XILklvr+QAQxkCGsFvwPYmFdIvOUf3vD4en139HOHiVranw
	 CPUfEVj9E7xau2jwsBDIS7ZvI2sDtPxpDlcfvSiKkBSBRyiaUyg9HG17JKpgNeiopbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955279;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=VYz9U40WK19ephf0M0jjCw8I18eEhFgVrlWaiCcqP8M=;
	b=mao9mhcSJj/YDShpRZ67X+H0+2nVdd0S3ESPRiIdxEXr43k+vrYKu8mO0Zd7IPVG4IBm
	 1lZOyxpv8ATXhfnrn83+xxhPo/VdLP9oOTNdrTHAmG5RIUYeGmYqwLiDo9yF20MexFv0c
	 wvmejoYapn4kcMoBXOE7Loy6GXIrYmTZWny78CPHnXVWciTI0aXxojWqowrIsDsPgjoUk
	 CaRzlgsbowHwZHmOS2RfuiDjDXIC1iRCMNcIz2cwyq3NNnB64SfH5ERaCo/BTKpQguf58
	 2csZuRpUCYcSraOtMVuYIznfr0oKu5Bv9obpm6waj4xFxDYbXCJN6LDdgM3vXPI847Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sverdlin.org;
	spf=pass smtp.mailfrom=sverdlin.org;
	dkim=pass header.d=sverdlin.org header.i=@sverdlin.org header.a=rsa-sha256 header.s=purelymail1 header.b=Rnfm5c7O;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=CfHVnquw;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57D606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 22:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B57D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sverdlin.org header.i=@sverdlin.org header.a=rsa-sha256 header.s=purelymail1 header.b=Rnfm5c7O;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=CfHVnquw
DKIM-Signature: a=rsa-sha256; b=Rnfm5c7Omqi+qVZSyeZvTs2HsYwCBSu7zSj8NkVkmiHYY8GTdzfAvXFWaizXM1EKcMuKXeu6t9pp6TtefKxLN0GT21PI3vwq0SmjzG/FMrQe6rwdCwpY72FiGyRdGIkQNrCsLJVxR1SIc8+T2ooVJUr4Rgt4F4b38H213y8bi9Y/+XpZK5yRpO6iTyXPPAEpbGsYnG6SUDk9/Pi4zZDAcwEsCLoPT4iQJ17x2HcoY2d4Jbiccss4QpIjjG6V3FqZfv84bMjMcxbMiy5jVE3Hkh1mDReDwx6OqzaEeC/FO5Gq+xB8fYmGqi39VXrAossFmSF41h0ysEH+F12hQstNew==; s=purelymail1; d=sverdlin.org; v=1; bh=VYz9U40WK19ephf0M0jjCw8I18eEhFgVrlWaiCcqP8M=; h=Received:Message-ID:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=CfHVnquwS75szLeOqixkL1ZKuvI7QzGtKeozivf9MzyIGY0Kuf28LVil6efC4xECI7SFMf8GWfCfu2+w5YHj5o1G8md3nHXJqjXz8R9+5nTCADrpMY3Ymwyj8ZECBEBY2XWpfEfNZsUM48TgHe2fo5/xVol95WeYYSPn6NfzKitiYA5JcxCb4nscp+4DD+5yfKQVmcOcTXVukOn8BHT/OYWN7m6uUJXpLtkVZqFHhsJ5ctzShDpVFl7rWlbQ8xA12EPr25TYxDvxFbd4Kc0JrCUJ3JaNtkkRzHTR4VIFkaBnCVRQcsTxMDk2ocD0c6l+zf1ONzYvVOw8BIZcIRpG2g==; s=purelymail1; d=purelymail.com; v=1; bh=VYz9U40WK19ephf0M0jjCw8I18eEhFgVrlWaiCcqP8M=; h=Feedback-ID:Received:Message-ID:Subject:From:To:Date;
Feedback-ID: 815097:39668:null:purelymail
X-Pm-Original-To: linux-pm@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1693380044;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 17 Nov 2026 22:41:15 +0000 (UTC)
Message-ID: <9f30d506be74bf49626440a7f013a748dde3ec2d.camel@sverdlin.org>
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: a133: Use the A133 CPU OPP
 table
From: Alexander Sverdlin <alex@sverdlin.org>
To: rajanyadav0307@gmail.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Cody Eksal <masterr3c0rd@epochal.quest>
Date: Tue, 17 Nov 2026 23:41:03 +0100
In-Reply-To: <20261104-a133-series-v1-6-58217cb33a87@gmail.com>
References: <20261104-a133-series-v1-0-58217cb33a87@gmail.com>
	 <20261104-a133-series-v1-6-58217cb33a87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Rajan!

On Wed, 2026-11-04 at 22:41 -0600, Rajan Yadav via B4 Relay wrote:
> From: Rajan Yadav <rajanyadav0307@gmail.com>
>=20
> Switch the three A133 boards in mainline (Baijie Helperboard A133,
> Liontron H-A133L and Teclast P80) from the A100 OPP table to the A133
> one, so the speed grade is selected as the vendor does it.
>=20
> What changes depends on the chip:
> - revision A-E parts with a normal marking ID get a0-a2 from the bin
> =C2=A0 field, as they get speed0-2 today, with the same voltages; only
> =C2=A0 1080 MHz becomes 1008 MHz. The exception is a part whose ICPU and
> =C2=A0 PCPU values are in the range for which the BSP forces a0.
> - revision F and later parts with a normal marking ID get the a3-a6
> =C2=A0 voltages: higher at 408 and 600 MHz, equal or lower from 1008 MHz,
> =C2=A0 and 1008 instead of 1080 MHz.
> - "high speed" parts get the b grades, with 1416 and 1512 MHz instead
> =C2=A0 of 1464 MHz.
> - if the firmware does not provide SMCCC SOC_ID, the driver keeps the
> =C2=A0 A100 selection, adds the BSP's a0 rule for normal parts and warns =
at
> =C2=A0 boot.
>=20
> All three boards supply the CPUs from AXP803 DCDC2 with a 0.81-1.2 V
> range, which covers every new voltage. Without the A133 support in
> sun50i-cpufreq-nvmem the A100 fallback applies. The Teclast P80 also
> needs "cpufreq: sun50i: Handle boards with the allwinner,sun50i-a133
> compatible" to get cpufreq at all.
>=20
> Claude Code (Anthropic) drafted this change and its message; I
> reviewed it. I tested the A133 table on a KickPi K5C; I cannot test
> these three boards.
>=20
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>

Reviewed-by: Alexander Sverdlin <alex@sverdlin.org>
Tested-by: Alexander Sverdlin <alex@sverdlin.org>

> ---
> =C2=A0arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard-core.dtsi | 2=
 +-
> =C2=A0arch/arm64/boot/dts/allwinner/sun50i-a133-liontron-h-a133l.dts=C2=
=A0 | 2 +-
> =C2=A0arch/arm64/boot/dts/allwinner/sun50i-a133-teclast-p80.dts=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A03 files changed, 3 insertions(+), 3 deletions(-)
