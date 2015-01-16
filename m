From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] MAINTAINERS: Add entry for Maxim PMIC-s on Samsung boards
Date: Fri, 16 Jan 2015 13:21:34 +0100
Message-ID: <1421410894.8119.9.camel@AMDC1943>
References: <1421407190-6771-1-git-send-email-k.kozlowski@samsung.com>
 <54B8FB31.5090105@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:41368 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbbAPMVn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jan 2015 07:21:43 -0500
In-reply-to: <54B8FB31.5090105@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Alessandro Zummo <a.zummo@towertech.it>

On pi=C4=85, 2015-01-16 at 20:51 +0900, Chanwoo Choi wrote:
> Hi Krzysztof,
>=20
> On 01/16/2015 08:19 PM, Krzysztof Kozlowski wrote:
> > Add myself as supporter for Maxim 77686 PMIC and Maxim 14577/77693 =
MUIC
> > drivers:
> >  - mfd (all of them),
> >  - extcon (extcon-max14577, extcon-max77693)
> >  - power (max14577_charger.c, 77693 on LKML [1]),
> >  - regulator (all of them),
> >  - clock (clk-max77686.c)
> >  - RTC (rtc-max77686.c).
> >=20
> > Lately I am the author of major contributors to them. These
> > drivers are used on Exynos-based boards (Trats 2, Gear 1 and Gear 2=
).
> >=20
> > [1] https://lkml.org/lkml/2015/1/5/139
> >=20
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Mike Turquette <mturquette@linaro.org>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Alessandro Zummo <a.zummo@towertech.it>
> > ---
> >  MAINTAINERS | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f017a30eb280..b033fb499186 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6143,6 +6143,21 @@ F:	Documentation/devicetree/bindings/i2c/max=
6697.txt
> >  F:	drivers/hwmon/max6697.c
> >  F:	include/linux/platform_data/max6697.h
> > =20
> > +MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS
> > +M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > +L:	linux-kernel@vger.kernel.org
> > +S:	Supported
> > +F:	drivers/*/*max14577*.c
> > +F:	drivers/*/*max77686*.c
> > +F:	drivers/*/*max77693*.c
>=20
> I knew that you did implement max14577 series because I did cowork to=
 implement it with you.
>=20
> But,
> The drivers/extcon/extcon-max77693.c was implemented by me
> and extcon-max14577.c was implemented by me and you.
>=20
> The initial version of drivers/mfd/max77876.c, drivers/regulator/max7=
7686.c
> was implemented by Jonghwa Lee(jonghwa3.lee@samsung.com).
>=20
> The initial version of drivers/mfd/max77693.c was implmented by me
> and drivers/mfd/max77693.c by Jonghwa Lee.
>=20

Yes, your are right. However I do not change the ownership or authorshi=
p
of these drivers here. You and the others will still be the authors.
Being the initial author is somehow different then reviewing and
developing the driver further.

Although you didn't say that explicitly here but if you think there
should be an entry also for you than I would appreciate it fully.

Best regards,
Krzysztof

> Best Regards,
> Chanwoo Choi
>=20
>=20
>=20

