Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F872D948D
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155369; cv=none; b=l6oNIT6NW4lyJnqdpZEvqfMSbEovPxR0ERHPL4rZZz+uyLdhLlLfQYb8yrWJhVXQL0xTcwfKpvmX6TyR5rvJqHoORp0faUqHkC9xPXdbqP1j0V4hXKF4tag3E10gdLM6hEt/13FHq/efEXSYl+pAMtohBLkuBGXhd56NL5WY3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155369; c=relaxed/simple;
	bh=QEW3lhhJANPdrCVBmAIqH1dXUDPD23689ylzZ5dnJco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxZw4aIK60rxUUgOeIjwljrFRsNzPddpmTzP/BVMArPmtT2hOeFvqjw4o4+pWYF0BERGnOUGMa9RFVo+pwcryGcu/ksQEKnA6eMmmFDNeQfvZ002DYZdTOznYiUUilsHePCLXPfCxEzQ+YLz7S9tZREM+e+XoSs9delMgxK7R1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cd80f56b27so285449785a.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 08:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155368; x=1773760168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ru18n38/qbgrYN5XhGLEd0K3IukQ/mw6D37X8x0z/qo=;
        b=DcrWEIj0vdLSnmUAYZ8iUMhIycNF+l/HV/NZ5zN+yZulwPmnH1MWBJRoWAsjo3RQWH
         eN91aU4JHLDIGLyhzhWUPpOX81k/k5VjmbBmt1zDmeRXyCMFgQP60cykEeW4O9UmBXKJ
         mLoFGVBJJcLfgDG9fk9IJtghecvGG5OjC4d7EAmTK3laNiVmohjJqBYkrQUTackYEa44
         XHzZBmYNpk6yGu1jy52nr3fTbH53BwF6cAXf//nm1+khFdkmhy3DesC6qjyTVcZFIEvw
         tH4se9TS1et+OfQJ1nBjonuc4sK9U/SpAzoLVTF7WSWzeNLcBYr1W3VSnuf8VKig1Ixr
         AfEg==
X-Forwarded-Encrypted: i=1; AJvYcCVGWLl6n9kCXoEOfAvteIuSytxaeD7lEcV+Bt/zeL6OABV2wOS3XVk2FsdYvKAY5QuDcY1d8HOqfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXE26lrnCJ4P1Isl8OEaEXY0Fs/OfWeO8hIL/4Eu17NLwuLOEJ
	pKMIiIyJraxOlvmbFTQ21+EcIZwNSGAMbDyNJkRySL1Mg8AufVB2xy9CLclvGPt3
X-Gm-Gg: ATEYQzzflemZjzjTnF6/Q3Pyz2m3+ie40Haq3og4Nyn2kpFtmV9WMBwRyyUa25yqsrD
	pJNzQTnSYr7euSRCq+LSTZ/HbUGi9HJQTVGOVVpWIDHHpTnYEuTo44J6OPS2lYBpO3z9kHXheXZ
	sMDAX1bOOpOIlOUF7sS8Wqoxgz5GfpvJJlYUUj9zRlOilthdJoMyIb1ncIrJ0eerZgcydb0edmL
	vqcIrDHWA2S4QdN21R7hRolftynK2p6rRbSNXNHx6ursUvL8DLS9eRcdKB6/Uq9BZZO1GUjHCId
	HP9L+0edNgGCON4CDHP2TtSwJpO/MJ1ae+8+nkKaCtZuB7MDXqiIfNDo2ZsOVZ7E2H75O90k/Mj
	HqUfqa5Gpeod1+6/+h/GSNoBMfRBCANBeMTRFiS04bxhRfhkEkWJEb7G7KQ4c8/mdxiGZV/BULG
	6Ue+yDhnRh08rqUKEe3ODEDa0DPLW8nZ4poXIHpB3x4Js5AHxyc2SDAtOZuKyz9/9M
X-Received: by 2002:a05:620a:318f:b0:8c9:f8e5:9f12 with SMTP id af79cd13be357-8cd6d4fe93bmr1846337985a.57.1773155367465;
        Tue, 10 Mar 2026 08:09:27 -0700 (PDT)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd9a637f18sm80993885a.35.2026.03.10.08.09.26
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 08:09:26 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cb40149037so1385409585a.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 08:09:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8ygk3T/55sg8+6XVTkX/1zF2Bc1Gpxg+DHmc3vF42QuLxQl/8nqE0OdLSiW5UbUden8gM8ifhDQ==@vger.kernel.org
X-Received: by 2002:a05:6102:c8f:b0:5f1:70fe:3027 with SMTP id
 ada2fe7eead31-5ffe6121c90mr5181206137.24.1773155033187; Tue, 10 Mar 2026
 08:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227135428.783983-1-herve.codina@bootlin.com> <20260227135428.783983-3-herve.codina@bootlin.com>
In-Reply-To: <20260227135428.783983-3-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Mar 2026 16:03:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
X-Gm-Features: AaiRm53b7liJL7XJhyMA-JPl81LkjhC0Orfn04kAcG7__Cf3-wDY5cIOlphhcC4
Message-ID: <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
Subject: Re: [PATCH v5 02/28] driver core: Rename get_dev_from_fwnode()
 wrapper to get_device_from_fwnode()
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@google.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herv=C3=A9,

On Fri, 27 Feb 2026 at 14:55, Herve Codina <herve.codina@bootlin.com> wrote=
:
> get_dev_from_fwnode() calls get_device() and so it acquires a reference
> on the device returned.
>
> In order to be more obvious that this wrapper is a get_device() variant,
> rename it to get_device_from_fwnode().
>
> Suggested-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/lkml/CAGETcx97QjnjVR8Z5g0ndLHpK96hLd4aYSV=
=3DiEkKPNbNOccYmA@mail.gmail.com/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

FTR, one more user of get_dev_from_fwnode() appeared in commit
9035073d0ef1de81 ("reset: convert reset core to using firmware nodes")
in reset/next.

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
