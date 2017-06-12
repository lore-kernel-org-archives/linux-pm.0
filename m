From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 1/2] power: supply: ltc2941-battery-gauge: Define LTC2942
 registers
Date: Mon, 12 Jun 2017 19:59:25 +0200
Message-ID: <20170612175925.fblyzaewuuoivt55@lenoch>
References: <20170612150226.woxfdi4lharq5gtq@lenoch>
 <20170612150356.wvehmijba6xbdwvb@lenoch>
 <8d97cccb-fef7-428d-b075-b0e59a590d80@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:51676 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbdFLR7k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 13:59:40 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23991346AbdFLR7c1wZ9d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Jun 2017 19:59:32 +0200
Content-Disposition: inline
In-Reply-To: <8d97cccb-fef7-428d-b075-b0e59a590d80@topic.nl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

On Mon, Jun 12, 2017 at 06:26:17PM +0200, Mike Looijmans wrote:
> On 12-6-2017 17:03, Ladislav Michl wrote:
> > Add LTC2942 registers definitions. No functional changes.
> > 
> > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > ---
> >  drivers/power/supply/ltc2941-battery-gauge.c | 27 +++++++++++++--------------
> >  1 file changed, 13 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
> > index 7efb908f4451..0a1b69bbca7f 100644
> > --- a/drivers/power/supply/ltc2941-battery-gauge.c
> > +++ b/drivers/power/supply/ltc2941-battery-gauge.c
> > @@ -34,16 +34,14 @@ enum ltc294x_reg {
> >  	LTC294X_REG_CONTROL		= 0x01,
> >  	LTC294X_REG_ACC_CHARGE_MSB	= 0x02,
> >  	LTC294X_REG_ACC_CHARGE_LSB	= 0x03,
> > -	LTC294X_REG_THRESH_HIGH_MSB	= 0x04,
> > -	LTC294X_REG_THRESH_HIGH_LSB	= 0x05,
> > -	LTC294X_REG_THRESH_LOW_MSB	= 0x06,
> > -	LTC294X_REG_THRESH_LOW_LSB	= 0x07,
> > -	LTC294X_REG_VOLTAGE_MSB	= 0x08,
> > -	LTC294X_REG_VOLTAGE_LSB	= 0x09,
> > -	LTC294X_REG_CURRENT_MSB	= 0x0E,
> > -	LTC294X_REG_CURRENT_LSB	= 0x0F,
> > -	LTC294X_REG_TEMPERATURE_MSB	= 0x14,
> > -	LTC294X_REG_TEMPERATURE_LSB	= 0x15,
> > +	LTC294X_REG_VOLTAGE_MSB		= 0x08,
> > +	LTC294X_REG_VOLTAGE_LSB		= 0x09,
> > +	LTC2942_REG_TEMPERATURE_MSB	= 0x0C,
> > +	LTC2942_REG_TEMPERATURE_LSB	= 0x0D,
> > +	LTC2943_REG_CURRENT_MSB		= 0x0E,
> > +	LTC2943_REG_CURRENT_LSB		= 0x0F,
> > +	LTC2943_REG_TEMPERATURE_MSB	= 0x14,
> > +	LTC2943_REG_TEMPERATURE_LSB	= 0x15,
> >  };
> 
> I don't see the advantage of renaming these, I'd rather see the LTC294X
> naming throughout, making it easier to locate them in the enum as they all
> share the exact same prefix.

LTC2942 and LTC2943 are using different register offsets for temperature
and current register is LTC2943 specific. Hence the rename, otherwise you
won't be able to distinguish between temperature registers in different chips.

> But if you do want this renaming, I guess you should also rename the LTC2941
> registers.

Well, naming convention is to use LTC294X prefix only for registers common
to all chips. Chip specific registers are using chip specific prefixes. Also
I'm not big fan of having register offsets as enums - offset is a number and
should be represented as such.

> I'm neutral to either naming, linux-pm maintainer will have the final word I
> guess.

I have no problem rolling change back with exception of tepmerature registers
(LTC294X_LTC2942_REG_TEMPERATURE_MSB would probably be an option, but such a
long identifier hurts my eyes).

Let's wait for maintainer's comment.

Best regards,
	ladis
