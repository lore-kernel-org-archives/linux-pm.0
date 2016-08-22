From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V3 2/5] thermal: bcm2835: add thermal driver for bcm2835
 soc
Date: Mon, 22 Aug 2016 15:45:40 +0800
Message-ID: <1471851940.2188.22.camel@intel.com>
References: <1463495753-967-1-git-send-email-kernel@martin.sperl.org>
         <1463495753-967-3-git-send-email-kernel@martin.sperl.org>
         <87mvn6qa2x.fsf@eliezer.anholt.net> <87r39lvs4v.fsf@eliezer.anholt.net>
         <1471591694.2691.39.camel@intel.com> <87inuwd1p4.fsf@eliezer.anholt.net>
         <1471786649.2188.4.camel@intel.com>
         <46FE06A3-5A7D-41D7-827B-C7B35E42E2C5@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39765 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753682AbcHVHpq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Aug 2016 03:45:46 -0400
In-Reply-To: <46FE06A3-5A7D-41D7-827B-C7B35E42E2C5@martin.sperl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Martin Sperl <kernel@martin.sperl.org>
Cc: Eric Anholt <eric@anholt.net>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Russell King <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 日, 2016-08-21 at 19:21 +0200, Martin Sperl wrote:
> > 
> > On 21.08.2016, at 15:37, Zhang Rui <rui.zhang@intel.com> wrote:
> > 
> > > 
> > > On 五, 2016-08-19 at 11:59 -0700, Eric Anholt wrote:
> > > Zhang Rui <rui.zhang@intel.com> writes:
> > > 
> > > > 
> > > > 
> > > > > 
> > > > > On 四, 2016-08-18 at 11:39 -0700, Eric Anholt wrote:
> > > > > 
> > > > > Eric Anholt <eric@anholt.net> writes:
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > kernel@martin.sperl.org writes:
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > From: Martin Sperl <kernel@martin.sperl.org>
> > > > > > > 
> > > > > > > Add basic thermal driver for bcm2835 SOC.
> > > > > > > 
> > > > > > > This driver currently relies on the firmware setting up
> > > > > > > the
> > > > > > > tsense HW block and does not set it up itself.
> > > > > > > 
> > > > > > > Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> > > > > > > 
> > > > > > > ChangeLog:
> > > > > > >  V1 -> V2: added specific settings depending on
> > > > > > > compatiblity
> > > > > > >       added trip point based on register
> > > > > > >       setting up ctrl-register if HW is not enabled by
> > > > > > > firmware
> > > > > > >         as per recommendation of Eric (untested)
> > > > > > >       check that clock frequency is in range
> > > > > > >         (1.9 - 5MHz - as per comment in clk-bcm2835.c)
> > > > > > > ---
> > > > > > > 
> > > > > > > diff --git a/drivers/thermal/bcm/Makefile
> > > > > > > b/drivers/thermal/bcm/Makefile
> > > > > > > new file mode 100644
> > > > > > > index 0000000..13456d2
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/thermal/bcm/Makefile
> > > > > > > @@ -0,0 +1 @@
> > > > > > > +obj-$(CONFIG_BCM2835_THERMAL)        :=
> > > > > > > bcm2835_thermal.o
> > > > > > > diff --git a/drivers/thermal/bcm/bcm2835_thermal.c
> > > > > > > b/drivers/thermal/bcm/bcm2835_thermal.c
> > > > > > > new file mode 100644
> > > > > > > index 0000000..73138cb
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/thermal/bcm/bcm2835_thermal.c
> > > > > > > 
> > > > > > > +static const struct of_device_id
> > > > > > > bcm2835_thermal_of_match_table[];
> > > > > > > +static int bcm2835_thermal_probe(struct platform_device
> > > > > > > *pdev)
> > > > > > > +{
> > > > > > > 
> > > > > > > +    /* enable clock and check rate */
> > > > > > > +    clk_prepare_enable(data->clk);
> > > > > > > +    rate = clk_get_rate(data->clk);
> > > > > > > +    if ((rate < 1920000) || (rate > 5000000)) {
> > > > > > > +        dev_warn(&pdev->dev,
> > > > > > > +             "Clock %pCn is running at %pCr Hz,
> > > > > > > which is outside the recommended range of 1.9 to 5.0
> > > > > > > MHz\n",
> > > > > > > +             data->clk, data->clk);
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    /* register it */
> > > > > > > +    tz = thermal_zone_device_register("bcm2835_thermal",
> > > > > > > +                      1, 0, data,
> > > > > > > +                      &bcm2835_thermal_o
> > > > > > > ps,
> > > > > > > +                      NULL, 0, 0);
> > > > > > I notice that the polling_delay is set to 0, but we're not
> > > > > > using
> > > > > > interrupts to trigger the trip.  Is it valid to expose a
> > > > > > trip
> > > > > > without a
> > > > > > polling_delay or interrupts?  Should passive_delay be set
> > > > > > as
> > > > > > well?
> > > > > > 
> > > > > > This is up to the thermal maintainers.  As far as I'm
> > > > > > concerned,
> > > > > > it's:
> > > > > > 
> > > > > > Acked-by: Eric Anholt <eric@anholt.net>
> > > > > > 
> > > > > > One it lands I'll pull the defconfig and DT bits.
> > > > > Ping on this question to thermal maintainers.  I'd still love
> > > > > to
> > > > > see
> > > > > this driver land.
> > > > hmmm, how is this driver supposed to work?
> > > > With this patch set, I think the only benefit is that we can
> > > > get
> > > > the
> > > > temperature and trip point information via thermal sysfs
> > > > interface,
> > > > but
> > > > kernel thermal control is a no-op here, right?
> > > Yeah.  It seems useful to be able to get the information.  Once
> > > we
> > > land
> > > this, I hope someone can add interrupt support so that there are
> > > actual
> > > trip points.
> > sounds reasonable to me.
> > Another question, why you need a separate directory for a single
> > file, bcm2835_thermal.c?
> Lots of other subsystems (clk, sound/soc, ...) are using vendor
> specific
> sub directories.
> In thermal there are already subdirectories for Samsung or st.
> So this was done in this case as well to support Broadcom immediately
> following this pattern.
> 
> You want a new version to keep it in thermal directly I can create a
> new version of the patch.
> 
If there are more broadcom patches coming, in your plan, it's okay to
have its own subdirectory. Or else, it's better to create the
subdirectory when it's actually needed.

thanks,
rui
> Thanks, Martin
