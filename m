From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Tue, 25 Apr 2006 23:41:19 +0200
Message-ID: <20060425214119.GA6542@elf.ucw.cz>
References: <200604241429.52022.david-b@pacbell.net>
	<200604250911.54951.david-b@pacbell.net>
	<200604252056.56534.rjw@sisk.pl>
	<200604251404.30228.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============092971106162385908=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604251404.30228.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Nigel Cunningham <nigel@suspend2.net>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============092971106162385908==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(aha, I see the mail now)

> > > I've begun thinking that calls like pm_should_I_spin_down_drives() would be a
> > > better structural approach than continually redefining this "freeze" thing so
> > > it makes less and less sense to all other drivers ... who nonethless need to
> > > clutter themselves up with a growing list of special cases, to accomodate
> > > rotating media that may not even exist in the target system.
> > 
> > I think we should do something different to device_power_down(PMSG_FREEZE)
> > there, but I'm not sure it should be kernel_restart_prepare(NULL).
> > 
> > Actually spinning down disks during resume is a problem for some users (yes,
> > we've had such bug reports recently), so it's better to avoid this.
> 
> Well, if we had a pm_should_I_spin_down_drives() it would make sense to me
> that it return FALSE during kernel_restart_prepare() too ... surely kexec
> users have the same issues!

pm_should_I_spin_down_drives() is incredibly ugly hack, sorry.

> > Then it goes like that (approximately):
> > (1) We activate swsusp which calls .suspend() for all devices including our
> > driver (this is a real suspend).
> > (2) swsusp snapshots the system and creates the image.
> > (3) swsusp calls .resume() for all devices in order to be able to save the
> > image (.resume() for our driver is also called which is OK).
> > (4) swsusp turns off the system.
> > (5) (some time later) We start a new kernel and tell it to resume.
> > (6) It activates swsusp which reads the image.
> 
> And assuming this is an x86 PC, at this point every device is in one of three states:
> 
>   - initialized by BIOS.  This is a particular PITA for USB, but one that's
>     handled OK (mostly) except when BIOS bugs kick in.  There's some nasty
>     code that kicks in along with PCI quirk handling, which ensures that by
>     the time Linux-USB  driver could see this state (or the input subsystem
>     needs to care about it), the state has morphed to reset.  Video cards
>     have funky issues here too.
> 
>   - (powerup) reset.  This is the ideal state, in terms of "truth" to convey
>     to the image we're about to restore ... no ambiguity, every driver will
>     need to re-init.  As if there were (thank you!!) no BIOS.
> 
>   - initialized by Linux ... which leads to the case my patch addresses.
> 
> Those first two states are legit for any resume() call, and they apply in
> your scenario restriction.
> 
> The third state is the problem scenario, kicking in when the driver was
> statically linked (or modprobed from initramfs, etc), but not during
> your scenario.

Driver should be able to resume() from state #3. If driver is broken
and can't do that, modify suspend() call to power down hardware.

> My patch/suggestion just ensures that instead of that broken state, reset is used.
> in all cases ... not just the "driver not initialized before snapshot resume" case.

I guess I partially see what you are saying. Behaviour in
driver-modular and driver-non-modular is indeed different and that is
not nice.

But it would be nice to have less intrusive solution than call reboot
notifiers...
								Pavel
-- 
Thanks for all the (sleeping) penguins.

--===============092971106162385908==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============092971106162385908==--
