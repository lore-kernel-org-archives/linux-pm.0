From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 2/2] power: charger-manager: Avoid recursive thermal
 get_temp call
Date: Mon, 13 Oct 2014 10:58:01 +0200
Message-ID: <1413190681.3829.7.camel@AMDC1943>
References: <326901692.426181413180076268.JavaMail.weblogic@epmlwas05a>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:42208 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbaJMI6G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Oct 2014 04:58:06 -0400
In-reply-to: <326901692.426181413180076268.JavaMail.weblogic@epmlwas05a>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Anton Vorontsov <anton@enomsg.org>, =?UTF-8?Q?=EC=9D=B4=EC=A2=85=ED=99=94?= <jonghwa3.lee@samsung.com>, =?UTF-8?Q?=EC=B5=9C=EC=B0=AC=EC=9A=B0?= <cw00.choi@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?UTF-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On pon, 2014-10-13 at 06:01 +0000, MyungJoo Ham wrote:
> >   
> >  Add a 'no_thermal' property to the power supply class. If true then
> > thermal zone won't be created for this power supply in
> > power_supply_register().
> > 
> > Power supply drivers may want to set it if they support
> > POWER_SUPPLY_PROP_TEMP and they are forwarding this get property call to
> > other thermal zone.
> > 
> > If they won't set it lockdep may report false positive deadlock for
> > thermal zone's mutex because of nested calls to thermal_zone_get_temp().
> > First is the call to thermal_zone_get_temp() of the driver's thermal
> > zone. Thermal core gets POWER_SUPPLY_PROP_TEMP property from this
> > driver. The driver then calls other thermal zone thermal_zone_get_temp()
> > and returns result.
> > 
> > Example of such driver is charger manager.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Do we really need to add another variable in the psy struct?
> In the previous thread, I thought that wasn't needed, though.

I considered the idea mentioned by  Jonghwa Lee:

static int psy_register_thermal(struct power_supply *psy)
{
...
+       if (psy->tzd)
+               return 0; 

but there would be problem in determining the ownership of the thermal
zone - who should unregister that thermal zone? Charger manager's power
supply or fuel gauge's power supply?

We could NULL-ify it manually from charger's remove function before
calling power_supply_unregister... but it is really accessing a private
field of power_supply structure. 

I think this should be done in API-level.

Best regards,
Krzysztof

> 
> 
> Cheers,
> MyungJoo
> 
> > 
> > ---
> > 
> > Changes since v1:
> > 1. New patch (new idea).
> > ---
> >  drivers/power/power_supply_core.c | 3 +++
> >  include/linux/power_supply.h      | 6 ++++++
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
> > index 6cb7fe5c022d..694e8cddd5c1 100644
> > --- a/drivers/power/power_supply_core.c
> > +++ b/drivers/power/power_supply_core.c
> > @@ -417,6 +417,9 @@ static int psy_register_thermal(struct power_supply *psy)
> >  {
> >  	int i;
> >  
> > +	if (psy->no_thermal)
> > +		return 0;
> > +
> >  	/* Register battery zone device psy reports temperature */
> >  	for (i = 0; i < psy->num_properties; i++) {
> >  		if (psy->properties[i] == POWER_SUPPLY_PROP_TEMP) {
> > diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> > index 3ed049673022..096dbced02ac 100644
> > --- a/include/linux/power_supply.h
> > +++ b/include/linux/power_supply.h
> > @@ -200,6 +200,12 @@ struct power_supply {
> >  	void (*external_power_changed)(struct power_supply *psy);
> >  	void (*set_charged)(struct power_supply *psy);
> >  
> > +	/*
> > +	 * Set if thermal zone should not be created for this power supply.
> > +	 * For example for virtual supplies forwarding calls to actual
> > +	 * sensors or other supplies.
> > +	 */
> > +	bool no_thermal;
> >  	/* For APM emulation, think legacy userspace. */
> >  	int use_for_apm;
> >  
> > -- 
> > 1.9.1
> > 

