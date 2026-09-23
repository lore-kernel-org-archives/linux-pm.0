Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072BA3E5EF8;
	Wed, 23 Sep 2026 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153922; cv=none; b=Ir0/fMkbFtj+e9SwE0qkYhvq54nXJHNESGlGtEK4oaCFkIkpwv5Ahe6ZnHSYKzetAbQUecC+/asDNVzzaWUsoA1eAC76WUyC1r8Xo+15OJ5OkuJimtzf4FUz0Ihn8ke3Ht6hCKDgOD4cztJng9gdZro9RkDsLLhXAM3nBUo0pGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153922; c=relaxed/simple;
	bh=g3hVjMA0R6/ltT9SHfldVqMWXu4JxuRkAB1CHzis8rM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXHCGP2Y5y5LXqITffQadydy7FD/8oh+SCuok4bRtgaalWN37+JuNgd5o04/UhIoU/l0l2/o7tqo39d0v2w0pSEJDd32TdgkFDLwLzMBERKSmYjTO9j4deZR/VQV4S+W6i6ST3dPK/5ovQh0lHbaN8sE9mn/39oGky/yMWZZEac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=bSL/Aqnv; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="bSL/Aqnv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1790153911; x=1790413111;
	bh=0reunzXmmAlNC6QmWf9sB2B+ZpS4HPPFDGCNxxmhsL4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bSL/Aqnv5i1WoJpO4J42Q1rB0nbJ2+sPGLyBJWRKgSe3qQft7lvEzarvmDMB13wjB
	 D1AermV1KzlnDF90rhlkjtnII6dZN6h4QeEcHaxSuWJyhaP+XEqBGIt9aH6oDS0gON
	 u2W+M10890a6eqYAf9XjEjcQozoJrP8CMiUBLI/Q8+l2zu/i6hHlSR8kzEylwE9Ygp
	 nft0jLqZ1xH6EJB5pEmi2FbcPmbQJtMsR7kSW0cUCvXZ2RhaoTmGmSehIn8CV9m94A
	 2GsHxfh6kCIF0Nqy1LGcf7S9rky2BOe0i33K8+C3bnQu0NOLwYeKu14AAn2D3cktpw
	 4ysJtnXQ9NdWw==
Date: Wed, 23 Sep 2026 08:58:27 +0000
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/3] cpufreq: mediatek: add mt6572 support
Message-ID: <_cWfHoNhfNqR8gHZc9mDkr4jScRg_xP3_yWfR9JqeDpaulfmw3nkbOhfWiqCPhWgG3SgH07xGtOEQ_Afivo61Ldan09HV0uTnas7lBCBI1A=@protonmail.com>
In-Reply-To: <b98716ab-1c7b-4da2-85c8-e425be39b4d7@collabora.com>
References: <20260923-6572-cpufreq-v1-0-41f7af6d6d1a@protonmail.com> <20260923-6572-cpufreq-v1-2-41f7af6d6d1a@protonmail.com> <b98716ab-1c7b-4da2-85c8-e425be39b4d7@collabora.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: e93288f4c7e7a54fb417d16ef81b885f5c370664
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, September 23rd, 2026 at 11:36 AM, AngeloGioacchino Del Regno =
<angelogioacchino.delregno@collabora.com> wrote:

> On 9/23/26 09:23, Roman Vivchar via B4 Relay wrote:
> > From: Roman Vivchar <rva333@protonmail.com>
> >
> > Add mt6572 SoC platform data for CPU frequency scaling.
> >
> > Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> > ---
> >   drivers/cpufreq/mediatek-cpufreq.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/media=
tek-cpufreq.c
> > index f15135b2898b..615bccc77c98 100644
> > --- a/drivers/cpufreq/mediatek-cpufreq.c
> > +++ b/drivers/cpufreq/mediatek-cpufreq.c
> > @@ -737,6 +737,14 @@ static const struct mtk_cpufreq_platform_data mt27=
01_platform_data =3D {
> >   =09.ccifreq_supported =3D false,
> >   };
> >
> > +static const struct mtk_cpufreq_platform_data mt6572_platform_data =3D=
 {
> > +=09.min_volt_shift =3D 100000,
> > +=09.max_volt_shift =3D 200000,
> > +=09.proc_max_volt =3D 1250000,
> > +=09.sram_min_volt =3D 0,
>=20
> Are you sure that there's no SRAM regulator on MT6572?

Yes. There's no 'sram' mention in the downstream code, neither mt6323 has s=
ram
regulator.

> If there's none, there's no need to set sram_min_volt here,

Ack

> but if there is, you
> also need to set sram_max_volt.
>=20
> The ccifreq_supported explicitly set to false is ok for human readability=
 of the
> SoC features - that's also unneeded but keep it for the same of understan=
ding
> what's going on with this SoC.
>=20
> Cheers,
> Angelo
>=20
> > +=09.ccifreq_supported =3D false,
> > +};
> > +
>=20
>

Best regards,
Roman
