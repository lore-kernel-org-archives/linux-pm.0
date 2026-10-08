Received: from sender6-pp-e107.zoho.com (sender6-pp-e107.zoho.com [165.173.180.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F95391E7B;
	Thu,  8 Oct 2026 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455479; cv=pass; b=BCHNgD6tet80iPuNhKE8+eS6axGkMnn2dfzZtBQhrrt4H/5NMJB4yuDW/S7tHUTewGIYWjmlvxraxLcNRIXg21SitQGIQLyp6xbtPAs2Y+2faC+NsYa9B1NvHScErGQC+FGVPVX3Iw7TctqWzEG0+qvdSN65U5P4z0U+/x2ohxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455479; c=relaxed/simple;
	bh=HA8SGj7wkjRDNhhCWgOc+4BuevohIaoxRKoUSNRKTnI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=meSAPH7eQv5PEhLdLbLEO0XXwwEhWboAQcS5iMCko/JqC6s4sy5hOVxMXFThH6BcOPXyBrMYztGX8JuwHOy423i+3/59Ru3UbuxFa4pyEVdqXHv2oaIBSRvxcLfpKr0TOsxWn9s0BS0I+RRD+zDvLT9VkBCGKFmbJc3wXhx3GUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=Xa4CCTGd; arc=pass smtp.client-ip=165.173.180.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="Xa4CCTGd"
ARC-Seal: i=1; a=rsa-sha256; t=1791455464; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PXhlqnbIPeeyBMoq4zj6OsSao1PWn2yoke5wffLUsWw9+hZSA3HE8mAowQUYiWMyY0qtCoENa+kjOMJ56T+/8kdKmNUbp4qZMwYm08jJAm55Y7CHf2n1p5S5gfYGlomKC5mwQ0PMkJDbAey8lYRjL+SvKn6xWr3xKYqCcVSmk8E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791455464; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TEVIQ7jUIEPxC+HGK4sUt5stotdCUh3Q7I4XuQyq/vU=; 
	b=fXr22wZyjecSTBJj/MHndJ36pVf9nqiRyPB7zHwKZzGkKj05HnSbZjcxsKt69n2eJ50BhpTY4d7sbrCwCTNQjovej0+HKmC+B9hEdoTMBamGg7aBh+5P9DarQWekC5wvg7gqsThh8ooSsV7MgTVabyr3tjDvKeksDJzW1jkr6PE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791455464;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=TEVIQ7jUIEPxC+HGK4sUt5stotdCUh3Q7I4XuQyq/vU=;
	b=Xa4CCTGdyQqhGs5mz5XWPtLsG3z3tv3u/QC4Tm+jFyOf5gdqI08/GkVxdXDsiihg
	M/SxIwLKYhKiq/yRo+yK7sYinL9mvGL9AdSK9JCmSDVH+ItV5tYKD8Xi9KjNqprp0uc
	pvc+sfdr2Hsg58RX6Npl9fb0qsGzLihjTkNyOM1yyN1HCS3S3Y4QDTItjBEVCvxzOhZ
	a0QBXFNNJi5d/IGDzMBDhs9vOfvIcHPh8M5aPjUrt/zqt75nhNefFXpitQEgPPY1GUD
	r0hdD9TywyaqYQhr2uwSq/Zrl9O8bMD59JyL0A+3Nd3F3vffidBWaYN8WW/JI+kd7W1
	XDv+CgxSCA==
Received: by smtp.zohomail.com with SMTPS id 1791455462271972.5250923053629;
	Thu, 8 Oct 2026 03:31:02 -0700 (PDT)
Message-ID: <cbba422d4ba9bd4a036536a50fadc2760efa1ae2.camel@icenowy.me>
Subject: Re: [PATCH v2 1/2] dt-bindings: power: spacemit: Add power domain
 controller IDs
From: Icenowy Zheng <uwu@icenowy.me>
To: Conor Dooley <conor@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Iker Pedrosa
 <ikerpedrosam@gmail.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, 	spacemit@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 18:30:55 +0800
In-Reply-To: <20261008-df80c21d73b287d09b6baa78@squawk>
References: <20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org>
	 <20261008-04-k3-pm-support-v2-1-6f778a53dd2d@kernel.org>
	 <20261008-df80c21d73b287d09b6baa78@squawk>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2026-10-08=E5=9B=9B=E7=9A=84 08:27 +0100=EF=BC=8CConor Dooley=E5=
=86=99=E9=81=93=EF=BC=9A
> On Thu, Oct 08, 2026 at 03:44:29AM +0000, Yixun Lan wrote:
> > Add initial power domain driver support for SpacemiT K1/K3 SoC, The
> > Power
> > Domain Controller is SoC internal module which is part of APMU
> > (Advanced
> > Power Management Unit), it is responsible for managing power across
> > multi
> > power domains, which includes power on/off, isolation, power-on
> > sequence.
>=20
> You should prob mention that this APMU is already documented
> elsewhere.

Maybe it's also meaningful to mention that APMU already has #power-
domain-cells property, because the first reaction of me is to add such
a property (and then found it already there).

Thanks,
Icenowy

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable
>=20
> Thanks,
> Conor.
>=20
> >=20
> > Signed-off-by: Yixun Lan <dlan@kernel.org>
> > ---
> > =C2=A0include/dt-bindings/power/spacemit,k1-power.h | 14 ++++++++++++++
> > =C2=A0include/dt-bindings/power/spacemit,k3-power.h | 12 ++++++++++++
> > =C2=A02 files changed, 26 insertions(+)
> >=20
> > diff --git a/include/dt-bindings/power/spacemit,k1-power.h
> > b/include/dt-bindings/power/spacemit,k1-power.h
> > new file mode 100644
> > index 000000000000..41ef540b5c44
> > --- /dev/null
> > +++ b/include/dt-bindings/power/spacemit,k1-power.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +
> > +#ifndef _DT_BINDINGS_SPACEMIT_K1_POWER_H_
> > +#define _DT_BINDINGS_SPACEMIT_K1_POWER_H_
> > +
> > +#define K1_PMDOMAIN_VPU		0
> > +#define K1_PMDOMAIN_GPU		1
> > +#define K1_PMDOMAIN_LCD		2
> > +#define K1_PMDOMAIN_ISP		3
> > +#define K1_PMDOMAIN_AUDIO	4
> > +#define K1_PMDOMAIN_GNSS	5
> > +#define K1_PMDOMAIN_HDMI	6
> > +
> > +#endif
> > diff --git a/include/dt-bindings/power/spacemit,k3-power.h
> > b/include/dt-bindings/power/spacemit,k3-power.h
> > new file mode 100644
> > index 000000000000..519fbf946312
> > --- /dev/null
> > +++ b/include/dt-bindings/power/spacemit,k3-power.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +
> > +#ifndef _DT_BINDINGS_SPACEMIT_K3_POWER_H_
> > +#define _DT_BINDINGS_SPACEMIT_K3_POWER_H_
> > +
> > +#define K3_PMDOMAIN_VPU		0
> > +#define K3_PMDOMAIN_GPU		1
> > +#define K3_PMDOMAIN_AUDIO	2
> > +#define K3_PMDOMAIN_LCD0	3
> > +#define K3_PMDOMAIN_LCD1	4
> > +
> > +#endif
> >=20
> > --=20
> > 2.56.0
> >=20
