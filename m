Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032267;
	b=vMokSYlT07vrguJT/kBfNxwlrChI5Edh1ndzu0zsjRXr/WS/2hRwfQMQ7uqzmNjyk5Mg
	 5m06gnWcPT+SlKjeQ8SGNvz0MGoCQBd1Z5O/MoAbW4foI8z8xWDDr0orFUUSRRHetpx5E
	 v9QwA4DCulYJPZxMIKeDWLAJvL7gYvgt5eVwK3SgF3pEmPsiCmAfsNsyhUKmJ98AM0M0b
	 Bm5j7TgWUyUCqgryuWeqW7By9q6SdMGZdfyuQtSClU9fmu+EXokL45iriRaQenBbhq3AJ
	 NH4eRWVZLr58kUboDdbF3vP64YLf0viGIV54bX5lPpySOi4kFv/3Hke20zMoHHLpv7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032267;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=GZNlEJ57vvQoyzdnQf9Tf6a/soql6P4/Cbt/mYWG1eE=;
	b=Kxl86tNnKf8lauX487lsaD6bWI4DTYm1BytKK5yg9ehqWskCvd42EsnE50g/7oysAYpS
	 n3xsVOnF1btzsmgfB8pq6HkRABZ45/rVPBheC1VjqqyU+iILoWf/fIFS8hBXUdCAwEzQ1
	 Fi6aGlBnsm2UPCpbVX3q5LL7bkHrvC783tCuF8p9qsHYziV9+6LAIbSXlQROUOUYzoXCM
	 pMYH8sGu03simwcvyw4RjObK4fwEVcpPdEQNrlbqRzzMvxOi/3v7nOR8qpNs3YhDAbib/
	 5ziiJw+AIxiJcbcsEqvvOQySAE+bfWDz2BXAWqjS1P1Yd2YXXf6OxwgHQT9IBpVpq5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sverdlin.org;
	spf=pass smtp.mailfrom=sverdlin.org;
	dkim=pass header.d=sverdlin.org header.i=@sverdlin.org header.a=rsa-sha256 header.s=purelymail1 header.b="IYRG/xW4";
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=opf4l8EM;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A1606A325
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 20:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D6A1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sverdlin.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sverdlin.org header.i=@sverdlin.org header.a=rsa-sha256 header.s=purelymail1 header.b=IYRG/xW4;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail1 header.b=opf4l8EM
DKIM-Signature: a=rsa-sha256; b=IYRG/xW445PJRT4UmZRgekHROgeT6auxlIgxTpu/5m7YtxNvPlNdUcWI1CD5+VuSFe+IO36Mr/lirfI0fK+ivsoI9AaED6fPk+g3kJxhHWEUuQVVxMCHQzKIWeA1UARlPrsB7xeWtdjO0vs+GEmlxplHXIGPDyQBJP1+Tu3mmIxnmZ4cVo5gFDi+20rTGiLr1qRGaId64iJgmQrbrh74svfiqAdTi3wofMUkl2jy8rfD9+vvV99c9lVqJe5Osc3PYaPs3ndbY0x9/pUrBs/AfASlJPa2x2HWLb0O0q3kXCcg1gMOAvVLbdT7TRp7pD78aNFdaIIbhtbBXdM7+NavHA==; s=purelymail1; d=sverdlin.org; v=1; bh=GZNlEJ57vvQoyzdnQf9Tf6a/soql6P4/Cbt/mYWG1eE=; h=Received:Message-ID:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=opf4l8EMklNabkEMKp+mORQZKQyKsAWUzdyFmxlVmoLTVLz/Wl0EibNt5CvrdJpBngfLhdUhBCAO9MpR722hU9p4XzRv3MUv//T64oEgUzsJom4KySXNG5M3txHPExJVchEqEWhLvcgo+XrHd0OfMEFVV1zK6SeV5rkVFUdbGbotazM66Oi0hBH9UgJ+TnDZApWnmSftQ1OhtFbPpYRar3C8NrboSQrWvYroKdT0NOGnmxso3S+iLeSGom4Z5SNZ9OuWNMhxaZF2fVZzWWfgMYmn8w8hofIyFa0X6DRqbAecChE0mKI+oSmXeZAAS179BnCS/dgifmihdmQ05+tglA==; s=purelymail1; d=purelymail.com; v=1; bh=GZNlEJ57vvQoyzdnQf9Tf6a/soql6P4/Cbt/mYWG1eE=; h=Feedback-ID:Received:Message-ID:Subject:From:To:Date;
Feedback-ID: 815097:39668:null:purelymail
X-Pm-Original-To: linux-pm@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 885494569;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 18 Nov 2026 20:04:09 +0000 (UTC)
Message-ID: <8a2d6ac552e7a5b7142dc00b72edd0d3b7a1382c.camel@sverdlin.org>
Subject: Re: [PATCH v2 5/6] arm64: dts: allwinner: a133: Add CPU OPP table
From: Alexander Sverdlin <alex@sverdlin.org>
To: rajanyadav0307@gmail.com, Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Cody Eksal <masterr3c0rd@epochal.quest>, Paul
 Kocialkowski <paulk@sys-base.io>
Date: Wed, 18 Nov 2026 21:03:59 +0100
In-Reply-To: <20261118-a133-series-v2-5-8bcec9c9aadf@gmail.com>
References: <20261118-a133-series-v2-0-8bcec9c9aadf@gmail.com>
	 <20261118-a133-series-v2-5-8bcec9c9aadf@gmail.com>
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

