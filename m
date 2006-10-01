From: Louis Garcia <louisg00@bellsouth.net>
Subject: Re: suspending to disk on FC6 not working
Date: Sun, 01 Oct 2006 01:22:10 -0400
Message-ID: <1159680130.4305.8.camel@soncomputer>
References: <EB12A50964762B4D8111D55B764A8454ABBCA8@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454ABBCA8@scsmsx413.amr.corp.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Sat, 2006-09-30 at 22:07 -0700, Pallipadi, Venkatesh wrote:
>  =

> >-----Original Message-----
> >From: Louis Garcia [mailto:louisg00@bellsouth.net] =

> >Sent: Saturday, September 30, 2006 10:00 PM
> >To: Dave Jones
> >Cc: Pallipadi, Venkatesh; Pavel Machek; linux-pm@lists.osdl.org
> >Subject: Re: [linux-pm] suspending to disk on FC6 not working
> >
> >On Sat, 2006-09-30 at 23:21 -0400, Dave Jones wrote:
> >> On Sat, Sep 30, 2006 at 10:49:42PM -0400, Louis Garcia wrote:
> >>  > On Fri, 2006-09-29 at 15:55 -0700, Pallipadi, Venkatesh wrote:
> >>  > > That's it.. This issue seems to be a side effect of =

> >that patch...
> >>  > > =

> >>  > > Louis: After normal boot of 2.6.18, if you are not =

> >seeing the directory
> >>  > > /sys/devices/system/cpu/cpu0/cpufreq
> >>  > > =

> >>  > > Then try reverting this patch
> >>  > > =

> >http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.
> >6.git;a=3Dc
> >>  > > ommit;h=3D911cb74bb9e77e40749abc2fca6fe74d87d940f3
> >>  > > =

> >>  > > and then check whether the suspend resume issue goes away. =

> >>  > > =

> >>  > > Thanks,
> >>  > > Venki
> >>  > =

> >>  > I reverted this patch and my suspend issue is gone. Though the
> >>  > directory /sys/devices/system/cpu/cpu0/cpufreq is non =

> >existent, with or
> >>  > without this patch.
> >> =

> >> Ok, I've backed that out in cpufreq.git, it'll go along to =

> >Linus soon.
> >> If you build acpi-cpufreq as a module, and you modprobe acpi-cpufreq,
> >> does it fail silently ? Or does it revert us back to the behaviour
> >> where it's noisy again?
> >> =

> >> 	Dave
> >
> >I had not noticed it was not loaded. This maybe a bigger problem. With
> >the latest FC6 kernel this module gets loaded and thus suspend fails. I
> >rebuilt the same kernel but plopped this patch in. The module does not
> >want to load:
> >
> ># /sbin/modprobe acpi-cpufreq
> >FATAL: Error inserting acpi_cpufreq
> >(/lib/modules/2.6.18-1.2708.cpufreq/kernel/arch/i386/kernel/cpu
> >/cpufreq/acpi-cpufreq.ko): No such device
> >
> >This is why suspend works. But now this module won't load.
> >
> =

> The module was not working on your laptop even when suspend was failing.
> That is what the absence of /sys.../cpufreq says. If this module was
> working for you earlier and stopped working recently or even otherwise
> both this and speedstep-centrino does not work on your platform, that is
> a separate issue. Was this module working and cpufreq supported on your
> system with any earlier kernels?
> =

> Thanks,
> Venki

I have no clue. All I noticed is suspend stopped working. I'm on a P4
desktop, I don't use or need cpufreq.

On the kernels that fail to suspend. This module is apparently loaded
because rmmod acpi-cpufreq succeeds and I can suspend to my harts
content.

-Louis
