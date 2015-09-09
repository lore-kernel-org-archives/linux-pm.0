From: Andreas Dannenberg <dannenberg@ti.com>
Subject: Re: [PATCH] power: bq24261_charger: Add support for TI BQ24261
 charger
Date: Wed, 9 Sep 2015 12:31:48 -0500
Message-ID: <20150909173147.GA9887@beast>
References: <1441560187-23611-1-git-send-email-ramakrishna.pallala@intel.com>
 <CAJKOXPfDu+LxoiQrV+CsqUbEVwYb1Zmk-m9y-L_1JxrB6ouS0g@mail.gmail.com>
 <20150909022617.GA32255@beast>
 <55EFB2C7.30800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43625 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbbIIRcA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Sep 2015 13:32:00 -0400
Content-Disposition: inline
In-Reply-To: <55EFB2C7.30800@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, laurentiu.palcu@intel.com
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Jenny TC <jenny.tc@intel.com>

On Wed, Sep 09, 2015 at 01:17:11PM +0900, Krzysztof Kozlowski wrote:
> On 09.09.2015 11:26, Andreas Dannenberg wrote:
> > Krzysztof, good observation! In bq2425x_charger.c (formerly known as
> > bq24257_charger.c :) that I worked on the unit used was uA. At that time
> > I did a quick check and there didn't seem to be a clear standard whether
> > to use the "micro" or "milli" units - different drivers use different
> > units. However there seems to be a tendency for the TI drivers to prefer
> > "milli" (bq2415x_charger.c, bq24735-charger.c)
> > 
> > Personally I think "milli" units are more appropriate for chargers since
> > they provide sufficient granularity and the numbers don't become too big
> > (try typing a voltage in the Volt-range in uV, it's very easy to get the
> > number of 0s wrong). However since the driver was already there I left
> > that aspect alone to preserve compatibility.
> 
> I am fine with both units but milli indeed seems easier to judge by fast
> looking and less error-prone. Whatever you choose - choose the same one. :)

Ok sounds good. If so, I could go ahead and change the units in the
bq2425x_charger.c over to mA and mV? It would be a bit labor some and I
also want to see what Laurentiu thinks but this way we could have most
of those TI charger drivers use the same units (the new bq24261 driver
Ram posted also uses mA/mV). Except bq25890_charger.c.... that would
still use uA/uV....

Laurentiu -- what made you chose the "micro" units for bq24257_charger.c
and bq25890_charger.c?

Thanks,

--
Andreas Dannenberg
Texas Instruments Inc

