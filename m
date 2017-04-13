From: Darren Hart <dvhart@infradead.org>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 13 Apr 2017 10:06:19 -0700
Message-ID: <20170413170619.GF2064@fury>
References: <20170412230854.GA11963@fury>
 <20170413073228.GB1462@ozzy.nask.waw.pl>
 <CALCETrXkx2QqDtKmajywpvtxqCXzrQ3nuW0aOeY6+Uxa-LOXiQ@mail.gmail.com>
 <dffeb42986e84887b2556987925dbf31@ausx13mpc120.AMER.DELL.COM>
 <CALCETrX8W7Zi2NTAm4kJFbW14HVSYanYQ5sGo78FTgitcWfwAw@mail.gmail.com>
 <0d4e6c4562fb4b85ad4c368ae73dbe06@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0d4e6c4562fb4b85ad4c368ae73dbe06@ausx13mpc120.AMER.DELL.COM>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: luto@kernel.org, kernel@kempniu.pl, rjw@rjwysocki.net, len.brown@intel.com, pali.rohar@gmail.com, corentin.chary@gmail.com, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 13, 2017 at 04:54:25PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Andy Lutomirski [mailto:luto@kernel.org]
> > Sent: Thursday, April 13, 2017 10:58 AM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: Andrew Lutomirski <luto@kernel.org>; Michał Kępień <kernel@kempniu.pl>;
> > Darren Hart <dvhart@infradead.org>; Rafael J. Wysocki <rjw@rjwysocki.net>; Len
> > Brown <len.brown@intel.com>; Pali Rohár <pali.rohar@gmail.com>; Corentin
> > Chary <corentin.chary@gmail.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; linux-kernel@vger.kernel.org; platform-
> > driver-x86@vger.kernel.org; linux-pm@vger.kernel.org
> > Subject: Re: RFC: WMI Enhancements
> > 
> > On Thu, Apr 13, 2017 at 8:55 AM,  <Mario.Limonciello@dell.com> wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Andy Lutomirski [mailto:luto@kernel.org]
> > >> Sent: Thursday, April 13, 2017 10:33 AM
> > >> To: Michał Kępień <kernel@kempniu.pl>
> > >> Cc: Darren Hart <dvhart@infradead.org>; Rafael Wysocki <rjw@rjwysocki.net>;
> > >> Len Brown <len.brown@intel.com>; Pali Rohár <pali.rohar@gmail.com>;
> > Corentin
> > >> Chary <corentin.chary@gmail.com>; Limonciello, Mario
> > >> <Mario_Limonciello@Dell.com>; Andy Lutomirski <luto@kernel.org>; Andy
> > >> Shevchenko <andriy.shevchenko@linux.intel.com>; LKML <linux-
> > >> kernel@vger.kernel.org>; platform-driver-x86@vger.kernel.org; linux-
> > >> pm@vger.kernel.org
> > >> Subject: Re: RFC: WMI Enhancements
> > >>
> > >> On Thu, Apr 13, 2017 at 12:32 AM, Michał Kępień <kernel@kempniu.pl> wrote:
> > >> >> Hi All,
> > >> >>
> > >> >> There are a few parallel efforts involving the Windows Management
> > >> >> Instrumentation (WMI)[1] and dependent/related drivers. I'd like to
> > >> >> have a round of discussion among those of you that have been involved
> > >> >> in this space before we decide on a direction.
> > >> >>
> > >> >> The WMI support in the kernel today fairly narrowly supports a
> > >> >> handful of systems. Andy L. has a work-in-progress series [2] which
> > >> >> converts wmi into a platform device and a proper bus, providing
> > >> >> devices for dependent drivers to bind to, and a mechanism for sibling devices
> > to
> > >> communicate with each other.
> > >> >> I've reviewed the series and feel like the approach is sound, I plan
> > >> >> to carry this series forward and merge it (with Andy L's permission).
> > >> >>
> > >> >> Are there any objections to this?
> > >> >
> > >> > Back in January 2016, I sent Andy a few minor comments about this
> > >> > series.  A year later, I offered to iron out the remaining issues and
> > >> > resubmit the series in Andy's name when I find the time.  Sadly,
> > >> > things have changed a bit for me since that time and it is unlikely
> > >> > that I will be able to deliver, for which I am sorry.
> > >> >
> > >> > However, browsing Andy's branch I see that most issues have been
> > >> > resolved, though I think some of my remarks [1] have either been
> > >> > missed or silently refuted :)
> > >> >
> > >> > Anyway, I also like this approach and I think this series is a
> > >> > valuable cleanup.
> > >>
> > >> Me too :)
> > >>
> > >> >> In Windows, applications interact with WMI more or less directly. We
> > >> >> don't do this in Linux currently, although it has been discussed in
> > >> >> the past [3]. Some vendors will work around this by performing
> > >> >> SMI/SMM, which is inefficient at best. Exposing WMI methods to
> > >> >> userspace would bring parity to WMI for Linux and Windows.
> > >> >>
> > >> >> There are two principal concerns I'd appreciate your thoughts on:
> > >> >>
> > >> >> a) As an undiscoverable interface (you need to know the method
> > >> >> signatures ahead of time), universally exposing every WMI "device" to
> > >> >> userspace seems like "a bad idea" from a security and stability
> > >> >> perspective. While access would certainly be privileged, it seems
> > >> >> more prudent to make this exposure opt-in. We also handle some of
> > >> >> this with kernel drivers and exposing those "devices" to userspace
> > >> >> would enable userspace and the kernel to fight over control. So - if
> > >> >> we expose WMI devices to userspace, I believe this should be done on
> > >> >> a case by case basis, opting in, and not by default as part of the
> > >> >> WMI driver (although it can provide the mechanism for a sub-driver to use),
> > and
> > >> possibly a devmode to do so by default.
> > >>
> > >> I agree.  I don't want too see gnome-whatever-widget talking directly to WMI
> > and
> > >> confusing the kernel driver for the same thing.
> > >
> > > So there are plenty of other things that can be done by WMI that don't
> > > really make sense to live in the kernel, particularly on what Dell exposes via
> > > WMI.
> > >
> > > If the desire of this group ends up being to not expose WMI by default,
> > > I'd like to at least propose it be exposed for the GUID's Dell is using.
> > 
> > Is it just the "call SMBIOS" GUID or are there other things?
> 
> There are some other things too, but I'll need to discuss with an internal
> team first  to clarify.
> 
> > 
> > >
> > > Perhaps as part of changing dell-smbios to use WMI, also extend it's
> > > functionality to userspace.
> > >
> > 
> > Could this still result in userspace and the kernel fighting over
> > control of various bits of the system?  If so, that's a bit less than
> > ideal.
> 
> No more than exists today with the dcdbas SMI interface (which
> only if you manually run userspace tools that manipulate the same
> data you can do that technically).
> 
> We're all reasonable folks, if there is an instance of this that comes
> up we can make changes to userspace to fix it.

Right. As Pali pointed out previously, if there is an existing class driver /
subsystem which supports this functionality we should use that.

I suppose one risk will be one GUID exposing both types of methods. Those which
are used by kernel drivers, and those which have no kernel support. Or worse,
methods which have multiple behaviors depending on their input arguments.

-- 
Darren Hart
VMware Open Source Technology Center
