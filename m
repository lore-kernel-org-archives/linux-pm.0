Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9FE40627B;
	Fri, 15 May 2026 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834350; cv=none; b=eD+T/nNYqU6mpMz6wWGBys2yq8/tikjbFxm//YkGCrT9b3WslTTebn4CQkQ3Mz4h/RmvJzDWyEhMzqckSj7RP7daLKAN4moC/X6Ff4qQbaSdaEoJOR02+rXP1Srbfn09m9w/eo2hzEW4JLQEK3eQ5pIveXuCmy/KNkxX8fADOaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834350; c=relaxed/simple;
	bh=gFOxLwuKLJqHFVUAa7d0vs339f2pCox0FPD1LrAAnQo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VD2q8AG/TKb3MRDIueZqf0sCaKpbVoWM/fnQk52sK5r5pYaSvZu9HZ34rUjIWD2mmEIlLKkB5ScG78DdODJUaJFzX1+w2xJ5RQdGE1Y+VGe+yF6jFo1fKPLcfunX/g8C2fkK8E19sZisCW6Z4mr3TZzsqNi+yFKiocqJRQb03uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=StoV+jzp; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="StoV+jzp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1778834336; x=1779093536;
	bh=gFOxLwuKLJqHFVUAa7d0vs339f2pCox0FPD1LrAAnQo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=StoV+jzpjxbhAoP9HPjGBy18gotqnhuHTjD+iqdspaDUwbrDbH6brBTfXAV4CvsYz
	 MURN8g9kejR0W/sMHRBcxXm1xygP975hAQVs7Ttj/oQnIdRytg14FAnV2KFK3XMPJW
	 LlTErOdFlezTlVv4Z0+EoqYWQOKubCCVlGMzMtykSJpPLyYaSfR9HrmhTIIv87u8EZ
	 /IwnqSmDGRKBOHtQYlT2dR5j2HDY0ywcg6Qmf+IkEKko1Tk1uhuclFF9utA42IukFI
	 S1jeQ331cIsWIyejiICOu403zxKKC/fEe9yfLCaOidtkhSVbLnIlZ2wOrlBn8kZDeC
	 7WPe05ky813jQ==
Date: Fri, 15 May 2026 08:38:46 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Matthias Brugger <matthias.bgg@gmail.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 16/16] MAINTAINERS: add MediaTek mt6323 PMIC thermal driver maintainer
Message-ID: <F4Z7s65enSXh9nWU9ypYTOaxyIVJX68NzxyJAH6FDNZxtJ-3JwSc0iIsK9v5rwdavG2SlwyuIp1cz-N4s2P7OwTHJ69edEjQsEG40C0_yl0=@protonmail.com>
In-Reply-To: <20260514-sweet-electric-buffalo-841c18@quoll>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com> <20260512-mt6323-v2-16-3efcba579e88@protonmail.com> <20260514-sweet-electric-buffalo-841c18@quoll>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: d8c14f9fad7e94425200fd560e52fcb3d8ec6e2b
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Thursday, May 14th, 2026 at 4:03 PM, Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:

> On Tue, May 12, 2026 at 08:18:30AM +0300, Roman Vivchar wrote:

...

> >
> > +MEDIATEK PMIC THERMAL DRIVER
> > +M:=09Roman Vivchar <rva333@protonmail.com>
> > +S:=09Odd Fixes
>=20
> Odd Fixes means driver is half-abandonded, so please explain in the
> commit msg why you add yourself as maintainer but not really committed.
> Such entry makes more sense for subsystems, but if individual driver has
> odd-fixes stage, shouldn't we just remove this maintainer entry? If so,
> why adding it in the first place?

That is a fair point. As an individual contributor, I'm hesitant to use
"Maintained" indefinitely, but I understand that "Odd Fixes" for a new
driver is not the best idea either.

If no one else can take it, I'll change the status to "Maintained" for
v3, but I want to see if there's a more sustainable long-term home for
the drivers first.

Angelo, Matthias:
Since the patch series is about MediaTek PMIC drivers, would you be
open for taking drivers under "ARM/Mediatek SoC support" entry?
Or is there someone at MediaTek who might be interested in this?

Best regards,
Roman
