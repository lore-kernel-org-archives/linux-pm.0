From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH 02/13] power: bq24257: Add dead battery reporting
Date: Fri, 4 Sep 2015 10:08:38 -0500
Message-ID: <20150904150838.GA28221@borg>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
 <1441073435-12349-3-git-send-email-dannenberg@ti.com>
 <55E5FD77.10100@ti.com>
 <20150901210446.GB17234@beast>
 <55E615AA.8080807@ti.com>
 <20150904132805.GA22335@lpalcu-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48159 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759065AbbIDPJF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 11:09:05 -0400
Content-Disposition: inline
In-Reply-To: <20150904132805.GA22335@lpalcu-desk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Fri, Sep 04, 2015 at 04:28:05PM +0300, Laurentiu Palcu wrote:
> On Tue, Sep 01, 2015 at 04:16:26PM -0500, Andrew F. Davis wrote:
> > On 09/01/2015 04:04 PM, Andreas Dannenberg wrote:
> > >>>  drivers/power/bq24257_charger.c | 4 ++++
> > >>>  1 file changed, 4 insertions(+)
> > >>>
> > >>>diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
> > >>>index db81356..0b34528 100644
> > >>>--- a/drivers/power/bq24257_charger.c
> > >>>+++ b/drivers/power/bq24257_charger.c
> > >>>@@ -274,6 +274,10 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
> > >>>  			val->intval = POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
> > >>>  			break;
> > >>>
> > >>>+		case FAULT_NO_BAT:
> > >>>+			val->intval = POWER_SUPPLY_HEALTH_DEAD;
> > >>>+			break;
> > >>>+
> > >>
> > >>I think the best thing to do would be to return -ENODEV as suggested by
> > >>power_supply_sysfs.c:305. Also you should probably add the POWER_SUPPLY_PROP_PRESENT
> > >>property check and set intval to 0 when there is no battery.
> > >
> > >Good find with -ENODEV. However in this case here the power supply is
> > >really a combination of a charger and a battery (which could be split
> > >out accordingly but that's a different story). If I were to report
> > >-ENODEV I would basically say the entire power supply is gone which is
> > >not correct IMHO. Even with a missing battery a system is typically
> > >functional as it gets powered through USB and the charger IC is still
> > >there and functioning. So I think I would either leave the reporting
> > >as *_DEAD or skip the patch. I'm curious if there are additional
> > >opinions.
> > >
> > 
> > It looks like returning -ENODEV for one property would not mark the whole
> > device gone, just POWER_SUPPLY_PROP_HEALTH, but I guess that depends on
> > what user-space does with the info. I would think that this is what
> > POWER_SUPPLY_PROP_PRESENT is for but different drivers seem to use it for
> > different things. Anyway, reporting DEAD for a missing battery is probably
> > not the most correct option, maybe drop the patch ( for the cat's sake :) ).
> I'm also in favor of dropping this patch for the same reasons. Also,
> since the latest phones/tablets do not allow battery removal, it's
> highly unlikely we'll even hit this case nowadays. Perhaps, we could use

Hi Laurentiu, ok I'll drop it. Understood about the unlikeliness of a
battery removal for most devices using LiIon during runtime but a more
granular reporting would help in case there is an issue with the HW
itself (loose contact, manufacturing defect in the battery, etc.)

> DEAD if the battery did not charge and the safety timer expired?
> But, if one alters iilimit and sets a limit that's too low for the
> battery to charge in time, that doesn't mean the battery is dead... :/

Yeah unless there is a specific register bit or some very specific
guidance in a device datasheet as how to detect a truly dead battery I
would be a bit hesitant trying to interpret device register values to
derive to such a conclusion. Sometimes algorithms which seem simple are
only simple because one doesn't consider all the corner cases initially
:)

> That's the main reason I'm so reluctant on having properties like charge
> current, charge voltage, or even input current limit, writable in
> sysfs.

Agreed from a safety perspective. And if someone really wants to play
with fire (pun intended) they can always change the driver in their own
copy of the Kernel.

--
Andreas Dannenberg
Texas Instruments Inc

