From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH] max17042: Fix build errors caused by missing REGMAP_I2C
 config
Date: Sun, 1 Dec 2013 14:26:59 -0800
Message-ID: <20131201222659.GC6271@lizard>
References: <20131124214149.cf1b6444d6e43d637ea7e34b@gmail.com>
 <52929C64.2090903@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:43510 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab3LAWcI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 Dec 2013 17:32:08 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so17526266pbc.39
        for <linux-pm@vger.kernel.org>; Sun, 01 Dec 2013 14:32:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <52929C64.2090903@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jonghwa3.lee@samsung.com
Cc: Austin Boyle <boyle.austin@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Myungjoo Ham <myungjoo.ham@samsung.com>

On Mon, Nov 25, 2013 at 09:40:04AM +0900, jonghwa3.lee@samsung.com wrot=
e:
> > max17042 now uses regmap interface but does not enable config optio=
n. This patch fixes the following build errors:
> >=20
> > drivers/power/max17042_battery.c:661:15: error: variable =E2=80=98m=
ax17042_regmap_config=E2=80=99 has initializer but incomplete type
> >=20
> > Signed-off-by: Austin Boyle <boyle.austin@gmail.com>
> > ---
> > diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> > index 5e2054a..85ad58c 100644
> > --- a/drivers/power/Kconfig
> > +++ b/drivers/power/Kconfig
> > @@ -196,6 +196,7 @@ config BATTERY_MAX17040
> >  config BATTERY_MAX17042
> >  	tristate "Maxim MAX17042/17047/17050/8997/8966 Fuel Gauge"
> >  	depends on I2C
> > +	select REGMAP_I2C
> >  	help
> >  	  MAX17042 is fuel-gauge systems for lithium-ion (Li+) batteries
> >  	  in handheld and portable equipment. The MAX17042 is configured
>=20
> Sorry, It's my fault. Thanks.
>=20
> Acked-by: Jonghwa Lee <jonghwa3.lee@samsung.com>

Applied, thanks!
