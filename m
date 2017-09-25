From: Johannes Stezenbach <js@sig21.net>
Subject: Re: S0ix failure due to "clk: x86: Do not gate clocks enabled by the
 firmware"
Date: Mon, 25 Sep 2017 21:17:49 +0200
Message-ID: <20170925191749.2oamusbajgs6clcg@sig21.net>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
 <4254964.MfDMP6QAfg@aspire.rjw.lan>
 <20170922080453.3bwad4ale4zizf42@sig21.net>
 <1555462.9U3gvkyXAX@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555462.9U3gvkyXAX@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, Sep 23, 2017 at 12:09:32AM +0200, Rafael J. Wysocki wrote:
> On Friday, September 22, 2017 10:04:53 AM CEST Johannes Stezenbach wrote:
> > In conclusion the BIOS bug is that it enables these clocks at boot,
> > and the correct quirk is to make clk-pmc-atom.c disable them during init,
> > but leave the _PRx handling for the used clocks (CLK3) to ACPI.
> > 
> > Right?
> 
> Well, depending.  The BIOS may need them for something, we just don't know.
> 
> But if the above works, that would be the cleanest way I suppose.

I had a previous quirk patch attached to
https://bugzilla.kernel.org/show_bug.cgi?id=193891
which disables the SATA controller.  I decided to
do the clk quirk on top of it and sending both as RFC.

I test with v4.14-rc2 + sound/topic/dollar-cove-ti-4.13-v5
+ sound/topic/soc-cx2072x-4.13 + your v4 i2c: designware
patches + some more out of tree patches that allow me to enter S0ix.

Thanks,
Johannes
