From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Thu, 27 Apr 2006 22:58:41 +0200
Message-ID: <20060427205841.GB10737@elf.ucw.cz>
References: <20060427080826.GB2376@ucw.cz>
	<20060427165536.GA3113@linux.intel.com>
	<200604271221.47160.david-b@pacbell.net>
	<200604280636.03606.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============85855824917019907=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604280636.03606.ncunningham@cyclades.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>, linux-usb-devel@lists.sourceforge.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============85855824917019907==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > 		During swsusp the system is
> > > > supposed to be completely off, with no suspend power available.  Hence
> > > > all the power sessions are guaranteed to be interrupted, and the boot
> > > > kernel doesn't have to worry about destroying any of them.
> > >
> > > Not necessarily. x86 hardware implementations of suspend-to-disk retain
> > > some power during suspend. Not many (if any) devices will retain context,
> > > but the system is definitely not completely "off".
> >
> > As a rule swsusp (or firmware suspend-to-disk) power off everything except
> > what's needed to power up the motherboard ... or to provide "5 AM wakeup"
> > type events using a battery-backed realtime clock.  Maintaining VBUS power
> > sessions from USB host controllers is one of those "theoretically allowed,
> > but never observed in the wild" cases.

Napa machine seems to maintain USB power even while turned off.

> > Right, not "completely" off ... but certainly nowhere as close to "on" as
> > would be true of suspend-to-RAM.  And regardless, the problem in $SUBJECT
> > is when Linux trashes the state which the limited "on" is there to
> > maintain.
> 
> This isn't necessarily true either. Suspend2 has supported writing the image, 
> then suspending to ram for a year or two. uswsusp has just gained the same 
> functionality. In this state, if you don't pull the plug/drain the battery, 
> you never actually power down. Having said that, this might be a different 
> kettle of fish though, because there's no boot kernel in that case. For 
> Suspend2 (and uswsusp, I assume), it's more akin to backing out of the cycle 
> at the last possible moment before powering down.

Yep it is same for uswsusp, and probably irrelevant here.
									Pavel



-- 
Thanks for all the (sleeping) penguins.

--===============85855824917019907==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============85855824917019907==--
