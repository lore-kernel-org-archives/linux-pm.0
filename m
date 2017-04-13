From: Darren Hart <dvhart@infradead.org>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 13 Apr 2017 09:08:37 -0700
Message-ID: <20170413160837.GB2064@fury>
References: <20170412230854.GA11963@fury>
 <20170413073228.GB1462@ozzy.nask.waw.pl>
 <CALCETrXkx2QqDtKmajywpvtxqCXzrQ3nuW0aOeY6+Uxa-LOXiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:33781 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdDMQIm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2017 12:08:42 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrXkx2QqDtKmajywpvtxqCXzrQ3nuW0aOeY6+Uxa-LOXiQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Mario Limonciello <Mario_Limonciello@dell.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Apr 13, 2017 at 08:32:48AM -0700, Andy Lutomirski wrote:
> On Thu, Apr 13, 2017 at 12:32 AM, Michał Kępień <kernel@kempniu.pl> wrote:
> >> Hi All,
> >>
> >> There are a few parallel efforts involving the Windows Management
> >> Instrumentation (WMI)[1] and dependent/related drivers. I'd like to have a round of
> >> discussion among those of you that have been involved in this space before we
> >> decide on a direction.
> >>
> >> The WMI support in the kernel today fairly narrowly supports a handful of
> >> systems. Andy L. has a work-in-progress series [2] which converts wmi into a
> >> platform device and a proper bus, providing devices for dependent drivers to
> >> bind to, and a mechanism for sibling devices to communicate with each other.
> >> I've reviewed the series and feel like the approach is sound, I plan to carry
> >> this series forward and merge it (with Andy L's permission).
> >>
> >> Are there any objections to this?
> >
> > Back in January 2016, I sent Andy a few minor comments about this
> > series.  A year later, I offered to iron out the remaining issues and
> > resubmit the series in Andy's name when I find the time.  Sadly, things
> > have changed a bit for me since that time and it is unlikely that I will
> > be able to deliver, for which I am sorry.
> >
> > However, browsing Andy's branch I see that most issues have been
> > resolved, though I think some of my remarks [1] have either been missed
> > or silently refuted :)
> >
> > Anyway, I also like this approach and I think this series is a valuable
> > cleanup.
> 
> Me too :)
> 
> >> In Windows, applications interact with WMI more or less directly. We don't do
> >> this in Linux currently, although it has been discussed in the past [3]. Some
> >> vendors will work around this by performing SMI/SMM, which is inefficient at
> >> best. Exposing WMI methods to userspace would bring parity to WMI for Linux and
> >> Windows.
> >>
> >> There are two principal concerns I'd appreciate your thoughts on:
> >>
> >> a) As an undiscoverable interface (you need to know the method signatures ahead
> >> of time), universally exposing every WMI "device" to userspace seems like "a bad
> >> idea" from a security and stability perspective. While access would certainly be
> >> privileged, it seems more prudent to make this exposure opt-in. We also handle
> >> some of this with kernel drivers and exposing those "devices" to userspace would
> >> enable userspace and the kernel to fight over control. So - if we expose WMI
> >> devices to userspace, I believe this should be done on a case by case basis,
> >> opting in, and not by default as part of the WMI driver (although it can provide
> >> the mechanism for a sub-driver to use), and possibly a devmode to do so by
> >> default.
> 
> I agree.  I don't want too see gnome-whatever-widget talking directly
> to WMI and confusing the kernel driver for the same thing.
> 
> >> Secondarily, Andy L created a simple driver to expose the MOF buffer [2] to
> >> userspace which could be consumed by a userspace tool to create sources for an
> >> interface to the exposed WMI methods.
> >
> > +1 for the idea, it makes figuring out what the firmware actually
> > exposes through WMI a bit easier.  After skimming through the driver's
> > code, I would only recommend to review the included headers
> > (linux/input/sparse-keymap.h, linux/dmi.h and acpi/video.h all seem
> > redundant to me).
> >
> > What we still need, though, is an open source version of wmiofck.exe.  I
> > am unaware of anything like that existing and installing the Windows
> > Driver Kit just to run one command which spits out a single *.h file is
> > not something I would describe as convenient (been there).
> 
> I haven't tried to see whether they do what's needed, but there's
> OpenWBEM and OpenPegasus.
> 
> Anyway, if such a tool exists, it would be handy to expose the binary
> MOF data to userspace so the tool could be used to help get WMI
> working on new platforms.
> 

Looking into what exists and what it might take to write a new tool is on my
todo list as a second priority to sorting out the WMI userspace mechanism issue.
Thanks for the pointers.

-- 
Darren Hart
VMware Open Source Technology Center
