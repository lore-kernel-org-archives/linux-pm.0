From: Darren Hart <dvhart@infradead.org>
Subject: RFC: WMI Enhancements
Date: Wed, 12 Apr 2017 16:08:54 -0700
Message-ID: <20170412230854.GA11963@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752870AbdDLXI7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 19:08:59 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Mario Limonciello <Mario_Limonciello@Dell.com>, Andy Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org

Hi All,

There are a few parallel efforts involving the Windows Management
Instrumentation (WMI)[1] and dependent/related drivers. I'd like to have a round of
discussion among those of you that have been involved in this space before we
decide on a direction.

The WMI support in the kernel today fairly narrowly supports a handful of
systems. Andy L. has a work-in-progress series [2] which converts wmi into a
platform device and a proper bus, providing devices for dependent drivers to
bind to, and a mechanism for sibling devices to communicate with each other.
I've reviewed the series and feel like the approach is sound, I plan to carry
this series forward and merge it (with Andy L's permission).

Are there any objections to this?

In Windows, applications interact with WMI more or less directly. We don't do
this in Linux currently, although it has been discussed in the past [3]. Some
vendors will work around this by performing SMI/SMM, which is inefficient at
best. Exposing WMI methods to userspace would bring parity to WMI for Linux and
Windows.

There are two principal concerns I'd appreciate your thoughts on:

a) As an undiscoverable interface (you need to know the method signatures ahead
of time), universally exposing every WMI "device" to userspace seems like "a bad
idea" from a security and stability perspective. While access would certainly be
privileged, it seems more prudent to make this exposure opt-in. We also handle
some of this with kernel drivers and exposing those "devices" to userspace would
enable userspace and the kernel to fight over control. So - if we expose WMI
devices to userspace, I believe this should be done on a case by case basis,
opting in, and not by default as part of the WMI driver (although it can provide
the mechanism for a sub-driver to use), and possibly a devmode to do so by
default.

b) The mechanism to expose WMI devices to userspace must allow for atomic
operation, which would exclude a sysfs interface involving multiple files.
Something like an ioctl or a char dev would be more appropriate.

Does anyone think differently regarding a) or b) ?

Secondarily, Andy L created a simple driver to expose the MOF buffer [2] to
userspace which could be consumed by a userspace tool to create sources for an
interface to the exposed WMI methods. With or without MOF support however, I
think it makes sense to provide a common WMI mechanism to expose specific
devices/methods to userspace.

Appreciate your thoughts,

References:
1. https://msdn.microsoft.com/en-us/library/windows/hardware/Dn614028(v=vs.85).aspx
2. https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=platform/wmi
3. https://www.mail-archive.com/linux-acpi@vger.kernel.org/msg11686.html

-- 
Darren Hart
VMware Open Source Technology Center
