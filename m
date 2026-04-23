Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B33D6663
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927546; cv=none; b=UsJCT2zvOy0XK2zwhHr6SgAsSYg1na37gya+3d10rpl+e9mTZc8g7XonXiKtEhwknIpAh8hVSfwuVGqwXfk70mDNY4l9/h2YbcWPDYDA9IJAy2+io80VXWEAxwLkpXB3sHky0ReqIkne9WMZryjSSSY3EIVM1pNXL6hufXP19UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927546; c=relaxed/simple;
	bh=hexwbOGW/6m/Df6+GU12KM4IKYYaGu617h9GqYfIhNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmLAoP38//jillsIqXAMw5+iTSuVKGmvyMFKRXCMk8ZB/YpTHXKlTrtwahtNAoXN5NaF7G4MME7KIo70SJbKOU3GAjQwDUTWkPsT5B3WXsxvR7VgZBMrgcAITE6WeNKtysC3LYSWVWuWCshlAOj530/CE98zZjX6xyU6kfy+wFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506aa68065eso47098231cf.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 23:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776927543; x=1777532343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FB5PTwtw54UUlBS193h15pAhGHmMjXQQ1mJTpaYMvb8=;
        b=X8ZU9+fra6rUlTDUX4N8bgzbqQGFpX9fh3xcHVMMKbU50rWA/WWvrSom9ekbp27unt
         231aebGB0xsGkBO8L3jMu5nlqnsUNXn4HpOhkGdahL1+NxmdvY7b7slawOzJloWdJM+l
         puyBBClFamz0MKzhBT59u45mGZve6Undwr7JsBA+KPYAWqKuupXs4IjTPbqjJ/76/OId
         bbP2O44ir8Q4TXSo1CDJc5CEMcL/h2VbdmFqmEaBvIs9p2bPc4XgAcNmcXZiFj1uLv+K
         HnhLJg4LkRXOmMYNiQj7UQcAqO+UQO3eKf+PFj0G230THvxisS1A/9lbGYnfXDOHUK9o
         rYuA==
X-Forwarded-Encrypted: i=1; AFNElJ9Wcz5442m0QsEu0MkxgtWh4YEf2gbLo+1AHgUFq/fvv9DzjnMwcKa+Eia0HNMQW8M97DqwawYskA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0OMldxWFDOrOS0mwA3uyrIaaoUA49LlmpR8hliK2As+g6wBf
	FQh2qeP3CODBqVU7ytatT/NAriQoSQRfbVIcKidB+Wqd488HuZEUpId2vTpzzJDHWJo=
X-Gm-Gg: AeBDievgX5tZAQor/NLztFA5ZkpNRqG2SjUw5g4A3mJraFnpGj17Rqt3IJ9YnryoKTh
	ymMIf6j8NwwYjnN1IALO4U6A1e572+EPV0yTRGSa7Wg7yCAwEvrX4XyDD/BiAyZOHAfjDFdbzLS
	nLVTgfjtNQ7p96EyyQOtG6YnuEA1v/WkPC1Xt1zYjoKBe0cs3xt4TJsLnnmD74GHZib+RknlkMi
	hy7zVP2I3KYbKEgDBw5UVrUrpbDEnYKM5vPB7fUhGCn6vOPM5o2IAxmtMyQtDVqa60697lHJ5n0
	UtRVrCaS204VMtyKFnS3BOx+dlFHC6srGSQ5kFhmN9pb93PdsxK2DggytW9iAkApEVHxz7DCr9n
	cR1rYpCqp+WWrZwYPF9qJWuLchPWxvvoWvvURE/aTpSeI/fanTgy22D93icS9PtDNlslJFGytgk
	/ITfU3PZkO8OZSZCcDyXcUkLZQMmtJrQoTN9pVYT4apJHzIFDTpSwkJAOMkhJvmCs4Q5CLNFyza
	tk=
