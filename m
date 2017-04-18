From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RFC: WMI Enhancements
Date: Tue, 18 Apr 2017 15:07:06 +0200
Message-ID: <3317007.TCiWpp4m4U@aspire.rjw.lan>
References: <20170412230854.GA11963@fury> <CALCETrXAb1=ae8XuNRcajNLJw3b45Z=Qz7GDYXRzFk7CQrd5kQ@mail.gmail.com> <20170417231051.GB7183@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47277 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751197AbdDRNNM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2017 09:13:12 -0400
In-Reply-To: <20170417231051.GB7183@fury>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Lutomirski <luto@amacapital.net>
Cc: Len Brown <len.brown@intel.com>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Mario Limonciello <Mario_Limonciello@dell.com>, Andy Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Monday, April 17, 2017 04:10:51 PM Darren Hart wrote:
> On Mon, Apr 17, 2017 at 03:03:29PM -0700, Andy Lutomirski wrote:
> > On Fri, Apr 14, 2017 at 4:05 PM, Darren Hart <dvhart@infradead.org> wrote:
> > > On Sat, Apr 15, 2017 at 12:45:30AM +0200, Rafael Wysocki wrote:
> > >> On Wednesday, April 12, 2017 04:08:54 PM Darren Hart wrote:
> > >> > Hi All,
> > >> >
> > >> > There are a few parallel efforts involving the Windows Management
> > >> > Instrumentation (WMI)[1] and dependent/related drivers. I'd like to have a round of
> > >> > discussion among those of you that have been involved in this space before we
> > >> > decide on a direction.
> > >> >
> > >> > The WMI support in the kernel today fairly narrowly supports a handful of
> > >> > systems. Andy L. has a work-in-progress series [2] which converts wmi into a
> > >> > platform device and a proper bus, providing devices for dependent drivers to
> > >> > bind to, and a mechanism for sibling devices to communicate with each other.
> > >> > I've reviewed the series and feel like the approach is sound, I plan to carry
> > >> > this series forward and merge it (with Andy L's permission).
> > >> >
> > >> > Are there any objections to this?
> > >> >
> > >> > In Windows, applications interact with WMI more or less directly. We don't do
> > >> > this in Linux currently, although it has been discussed in the past [3]. Some
> > >> > vendors will work around this by performing SMI/SMM, which is inefficient at
> > >> > best. Exposing WMI methods to userspace would bring parity to WMI for Linux and
> > >> > Windows.
> > >> >
> > >> > There are two principal concerns I'd appreciate your thoughts on:
> > >> >
> > >> > a) As an undiscoverable interface (you need to know the method signatures ahead
> > >> > of time), universally exposing every WMI "device" to userspace seems like "a bad
> > >> > idea" from a security and stability perspective. While access would certainly be
> > >> > privileged, it seems more prudent to make this exposure opt-in. We also handle
> > >> > some of this with kernel drivers and exposing those "devices" to userspace would
> > >> > enable userspace and the kernel to fight over control. So - if we expose WMI
> > >> > devices to userspace, I believe this should be done on a case by case basis,
> > >> > opting in, and not by default as part of the WMI driver (although it can provide
> > >> > the mechanism for a sub-driver to use), and possibly a devmode to do so by
> > >> > default.
> > >>
> > >> A couple of loose thoughts here.
> > >>
> > >> In principle there could be a "generic default WMI driver" or similar that would
> > >> "claim" all WMI "devices" that have not been "claimed" by anyone else and would
> > >> simply expose them to user space somehow (e.g. using a chardev interface).
> > >>
> > >> Then, depending on how that thing is implemented, opt-in etc should be possible
> > >> too.
> > >>
> > >
> > > I think we agree this would be an ideal approach.
> > >
> > > As we look into this more, it is becoming clear that the necessary functionality
> > > is not nicely divided into GUIDs for what is necessary in userspace and what is
> > > handled in the kernel. A single WMI METHOD GUID may be needed by userspace for
> > > certain functionality, while the kernel drivers may use it for something else.
> > >
> > > :-(
> > >
> > > The input to a WMI method is just a buffer, so it is very free form. One
> > > approach Mario has mentioned was to audit the user space WMI METHOD calls in the
> > > kernel platform drivers and reject those calls with arguments matching those
> > > issued by the kernel driver. This is likely to be complex and error prone in my
> > > opinion. However, I have not yet thought of another means to meet the
> > > requirement of having disjoint feature sets for userspace and kernel space via a
> > > mechanism that was effectively designed to be used solely from user space with
> > > vendor defined method signatures.
> > >
> > > Next step is to look at just how complex it would be to audit the method calls
> > > the kernel currently uses.
> > 
> > I'm wondering whether it's really worth it.  We already allow doing
> > darned near anything using dcdbas.  Maybe the world won't end if we
> > expose a complete-ish ioctl interface to WMI.

I guess the world wouldn't end then (it has not ended for far more serious
reasons so far after all), but this also doesn't feel entirely right.

For one, if something is used inside of the kernel (by drivers etc), then
allowing user space to use the same thing directly is a recipe for unsupportable
mess IMO.

> > Also, dcdbas is, to put it mildly, a bit ridiculous.  It seems to be a
> > seriously awkward sysfs interface that allows you to, drumroll please,
> > issue outb and inb instructions.  It doesn't even check that it's
> > running on a Dell system.  It might be nice to deprecate it some day
> > in favor of a real interface.  I'd consider a low-level WMI ioctl
> > interface to be a vast improvement.
> > 
> 
> I've been reluctantly arriving here as well. Given that every WMI interface will
> be vendor specific, and non-discoverable, it seems unlikely developers will
> eagerly duplicate kernel functionality in user-space. And if they do, it will
> affect very few platforms.
> 
> I still think it makes sense to only expose a WMI interface by default on some
> matching criteria. It could be DMI related, but I'd like to know if the UID is
> possible as well (it depends on how vendors use the UID, if consistently, not at
> all, etc.) Otherwise, the interface would not be enabled unless the user
> explicitly requests it via a module parameter or similar.

To me, that should be the bare minimum, but I really think that mutual exclusion
between user space and the kernel needs to be ensured somehow when the
interface is enabled too.

This looks similar to exposing _DSM functionality for certain device to user
space where some functions of the _DSM in question are already in use by
kernel code.  In that case I would think about an interface with a function
granularity (so it would check the GUID and the function and possibly the
ordering with respect to the other functions too before invoking the _DSM
on behalf of user space).

Thanks,
Rafael
