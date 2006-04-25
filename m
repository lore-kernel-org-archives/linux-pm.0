From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Tue, 25 Apr 2006 16:13:41 -0700
Message-ID: <200604251613.42388.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net> <200604251404.30228.david-b@pacbell.net> <20060425214119.GA6542@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060425214119.GA6542@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Nigel Cunningham <nigel@suspend2.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Tuesday 25 April 2006 2:41 pm, Pavel Machek wrote:

> > Well, if we had a pm_should_I_spin_down_drives() it would make sense to me
> > that it return FALSE during kernel_restart_prepare() too ... surely kexec
> > users have the same issues!
> 
> pm_should_I_spin_down_drives() is incredibly ugly hack, sorry.

The name was chosen to be ugly.  I'd expect someone to make it prettier;
maybe draw ponies around the name or somesuch.  ;)


However, by the way your pm_message_t changes removed all information about
system states, you've forced that family of approach in every driver that needs
to know about such states in order to behave correctly.  For example, "don't
turn off clock X in PM_STANDBY" ... since no driver has a standard way to know
about PM_STANDBY, it needs some function accessing state set up by pm_ops.prepare
or else it's not going to be able to behave right.



> > The third state is the problem scenario, kicking in when the driver was
> > statically linked (or modprobed from initramfs, etc), but not during
> > your scenario.
> 
> Driver should be able to resume() from state #3. If driver is broken
> and can't do that, modify suspend() call to power down hardware.

You conveniently edited out the elaboration there.  State #3 is no problem
by itself ... it's later states, only accessible through door #3.

The problem comes from then calling suspend() -- as you advise! -- to force
broken/invalid/bogus suspend state into the hardware.  It's NOT a driver
issue ... it's the fact that calling suspend() there will trash hardware
state (needlessly).  Drivers should not need to cope with such trashing.


> > My patch/suggestion just ensures that instead of that broken state, reset is used.
> > in all cases ... not just the "driver not initialized before snapshot resume" case.
> 
> I guess I partially see what you are saying. Behaviour in
> driver-modular and driver-non-modular is indeed different and that is
> not nice.

That's part of it; the other part is that swsusp should never force the
hardware to reflect an invalid state (the way it does without my patch).

Different behaviours wouldn't be much trouble if they were both correct.


> But it would be nice to have less intrusive solution than call reboot
> notifiers...

Actually, we'd need the notifiers to be called as much as the driver.shutdown()
methods ... they are both used to reset hardware.


You still haven't come up with a response to my point that starting up a
new kernel via swsusp snapshot resume is a system restart in exactly the
same way as it is for kexec() ... at this point, there is no better fix
for the problem than my original patch, AND you haven't actually identified
a single real problem with it.

- Dave



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
