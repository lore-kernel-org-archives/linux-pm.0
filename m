From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Thu, 9 Jul 2015 14:46:40 +0200
Message-ID: <559E6D30.701@atmel.com>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com> <20150709120335.GW28632@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:7832 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbbGIMrx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 08:47:53 -0400
In-Reply-To: <20150709120335.GW28632@lukather>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Josh Wu <josh.wu@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org

Le 09/07/2015 14:03, Maxime Ripard a =E9crit :
> Hi,
>=20
> On Thu, Jul 09, 2015 at 06:15:46PM +0800, Josh Wu wrote:
>> As since sama5d3, to reset the chip, we don't need to shutdown the d=
dr
>> controller.
>>
>> So add a new compatible string and new restart function for sama5d3 =
and
>> later chips. As we don't use sama5d3 ddr controller, so remove it as
>> well.
>>
>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>>
>>  drivers/power/reset/at91-reset.c | 30 +++++++++++++++++++++--------=
-
>>  1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/=
at91-reset.c
>> index 36dc52f..8944b63 100644
>> --- a/drivers/power/reset/at91-reset.c
>> +++ b/drivers/power/reset/at91-reset.c
>> @@ -123,6 +123,14 @@ static int at91sam9g45_restart(struct notifier_=
block *this, unsigned long mode,
>>  	return NOTIFY_DONE;
>>  }
>> =20
>> +static int sama5d3_restart(struct notifier_block *this, unsigned lo=
ng mode,
>> +			void *cmd)
>> +{
>> +	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PR=
OCRST),
>> +				at91_rstc_base);
>> +	return NOTIFY_DONE;
>> +}
>> +
>>  static void __init at91_reset_status(struct platform_device *pdev)
>>  {
>>  	u32 reg =3D readl(at91_rstc_base + AT91_RSTC_SR);
>> @@ -155,13 +163,13 @@ static void __init at91_reset_status(struct pl=
atform_device *pdev)
>>  static const struct of_device_id at91_ramc_of_match[] =3D {
>>  	{ .compatible =3D "atmel,at91sam9260-sdramc", },
>>  	{ .compatible =3D "atmel,at91sam9g45-ddramc", },
>> -	{ .compatible =3D "atmel,sama5d3-ddramc", },
>>  	{ /* sentinel */ }
>>  };
>> =20
>>  static const struct of_device_id at91_reset_of_match[] =3D {
>>  	{ .compatible =3D "atmel,at91sam9260-rstc", .data =3D at91sam9260_=
restart },
>>  	{ .compatible =3D "atmel,at91sam9g45-rstc", .data =3D at91sam9g45_=
restart },
>> +	{ .compatible =3D "atmel,sama5d3-rstc", .data =3D sama5d3_restart =
},
>>  	{ /* sentinel */ }
>>  };
>> =20
>> @@ -181,17 +189,21 @@ static int at91_reset_of_probe(struct platform=
_device *pdev)
>>  		return -ENODEV;
>>  	}
>> =20
>> -	for_each_matching_node(np, at91_ramc_of_match) {
>> -		at91_ramc_base[idx] =3D of_iomap(np, 0);
>> -		if (!at91_ramc_base[idx]) {
>> -			dev_err(&pdev->dev, "Could not map ram controller address\n");
>> -			return -ENODEV;
>> +	match =3D of_match_node(at91_reset_of_match, pdev->dev.of_node);
>> +	at91_restart_nb.notifier_call =3D match->data;
>> +
>> +	if (match->data !=3D sama5d3_restart) {
>=20
> Using of_device_is_compatible seems more appropriate.
>=20
> Also, why are you changing the order of this loop and the notifier
> registration?

Well, it's because the sama5d3 onwards controllers don't need ramc
controller.
So, reverting the order seems needed. Doesn't it address your question,
or did I lost track?

Bye,
--=20
Nicolas Ferre
