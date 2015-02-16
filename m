From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/6] mfd: max77843: Add max77843 MFD driver core driver
Date: Mon, 16 Feb 2015 13:42:06 +0000
Message-ID: <20150216134206.GH14545@x1>
References: <1423025771-4139-1-git-send-email-jaewon02.kim@samsung.com>
 <1423025771-4139-2-git-send-email-jaewon02.kim@samsung.com>
 <54D20A32.1020604@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:32837 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755526AbbBPNmM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Feb 2015 08:42:12 -0500
Received: by mail-we0-f179.google.com with SMTP id u56so29257094wes.10
        for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2015 05:42:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54D20A32.1020604@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Jaewon Kim <jaewon02.kim@samsung.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Beomho Seo <beomho.seo@samsung.com>

On Wed, 04 Feb 2015, Chanwoo Choi wrote:
> On 02/04/2015 01:56 PM, Jaewon Kim wrote:
> > This patch adds MAX77843 core/irq driver to support PMIC,
> > MUIC(Micro USB Interface Controller), Charger, Fuel Gauge,
> > LED and Haptic device.
> >=20
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> > Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> > ---
> >  drivers/mfd/Kconfig                  |   14 ++
> >  drivers/mfd/Makefile                 |    1 +
> >  drivers/mfd/max77843.c               |  245 +++++++++++++++++++
> >  include/linux/mfd/max77843-private.h |  441 ++++++++++++++++++++++=
++++++++++++
> >  4 files changed, 701 insertions(+)
> >  create mode 100644 drivers/mfd/max77843.c
> >  create mode 100644 include/linux/mfd/max77843-private.h

<LOTS OF POINTLESS LINES OF UNCHANGED/UNREVIEWED CODE>

> Looks good to me.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Chanwoo,

If you're not going to make any comments, either put the Reviewed-by
at the top, or better still, snip out all of the bumph in the middle.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
