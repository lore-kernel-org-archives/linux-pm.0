From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] power: bq24190_charger: Limit over/under voltage
 fault logging
Date: Wed, 29 Mar 2017 09:33:38 -0700
Message-ID: <20170329163338.GP8575@atomide.com>
References: <20170325112419.25120-1-liam@networkimprov.net>
 <be76b89a-7d18-096a-b22c-53101ba43cfc@redhat.com>
 <CAKvHMgQOv=0cYJj6_0QgP9ApKwaxiJWvOwWfShFhBVGQtvpJQg@mail.gmail.com>
 <a2a73d00-faee-2032-a5ac-87cf49d94cdd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:42666 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753286AbdC2Qdn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Mar 2017 12:33:43 -0400
Content-Disposition: inline
In-Reply-To: <a2a73d00-faee-2032-a5ac-87cf49d94cdd@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

* Hans de Goede <hdegoede@redhat.com> [170326 04:06]:
> Hi,
> 
> On 26-03-17 12:56, Liam Breck wrote:
> > On Sun, Mar 26, 2017 at 1:44 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> > > Hi,
> > > 
> > > 
> > > On 25-03-17 12:24, Liam Breck wrote:
> > > > 
> > > > From: Liam Breck <kernel@networkimprov.net>
> > > > 
> > > > If the charger is unplugged before the battery is full we may
> > > > see an over/under voltage fault. Ignore this rather then emitting
> > > > a message or uevent.
> > > > 
> > > > This fixes messages like these getting logged on charger unplug + replug:
> > > > bq24190-charger 15-006b: Fault: boost 0, charge 1, battery 0, ntc 0
> > > > bq24190-charger 15-006b: Fault: boost 0, charge 0, battery 0, ntc 0
> > > > 
> > > > Cc: Tony Lindgren <tony@atomide.com>
> > > > Cc: Hans de Goede <hdegoede@redhat.com>
> > > > Signed-off-by: Liam Breck <kernel@networkimprov.net>
> > > > ---
> > > > v2: Don't hide clearance of other more urgent faults, or produce
> > > >     a uevent for this superficial fault.
> > > > 
> > > >  drivers/power/supply/bq24190_charger.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/power/supply/bq24190_charger.c
> > > > b/drivers/power/supply/bq24190_charger.c
> > > > index 897491d..de1c54f 100644
> > > > --- a/drivers/power/supply/bq24190_charger.c
> > > > +++ b/drivers/power/supply/bq24190_charger.c
> > > > @@ -1256,8 +1256,13 @@ static void bq24190_check_status(struct
> > > > bq24190_dev_info *bdi)
> > > >                 }
> > > >         } while (f_reg && ++i < 2);
> > > > 
> > > > +       /* ignore over/under voltage fault after disconnect */
> > > > +       if (f_reg == (1 << BQ24190_REG_F_CHRG_FAULT_SHIFT) &&
> > > > +           !(ss_reg & BQ24190_REG_SS_PG_STAT_MASK))
> > > > +               f_reg = 0;
> > > > +
> > > >         if (f_reg != bdi->f_reg) {
> > > > -               dev_info(bdi->dev,
> > > > +               dev_warn(bdi->dev,
> > > >                         "Fault: boost %d, charge %d, battery %d, ntc
> > > > %d\n",
> > > >                         !!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
> > > >                         !!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
> > > > 
> > > 
> > > You're now once again logging a warning when all faults clear,
> > 
> > By design; I want to know when any serious fault clears.
> > 
> > The under-voltage fault on disconnect will not trigger a cleared msg,
> > because the orig error is not recorded in bdi->f_reg.
> 
> Ok fine by me.

Fine with me too:

Acked-by: Tony Lindgren <tony@atomide.com>
