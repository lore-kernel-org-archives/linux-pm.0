Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6090377030
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395054; cv=pass; b=pSGLdouJq1iM/INxYuPb8Wq6FUrK3aJHdr5oAcr1VRqbx8NXDYApNEQ/++iFEvMvx7PXiINnkfq77KO963iX0mV0hw4WjE89C0kiGWWNsJuU38p/neD8nZ/qY5jzbhNrcgU1g2tvUl2T/Js8VNXWTNRK6esfLaWDlD+Z5F4VwLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395054; c=relaxed/simple;
	bh=a4PkyDJIX7KyCPscZwhkhXLXTwGONJMI97/AnswuOLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJwRIsodF7yAI3IQW36KAecCVC0jwdbp02uEtSJdZshuqLIcxsE9JMiMgRuynCayi1JYW8EjMCuFZsj2znWc+kOai6Nhg/ahx6MLzLkfEo/ku9pvK9rnBneIg82zMJcomLnc8qA0VEd9d2tVc2SfPnKJ2cUsnNHFMJiVZrV34R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CVJB0EpM; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CVJB0EpM"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a107b387a5so2608495e87.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 02:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773395051; cv=none;
        d=google.com; s=arc-20240605;
        b=HVHki4lzT+8VC8KCa4wKqIYpRt02sFxkSIvC1hvm5r5GLCFPZ5e8uV8aIS+rouTfde
         mqFdxkgLrY7qAiTFwa1pCIx7/ZBzGDVu4yhYM4h1lgDYoCr7bSv8nt06WaYGFRthh6jL
         da7QJUF2QboJpgktUallkHSX/PMUkknGQ5AEqutH+EQSSodLdogu9bcpS6Wen3Pwm43A
         41A5Cyfk5hIwwKC1ABbXYu/yXT7Dz4hVEsycIvHa6ypgPez0Vn24mkhPCqZI8K8VLRg/
         wBwG68ZWc9Chqhv3B4R5gZzu77Ycm9OEVuNX0mKqT0k9LAPwxHLrLsjPkHOxJvSMpe+2
         aSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zhNoTkJIeGg7k6SX7++UNulbkoe8PKd3t4WsYSulIm0=;
        fh=pm0f6GzvU6yJgJ1VFYip8w75HS4Zko9xq/I+wbKtstU=;
        b=LJelgIwqS7LcwJrNxzQX4/T5KQfOM6e4LWLmilFDjUNEOEWyxV2N6vKzj3dSekugk2
         dPGwsXUxagBQGPujTiPLZY2MebszGO4HcWdB6RCP/D8T5VxVLdkdiP+g2J39rznU1VNq
         7d2KvXyhHKtyn6CzdU/bsBhA8XDTK2hEcqmnXfTQ58vJcM5MZkxOqUvaNkT93mehpce/
         O7usK8edDnAuaiXyVKQU8NFgjkNilaU2/XnHwCnsct3x52uSrWMbSC1Jgjhh/4bs78Hq
         1zqWJFEM8IULzc3OFALilGlk7HRengJEtW5deE9676WhY8fZxij6Mv0gsX095pe/bZGq
         cYLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773395051; x=1773999851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhNoTkJIeGg7k6SX7++UNulbkoe8PKd3t4WsYSulIm0=;
        b=CVJB0EpMEVa6sLzbpbpZgC6oxzg2jOtTdosOr5xZNtsl8bsqrxagaYbJB1fdwaFsDi
         MU38WYuy9AWHvdgCpCuHaIpr0k74xYGQOeELdWDSwcfyzs8cqYkIXiRIRrqyxiibpEVP
         wMrz3HxyzbyPSSjmSzWbKbBJgizyZo+BgjwH4r+2CXA44MTS6E41EE0YnfUJRp2yUitr
         rl9LQ9jslbZWwEoeHXtCnBIpFBQl7bMUoyyvJJ1DVrzW8G12l73vTupZQjGfuJkAAf20
         jQIIgy05OQGFnn5ib4SoM+EKD7qPNjwSuIvoucoWtcAxJOQaShYcNfKbcoRIEG60ZMKr
         agpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773395051; x=1773999851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zhNoTkJIeGg7k6SX7++UNulbkoe8PKd3t4WsYSulIm0=;
        b=qzNMhJrgyKJmMMe0EOJ05h2Pu/p8idn4qg7JGAAyO62nzxEvDrgcqvVeSiFhHs//EW
         OiLs6/K9XK+/DlWjyT4UI/OGKW9maMj8ebpQyDw2/Oxq21wd1VNT5vw/ye37Y6c1kezO
         XLEHLO/myNKLyHJbE1TYTM3QFdnX2bxi9Qwq+GYEIdWdZqP44v8eCRLcUefP9TPSzEtg
         YLDYx7DhFxjORt2Dcy8mux8VgOnZkQv+Js+PMcCrQeZLVoYYN3SZXSObpBQaBFItlZ1x
         TyGkgWNSTHvIuJCGf/43PgUjz4nkKxPpLve7VvgD/7ODZD/xTJv0qaf5iuHbOs6LmFun
         +sZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgWx5w8xXRgSoupxRRwibBHC7LNqd/S8QUCrZ2ZesvjzvUG4DurQIYCIESsGHM0O+4sZQP5m3//w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNG/h+a6wAJwYHPK9Brkq3WUDelnkGyrsjcZo8kdxYXcL38JAH
	AtES2+PgErXCohz3VZzpWbfNtpEl5vILHx8sxUPp9pHJcKbmM5aLzJdfi71y0NGdbE1zXyUVg6d
	lUhMAhkh5MOh71ETHDy7fEGsyTgUno+NdDUs5NpJbag==