X-Received: by 2002:a05:622a:8c04:b0:50f:bb01:9866 with SMTP id d75a77b69052e-50fbb019c2dmr117806881cf.23.1776927543050;
        Wed, 22 Apr 2026 23:59:03 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e40aab60dsm143744021cf.18.2026.04.22.23.59.02
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 23:59:02 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8ee62a19730so252010485a.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 23:59:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/16CpSnMAxtrEX2VgsHfLuVhcwDqQKPOPS43NIVTgiC/LmnDbpTofGuHyCKrGPXtUSFkmDOIFxKQ==@vger.kernel.org
X-Received: by 2002:a05:6102:441d:b0:611:6fef:905 with SMTP id
 ada2fe7eead31-616f750858emr13450072137.20.1776927225241; Wed, 22 Apr 2026
 23:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com>
 <20260325143555.451852-3-herve.codina@bootlin.com> <CAMuHMdU7x7LWFkD9xiq+wyOqnn0bdzr+JLfvbBexoiWyv8kftA@mail.gmail.com>
 <CAD=FV=UK3NQKQN7FXyG4nGdDKO=LQYhnL4ZweomQ_4R9-EAYag@mail.gmail.com>
 <aekg_IELc65BFrWp@ashevche-desk.local> <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
In-Reply-To: <CAD=FV=XTvvq11y7kxmrfBe3dZsKro7N9=i-Hj9aqsLBay2Q9Rw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Apr 2026 08:53:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUDCQrQ2Z9D7-ZOKiuDznDJVf2R_b_8P9+Xhk4RiJ3vdw@mail.gmail.com>
X-Gm-Features: AQROBzAvgx3axNivzcvHu1RjLcwZ8ZssrkMMWMoOA6QWZi8LwGEf_PBN_biPlMM
Message-ID: <CAMuHMdUDCQrQ2Z9D7-ZOKiuDznDJVf2R_b_8P9+Xhk4RiJ3vdw@mail.gmail.com>
Subject: Re: [PATCH v6 02/27] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Doug Anderson <dianders@chromium.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Herve Codina <herve.codina@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
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

Hi Doug,

On Wed, 22 Apr 2026 at 21:40, Doug Anderson <dianders@chromium.org> wrote:
> On Wed, Apr 22, 2026 at 12:27=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Apr 22, 2026 at 11:51:36AM -0700, Doug Anderson wrote:
> > > On Wed, Apr 22, 2026 at 10:44=E2=80=AFAM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.co=
m> wrote:
> >
> > ...
> >
> > > > > +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
> > > >
> > > > After commit f72e77c33e4b5657 ("device property: Make modifications
> > > > of fwnode "flags" thread safe"), this must be changed to:
> > > >
> > > >     if (fwnode_test_flag(fwnode, FWNODE_FLAG_NOT_DEVICE))
> > > >
> > > > With this change my DT overlays are working again.
> > > >
> > > > I guess keeping the FWNODE_FLAG_* names, but changing their values
> > > > from bit masks to bit numbers was probably not such a good idea,
> > > > as it fails to catch missing conversions...
> > >
> > > Crud, I should have thought about that. :( Do you think it's worth it
> > > to do a rename at this point to catch future problems?

I am afraid it is too late (it is already in Linus' tree), and would
add only more to the confusion.  We just have to take care when this
patch (and 01/27) is backported to stable.  Fortunately the reverse
is caught, as the fwnode_*_flag() helpers did not exist before.

> > You can try locally with allyesconfig / allmodconfig and see the outcom=
e.
> > If there are missed cases, and their amount reasonably low, I won't bot=
her
> > in this case.
>
> I believe I caught all of them at the time of my CL, but the problem
> is in-flight stuff, right? I think the problem Geert is pointing out
> isn't something I missed in my original patch but rather an
> interaction between my patch and this in-flight patch.

There are no unconverted cases in upstream or linux-next
(I checked yesterday, and rechecked this morning).

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
