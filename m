From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Tue, 25 Apr 2006 14:04:29 -0700
Message-ID: <200604251404.30228.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200604250911.54951.david-b@pacbell.net>
	<200604252056.56534.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76081724639650949=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604252056.56534.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============76081724639650949==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 25 April 2006 11:56 am, Rafael J. Wysocki wrote:
> 
> > I've begun thinking that calls like pm_should_I_spin_down_drives() would be a
> > better structural approach than continually redefining this "freeze" thing so
> > it makes less and less sense to all other drivers ... who nonethless need to
> > clutter themselves up with a growing list of special cases, to accomodate
> > rotating media that may not even exist in the target system.
> 
> I think we should do something different to device_power_down(PMSG_FREEZE)
> there, but I'm not sure it should be kernel_restart_prepare(NULL).
> 
> Actually spinning down disks during resume is a problem for some users (yes,
> we've had such bug reports recently), so it's better to avoid this.

Well, if we had a pm_should_I_spin_down_drives() it would make sense to me
that it return FALSE during kernel_restart_prepare() too ... surely kexec
users have the same issues!


If you currently have users who object to spindown-during-resume, then it'd
seem that my patch couldn't change anything except maybe details.  And that
switching over to a call like pm_should_I_spin_down_drives() should fix it all.


> > > OTOH I think at least some device driver writers assume that .resume() will
> > > always be called after .suspend() which only is true for non-modular drivers
> > > (or for modular drivers loaded from an initrd before resume). 
> > 
> > Say what?  Of _course_ resume() should only be called after suspend().  If
> > that's not true in any case, the code wrongly issuing the resume() is buggy.
> 
> Well, suppose we have a modular driver that's not loaded before resume.

That's not the problem case though; it works correctly, since the device
hardware is already being left in an appropriate (RESET) state.


> Then it goes like that (approximately):
> (1) We activate swsusp which calls .suspend() for all devices including our
> driver (this is a real suspend).
> (2) swsusp snapshots the system and creates the image.
> (3) swsusp calls .resume() for all devices in order to be able to save the
> image (.resume() for our driver is also called which is OK).
> (4) swsusp turns off the system.
> (5) (some time later) We start a new kernel and tell it to resume.
> (6) It activates swsusp which reads the image.

And assuming this is an x86 PC, at this point every device is in one of three states:

  - initialized by BIOS.  This is a particular PITA for USB, but one that's
    handled OK (mostly) except when BIOS bugs kick in.  There's some nasty
    code that kicks in along with PCI quirk handling, which ensures that by
    the time Linux-USB  driver could see this state (or the input subsystem
    needs to care about it), the state has morphed to reset.  Video cards
    have funky issues here too.

  - (powerup) reset.  This is the ideal state, in terms of "truth" to convey
    to the image we're about to restore ... no ambiguity, every driver will
    need to re-init.  As if there were (thank you!!) no BIOS.

  - initialized by Linux ... which leads to the case my patch addresses.

Those first two states are legit for any resume() call, and they apply in
your scenario restriction.

The third state is the problem scenario, kicking in when the driver was
statically linked (or modprobed from initramfs, etc), but not during
your scenario.


> (7) (without your change) swsusp calls .suspend() for all device drivers that
> are present at that time,

... the current troublesome consequence of that third state ...

> but our driver is not there, so its .suspend() 
> _won't_ be called.  [Of course with your change .suspend() won't be called
> for any driver.]

Right:  the first two "safe" cases kick in.  This is the partial workaround I
had identified:  dodging the code paths for that third state, where suspend()
is being used to put the hardware into a broken suspend state.


Note that with that third state, there are actually two suspend() calls, but
only one resume() call.  (Suspend before snapshot, suspend before resume
snapshot, resume after activating snapshot.)  Such an extra suspend() call is
a small hint that something's odd, and maybe wrong.


> (8) swsusp restores the image.
> (9) swsusp calls .resume() for all devices _including_ our driver, because it
> was in memory before suspend.  For our driver this .resume() is not
> called after .suspend(), is it?

The suspend() was called from the kernel being resumed ... and the device hardware
is in one of the states (reset) that it's allowed to be in when calling its
matching resume().  No problem there.


> You're saying that (9) is wrong, so could you please suggest what to do
> instead of it?

The case in which (9) is wrong is the case you excluded:  where the pre-resume
kernel loaded the driver and used the third state listed above, and then trashed
the correct device hardware state (reset) and replaced it with a suspend state.

It may help to think of two distinct types of device hardware suspend states
(only the first is real, the second is just a software bug):

 - Correct, with internal state corresponding to what the driver suspend() did;
   what a normal hardware suspend/resume cycle (not powercycle!) could do.

 - Broken, with any other internal state (except reset).  This is what swsusp
   currently forces, by adding **AND HIDING** a reset and reinit cycle, because
   of the extra suspend() call in (7).

My patch/suggestion just ensures that instead of that broken state, reset is used.
in all cases ... not just the "driver not initialized before snapshot resume" case.

- Dave


--===============76081724639650949==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76081724639650949==--
