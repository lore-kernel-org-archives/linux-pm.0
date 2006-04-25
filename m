From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Tue, 25 Apr 2006 10:41:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0604251010460.5330-100000@iolanthe.rowland.org>
References: <200604252034.54352.ncunningham@cyclades.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============067453615950721524=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604252034.54352.ncunningham@cyclades.com>
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
Cc: David Brownell <david-b@pacbell.net>, Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============067453615950721524==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 25 Apr 2006, Nigel Cunningham wrote:

> It seems to me that the right solution might be for these usb devices to
> treat a resume from a freeze as an indication that hardware should be reset.

That can't be right.  For example, we issue resume from freeze during the 
suspend portion of swsusp (to write out the image).

> The only reason that driver suspend/resume handling is still far from perfect 
> is that a good number of drivers still don't have any suspend/resume 
> handling. Getting rid of the instrastructure because it isn't completely 
> implemented is the wrong approach. We should instead complete implementing 
> the support so that drivers understand the difference between freezing, 
> suspending, powering down, powering up and resuming. If we dumb things down, 
> we'll only create problems.

I agree that this is a major reason.  It's not the _only_ reason.  But 
never mind that now...

> Rafael raised the issue in another email of code built as modules that is 
> suspended and not resumed or vice versa because in the case of suspend to 
> disk, the module is loaded at boot time but not in the suspended kernel (or 
> v.v). It seems to me that the right way to deal with this is to extend the 
> use of __nosave so that information about what was loaded in the boot kernel 
> is available when resuming drivers after the atomic restore.

It's not clear that you're getting the point.  (In fact, it's not entirely
clear that I understand it perfectly either, because this is fairly
subtle.)

When the USB subsystem resumes a device, it relies on the fact that a
certain amount of state has been preserved _in the device_.  At a minimum,
that state includes the device's bus address, which is assigned
dynamically and obviously is necessary for communicating with the device.  
This state will be lost whenever the "power session" is interrupted, which
means that USB devices cannot remain suspended when VBUS power is lost --
and many systems do not provide VBUS suspend current while in various
sleep states, although some systems do.

Regardless, the problem is that the resuming kernel doesn't have any
terribly good ways of telling whether or not the power session has
remained intact.  It can test whether the host controller is still in the
same state that a suspend would leave it in.  It can test whether the
device's port is still enabled and whether anything responds at the
device's bus address.  (We don't currently try to tell whether the
responder actually _is_ the device we're trying to resume as opposed to
some other device!)

The real difficulty comes when the USB drivers are compiled into the boot 
kernel or loaded by an initrd.  They will take over the host controllers 
and any devices they can find, destroying the preserved state.  Then when 
they are told to prepare for the upcoming atomic restore, they will try to 
freeze or reset (or whatever) the devices.

Now the resuming kernel starts up, and it has to guess whether everything
is still properly suspended with all the necessary state intact.  Suppose
the boot kernel has destroyed the state and left the devices frozen, as
happens now (without David's patch).  It will appear to the resuming
kernel that the devices are still suspended, but unbeknownst to the kernel 
the state information is gone.  That's why the devices don't work after 
resuming until the user unplugs and replugs them.

The right way to solve this is to make sure that the resuming kernel can
correctly determine whether the power session (way back from the original
sw-suspend) is still intact.  It's expected that in many cases it won't
be, because most systems won't provide suspend current while the machine
is off.  We have to guarantee that the boot kernel's actions won't end up
fooling the resuming kernel into thinking that the power sessions are
intact when in fact they aren't.  (Furthermore, in an ideal world, we
would also make sure that the boot kernel won't destroy any power sessions
that still _are_ intact.  Right now we have no way to do this, because the
drivers in the boot kernel don't know that it _is_ a boot kernel.)

Making the boot kernel shut down the host controllers instead of freezing
or suspending them will indeed destroy all existing power sessions, as
well as making it clear to the resuming kernel that that are gone.  Under
certain circumstances, freezing the host controllers will fool the
resuming kernel.

Propagating some kind of information from one kernel to the next is the
solution.  Maybe that's what you meant.  Trying to store that information
in the host controller's state is a poor-man's way of doing it, but at the
moment it's the only way we have.  That's why David doesn't want the state 
during the atomic reload to be the same as the state during a regular 
resume.

Alan Stern


--===============067453615950721524==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============067453615950721524==--
