From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 13 Apr 2017 09:33:39 +0200
Message-ID: <20170413073339.GH3090@pali>
References: <20170412230854.GA11963@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170412230854.GA11963@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Mario Limonciello <Mario_Limonciello@Dell.com>, Andy Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 12 April 2017 16:08:54 Darren Hart wrote:
> In Windows, applications interact with WMI more or less directly. We don't do
> this in Linux currently, although it has been discussed in the past [3]. Some
> vendors will work around this by performing SMI/SMM, which is inefficient at
> best. Exposing WMI methods to userspace would bring parity to WMI for Linux and
> Windows.

Maybe we should first ask, why linux userspace applications need direct
access to WMI? If we look at current WMI linux drivers, basically every
one translate WMI interface to some standard linux class driver (with
some extensions). This is something which should stay in kernel. E.g.
rfkill, backlight, led, input keyboard, ...

-- 
Pali Rohár
pali.rohar@gmail.com
