Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C2370D45
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886969; cv=none; b=Qj3R/4AGjLDqvTuDgZkMJNtjFaha1+OAPKv/ihPxxBCFO2fG8yoqGrlEnVanAxfyK8LbE4CbflRph+xNr8bc8/WF4G2HUAYCQdHJca0VMC03sRPag3+ZXwTyI8NdyWOkpeZOkF9k3u2yCqYQ2Y+frGY+dKIfo1tQb5RWDZVLkeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886969; c=relaxed/simple;
	bh=1jDHS3//SVF2/A/vC8oT6/lwq+kdzpM3dPjKRF+cWNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNalEorYS1oZPM/lffXSI9WWfa8PSkS9+GOBOose28XbOFuGNOlrvPwz90jJrqj0L9VQR3WCKQVQYeVXg9svPGRXlGelA/nF+zAYUm8FKDiE0tW0g2XMcFcTDxcd05fTugH+5HKMeMzRUSVzSiRt2w8SAKvPt1WImW99QHVncEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RY/vPrR0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RY/vPrR0"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b936331786dso762463766b.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 12:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776886966; x=1777491766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8JHz3Efp15Ndyc9pOP3Ax7qZyPD4IXnQM3cK5pq58E=;
        b=RY/vPrR0O8jH7Ez3I+Dir72gco0n6uGUuDA3TgtrHWAGu7vCH4rm4gKfkaaKdXMN2m
         D4xYINFNjCCqZvLEjVWlp/lZ1DWund4J4W0RvksJfxbUvNeJxLPa2XTmrJjwejM9wE8a
         qUGm7P++qIkjx87o9XIpLBqD3NjKrajszW8bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886966; x=1777491766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A8JHz3Efp15Ndyc9pOP3Ax7qZyPD4IXnQM3cK5pq58E=;
        b=X6/qMODnEuWfnaXE6Wpsyf0LAnEOwVHSdQ0/9PBSmWJR+MYApx1LDd3wqwk643LlSr
         e5sbOR6AzLCohtqlcu9HeNrFhlnmT5AYKiiK40a5asfv53aenXUIV0kXwDBbdOkk4b6k
         P+zVDqp7N50eeOtu6H1KZ0xNhfCeABXALwUIFeJsGiKfMxYsSh8zCXT4aLVMIQvzthBt
         8YGdktdaTgxymu7nA47VX6FDBJ+SWyUClr3mF8JMIRtcA8483dDji4Z4zzU+TMtYm3PU
         9GN9vhxHHYmQ/mvrF6sb7YtBMlYq7rAhlr7eSTjyikmlTNMz/s1qBtXqU5UaR7ihdjw8
         7h+g==
X-Forwarded-Encrypted: i=1; AFNElJ+bfpSOplgtVo+j6HdXuBfP+J0abOGK8zPuJkuzg9efD8Pq9UBuNlQqBUqbfy8JBARgz1iV/DJ6/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgnuJrvh1ZR9es3pR4KcWqM+vpjU6Bu8I2u6rZK/dOOfBiJWko
	p7jnz7q1j0X2VBHM6K3Lz2bfOd/8gbhpeLubxL/rsUhFZogKKLFz341TF2Q2Vq6cZNJx6txc9aV
	+7Jb08z2c
X-Gm-Gg: AeBDiescrDfKCBhd+7hL4oEm4TUykcNHklvo0LtkiPPmFCo1JNbuT2eOpb6/mdPtkP/
	5hn5zBQBMsfB4f7OTV0QCW/ZKHPPDQzQ7T/FFYB08aWhFH84+V6jorGzt7AWbeDgSo7Q2SkQqpR
	FG2AaKhjQMXNE3JT2Ew4JlHE90yA65amb7qEgEsAdJ98miZULU+mSkRdrLkgmScosKS0hatgqOo
	zU9KNYTs/my4Jj2K7P1uVTcl7SaDierdmg31pv9g+4xeOM3mNp+H9brQ+o3kdh1aMK05MgV4IYc
	P07+IEMTlkFeCAIvaj3wSfRFwf2EnRl6KWnmEr3SUclYGyPYDFep5FEZEvQP5Fam7rbrA0ATlC+
	9gKJr1n/owZ0MlaO3/tHZIt8NDzplQDM5qPFcTu+1kQgr93z/KI80PaNrRfWPQXHCOaS8B69WSm
	6KgWo0F4O29+QOo24GRpEWaWK/T+OIwYg9JZoMeyWRAZEMRekbcyz+uKHFPHXhvxDMTGXkOg2oL
	i+hZXPAe2o=
X-Received: by 2002:a17:906:fe4d:b0:b9d:ed9a:5f30 with SMTP id a640c23a62f3a-ba41b1dfccdmr1238371366b.48.1776886965708;
        Wed, 22 Apr 2026 12:42:45 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451211091sm617204866b.5.2026.04.22.12.42.45
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 12:42:45 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b936331786dso762462266b.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 12:42:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/esCSqnMWeULaw2gszCUAD2wwvlguvDYIOH1+GtpBeXU/Jd5ERKXkFgnpvwJLCmo3VOJJXekQXhA==@vger.kernel.org
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a55743d05mr122645615e9.27.1776886533988; Wed, 22 Apr 2026
 12:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com>
 <20260325143555.451852-3-herve.codina@bootlin.com> <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
 <CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com> <aekg_IELc65BFrWp@ashevche-desk.local>
In-Reply-To: <aekg_IELc65BFrWp@ashevche-desk.local>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 22 Apr 2026 12:35:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
X-Gm-Features: AQROBzBA2DSdR2HBaIYSKp4MrG-iWYSiPDxUw6OYCOPyJYNxN20LzPXgyZNheJI
Message-ID: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Herve Codina <herve.codina@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Niemi <kaleposti@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 22, 2026 at 12:27=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 22, 2026 at 11:51:36AM -0700, Doug Anderson wrote:
> > On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com>=
 wrote:
>
> ...
>
> > > > +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
> > >
> > > After commit f72e77c33e4b5657 ("device property: Make modifications
> > > of fwnode "flags" thread safe"), this must be changed to:
> > >
> > >     if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))
> > >
> > > With this change my DT overlays are working again.
> > >
> > > I guess keeping the FWNODE_FLAG_* names, but changing their values
> > > from bit masks to bit numbers was probably not such a good idea,
> > > as it fails to catch missing conversions...
> >
> > Crud, I should have thought about that. :( Do you think it's worth it
> > to do a rename at this point to catch future problems?
>
> You can try locally with allyesconfig / allmodconfig and see the outcome.
> If there are missed cases, and their amount reasonably low, I won't bothe=
r
> in this case.

I believe I caught all of them at the time of my CL, but the problem
is in-flight stuff, right? I think the problem Geert is pointing out
isn't something I missed in my original patch but rather an
interaction between my patch and this in-flight patch.

> But for the future it's kinda rule of thumb to rename when
> semantics changed.

Noted. I've certainly done that before, but I didn't think about it in
this case.

-Doug
