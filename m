From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Linux Power Management
Date: Mon, 9 May 2005 09:02:02 -0700
Message-ID: <200505090902.03018.david-b@pacbell.net>
References: <1115094736.28902.167.camel@localhost.localdomain>
	<200505081131.55962.david-b@pacbell.net>
	<1115609217.27130.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============11354771503687733=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1115609217.27130.34.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <abelay@novell.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============11354771503687733==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 08 May 2005 8:26 pm, Adam Belay wrote:
> > > Problems with current Linux PM
> > > ==============================
> > > 
> > > Although the existing model is sufficient for suspend and resume, modern
> > 
> > That is, system-wide suspend/resume.  For suspend/resume of individual
> > devices, at run-time, it's quite weak.
> 
> Agreed, but the PM model should generally be less involved with
> suspend/resume of individual devices.

But right now it _is_ involved.  And regardless, it's hard to
argue in favor of different suspend/resume calls for system
sleep state transitions and selective suspend/resume actions;
to the driver, there's no real difference.

Though as I'm sure you've picked up, I'm starting to believe that
there should ONLY be system-wide PM operations through sysfs,
with any device-specific ones going through application-specific
requests (again using "hdparm -S" and "xset dpms" as examples).


> > > In this model, power management is not limited to sleep and suspend
> > > operations.  Instead, each device has the option of managing its power
> > > dynamically while the system is running.  Parent devices must be aware
> > > of the power requirements of their children.
> > 
> > Yes, though the parent/child statement seems a bit too strong.
> > 
> > Devices commonly have multiple sorts of parents; clocks, power
> > control, and multiple busses (such as one for control and one
> > for DMA) and bridges.  It probably works better for devices to
> > know about those parents, and only require the PM core to
> > accomodate those multiple relationships (rather than getting
> > in the way by for example insisting the hardware may only have
> > one such relationship, called "parent").
> 
> I'm aware of this.  I think its impossible for any PM model to handle
> these multiple relationships.  They're too non-standardized.  In most
> cases, I think we should just stay out of the way.

Staying out of the way should work, if it's done right.  That may
mean adding a few mechanisms that are missing, or changing things
that get in the way now.


> However, many standards and platforms accustom to expansion follow a
> power-domain model.  Although the power domain support shouldn't get in
> the way of those who don't need it, it's important that we provide this
> functionality.  For most devices it will just make things easier.
> 
> Power resources are my attempt to model everything else.  For things any
> weirder, the PM core doesn't need to know about them at all.

It's probably best to make sure essential concrete cases work well,
generalizing later instead of earlier.  (I still don't have such
examples for "power resources".)

Right now, I'm comfortable saying we don't have a very good way
to model even common abstractions like USB hubs (each of which
is a power domain).  And that's not really different from any
other kind of bridge, or (generally) internal node in the device
tree.


> > > Userspace interaction with power management policy is a key goal.  While
> > > policy configuration values may be specified by the user, policy
> > > execution should occur in kernel-space whenever possible.  Userspace
> > > will be notified of power events (including device state changes) via
> > > kevents.
> > 
> > I don't agree about userspace interaction as a goal, beyond the
> > ability to pass general policy inputs to drivers.  It's fair that
> > some devices might support policies like "off" and "on"; but
> > that's not something to expect (or require!) from all drivers.
> 
> I think this is really something that varies between device and
> platform.  As I have said numerous times, I'd like to have policy
> variables be configurable, but enforcement to occur in the kernel.

Depending on how "policy" is defined, that can mean a lot of things... ;)


> > In fact I still like the idea of just removing all the sysfs
> > power support entirely; ripping it out since it's never worked
> > well, and doesn't do what's needed.  The main counter-argument
> > is that there'd need to be some better way to test selective
> > suspend in drivers, if "echo -n 3 > power/state" vanishes.
> > (Like, hmm, something sitting in debugfs...)
> 
> It depends on what we want to do with power management.  However, one of
> the original reasons sysfs was created was to provide a power dependency
> tree.  You can't just say that you don't like sysfs.  

I didn't ... and neither does providing such a tree require
exposing per-device controls.  Taking away those (broken)
controls is simple.  In fact, configure without CONFIG_PM
and you'll see a useful sysfs that doesn't have them ...


> > And for example the current pm_parent seems like it could help to
> > manage such a "power domain"...
> 
> Perhaps.  I like the checks you added for this.

Which FWIW I forwarded to Greg to merge, ideally "soon" though
the checks aren't critical in normal usage.


> So here's another argument.  Each power resource could have its own
> ->suspend and ->resume hook for when we transition system states.  I
> think this would be useful in some cases, and if not then just don't
> provide them.  Also, these power resources might have their own policy
> configuration variables.

Can you maybe provide concrete examples of a "power resource"?
If we just talk about abstract notions, they don't seem useful.

- Dave


--===============11354771503687733==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============11354771503687733==--
