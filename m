Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305E3845B7
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635726; cv=none; b=pz0xnoAYR4lN5XrpHZmdrS/7vMAIh1e7YtPLH/109W4Uz3tHPbMVcih+VFZLnvdgc7VQ8QyiclK09e66wI47Zva5TpJE4r9nF2GPafHi2SmR9WiRWXfWdWx3smczym71PpHWg3MryBTdym2Cw8P2GSKlstuV4Us7lgQPh1bHzYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635726; c=relaxed/simple;
	bh=qgkECxzGSpnuq07rnxhj52qCBc/KBJvowuMtgBzyENM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUMDUqAzUkVD+rxuqKi1sUIR9agHwkT+ElAo8awAktOm0zfol3Nuv72YnNFNjcP8a8stUvgdCEqgEVcky+3as/CycNPqUfwfc+qcVuM7980uKSWDHKOLdJQpClV75PzoqENhy6+7zuvUJn0Ta2FJ9341yacgueGd/tmRTXoJLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad9a9be502so37792945ad.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 01:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775635724; x=1776240524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgSjrs+bZCBNPvbS97WPj5GTT7jaQlR+JpRwd/gT2+Y=;
        b=aWeYgzW7JKBKiWV3LTxH8Yxs3KvT/sdo9wn8UZAEfO9NzWFfMmmhyR4vvoLu13lJ/S
         0MVSKm+sVsdQBsvYmMre3pDLtm08pXIFpif/b4IJdN7h1kaLuXm9DD65sF+yKWAFUsJo
         p7qF8zYT/iUeHRyCvjyOa81BnbMT6li1R85UWoqeFJWQMWfjYTHMnu88Ghb6JMsKv3f4
         OLMb1SCiHYCPtTwcXiULGex/gm88FjcVBvTtK/7smIYbn4cSFH5v5lCV2kPuaXeXNmcK
         dEQ2sd2L3ocTyaR0/RSvHaY6WpSG+VygCE+jcOIEuFyaYIJLZeyMrOz2dQODPUSh+gfM
         yKaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkJLuEtXhbCiI/rQ3ovI5pWiRdNwzpGZ5UOnZzoYdSDtc7OhRlQK8qtREfw3MOqEd9UqXTsxh7Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOaZdEcKn4VdXWlvApsglrj/OtH3SxESvBqYtosOy76Nmo8dXV
	uQhftwjeI7keKSHTx7sEfaT6nScnJcDojd/YOVMjDWdVhaAzR87RbVVplqZaaE0x
X-Gm-Gg: AeBDies/eWC9DlcklNdwWyZnBWgAtRm2i6xt3xyEB0FISD0AUPWyvfQgJ7gCXyTWv5x
	e3qctdA48zlYXw4vCi1FDXc/Mc5KCxvBJK6JYimfKoyayTcjzUZdxKV0CZJYmG7LxuJ+IleSXDx
	OCrYtvpULl0U2uzQ4jVIIAq/R/qNXCWhjkSm/uVtyPrBIN0rxZyeOX96RzhPowi2pQslICMtsvZ
	oQ0ckMAf9JKFdt0k+CjyYrSvE1nj1R6za47EAGldRp0eZspRRgUTlBGZdcebE9qt0VisjachF5v
	EX8OI6NzywQVxl/T8m96/hSmbGfrt4BACXLVWNo63lMaDjHmBDGDZOHBLuG5vSFnnk6iJ00C6t1
	y/mINK2DpTZX7Ioy4wU/Gonai2kW4It1ZqFX9NylQ9OkOV4cGsQXwqYzvyoS/ao1Ufc/01/je3g
	nTAVvE95W++iUUj93cSeB9JxNd0v+sFhkbHCrfh9kY0QXbihBH5KVaVGAbfA/a4s+e
X-Received: by 2002:a17:903:4b07:b0:2b2:4cd2:e162 with SMTP id d9443c01a7336-2b281838b2fmr226443945ad.34.1775635723994;
        Wed, 08 Apr 2026 01:08:43 -0700 (PDT)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2ae05991bsm48305075ad.70.2026.04.08.01.08.43
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 01:08:43 -0700 (PDT)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82cd9d0eceaso4434823b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 01:08:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAghR2IN4dyvwawxQwpPkvbqUFKnXGCIDoVEQnIK/VzzcEhAqw72+3tJryQbM1kQ/0ozbwZsfxKw==@vger.kernel.org
X-Received: by 2002:a05:6102:688e:b0:607:9b47:81f2 with SMTP id
 ada2fe7eead31-6079b478f09mr649179137.20.1775635395263; Wed, 08 Apr 2026
 01:03:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com> <20260325143555.451852-2-herve.codina@bootlin.com>
In-Reply-To: <20260325143555.451852-2-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 10:03:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVh2gFQf16AarJCY+2y+24bOgaQyTUv6opPqVKCoUwMag@mail.gmail.com>
X-Gm-Features: AQROBzDnP0FsdrSe7kiaKBzgO-Rt21-zwjAE4PjirQbwD7WYIqJw4iFM_IJ47Kw
Message-ID: <CAMuHMdVh2gFQf16AarJCY+2y+24bOgaQyTUv6opPqVKCoUwMag@mail.gmail.com>
Subject: Re: [PATCH v6 01/27] Revert "treewide: Fix probing of devices in DT overlays"
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 15:36, Herve Codina <herve.codina@bootlin.com> wrote:
> From: Saravana Kannan <saravanak@google.com>
>
> This reverts commit 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924.
>
> While the commit fixed fw_devlink overlay handling for one case, it
> broke it for another case. So revert it and redo the fix in a separate
> patch.
>
> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8x6=9F9rZ+-KzjOg@mail.gmail.com/
> Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com/
> Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Link: https://lore.kernel.org/lkml/20240411235623.1260061-2-saravanak@google.com/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Mark Brown <broonie@kernel.org>

> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -327,12 +327,6 @@ static int of_weim_notify(struct notifier_block *nb, unsigned long action,
>                                  "Failed to setup timing for '%pOF'\n", rd->dn);
>
>                 if (!of_node_check_flag(rd->dn, OF_POPULATED)) {
> -                       /*
> -                        * Clear the flag before adding the device so that
> -                        * fw_devlink doesn't skip adding consumers to this
> -                        * device.
> -                        */
> -                       rd->dn->fwnode.flags &= ~FWNODE_FLAG_NOT_DEVICE;
>                         if (!of_platform_device_create(rd->dn, NULL, &pdev->dev)) {
>                                 dev_err(&pdev->dev,
>                                         "Failed to create child device '%pOF'\n",

Note that all these removals no longer apply cleanly due to commit
f72e77c33e4b5657 ("device property: Make modifications of fwnode
"flags" thread safe") in driver-core-next, which is gonna complicate
backporting to stable.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
