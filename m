From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: RFC: WMI Enhancements
Date: Mon, 17 Apr 2017 15:03:29 -0700
Message-ID: <CALCETrXAb1=ae8XuNRcajNLJw3b45Z=Qz7GDYXRzFk7CQrd5kQ@mail.gmail.com>
References: <20170412230854.GA11963@fury> <2216131.lxtCY30Ovb@aspire.rjw.lan> <20170414230551.GA5438@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170414230551.GA5438@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Mario Limonciello <Mario_Limonciello@dell.com>, Andy Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 14, 2017 at 4:05 PM, Darren Hart <dvhart@infradead.org> wrote:
> On Sat, Apr 15, 2017 at 12:45:30AM +0200, Rafael Wysocki wrote:
>> On Wednesday, April 12, 2017 04:08:54 PM Darren Hart wrote:
>> > Hi All,
>> >
>> > There are a few parallel efforts involving the Windows Management
>> > Instrumentation (WMI)[1] and dependent/related drivers. I'd like to have a round of
>> > discussion among those of you that have been involved in this space before we
>> > decide on a direction.
>> >
>> > The WMI support in the kernel today fairly narrowly supports a handful of
>> > systems. Andy L. has a work-in-progress series [2] which converts wmi into a
>> > platform device and a proper bus, providing devices for dependent drivers to
>> > bind to, and a mechanism for sibling devices to communicate with each other.
>> > I've reviewed the series and feel like the approach is sound, I plan to carry
>> > this series forward and merge it (with Andy L's permission).
>> >
>> > Are there any objections to this?
>> >
>> > In Windows, applications interact with WMI more or less directly. We don't do
>> > this in Linux currently, although it has been discussed in the past [3]. Some
>> > vendors will work around this by performing SMI/SMM, which is inefficient at
>> > best. Exposing WMI methods to userspace would bring parity to WMI for Linux and
>> > Windows.
>> >
>> > There are two principal concerns I'd appreciate your thoughts on:
>> >
>> > a) As an undiscoverable interface (you need to know the method signatures ahead
>> > of time), universally exposing every WMI "device" to userspace seems like "a bad
>> > idea" from a security and stability perspective. While access would certainly be
>> > privileged, it seems more prudent to make this exposure opt-in. We also handle
>> > some of this with kernel drivers and exposing those "devices" to userspace would
>> > enable userspace and the kernel to fight over control. So - if we expose WMI
>> > devices to userspace, I believe this should be done on a case by case basis,
>> > opting in, and not by default as part of the WMI driver (although it can provide
>> > the mechanism for a sub-driver to use), and possibly a devmode to do so by
>> > default.
>>
>> A couple of loose thoughts here.
>>
>> In principle there could be a "generic default WMI driver" or similar that would
>> "claim" all WMI "devices" that have not been "claimed" by anyone else and would
>> simply expose them to user space somehow (e.g. using a chardev interface).
>>
>> Then, depending on how that thing is implemented, opt-in etc should be possible
>> too.
>>
>
> I think we agree this would be an ideal approach.
>
> As we look into this more, it is becoming clear that the necessary functionality
> is not nicely divided into GUIDs for what is necessary in userspace and what is
> handled in the kernel. A single WMI METHOD GUID may be needed by userspace for
> certain functionality, while the kernel drivers may use it for something else.
>
> :-(
>
> The input to a WMI method is just a buffer, so it is very free form. One
> approach Mario has mentioned was to audit the user space WMI METHOD calls in the
> kernel platform drivers and reject those calls with arguments matching those
> issued by the kernel driver. This is likely to be complex and error prone in my
> opinion. However, I have not yet thought of another means to meet the
> requirement of having disjoint feature sets for userspace and kernel space via a
> mechanism that was effectively designed to be used solely from user space with
> vendor defined method signatures.
>
> Next step is to look at just how complex it would be to audit the method calls
> the kernel currently uses.

I'm wondering whether it's really worth it.  We already allow doing
darned near anything using dcdbas.  Maybe the world won't end if we
expose a complete-ish ioctl interface to WMI.

Also, dcdbas is, to put it mildly, a bit ridiculous.  It seems to be a
seriously awkward sysfs interface that allows you to, drumroll please,
issue outb and inb instructions.  It doesn't even check that it's
running on a Dell system.  It might be nice to deprecate it some day
in favor of a real interface.  I'd consider a low-level WMI ioctl
interface to be a vast improvement.
