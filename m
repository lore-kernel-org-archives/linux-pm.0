From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] dynamic device power management proposal
Date: Wed, 21 Mar 2007 22:39:09 +0100
Message-ID: <20070321213909.GB6057@elf.ucw.cz>
References: <1174295302.31250.1.camel@sli10-conroe.sh.intel.com>
	<20070320183022.GC2670@elf.ucw.cz>
	<1174440888.29722.15.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174440888.29722.15.camel@sli10-conroe.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > So far so good, but please use ascii ' for '.
> > =

> > > I think we need answer below questions:
> > > 1. How to present device???s power info/control interface to policy.
> > ...
> > =

> > Depends on bus, I'm afraid. We do not want to do this in generic code.
> Agree it depends on bus. But it's better a framework can abstract the
> interface

Parse error. Anyway, feel free to suggest framework to improve USB.

> > > 2. How to handle devices dependences. For example, for a PCI
> > endpoint
> > ...
> > =

> > USB gets the dependencies right, just copy that.
> Does USB include all kinds of dependence, eg non parent-children
> dependence?

No, probably not, as USB was designed properly. How common are those
cross dependencies? Do we really want to solve them generically?

> > > int foo() //all service routines of the driver should do
> > > {
> > >             //wakeup the device if it???s suspended
> > >             dpm_active_device();
> > =

> > No, we do not want this kind of interface. It should be something like
> > mod_timer(my_timer, HZ+10);
> 1. the device might suspend already here, we should resume it.
> 2. mod_timer is a bad idea. It's too heavy, if the routine is called
> very frequently, mod_timer will be a big overload. That's why I use a
> timestamp. Updating a timestamp hasn't any overload.

Heh, if mod_timer is bad idea, we'll fix mod_timer. Anyway, if you use
timestamp, you'll have to add polling, and that means overhead even
when idle.

Anyway, we do not have to decide that at this point.

> > We can talk about generic device attribute "powerdown_timeout" in
> > sysfs... but I'd prefer few more drivers that do powersave before we
> > do that.
> Using this you will have a timer in the driver, and the timer's callback
> will suspend the device. This approach has some issues. 1. it's better
> driver doesn't handle device dependence. This approach requires driver
> handle dependence. =


Why not?

> 2. It's better a userspace policy to directly suspend
> a device and driver just provides control interface. A userspace is
> definitely flexible and make driver simpler.

No.

> > No, that's not how it works; look at hda_audio, it already has
> > powersave. Just power down audio card 5 seconds after its control file
> > is closed.
> It's another case of doing policy in a driver.

Yes, but in this case we want it there, as someone already explained.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
