From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH] power: bq24261_charger: Add support for TI BQ24261
 charger
Date: Thu, 10 Sep 2015 17:50:26 +0300
Message-ID: <20150910145026.GO21512@lpalcu-desk>
References: <1441560187-23611-1-git-send-email-ramakrishna.pallala@intel.com>
 <CAJKOXPfDu+LxoiQrV+CsqUbEVwYb1Zmk-m9y-L_1JxrB6ouS0g@mail.gmail.com>
 <20150909022617.GA32255@beast>
 <55EFB2C7.30800@samsung.com>
 <20150909173147.GA9887@beast>
 <55F0C586.3010003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:37297 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970AbbIJOua (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 10:50:30 -0400
Content-Disposition: inline
In-Reply-To: <55F0C586.3010003@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Andreas Dannenberg <dannenberg@ti.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Jenny TC <jenny.tc@intel.com>

On Thu, Sep 10, 2015 at 08:49:26AM +0900, Krzysztof Kozlowski wrote:
> On 10.09.2015 02:31, Andreas Dannenberg wrote:
> > On Wed, Sep 09, 2015 at 01:17:11PM +0900, Krzysztof Kozlowski wrote:
> >> On 09.09.2015 11:26, Andreas Dannenberg wrote:
> >>> Krzysztof, good observation! In bq2425x_charger.c (formerly known as
> >>> bq24257_charger.c :) that I worked on the unit used was uA. At that time
> >>> I did a quick check and there didn't seem to be a clear standard whether
> >>> to use the "micro" or "milli" units - different drivers use different
> >>> units. However there seems to be a tendency for the TI drivers to prefer
> >>> "milli" (bq2415x_charger.c, bq24735-charger.c)
> >>>
> >>> Personally I think "milli" units are more appropriate for chargers since
> >>> they provide sufficient granularity and the numbers don't become too big
> >>> (try typing a voltage in the Volt-range in uV, it's very easy to get the
> >>> number of 0s wrong). However since the driver was already there I left
> >>> that aspect alone to preserve compatibility.
> >>
> >> I am fine with both units but milli indeed seems easier to judge by fast
> >> looking and less error-prone. Whatever you choose - choose the same one. :)
> > 
> > Ok sounds good. If so, I could go ahead and change the units in the
> > bq2425x_charger.c over to mA and mV?
> 
> Wait, these are existing bindings (for bq24257). You cannot change
> existing binding.
> 
> Best regards,
> Krzysztof
> 
> > It would be a bit labor some and I
> > also want to see what Laurentiu thinks but this way we could have most
> > of those TI charger drivers use the same units (the new bq24261 driver
> > Ram posted also uses mA/mV). Except bq25890_charger.c.... that would
> > still use uA/uV....
> > 
> > Laurentiu -- what made you chose the "micro" units for bq24257_charger.c
> > and bq25890_charger.c?
When I started writing the BQ24257 driver, I had a look on what existed
already. Somehow, I don't know why, I settled on bq24190_charger which
has all the units in uA/uV. I thought it's the de-facto standard for
charger drivers... :/

For bindings, I looked at the existing TI chips bindings and chose the
same binding names, where possible. But for some dumb reason, I missed
that the units already used where mainly in mA/mV and, honestly, I
didn't even suspect units must be consistent from device to device. What
happens if a chip needs a more fine grained setting? I agree on binding
name consistency though: ti,charge-current (for example) should mean the
same for all TI chargers.

That said, is not much we can do on the mA/uA or mV/uV front... At least
we can agree on using the same binding names.

laurentiu
