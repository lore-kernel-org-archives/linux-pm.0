From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH 2/2] clk: x86: Disable unused clocks to fix S0ix
Date: Wed, 13 Dec 2017 16:29:12 +0200
Message-ID: <1513175352.7000.7.camel@linux.intel.com>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
         <1555462.9U3gvkyXAX@aspire.rjw.lan>
         <20170925192352.ihzakshd7yofowdd@sig21.net>
         <7178688.oS2VOf73im@aspire.rjw.lan>
         <fb202f9b-1fa2-4b9c-de75-4431a6273d12@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <fb202f9b-1fa2-4b9c-de75-4431a6273d12@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Johannes Stezenbach <js@sig21.net>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2017-12-13 at 09:56 +0100, Hans de Goede wrote:
> Hi,
> 
> On 13-12-17 01:01, Rafael J. Wysocki wrote:
> > On Monday, September 25, 2017 9:23:52 PM CET Johannes Stezenbach
> > wrote:
> > > d31fd43c0f9a "clk: x86: Do not gate clocks enabled by the
> > > firmware"
> > > exposed an issue on Asus E200HA where BIOS enables unused
> > > Atom PMC clocks which prevent the system from entering S0ix.
> > > Add a quirk to disable these clocks on E200HA.
> > > 
> > > Signed-off-by: Johannes Stezenbach <js@sig21.net>
> > 
> > Mika, Andy, Hans, any comments here?

I remember discussing those in bugzilla, though I agree with Hans, it
looks hackish still. I'm not sure on the other hand we can solve this
properly in a meantime.

I also have some style related comments, but they are minor. I can go
through better review after we settle down the way we would like to fix
the issue.

> This seems like it is papering over an issue in the
> d31fd43c0f9a "clk: x86: Do not gate clocks enabled by the firmware"
> patch to me. That patch seems like a somewhat hackish fix to
> me, it would be better to figure out which device needs the clock
> in question and fix the device's driver...

My understanding of S0ix prerequisites is all devices in question *must*
have drivers loaded and drivers *must* have implemented runtime PM.

(Since I don't know if it's guaranteed by firmware that devices are left
in D3 if they are not used. Besides that from the SATA case looks like
some BIOS [hardware?] issue with power gating)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
