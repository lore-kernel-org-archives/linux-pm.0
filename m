From: Holger Macht <hmacht@suse.de>
Subject: Re: Runtime device power management in userspace
Date: Sat, 24 Dec 2005 16:31:19 +0100
Message-ID: <20051224153119.GA9721@work.suse.de>
References: <20051223143047.GC16463@f192.suse.de>
	<Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76446879045912208=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0512230706530.13289-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============76446879045912208==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fr 23. Dez - 07:12:35, Patrick Mochel wrote:
> 
> On Fri, 23 Dec 2005, Holger Macht wrote:
> 
> > Hi,
> >
> > We implemented device runtime power management in a userspace application
> > (the powersave daemon). In this specific case, it means to successively
> > put pci devices into D3 powersave mode with writing a numerical '3' to the
> > corresponding power state file.
> >
> > There are two main reasons for us to even doing this:
> >
> >   1. At first, the obvious reason. As mentioned in our research regarding
> >      power consumption on this list, there is a very huge potential to
> >      save battery power.
> >
> >   2. Due to the fact that this is AFAIK a heavily untested area, as a side
> >      effect, we like to get reports about broken modules/drivers and maybe
> >      get them fixed.
> 
> That's great!
> 
> Please note that D3 is only relevant for PCI devices and for ACPI devices.
> The fact that it's the same value for every device in the system is a
> design flaw. Please be aware that the value to write to the device file
> could change, and will be dependent on the type (bus) of device, and quite
> possibly on the device itself. It may not even be '3' for all PCI devices
> in the future, or may be a string rather than 1 character, or simply a '1'
> into a different file.

It should be no problem to adjust that if the kernel interface changes.

> Please also note that D3 is not always a good choice. A driver may not be
> able to reinitialize the device from D3. And, since it takes longer to
> resume from D3, you may want to start with D1 or D2. (The same concept is
> true for devices other than PCI, though the values will be different.)

We only played around with D3 until now. The main implementation is done,
but we are still at a very early stage. So there is much room for
improvements...

> How do you determine the idleness of a device? Or, is it based purely on
> user direction?

That's one of the main problems. For some devices, for instance network
cards, we can query the NetworkManager (as far as available) via DBus if
the device is currently in use or not. But we don't have that possiblity
for all devices. The even more problematic point is the other way
round. How to figure out if we have to resume a device as soon as another
application wants to access it? I have currently no clue how to do this.

Thus, at the moment, the suspend and resume triggers are based on user
direction. We introduced a new so called powersave scheme
'AdvancedPowersave' to configure and handle all this experimental
stuff. Switching automatically to this scheme is possible, of course. But
not by default and it is too early to do more magic like powering down
devices when they are idle and resuming them as soon as they are
needed. But the new scheme will show up in our main client (kpowersave)
and most of the runtime power management options can be controlled from
there. Event without the automatic handling, we hope to reach some people,
or at least some power users, who want to give it a try despite of the
warnings we will generate.

> Also, is there source available?

Of course, there is. Tarballs [1] are available at sourceforge. You can
directly browse the code [2] from the svn webinterface. The corresponding
source files are device_management.{cpp,h} and device.{cpp,h}.

> 
> Thanks,
> 
> 
> 	Patrick
> 

Regards,
	Holger


[1] https://sourceforge.net/project/showfiles.php?group_id=124576
[2] http://forge.novell.com/modules/xfmod/svn/svnbrowse.php?repname=powersave

--===============76446879045912208==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76446879045912208==--
