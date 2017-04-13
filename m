From: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 13 Apr 2017 09:32:28 +0200
Message-ID: <20170413073228.GB1462@ozzy.nask.waw.pl>
References: <20170412230854.GA11963@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170412230854.GA11963@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Mario Limonciello <Mario_Limonciello@Dell.com>, Andy Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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

Back in January 2016, I sent Andy a few minor comments about this
series.  A year later, I offered to iron out the remaining issues and
resubmit the series in Andy's name when I find the time.  Sadly, things
have changed a bit for me since that time and it is unlikely that I will
be able to deliver, for which I am sorry.

However, browsing Andy's branch I see that most issues have been
resolved, though I think some of my remarks [1] have either been missed
or silently refuted :)

Anyway, I also like this approach and I think this series is a valuable
cleanup.

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
> 
> b) The mechanism to expose WMI devices to userspace must allow for atomic
> operation, which would exclude a sysfs interface involving multiple files.
> Something like an ioctl or a char dev would be more appropriate.
> 
> Does anyone think differently regarding a) or b) ?

Please pardon my ignorance, but what do we actually gain by exposing WMI
to userspace?  Enabling applications to fetch SMBIOS data?  We already
have an interface for that.  Enabling applications to receive input
events?  Likewise.  You mentioned WMI's efficiency compared to SMI/SMM,
but is it a difference significant enough for anyone to notice?

I am biased here as I have had my own struggles with WMI in the past,
but it looks like a layer of indirection which brings little value, yet
is tricky to expose properly.  If there is a real-life use case that
makes this idea worthwhile, I would love to be enlightened.  

> Secondarily, Andy L created a simple driver to expose the MOF buffer [2] to
> userspace which could be consumed by a userspace tool to create sources for an
> interface to the exposed WMI methods.

+1 for the idea, it makes figuring out what the firmware actually
exposes through WMI a bit easier.  After skimming through the driver's
code, I would only recommend to review the included headers
(linux/input/sparse-keymap.h, linux/dmi.h and acpi/video.h all seem
redundant to me).

What we still need, though, is an open source version of wmiofck.exe.  I
am unaware of anything like that existing and installing the Windows
Driver Kit just to run one command which spits out a single *.h file is
not something I would describe as convenient (been there).

[1] https://www.spinics.net/lists/platform-driver-x86/msg08201.html

-- 
Best regards,
Michał Kępień
