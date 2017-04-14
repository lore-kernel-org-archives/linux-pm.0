From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: RFC: WMI Enhancements
Date: Sat, 15 Apr 2017 00:45:30 +0200
Message-ID: <2216131.lxtCY30Ovb@aspire.rjw.lan>
References: <20170412230854.GA11963@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58112 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752277AbdDNWvg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 18:51:36 -0400
In-Reply-To: <20170412230854.GA11963@fury>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Len Brown <len.brown@intel.com>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Mario Limonciello <Mario_Limonciello@dell.com>, Andy Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

On Wednesday, April 12, 2017 04:08:54 PM Darren Hart wrote:
> Hi All,
> 
> There are a few parallel efforts involving the Windows Management
> Instrumentation (WMI)[1] and dependent/related drivers. I'd like to have a round of
> discussion among those of you that have been involved in this space before we
> decide on a direction.
> 
> The WMI support in the kernel today fairly narrowly supports a handful of
> systems. Andy L. has a work-in-progress series [2] which converts wmi into a
> platform device and a proper bus, providing devices for dependent drivers to
> bind to, and a mechanism for sibling devices to communicate with each other.
> I've reviewed the series and feel like the approach is sound, I plan to carry
> this series forward and merge it (with Andy L's permission).
> 
> Are there any objections to this?
> 
> In Windows, applications interact with WMI more or less directly. We don't do
> this in Linux currently, although it has been discussed in the past [3]. Some
> vendors will work around this by performing SMI/SMM, which is inefficient at
> best. Exposing WMI methods to userspace would bring parity to WMI for Linux and
> Windows.
> 
> There are two principal concerns I'd appreciate your thoughts on:
> 
> a) As an undiscoverable interface (you need to know the method signatures ahead
> of time), universally exposing every WMI "device" to userspace seems like "a bad
> idea" from a security and stability perspective. While access would certainly be
> privileged, it seems more prudent to make this exposure opt-in. We also handle
> some of this with kernel drivers and exposing those "devices" to userspace would
> enable userspace and the kernel to fight over control. So - if we expose WMI
> devices to userspace, I believe this should be done on a case by case basis,
> opting in, and not by default as part of the WMI driver (although it can provide
> the mechanism for a sub-driver to use), and possibly a devmode to do so by
> default.

A couple of loose thoughts here.

In principle there could be a "generic default WMI driver" or similar that would
"claim" all WMI "devices" that have not been "claimed" by anyone else and would
simply expose them to user space somehow (e.g. using a chardev interface).

Then, depending on how that thing is implemented, opt-in etc should be possible
too.

Thanks,
Rafael
