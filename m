From: Andy Lutomirski <luto@kernel.org>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 13 Apr 2017 10:32:49 -0700
Message-ID: <CALCETrUh000Qw4Y2-V9TVfy+6-my3W9xWCUgRin_=Boqf2j8hw@mail.gmail.com>
References: <20170412230854.GA11963@fury> <20170413073228.GB1462@ozzy.nask.waw.pl>
 <CALCETrXkx2QqDtKmajywpvtxqCXzrQ3nuW0aOeY6+Uxa-LOXiQ@mail.gmail.com>
 <dffeb42986e84887b2556987925dbf31@ausx13mpc120.AMER.DELL.COM> <20170413170245.GE2064@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170413170245.GE2064@fury>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Mario.Limonciello@dell.com, Andrew Lutomirski <luto@kernel.org>, =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 13, 2017 at 10:02 AM, Darren Hart <dvhart@infradead.org> wrote:
> On Thu, Apr 13, 2017 at 03:55:01PM +0000, Mario.Limonciello@dell.com wrote:
>>
>>
>> > -----Original Message-----
>> > From: Andy Lutomirski [mailto:luto@kernel.org]
>> > Sent: Thursday, April 13, 2017 10:33 AM
>> > To: Michał Kępień <kernel@kempniu.pl>
>> > Cc: Darren Hart <dvhart@infradead.org>; Rafael Wysocki <rjw@rjwysocki.net>;
>> > Len Brown <len.brown@intel.com>; Pali Rohár <pali.rohar@gmail.com>; Corentin
>> > Chary <corentin.chary@gmail.com>; Limonciello, Mario
>> > <Mario_Limonciello@Dell.com>; Andy Lutomirski <luto@kernel.org>; Andy
>> > Shevchenko <andriy.shevchenko@linux.intel.com>; LKML <linux-
>> > kernel@vger.kernel.org>; platform-driver-x86@vger.kernel.org; linux-
>> > pm@vger.kernel.org
>> > Subject: Re: RFC: WMI Enhancements
>> >
>> > On Thu, Apr 13, 2017 at 12:32 AM, Michał Kępień <kernel@kempniu.pl> wrote:
>> > >> Hi All,
>> > >>
>> > >> There are a few parallel efforts involving the Windows Management
>> > >> Instrumentation (WMI)[1] and dependent/related drivers. I'd like to
>> > >> have a round of discussion among those of you that have been involved
>> > >> in this space before we decide on a direction.
>> > >>
>> > >> The WMI support in the kernel today fairly narrowly supports a
>> > >> handful of systems. Andy L. has a work-in-progress series [2] which
>> > >> converts wmi into a platform device and a proper bus, providing
>> > >> devices for dependent drivers to bind to, and a mechanism for sibling devices to
>> > communicate with each other.
>> > >> I've reviewed the series and feel like the approach is sound, I plan
>> > >> to carry this series forward and merge it (with Andy L's permission).
>> > >>
>> > >> Are there any objections to this?
>> > >
>> > > Back in January 2016, I sent Andy a few minor comments about this
>> > > series.  A year later, I offered to iron out the remaining issues and
>> > > resubmit the series in Andy's name when I find the time.  Sadly,
>> > > things have changed a bit for me since that time and it is unlikely
>> > > that I will be able to deliver, for which I am sorry.
>> > >
>> > > However, browsing Andy's branch I see that most issues have been
>> > > resolved, though I think some of my remarks [1] have either been
>> > > missed or silently refuted :)
>> > >
>> > > Anyway, I also like this approach and I think this series is a
>> > > valuable cleanup.
>> >
>> > Me too :)
>> >
>> > >> In Windows, applications interact with WMI more or less directly. We
>> > >> don't do this in Linux currently, although it has been discussed in
>> > >> the past [3]. Some vendors will work around this by performing
>> > >> SMI/SMM, which is inefficient at best. Exposing WMI methods to
>> > >> userspace would bring parity to WMI for Linux and Windows.
>> > >>
>> > >> There are two principal concerns I'd appreciate your thoughts on:
>> > >>
>> > >> a) As an undiscoverable interface (you need to know the method
>> > >> signatures ahead of time), universally exposing every WMI "device" to
>> > >> userspace seems like "a bad idea" from a security and stability
>> > >> perspective. While access would certainly be privileged, it seems
>> > >> more prudent to make this exposure opt-in. We also handle some of
>> > >> this with kernel drivers and exposing those "devices" to userspace
>> > >> would enable userspace and the kernel to fight over control. So - if
>> > >> we expose WMI devices to userspace, I believe this should be done on
>> > >> a case by case basis, opting in, and not by default as part of the
>> > >> WMI driver (although it can provide the mechanism for a sub-driver to use), and
>> > possibly a devmode to do so by default.
>> >
>> > I agree.  I don't want too see gnome-whatever-widget talking directly to WMI and
>> > confusing the kernel driver for the same thing.
>>
>> So there are plenty of other things that can be done by WMI that don't
>> really make sense to live in the kernel, particularly on what Dell exposes via
>> WMI.
>>
>> If the desire of this group ends up being to not expose WMI by default,
>> I'd like to at least propose it be exposed for the GUID's Dell is using.
>>
>
> What I'm thinking is an explicit list of GUIDs within the drivers which are to
> be exposed to user space. The rationale being:
>
> * GUIDs which are managed by kernel drivers (LEDs, hotkeys, etc.) should not be
>   exposed to userspace.
>
> * Management GUIDs should not change frequently
>
> * Management GUIDs are a trivial add, equivalent to adding a DEVICE ID to an
>   existing driver. This means minimal review time to get upstream, and the
>   ability to include in stable backports as needed. I haven't confirmed
>   this with Greg KH, but I think I can make the case, especially after
>   Andy L's WMI-as-a-bus patches.

Would this be a class driver that would expose a chardev for each
bound GUID?  I agree that this makes a lot more sense than trying to
shoehorn it into sysfs.  Especially since we'd want closing the
chardev to disable any "expensive" collections that have been enabled
by ioctl on that chardev.  Exposing Dell's smbios entry point through
this type of device seems reasonable to me.

If we go this route, then I think that exposing the MOF through sysfs
would make sense -- after all, someone might actually want to parse
the thing for production purposes.

On a sort-of-on-topic note, there's one platform feature that we
complete fail to handle in the kernel that might be nice to add before
it gets kludged into lots of userspace code: battery charge controls.
Thinkpads expose charge thresholds using abominable interfaces, but I
think they've all been reverse-engineered.  Dell probably has them,
and I bet that Mario would consider telling us how to use them if we
asked nicely.  It might be nice to expose these generically through
sysfs somewhere.

I'm guilty myself:

https://github.com/amluto/tp_charge
