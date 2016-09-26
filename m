From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/2] power: supply: max17042_battery: add technology
 property support
Date: Mon, 26 Sep 2016 18:32:52 +0200
Message-ID: <20160926163252.GA3196@kozik-lap>
References: <20160926105510.GA8140@kozik-lap>
 <87eg46x1ir.fsf@machinist.wiedmeyer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33911 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938895AbcIZQc5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Sep 2016 12:32:57 -0400
Content-Disposition: inline
In-Reply-To: <87eg46x1ir.fsf@machinist.wiedmeyer.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 26, 2016 at 02:56:44PM +0200, Wolfgang Wiedmeyer wrote:
> 
> Krzysztof Kozlowski writes:
> 
> > On Sun, Sep 25, 2016 at 11:10:11PM +0200, Wolfgang Wiedmeyer wrote:
> >> This patch reports the battery technology as Li-ion.
> >> 
> >> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
> >> ---
> >>  drivers/power/max17042_battery.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >> 
> >> diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
> >> index 20cb1fd..43cb5df 100644
> >> --- a/drivers/power/max17042_battery.c
> >> +++ b/drivers/power/max17042_battery.c
> >> @@ -92,6 +92,7 @@ static enum power_supply_property max17042_battery_props[] = {
> >>  	POWER_SUPPLY_PROP_TEMP_MIN,
> >>  	POWER_SUPPLY_PROP_TEMP_MAX,
> >>  	POWER_SUPPLY_PROP_HEALTH,
> >> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> >>  	POWER_SUPPLY_PROP_CURRENT_NOW,
> >>  	POWER_SUPPLY_PROP_CURRENT_AVG,
> >>  };
> >> @@ -296,6 +297,9 @@ static int max17042_get_property(struct power_supply *psy,
> >>  		if (ret < 0)
> >>  			return ret;
> >>  		break;
> >> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> >> +		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
> >
> > How can you be sure it is always Li-Ion? For wearables and mobiles, rather yes, but
> > the driver is also used in other devices. Technically, specs are saying
> > it might be used also with Li-Poly applications.
> 
> I suppose that there is no way to detect this. Would it be ok if I add
> an optional Device Tree property that allows to specify if it's Li-Ion
> or Li-Poly? If the property is not supplied, then "unknown" is returned.

I am not sure in such case what will be the benefit of exposing this to
user-space... but it won't harm neither and sounds like a valid usage of
DT properties. Fine with me.

Best regards,
Krzysztof
