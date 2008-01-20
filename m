From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: b43_suspend problem
Date: Sun, 20 Jan 2008 19:26:55 +0100
Message-ID: <200801201926.56363.rjw__41065.5720778324$1200853612$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0801131634380.28667-100000@netrider.rowland.org>
	<200801200220.29640.rjw@sisk.pl> <200801201333.10123.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801201333.10123.mb@bu3sch.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael Buesch <mb@bu3sch.de>
Cc: pm list <linux-pm@lists.linux-foundation.org>, bcm43xx-dev@lists.berlios.de, Larry Finger <larry.finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

On Sunday, 20 of January 2008, Michael Buesch wrote:
> On Sunday 20 January 2008, Rafael J. Wysocki wrote:
> > On Sunday, 13 of January 2008, Alan Stern wrote:
> > > On Sun, 13 Jan 2008, Michael Buesch wrote:
> > > 
> > > > > Besides, if you're going to register the device right back again during 
> > > > > the subsequent resume, then why go to the trouble of unregistering it 
> > > > > during suspend?  Why not just leave it registered the whole time and 
> > > > > avoid all the complication (and excess meaningless uevents)?
> > > > 
> > > > Well, because not doing it complicates code :)
> > > > Currently suspend/resume calls the same code as init/exit.
> > > > The b43 init/exit code is really complicated, compared to other
> > > > drivers, due to dozens of hardware versions. So I just avoided
> > > > having yet other codepaths for suspend/resume. But I will add
> > > > a flag to the device structure that's used to avoid unregistering stuff.
> > > 
> > > Instead of adding an extra flag you should refactor the code.  Have a
> > > common "enable" subroutine that can be called for both init and resume,
> > > and a common "disable" subroutine that can be called for both exit and
> > > suspend.  Then the method routines themselves will contain only the
> > > portions unique to their particular functions, making them shorter and
> > > simpler.
> > 
> > Well, it doesn't seem to be that easy.
> > 
> > I tried to fix the issue myself and finally obtained the appended, apparently
> > working, patch (against 2.6.24-rc8-mm1).  Well, it should have been a series
> > of patches against multiple subsystems, but I thought it would be instructive
> > to put everything needed into one bigger patch for starters.
> > 
> > Greetings,
> > Rafael
> > 
> > ---
> >  drivers/base/power/main.c       |    1 
> >  drivers/base/power/power.h      |    1 
> >  drivers/char/hw_random/core.c   |   10 ++++-----
> >  drivers/char/misc.c             |   13 ++++++++----
> >  drivers/leds/led-class.c        |   13 ++++++++----
> >  drivers/net/wireless/b43/leds.c |   17 +++++++++------
> >  drivers/net/wireless/b43/leds.h |   14 +++++++++++--
> >  drivers/net/wireless/b43/main.c |   43 +++++++++++++++++++++++++++++-----------
> >  include/linux/device.h          |    6 +++++
> >  include/linux/hw_random.h       |   10 ++++++++-
> >  include/linux/leds.h            |   10 ++++++++-
> >  include/linux/miscdevice.h      |   10 ++++++++-
> >  12 files changed, 111 insertions(+), 37 deletions(-)
> > 
> > Index: linux-2.6.24-rc8-mm1/drivers/net/wireless/b43/main.c
> > ===================================================================
> > --- linux-2.6.24-rc8-mm1.orig/drivers/net/wireless/b43/main.c
> > +++ linux-2.6.24-rc8-mm1/drivers/net/wireless/b43/main.c
> > @@ -2470,10 +2470,15 @@ static int b43_rng_read(struct hwrng *rn
> >  	return (sizeof(u16));
> >  }
> >  
> > -static void b43_rng_exit(struct b43_wl *wl)
> > +static void __b43_rng_exit(struct b43_wl *wl, bool suspended)
> >  {
> >  	if (wl->rng_initialized)
> > -		hwrng_unregister(&wl->rng);
> > +		__hwrng_unregister(&wl->rng, suspended);
> > +}
> > +
> > +static void b43_rng_exit(struct b43_wl *wl)
> > +{
> > +	__b43_rng_exit(wl, false);
> >  }
> >  
> >  static int b43_rng_init(struct b43_wl *wl)
> > @@ -3289,7 +3294,7 @@ static void b43_set_retry_limits(struct 
> >  
> >  /* Shutdown a wireless core */
> >  /* Locking: wl->mutex */
> > -static void b43_wireless_core_exit(struct b43_wldev *dev)
> > +static void __b43_wireless_core_exit(struct b43_wldev *dev, bool no_suspend)
> >  {
> >  	struct b43_phy *phy = &dev->phy;
> >  
> > @@ -3298,8 +3303,10 @@ static void b43_wireless_core_exit(struc
> >  		return;
> >  	b43_set_status(dev, B43_STAT_UNINIT);
> >  
> > -	b43_leds_exit(dev);
> > -	b43_rng_exit(dev->wl);
> > +	if (no_suspend) {
> > +		b43_leds_exit(dev);
> > +		b43_rng_exit(dev->wl);
> > +	}
> >  	b43_pio_free(dev);
> >  	b43_dma_free(dev);
> >  	b43_chip_exit(dev);
> > @@ -3313,8 +3320,13 @@ static void b43_wireless_core_exit(struc
> >  	ssb_bus_may_powerdown(dev->dev->bus);
> >  }
> >  
> > +static void b43_wireless_core_exit(struct b43_wldev *dev)
> > +{
> > +	__b43_wireless_core_exit(dev, true);
> > +}
> 
> Nah, please don't obfuscate the code.
> Better add a flag to struct b43_wldev and check that in the few places
> that need different behaviour.

I can do that, if you prefer, but that will look worse, IMHO.

Thanks,
Rafael
