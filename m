Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064454;
	b=ww+6S5PhU/WyCYhErSll7rSDzaaBI38LoVDf316L3GdRTAxmrtQtPvr954plDdDVEEYQ
	 lyP9nqfKmypsRcmPYPKIm60qn0zKWv44ER2ErZLwNPuNIo2aP4TcqlGaOOJoK7XAf1NRg
	 MTIG+txxPmXef2/i7uxvPHp9ZL5Lmx0GU8e+ny3QbMZozNNRKHfxi2LSiVV5EiMNqNZJW
	 RlPLPuF4ZswRXZU6vOw94Y4lfseXzZZLDtB13aoW7VPISxQomG3C6mH9kxY4EZNawqrbI
	 Xz0YM0q4h9bjE5dDyAcSfXktF4vs/9/im9Pnm8LmS10WwQmFmpWCdU+urf1GhPuvZdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064454;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=AM2+ROYz6zHyjM9qbGIPn3yG3QGJhtGkC3tgAmCv0WE=;
	b=OPRXsE9pKOSVS0HS+A8mqMHAOJy30Zok88fHob6bwWW/A8C8Y06OsiI0FLFygCIx4/rb
	 Gmn0BoR3fVb7lP/UBdtWsvTN4Uj7WJvjzWIw1U3GnyPqiYYyR9H9pS0fWvaGBud2IASgA
	 sT/C3/lGoeSWH34QSio6Ca2PDc4L2TcpX5V2xSlSUrBPsSJA8g1Z2w00FLQlCZLrXPbsl
	 7YnbrmrqoiF5g6zWuPCd5H8pKMSNdO5dE6g6dd7wDqme0cLk7PBz/c5g/Z2kJdQNp1lLn
	 iwT8rY7Yx+j1yb0ENSTj7I2uflRjtuPPAEB8rcyiQbCFrmTdVb1mhLs0grtfVX6pUWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ANlytgWy;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2699606C004;
	Sat,  7 Nov 2026 15:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2699606C004
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ANlytgWy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=AM2+ROYz6zHyjM9qbGIPn3yG3QGJhtGkC3tgAmCv0WE=; b=ANlytgWyNbxksTlctB1IPmnOyw
	eVN8ZWy4Jk9Woz7x9MdiIUjtWgomTH3Zh3oLQLaWjyNesR8IAVyvb9htWNi0VjAJl5dImAwJ/2jhH
	4SO1BZKBOHp6QrMer/QOFmpOaPFFmv0FfchFRa2BZWwnH4tkavdWhHimHgzkzP6VM7iHox0J22vWp
	CrjI2E3FIyQQDpA8jkpGXZDEZPO/8UBflGmtaFZUzzQtUCarH4Chp36byFQyTGz9cvS+y18IMLX7B
	xdmvp03YJGwy2H0Kfg7A4+TskVQ9C4X4gxt60WeIJ41YdJhAgQXIiZsK1Mb3jikC525CkgbDGm8N9
	oVk5Kxuw==;
From: Heiko Stuebner <heiko@sntech.de>
To: rafael@kernel.org, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 6/6] powercap: dtpm: Add RK3588 hierarchy
Date: Sat, 07 Nov 2026 16:14:06 +0100
Message-ID: <17421425.hlxOUv9cDv@phil>
In-Reply-To:
 <973998404b628e5a995a06fbd0febce0802f79bd.1793666444.git.daniel.lezcano@oss.qualcomm.com>
References:
 <cover.1793666444.git.daniel.lezcano@oss.qualcomm.com>
 <973998404b628e5a995a06fbd0febce0802f79bd.1793666444.git.daniel.lezcano@oss.qualcomm.com>
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

Hi Daniel,

Am Dienstag, 3. November 2026, 05:48:20 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Daniel Lezcano:
> The RK3588 has three CPU frequency domains, with CPUs grouped into
> three cpufreq policies.
>=20
> Add a DTPM hierarchy for the RK3588 with one CPU node per cpufreq
> policy, represented by cpu@0, cpu@400 and cpu@600. Group the three CPU
> domains under a virtual package node attached to the RK3588 root node.
>=20
> Add the RK3588 compatible to the Rockchip DTPM match table to select
> the new hierarchy.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

[...]

>  static struct of_device_id __initdata rockchip_dtpm_match_table[] =3D {
>  	{ .compatible =3D "rockchip,rk3399", .data =3D &rk3399_hierarchy },
> +	{ .compatible =3D "rockchip,rk3588", .data =3D &rk3588_hierarchy },
>  	{},
>  };

the change itself looks good for the RK3588 (without variants), so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


but support for the family is sort of incomplete :-)
We have
=2D the rockchip,rk3588s (same as the rk3588 in terms of cores,
  but different compatible - see all the rk3588s-* boards)
=2D the RK3582 ... with a compatible of
  "rockchip,rk3582", "rockchip,rk3588s"
  Because this is some sort of chip with production defects
  where two _random_ big do not work or so and get disabled
  by firmware see [0] and marks them as "fail"

So as I said the change alone is fine, but there are additional variants
to maybe figure out in the future.


Heiko



[0] https://patchwork.ozlabs.org/project/uboot/cover/20250810222644.4095072=
=2D1-jonas@kwiboo.se/




