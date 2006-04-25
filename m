From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Tue, 25 Apr 2006 16:45:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0604251626180.839-100000@iolanthe.rowland.org>
References: <200604251037.13714.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============63399031290549157=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604251037.13714.david-b@pacbell.net>
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
Cc: Andrew Morton <akpm@osdl.org>, Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============63399031290549157==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 25 Apr 2006, David Brownell wrote:

> On Tuesday 25 April 2006 7:41 am, Alan Stern wrote:
> > 
> > When the USB subsystem resumes a device, it relies on the fact that a
> > certain amount of state has been preserved _in the device_.  At a minimum,
> > that state includes the device's bus address, which is assigned
> > dynamically and obviously is necessary for communicating with the device.  
> 
> It also includes other state

Maybe.  If the device has been configured and a driver loaded.

> ... for example the device's driver may
> have initialized it in a particular way, and external events may also
> have changed things in ways that the kernel cares about.  Not all of
> that state can be interrogated by Linux, and drivers are allowed to
> rely on that information being unchanged after a true resume().

Yes, certainly.

> > This state will be lost whenever the "power session" is interrupted, which
> > means that USB devices cannot remain suspended when VBUS power is lost --
> > and many systems do not provide VBUS suspend current while in various
> > sleep states, although some systems do.
> 
> Most systems _do_ provide VBUS power during true suspend states.  But the
> swsusp approach precludes VBUS;

I don't know how you justify that "Most".  At the least it would depend on
the particular state.  For instance, I've got a PCI USB controller card
(VIA) on which the UHCI controllers support only D0 and D3cold.  And
(although I'm not certain of this) I may have seen a report from someone
whose system _does_ retain power during swsusp.  IIRC it was a powerbook
of some sort.

> it's "system off" not "system suspend".

Well, there's "off" and there's "off".  You're the one who's been 
complaining about generic terms like "on" and "off" being too imprecise.

> > Regardless, the problem is that the resuming kernel doesn't have any
> > terribly good ways of telling whether or not the power session has
> > remained intact.
> 
> Actually almost all systems do have ways to report that.

Again, I'm not so sure about that "almost all".  There have been plenty of 
reports of controller settings getting messed up by BIOS firmware during a 
suspend/resume cycle.  Basically we have to assume that if the controller 
isn't exactly the way we left it then the whole thing needs to be reset.  
There should be a better approach...

> > The right way to solve this is to make sure that the resuming kernel can
> > correctly determine whether the power session (way back from the original
> > sw-suspend) is still intact.  It's expected that in many cases it won't
> > be, because most systems won't provide suspend current while the machine
> > is off.
> 
> True for swsusp, but generally not for true system suspend states.

As mentioned above, there's lots of variability.

> Again, true system suspend states don't have this issue.  With swsusp
> the sessions will always be broken.

If that is correct, then your patch is the right thing to do.  If it's not
correct, your patch still isn't wrong -- it's just not quite optimal.

> > Maybe that's what you meant.  Trying to store that information 
> > in the host controller's state is a poor-man's way of doing it, but at the
> > moment it's the only way we have.  That's why David doesn't want the state 
> > during the atomic reload to be the same as the state during a regular 
> > resume.
> 
> I'd put it differently.  It's not a poor-man's way at all; passing that
> information in hardware is the correct solution.  A regular resume would
> keep the information there too (from STR or standby).  We don't want to
> have swsusp piling on special cases.

Okay, I take it back.  Yes, putting the hardware into the appropriate 
state is the right thing to do.

On the other hand, it might not be so easy to know what that state is.  
Perhaps the decision should be left up to the device driver.  If drivers
were told the difference between "FREEZE to prepare for creating a memory
snapshot" and "FREEZE to prepare for restoring a memory image" then they 
could do the right thing always.

Alan Stern


--===============63399031290549157==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============63399031290549157==--
