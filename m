Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BA83E4115
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282655; cv=none; b=jAMJoswcuww2PR3Ypb3IFbcJ/wju3LQfDp39JZE8s7TaqRiiinZNFHGylg8p/JYLJhLIWxco32ut93D03zmj1qQD7Oy9CVYnxkwPmRwlxAMuI3NEkbbjtKyIbc2sPqS7cgbBxdzJh6v4BsOED74pRK5OLvYqRInYpu162OCJyXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282655; c=relaxed/simple;
	bh=xQbV5GbBp43r4Try8maWYx6KPArL8fbqa1bW31iNOu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPJAcTWfIEBUJAi9CCmQffuiXY4eaYjrxPYiSDhAmJs+k7Rb3Hj9nLIutV1N+DMCRUHwWqH7iHg551Tl9V+D4F/q5kwhXP+03eXKDDU0vX2NtQgNHUAxD5DD7W2r7tqcvegGT4n/b8oRppPClXMF4JeztQ5nySs5ygaSJN1nG5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD0cwu0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD0cwu0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EBB1F0089F
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 10:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791282653;
	bh=5ZaN40cf3gaPYVrOntAep/0sU9jdzMlSTIwHDqydOaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dD0cwu0NaDmzI6FDzUr53SqL2l2laUa5BRdUfSDXpMeJulyDsNvKsVevM17EV3FEd
	 UnKpbzoEAi1KOzIDEnEX7hQZBVO5C3K16NnV0NfEVsa75lDW43NjtZdYPMUCx8kT6T
	 V8dDmhAxtndAcxWds7MxUMrjuRmmQvQuryZPTJHIBHYHLkXZGXoeemLfEexl0uadYO
	 x7OD+ttM+AOxtRzH0yQD4Mh6ONR7x4isxees6zA9pEdZ9XuqQ8uB2KiPLHPnoUTkJP
	 jQfDo++ybon7Jrf/vh/St2hPwor3pVNafuKsj1hcHTvtBSXNJsk2YgzKp/i53Om+GZ
	 xpXvOTPX/BvJQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a9841363b5so3079201fa.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 03:30:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByiJriXZTmFkRaAzkjWHQBQIXOLjxUEEEZmxZClenIk01c8nw/5dN8+o27+IL6f+ktRTTIl3ThCRw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIjPA6OH0rY44cH7gkesMr7PJaG3oGVzPgdHZnnqnlV0lromOmN
	QjGUdSQ1k0DNEic4ioNpCsUcN78g0RzqpszJ5Jh3F1mAZrpxXTATlc6KvZhKSfbJzlPbOHvWDXa
	HdSRCZGbWzIZ0SA492RiVv5rzrSFVIWI=
X-Received: by 2002:a2e:9fca:0:b0:3a9:969e:98a6 with SMTP id
 38308e7fff4ca-3a99af67db3mr1737921fa.25.1791282652577; Tue, 06 Oct 2026
 03:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 6 Oct 2026 12:30:40 +0200
X-Gmail-Original-Message-ID: <CAD++jL=gFt9kKZH9T-m8B_pbwRvzc35tTrMn5V238d3528DpUg@mail.gmail.com>
X-Gm-Features: AclHuK_AtwEo8WT_r25jczYf_hFshziwzfIIOr6vEXjFvPYUcVAgc5OmT1Oo8GM
Message-ID: <CAD++jL=gFt9kKZH9T-m8B_pbwRvzc35tTrMn5V238d3528DpUg@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] pmdomain: st: ux500: Implement ux500 power domains
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dmaengine@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Frank Li <Frank.Li@nxp.com>, 
	Frank Li <Frank.li@oss.nxp.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Frank Li <Frank.Li@kernel.org>, 
	Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Mon, Sep 21, 2026 at 12:48=E2=80=AFAM Linus Walleij <linusw@kernel.org> =
wrote:

> This series pays off technical debt from the beginning of the device
> tree for ARM initiative in the early 2010s.

I have so many fixes series that need to land for v7.4 that this is
mostly targeted at v7.4 at this point.

However:

> Linus Walleij (18):
>       dt-bindings: power: Convert Ux500 PM domains to schema
>       dt-bindings: arm: ux500: Drop NR_DOMAINS
>       dt-bindings: arm: Add the actual power domains on U8500

What do you think about applying these three patches to the
PM domain tree as a starter for v7.4 if it's not too late?

They are reviewed by binding maintainers and should be
uncontroversial and will make it possible to avoid trouble when
merging more stuff later.

Yours,
Linus Walleij
