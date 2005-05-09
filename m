From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.12-rc4] driver model wakeup support
Date: Mon, 9 May 2005 07:36:05 -0700
Message-ID: <200505090736.05302.david-b@pacbell.net>
References: <200505081724.09468.david-b@pacbell.net>
	<20050509014916.GA27448@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============47523815246288614=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050509014916.GA27448@neo.rr.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============47523815246288614==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 08 May 2005 6:49 pm, Adam Belay wrote:
> On Sun, May 08, 2005 at 05:24:09PM -0700, David Brownell wrote:
> > This is a refresh of a patch I sent before.  I suspect it'd be
> > appropriate to merge this, given the agreement I thought I
> > heard last time I posted it.
> > ...
> 
> I actually was working on a similar patch, but decided to stop.  I have some
> concerns about the generic-ness of "wakeup".  For example, some devices may
> have multiple wakeup modes or wakeup criteria.  Under these situations having
> a global "wakeup" parameter might become clumsy.  So should drivers be
> exporting these sort of things on their own?
> 
> "Wake-on-lan", as an example, could have 4 or 5 different packet types to look
> for.  So when the user specifies one of these, he or she is expecting
> "wake-on-lan" to just work.  In the case of your patch, I think the sysfs
> attribute would also need to be configured.

As I commented.  Note that the various WOL options that "ethtool" exposes
apply to the "ethN" device (in sysfs, /sys/class/net/* devices) which are
not affected by this patch, not to real /sys/devices/... ones which are.


> "wakeup" seems to fit most ACPI and PCI devices well.  I'm not sure how it
> would apply to usb, firewire, pcmcia, etc., especially when determining
> if it supports wake.  It may just be something that only the driver knows.

This patch was partially written to solve a big gaping hole in the
PM framework that I noticed from USB.  It certainly behaves with USB!
(That is, with USB parts not included in that core patch.)

I have a hard time seeing how a simple policy setting could NOT work
for other wakeup-capable frameworks (or devices), though I suppose
an argument could be made that there should be an "always enabled"
option to export perverse hardware to userspace.

USB devices have a single "remote wakeup" mechanism, which not all
devices support.  If they support it, it's listed in the descriptor
for the active configuration (the one being suspended).  That's info
that's known by usbcore.  Network adapters often use it (with WOL),
as do keyboards and mice.


> A few more points:
> 
> Wakeup configuration may vary between system states, how can we account for
> this?  Should wakeup information be reconfigured by userspace before entering
> a sleep or off state?

What do you mean by "wakeup configuration"?  

I don't see any benefit to having state-specific policies; if the device
is going to be able to wake the system from sleep, the user isn't really
going to care how deep a sleep is involved.  They may be annoyed when it
can wake from some states and not others ... but that's basically going
to be an inescapable hardware limitation.  (Example:  sleep states that
let USB controllers retain root hub power can support wakeup by USB.
But sleep states which power off the hubs, maybe "deeper" sleep, can't.)


> Would there be any value in exporting a list of system states in which wake is
> supported on a per-device basis?

How would normal users -- "joe six-pack", "aunt tilly", or whoever -- use
such things?  I don't see many folk wanting to think about such issues.
They'll care if they can wake it up by touching the keyboard, and likely
remember that sometimes they have to use the front panel power switch
(for classic swsusp) rather than the one on the keyboard.


> > It would be preferable to not have the attribute for devices that aren't
> > wired with wakeup support, but that'd involve extra sysfs magic.
> 
> This probably isn't too difficult.  The question is how consistent we want
> the interface to be.

I'd say it differently:  the question is how we want to trade off types
of consistency versus memory usage.  At one point Patrick estimated that
each sysfs attribute instance cost about 1 KByte.  That adds up quickly,
especially on embedded systems ... and it's probably more consistent to
not have attributes if they're not meaningful, than to have them always
and to require userspace to always check for null values (etc).

- Dave


--===============47523815246288614==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============47523815246288614==--
