From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH on mfd-regulator-power-v3.17] charger: max14577: Fix build
 breakage when compiled as module
Date: Wed, 24 Sep 2014 16:38:25 +0200
Message-ID: <1411569505.32515.0.camel@AMDC1943>
References: <1411560006-16471-1-git-send-email-k.kozlowski@samsung.com>
 <20140924143519.GJ32069@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:41909 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaIXOi2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Sep 2014 10:38:28 -0400
In-reply-to: <20140924143519.GJ32069@lee--X1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>

On =C5=9Bro, 2014-09-24 at 15:35 +0100, Lee Jones wrote:
> On Wed, 24 Sep 2014, Krzysztof Kozlowski wrote:
>=20
> > The charger's module device table used the same name as regulator d=
river
> > causing a build break when charger was compiled as a module:
> >=20
> > drivers/power/max14577_charger.c:598:1: error: =E2=80=98__mod_platf=
orm__max14577_regulator_id_device_table=E2=80=99 aliased to undefined s=
ymbol =E2=80=98max14577_regulator_id=E2=80=99
> > make[2]: *** [drivers/power/max14577_charger.o] Error 1
> >=20
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > ---
> >  drivers/power/max14577_charger.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> I have fixed this up into the original set and re-sent the
> pull-request.

Great, thanks!

Best regards,
Krzysztof