X-Gm-Gg: ATEYQzyiJp8jAiRM+v1mWuGP6DejLJa8WbA7Rp4wTMs0/asWDUWdxlWHMtVszZ2WDlg
	uv7yybIAk1XTH/XzZr2PikUxv0foh9d5yH0hg2GUVPa+CjMZ+mPh45B2q0RfRjtgBKL6gT6JFK5
	8VWfsW8+T0VS1LAsrM81PtjwrbRHbrmCSuiaqIkJD/EEAR2i2Q+9OGgZAE/gD7CSh+6C6g3x3jk
	XaxE/HkzAt4IDqVYF+xJ/Ai4sd/1lgc885vonfTgPHWiGxfjjU3bWx2HkOmxXDqMosasIsiooEP
	TLWrSUI2
X-Received: by 2002:a05:6512:1589:b0:5a1:381b:fae2 with SMTP id
 2adb3069b0e04-5a162b0d32fmr863539e87.33.1773395050576; Fri, 13 Mar 2026
 02:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227135428.783983-1-herve.codina@bootlin.com>
 <20260227135428.783983-3-herve.codina@bootlin.com> <CAMuHMdVVsEB-xb8Jz4ujBam2NxtxAOb7byYa3VR_eHsbTD5rXw@mail.gmail.com>
 <2026031242-debug-aviation-19b8@gregkh>
In-Reply-To: <2026031242-debug-aviation-19b8@gregkh>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 13 Mar 2026 10:43:33 +0100
X-Gm-Features: AaiRm535RzzFrlMRqNsLHd1XM8yzn674dd-38MKB2CsmserIvJfHsK0fUYGtRYw
Message-ID: <CAPDyKFpX3A3r4s72PNjBz5QaZUsq1xaGhn5vXwegue7Tyh_Zew@mail.gmail.com>
Subject: Re: [PATCH v5 02/28] driver core: Rename get_dev_from_fwnode()
 wrapper to get_device_from_fwnode()
To: Herve Codina <herve.codina@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Niemi <kaleposti@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
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

On Thu, 12 Mar 2026 at 16:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 10, 2026 at 04:03:42PM +0100, Geert Uytterhoeven wrote:
> > Hi Herv=C3=A9,
> >
> > On Fri, 27 Feb 2026 at 14:55, Herve Codina <herve.codina@bootlin.com> w=
rote:
> > > get_dev_from_fwnode() calls get_device() and so it acquires a referen=
ce
> > > on the device returned.
> > >
> > > In order to be more obvious that this wrapper is a get_device() varia=
nt,
> > > rename it to get_device_from_fwnode().
> > >
> > > Suggested-by: Mark Brown <broonie@kernel.org>
> > > Link: https://lore.kernel.org/lkml/CAGETcx97QjnjVR8Z5g0ndLHpK96hLd4aY=
SV=3DiEkKPNbNOccYmA@mail.gmail.com/
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Reviewed-by: Saravana Kannan <saravanak@google.com>
> > > Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > FTR, one more user of get_dev_from_fwnode() appeared in commit
> > 9035073d0ef1de81 ("reset: convert reset core to using firmware nodes")
> > in reset/next.
>
> Ick, that's going to make this hard to land anywhere.  This is a rough
> series, perhaps it should be split up to make it easier somehow?
>
> thanks,
>
> greg k-h

I fully agree with the above. Renaming the function isn't necessary
for the $subject series.

I suggest we simply drop this patch from the series - and if the
renaming really makes sense in the end, we can deal with that
separately later on.

So withdrawing my ack from this one.

Kind regards
Uffe
