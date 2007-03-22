From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 14:13:56 +0100
Message-ID: <20070322131356.GB6050@elf.ucw.cz>
References: <1174295302.31250.1.camel@sli10-conroe.sh.intel.com>
	<20070320183022.GC2670@elf.ucw.cz>
	<1174440888.29722.15.camel@sli10-conroe.sh.intel.com>
	<20070321213909.GB6057@elf.ucw.cz>
	<1174532979.2208.3.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1174532979.2208.3.camel@sli10-conroe.sh.intel.com>
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

> > Heh, if mod_timer is bad idea, we'll fix mod_timer. Anyway, if you use
> > timestamp, you'll have to add polling, and that means overhead even
> > when idle.
> No, we don't need poll the timestamp frequently (maybe 1 minute or 5
> minute one time depends on your requirement)

Hmm, so instead of powering down soundcard 5 seconds after its last
use, we'll power it down 5 _minutes_ after that?

> > Anyway, we do not have to decide that at this point.
> > =

> > > > We can talk about generic device attribute "powerdown_timeout" in
> > > > sysfs... but I'd prefer few more drivers that do powersave before
> > we
> > > > do that.
> > > Using this you will have a timer in the driver, and the timer's
> > callback
> > > will suspend the device. This approach has some issues. 1. it's
> > better
> > > driver doesn't handle device dependence. This approach requires
> > driver
> > > handle dependence.
> > =

> > Why not?
> This will make driver complex. Driver should be as simple as possible.

You are free to provide helpers. Of course drivers will get more
complex with pm, but that's unavoidable.

								Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
