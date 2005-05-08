From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Linux Power Management
Date: Sun, 8 May 2005 11:35:56 -0700
Message-ID: <200505081135.56811.david-b@pacbell.net>
References: <1115094736.28902.167.camel@localhost.localdomain>
	<Pine.LNX.4.44L0.0505031132520.19073-100000@iolanthe.rowland.org>
	<20050505043920.GB21223@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============21469114579168269=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050505043920.GB21223@neo.rr.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============21469114579168269==
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wednesday 04 May 2005 9:39 pm, Adam Belay wrote:
> On Tue, May 03, 2005 at 11:52:45AM -0400, Alan Stern wrote:
> > On Tue, 3 May 2005, Adam Belay wrote:
> > 
> > You said explicitly that power devices may or may not coincide with struct 
> > devices in the driver model.  Why do you want to do this?  Why not insist 
> > that power devices _are_ struct devices?  It would make many things a lot 
> > easier and allow much more code sharing plus reduction of memory usage.  
> > (Kobjects aren't cheap, especially for embedded systems.)
> 
> I think you make a good point.  My original intention here was to support
> strange power relationships that do not match the device tree.

In fact, that's why "struct dev_pm_info" has a "pm_parent".  Today.
And device_pm_set_parent() ... which I don't necessarily think would
work, if anyone were to use it.  That information is invisible through
sysfs, note!

Hmm, I think I'll post a patch I've had sitting around for a while,
to at least report violation of the relevant integrity constraints.
It doesn't solve the problem that a pm_parent won't automatically
know about its children though, for example.  That's something I
liked about Adam's direction:  formalizing that relationship.


> However, I 
> don't think this will be common, and not every layer in between the tree
> has to participate.  So, psuedo-logical device layers like we're seeing in the
> PCI express bus driver could just be skipped past.  I'll change my plans to
> reflect this.

When you "don't think this will be common" you're basically assuming
Linux won't be used on embedded hardware.   Unhealthy assumption!!

It's **really easy** and in fact natural for hardware designers to
provide power management relationships that don't directly match
the logical bus structure that software likes to use.  Chips to
switch power are in widespread use, and the GPIO lines used to drive
them don't always come from a CPU (where they'd probably be always
available unless the CPU itself suspends).

The way those systems manage to work at all on 2.6 relies on several
things, in the systems I've seen.

   * System initialization order changes like subsys_initcall for
     I2C not device_initcall, also for the power switching device.
     That way, power can be turned on by board-specific logic in
     drivers for either (a) the power switching devices, or even
     better (b) the device whose power is switched knows how
     to ask the power-switch driver to give it power.  (Since
     they can rely on the switching device to be "live" by then.)

   * Despite the fact that sysfs exposes power/state, nobody is
     actually using that for anything except very selective
     testing ... so the deep brokenneses that _could_ happen is
     quite unlikely; we don't expect userspace to selectively
     suspend a parent without having suspended its child.
     (The device drivers use selective suspend all the time,
     but they know not to do such stuff.)

You'll observe that this entirely bypasses the driver model
PM structure, using init sequencing instead.  So until someone
tries to use sysfs for selective suspend, it can't matter
that some I2C device is actually controlling power for every
device in the system (CPU included!) yet isn't the driver
model parent of any one of them...

The fact that these systems can even boot under Linux relies on
board-specific logic to handle the things that the pmcore model
was allegedly "designed to handle".  Arguably it's better to have
code in driver X that just says "driver Y, please set GPIO 3 high"
since anything less direct is just wasted code ... but if so, then
what's the relevance of pmcore here?  What _should_ pmcore do for
normal board configurations like that?


> > Anything else?  This list in itself doesn't require much in the way of 
> > policy management.
> 
> Wake devices would also require userspace configuration of policy.

I'll definitely repost my patch adding that policy support; I've got
it updated, after all!  And the PCI-E changes to access PCI config
space "early" seem to have laid to rest concerns about whether that's
safe to do, so that simplifies the PCI stuff too.


> I appreciate your comments.  To sumarize, I'd like to introduce power
> resources into our current PM model and add a concept of device power states.

That is, distinct from dev_pm_info.power_state?  That notion is rather
bogus, and AFAICT is there _only_ to support sysfs selective suspend.

And the sysfs support for selective suspend is pretty bogus -- it doesn't
do recursion, dev_pm_info.power_state updates are iffy, and it obviously
can't preserve the pm parent/child relationships -- that whole area does
need much work/replacement.

- Dave


--===============21469114579168269==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============21469114579168269==--
