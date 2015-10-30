From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 2/2] drivers:power:twl4030-charger: don't check if battery is present
Date: Fri, 30 Oct 2015 07:14:25 +0100
Message-ID: <F5CC5DDB-A65F-4B9E-8CC4-8F55823D2D4E@goldelico.com>
References: <cover.1446138086.git.hns@goldelico.com> <72eab67d8ae1e25803a78a4636c8da78b7a0d32f.1446138086.git.hns@goldelico.com> <56327882.2030205@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:22069 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976AbbJ3GOd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 02:14:33 -0400
In-Reply-To: <56327882.2030205@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, gta04-owner@goldelico.com


Am 29.10.2015 um 20:50 schrieb Nishanth Menon <nm@ti.com>:

> On 10/29/2015 12:01 PM, H. Nikolaus Schaller wrote:
>> We can't assume that the battery is present after probing (it can
>> usually be removed while device is operated through external AC
>> or USB power). So it makes no sense to check for it during probe.
> 
> 
> Do you mean hot plug battery?

Yes.

> you sure twl4030 is capable of dealing
> with that :) ?

I am not sure about the twl4030 but with the tps65950 used in the GTA04,
it worked always in the past years with the old drivers (before 4.3-rc1 because
we have not tested the new ones well enough).

> we ran into all kinds of issues with LDP3430 trying to
> make that logic work, finally came to the conclusion that the TWL4030
> as it stands on LDP cannot just do that.

One issue is of course that AC or USB must provide enough current to
operate the board stand-alone. I.e. charging with high enough max_current
must be enabled.

A typical scenario I was using is to enable e.g. 800 mA max_current for
USB, connect the device to some laptop or USB wall charger and then
replace the battery.

This works with full and empty replacement batteries. Well, it should not
be too empty so that the inrush-current is not too much for the USB supply.

What we can't do is to boot from power-off without battery. In that case
the BCI isn't enabled for high enough current to operate the OMAP. But
as soon as the BCI enables enough current, it worked.

My main observation is that you can't make sure by software that the
user is not trying to hot-swap the battery. I.e. it can still happen after
probe time. This is why I think this check doesn't solve a problem.

So if there are problems with battery removed, we must find a solution
in the driver to handle that situation. And not only check once at boot time.

BR,
NIkolaus Schaller

> 
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> ---
>> drivers/power/twl4030_charger.c | 7 -------
>> 1 file changed, 7 deletions(-)
>> 
>> diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
>> index 859991f..e232453 100644
>> --- a/drivers/power/twl4030_charger.c
>> +++ b/drivers/power/twl4030_charger.c
>> @@ -1008,13 +1008,6 @@ static int twl4030_bci_probe(struct platform_device *pdev)
>> 	bci->irq_chg = platform_get_irq(pdev, 0);
>> 	bci->irq_bci = platform_get_irq(pdev, 1);
>> 
>> -	/* Only proceed further *IF* battery is physically present */
>> -	ret = twl4030_is_battery_present(bci);
>> -	if  (ret) {
>> -		dev_crit(&pdev->dev, "Battery was not detected:%d\n", ret);
>> -		return ret;
>> -	}
>> -
>> 	platform_set_drvdata(pdev, bci);
>> 
>> 	bci->ac = devm_power_supply_register(&pdev->dev, &twl4030_bci_ac_desc,
>> 
> 
> 
> -- 
> Regards,
> Nishanth Menon

