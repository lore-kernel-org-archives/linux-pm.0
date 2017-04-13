From: Darren Hart <dvhart@infradead.org>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 13 Apr 2017 09:56:46 -0700
Message-ID: <20170413165646.GD2064@fury>
References: <20170412230854.GA11963@fury>
 <20170413073339.GH3090@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170413073339.GH3090@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Mario Limonciello <Mario_Limonciello@Dell.com>, Andy Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 13, 2017 at 09:33:39AM +0200, Pali Rohár wrote:
> On Wednesday 12 April 2017 16:08:54 Darren Hart wrote:
> > In Windows, applications interact with WMI more or less directly. We don't do
> > this in Linux currently, although it has been discussed in the past [3]. Some
> > vendors will work around this by performing SMI/SMM, which is inefficient at
> > best. Exposing WMI methods to userspace would bring parity to WMI for Linux and
> > Windows.
> 
> Maybe we should first ask, why linux userspace applications need direct
> access to WMI? If we look at current WMI linux drivers, basically every
> one translate WMI interface to some standard linux class driver (with
> some extensions). This is something which should stay in kernel. E.g.
> rfkill, backlight, led, input keyboard, ...

Agreed on these common functions. Whenever we have a common subsystem / class
driver, we should make use of that. This is another good reason not to publish
all WMI methods wholesale to userspace. That said, class drivers are written
after we eventually see a pattern in drivers and refactor them to encapsulate a
common functionality. This takes time, and is only worth doing for things that
are truly common.

WMI (Windows Management Instrumentation) is very generic and is intended to
provide vendors the ability to manage and configure the systems at the firmware
level.

I am a strong supporter of the following philosophy with respect to supporting
innovation:
"Enable them to enable themselves and get out of their way"

I've followed this approach over the years to encourage upstream first software
development, open-first policy toward specifications and documentation, proper
license selection, and development of new mechanisms in existing standards, like
ACPI _DSD. All of these serve to support innovation by removing bottlenecks and
enabling developers to be independent.

What I don't want to see is the Linux kernel becoming a bottleneck to feature
parity with Windows (or to becoming the lead vehicle for new features). When a
vendor has a feature they want to expose which they determine to be a value
proposition for their product, I don't want the lack of a class driver to get in
the way. Exposing specific GUIDs is a minimal and easy to upstream change which
would enable rapid feature enabling.

Perhaps I should have led with this :-)

-- 
Darren Hart
VMware Open Source Technology Center