Hi Rajan,

On Wed, 2026-11-18 at 04:52 -0600, Rajan Yadav via B4 Relay wrote:
> From: Rajan Yadav <rajanyadav0307@gmail.com>
>=20
> Add the A133 CPU OPPs from the vendor BSP (sun50iw10p1.dtsi), plus
> 1608 MHz for b0 and b1 from the vendor table in the factory firmware of
> the KickPi K5C. There are ten voltage sets, speed0-5 for the a0-a5/a6
> grades and speed6-9 for the "high speed" b0-b3 grades.
> opp-supported-hw selects the frequencies of each grade:
>=20
> - 1464 MHz only for the a grades
> - 1416 and 1512 MHz only for the b grades
> - 1608 MHz only for b0 and b1, the revision A-E "high speed" grades
> - 408-1320 MHz for all
>=20
> The highest voltage is 1.18 V, inside the 0.81-1.2 V recommended
> operating range of VDD_CPU in the A133 datasheet (V1.5, table 5-2).
>=20
> The BSP uses 1008 MHz where the A100 table uses 1080 MHz, at the same
> voltages for a0-a2. U-Boot starts the CPU at 1008 MHz, which mainline
> now reports as an unlisted initial frequency. This table follows the
> BSP.
>=20
> The BSP table stops at 1512 MHz, although some datasheet versions list
> 1.6 GHz for the A133. The factory firmware of the KickPi K5C (Linux
> 4.9.170, built January 2026) has the same table plus five OPPs:
> 1608 MHz for b0 (1.18 V) and b1 (1.13 V, at most 1.14 V), and 1416 MHz
> for a0-a2. This patch takes the 1608 MHz OPP from it.
>=20
> The K5C is a b2 part and never uses this OPP. With a test-only change
> that forces the grade, the CPU PLL locked at 1608 MHz and the PMIC was
> set to 1.18 V for b0 and 1.13 V for b1. Forced to b0, two 20-minute
> runs of full load on the K5C without a heatsink reached the 90 C
> passive trip after 10-13 minutes; from then on the temperature stayed
> between 83.5 and 90.4 C.
>=20
> The table has the A100 compatible as a fallback and the speed bin cell
> first, so a kernel without A133 support selects speed0-2 from the speed
> bin and gets the voltages of the A100 table, with 1008 instead of
> 1080 MHz. It needs the efuse cells added to sun50i-a100.dtsi in the
> previous patch.
>=20
> A script compared every voltage and the frequency set of every grade
> with both vendor tables. It found no difference to the BSP file other
> than the added 1608 MHz OPP, and no difference to the factory table
> other than its 1416 MHz OPP for a0-a2.
>=20
> Claude Code (Anthropic) drafted this table and its message from the
> two vendor device trees (numbers only) and wrote the comparison script;
> I reviewed it and tested it on a KickPi K5C.
>=20
> Suggested-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>

I've re-tested the whole series on HelperBoard A133
("marking 0x1400, bin 4, revision 6: speed grade 9"),
no 1608MHz for me (as expected):

# cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
408000 600000 816000 1008000 1200000 1320000 1416000 1512000=20

Reviewed-by: Alexander Sverdlin <alex@sverdlin.org>
Tested-by: Alexander Sverdlin <alex@sverdlin.org>

> ---
> Changes in v2:
> - Add 1608 MHz for b0 and b1 from the factory firmware table, as Andre
> =C2=A0 asked; the commit message describes the source and the K5C tests.
> - Alexander's Reviewed-by and Tested-by for v1 are not carried over
> =C2=A0 because of this change. Alexander, could you check whether they
> =C2=A0 still apply to this version?
> ---
> =C2=A0.../boot/dts/allwinner/sun50i-a133-cpu-opp.dtsi=C2=A0=C2=A0=C2=A0 |=
 182 +++++++++++++++++++++
> =C2=A01 file changed, 182 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a133-cpu-opp.dtsi b/arc=
h/arm64/boot/dts/allwinner/sun50i-a133-cpu-opp.dtsi
> new file mode 100644
> index 00000000000..dd5fdeea7ea
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a133-cpu-opp.dtsi

[]

> +=09=09opp-1512000000 {
> +=09=09=09clock-latency-ns =3D <244144>; /* 8 32k periods */
> +=09=09=09opp-hz =3D /bits/ 64 <1512000000>;
> +
> +=09=09=09opp-microvolt-speed6 =3D <1180000>;
> +=09=09=09opp-microvolt-speed7 =3D <1130000 1130000 1140000>;
> +=09=09=09opp-microvolt-speed8 =3D <1100000>;
> +=09=09=09opp-microvolt-speed9 =3D <1080000>;
> +=09=09=09opp-supported-hw =3D <0x3c0>;
> +=09=09};
> +
> +=09=09opp-1608000000 {
> +=09=09=09clock-latency-ns =3D <244144>; /* 8 32k periods */
> +=09=09=09opp-hz =3D /bits/ 64 <1608000000>;
> +
> +=09=09=09opp-microvolt-speed6 =3D <1180000>;
> +=09=09=09opp-microvolt-speed7 =3D <1130000 1130000 1140000>;
> +=09=09=09opp-supported-hw =3D <0xc0>;
> +=09=09};
> +=09};
> +};

[]
