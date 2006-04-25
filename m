From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Tue, 25 Apr 2006 10:37:13 -0700
Message-ID: <200604251037.13714.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0604251010460.5330-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0604251010460.5330-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 25 April 2006 7:41 am, Alan Stern wrote:
> 
> When the USB subsystem resumes a device, it relies on the fact that a
> certain amount of state has been preserved _in the device_.  At a minimum,
> that state includes the device's bus address, which is assigned
> dynamically and obviously is necessary for communicating with the device.  

It also includes other state ... for example the device's driver may
have initialized it in a particular way, and external events may also
have changed things in ways that the kernel cares about.  Not all of
that state can be interrogated by Linux, and drivers are allowed to
rely on that information being unchanged after a true resume().


> This state will be lost whenever the "power session" is interrupted, which
> means that USB devices cannot remain suspended when VBUS power is lost --
> and many systems do not provide VBUS suspend current while in various
> sleep states, although some systems do.

Most systems _do_ provide VBUS power during true suspend states.  But the
swsusp approach precludes VBUS; it's "system off" not "system suspend".


> Regardless, the problem is that the resuming kernel doesn't have any
> terribly good ways of telling whether or not the power session has
> remained intact.

Actually almost all systems do have ways to report that.  The issue in
this case is that swsusp both trashed that report and replaced it with
an incorrect and troublesome report that the sessions DID remain.


> It can test whether the host controller is still in the 
> same state that a suspend would leave it in.  It can test whether the
> device's port is still enabled and whether anything responds at the
> device's bus address.  (We don't currently try to tell whether the
> responder actually _is_ the device we're trying to resume as opposed to
> some other device!)

True.  Sometimes the port is managed with the help of an external
transceive that can monitor things more closely than the controller,
so the "controller" isn't the only relevant device.

 
> The real difficulty comes when the USB drivers are compiled into the boot 
> kernel or loaded by an initrd.  They will take over the host controllers 
> and any devices they can find, destroying the preserved state.  Then when 
> they are told to prepare for the upcoming atomic restore, they will try to 
> freeze or reset (or whatever) the devices.

That's what the patch changed:  to reset, not (wrongly) freeze/suspend.

And note that it also makes the behavior uniform, so that the snapshot
will always see the reset even if that driver had initialized inside
the kernel that restored the snapshot.


> Now the resuming kernel starts up, and it has to guess whether everything
> is still properly suspended with all the necessary state intact.  Suppose
> the boot kernel has destroyed the state and left the devices frozen, as
> happens now (without David's patch).  It will appear to the resuming
> kernel that the devices are still suspended, but unbeknownst to the kernel 
> the state information is gone.  That's why the devices don't work after 
> resuming until the user unplugs and replugs them.

Yes:  swsusp trashed the correct status report.


> The right way to solve this is to make sure that the resuming kernel can
> correctly determine whether the power session (way back from the original
> sw-suspend) is still intact.  It's expected that in many cases it won't
> be, because most systems won't provide suspend current while the machine
> is off.

True for swsusp, but generally not for true system suspend states.


> We have to guarantee that the boot kernel's actions won't end up 
> fooling the resuming kernel into thinking that the power sessions are
> intact when in fact they aren't.  (Furthermore, in an ideal world, we
> would also make sure that the boot kernel won't destroy any power sessions
> that still _are_ intact.  Right now we have no way to do this, because the
> drivers in the boot kernel don't know that it _is_ a boot kernel.)

Again, true system suspend states don't have this issue.  With swsusp
the sessions will always be broken.

 
> Making the boot kernel shut down the host controllers instead of freezing
> or suspending them will indeed destroy all existing power sessions, as
> well as making it clear to the resuming kernel that that are gone.  Under
> certain circumstances, freezing the host controllers will fool the
> resuming kernel.

Right.

 
> Propagating some kind of information from one kernel to the next is the
> solution. 

True system suspend states propagate that information in the hardware,
and I see no reason to define a second mechanism.


> Maybe that's what you meant.  Trying to store that information 
> in the host controller's state is a poor-man's way of doing it, but at the
> moment it's the only way we have.  That's why David doesn't want the state 
> during the atomic reload to be the same as the state during a regular 
> resume.

I'd put it differently.  It's not a poor-man's way at all; passing that
information in hardware is the correct solution.  A regular resume would
keep the information there too (from STR or standby).  We don't want to
have swsusp piling on special cases.

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
