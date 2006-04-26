From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Tue, 25 Apr 2006 17:30:33 -0700
Message-ID: <200604251730.34377.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0604251626180.839-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70531468479085802=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0604251626180.839-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@osdl.org>, Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============70531468479085802==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


> > > This state will be lost whenever the "power session" is interrupted, which
> > > means that USB devices cannot remain suspended when VBUS power is lost --
> > > and many systems do not provide VBUS suspend current while in various
> > > sleep states, although some systems do.
> > 
> > Most systems _do_ provide VBUS power during true suspend states.  But the
> > swsusp approach precludes VBUS;
> 
> I don't know how you justify that "Most".  

Most PC motherboards -- more than half for sure, every one I've seen or
heard of -- maintain it.  I've seen one ultralight laptop that powers
off VBUS during suspend-to-RAM, to save battery power.  Ditto for every
embedded board I've worked with; a few have a GPIO that can be used to
switch off the VBUS supply.


> At the least it would depend on 
> the particular state.  For instance, I've got a PCI USB controller card
> (VIA) on which the UHCI controllers support only D0 and D3cold.  And
> (although I'm not certain of this) I may have seen a report from someone
> whose system _does_ retain power during swsusp.  IIRC it was a powerbook
> of some sort.

I know that Macintoshes are good about maintaining power during STR, and
suspect that some systems running Apple's OS will do so during "hibernate";
they have a more complete/powerful power management framework than Linux.

But last time the topic came up, I recall Pavel saying he'd never seen or
heard of hardware that did things like that with swsusp, even when using
"platform" (or "firmware") suspend mode.


> > it's "system off" not "system suspend".
> 
> Well, there's "off" and there's "off".  You're the one who's been 
> complaining about generic terms like "on" and "off" being too imprecise.

In that context I meant real power off.  Sorry, didn't mean to confuse.

 
> > > Regardless, the problem is that the resuming kernel doesn't have any
> > > terribly good ways of telling whether or not the power session has
> > > remained intact.
> > 
> > Actually almost all systems do have ways to report that.
> 
> Again, I'm not so sure about that "almost all".  There have been plenty of 
> reports of controller settings getting messed up by BIOS firmware during a 
> suspend/resume cycle. 

Well, EHCI certainly has such ways, and for the past few years it's been
hard to find motherboards that don't include that.  OHCI also has ways,
which counts for all non-Intel/VIA motherboard.   I think you've explained
that UHCI still has some issues there ... although in that case, ISTR you
can at least detect that the controller was reset during suspend, and thus
deduce that the poser session was broken.


> Basically we have to assume that if the controller  
> isn't exactly the way we left it then the whole thing needs to be reset.  
> There should be a better approach...

Because for example that approach wouldn't detect the scenario that
led to my patch.  :)


> > Again, true system suspend states don't have this issue.  With swsusp
> > the sessions will always be broken.
> 
> If that is correct, then your patch is the right thing to do.  If it's not
> correct, your patch still isn't wrong -- it's just not quite optimal.

I still think it's correct.


> > > Maybe that's what you meant.  Trying to store that information 
> > > in the host controller's state is a poor-man's way of doing it, but at the
> > > moment it's the only way we have.  That's why David doesn't want the state 
> > > during the atomic reload to be the same as the state during a regular 
> > > resume.
> > 
> > I'd put it differently.  It's not a poor-man's way at all; passing that
> > information in hardware is the correct solution.  A regular resume would
> > keep the information there too (from STR or standby).  We don't want to
> > have swsusp piling on special cases.
> 
> Okay, I take it back.  Yes, putting the hardware into the appropriate 
> state is the right thing to do.
> 
> On the other hand, it might not be so easy to know what that state is.  

That was the point of my comment above (you responded "if that is correct...").
That's how to know.  Hardware is already correct in all cases except the annoying
one where the kernel resuming a swsusp snapshot initializes that USB driver; and
in that case, it's always correct to reset the USB controller.


> Perhaps the decision should be left up to the device driver.  If drivers
> were told the difference between "FREEZE to prepare for creating a memory
> snapshot" and "FREEZE to prepare for restoring a memory image" then they 
> could do the right thing always.

Or better yet, just do what kexec() does.  :)

- Dave


--===============70531468479085802==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============70531468479085802==--
