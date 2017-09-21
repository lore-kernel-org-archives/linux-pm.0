From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: S0ix failure due to "clk: x86: Do not gate clocks enabled by the firmware"
Date: Fri, 22 Sep 2017 00:24:06 +0200
Message-ID: <6159689.HysJJF9vfD@aspire.rjw.lan>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net> <20170921162307.amdz2uyei7eackhs@sig21.net> <2582638.tGggrMFmYq@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <2582638.tGggrMFmYq@aspire.rjw.lan>
Sender: linux-clk-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, September 22, 2017 12:20:55 AM CEST Rafael J. Wysocki wrote:
> On Thursday, September 21, 2017 6:23:07 PM CEST Johannes Stezenbach wrote:
> > On Thu, Sep 21, 2017 at 04:21:46PM +0200, Rafael J. Wysocki wrote:
> > > So I would be inclined to think of that as a BIOS issue.
> > 
> > OK, wrt $Subject it sparks the question how to fix the
> > issue exposed by commit d31fd43c0f9a4 "clk: x86: Do not
> > gate clocks enabled by the firmware".  Add quirks to
> > the drivers for the devices that have the dangling
> > PowerResources and manually call _OFF/_ON during suspend/resume?
> 
> Well, it may just be better to do that in the core at the suspend
> time, so I'm wondering if the appended patch makes any difference?

But if this is S0ix, then the system states is S0 anyway all the time, so
I'm not sure about the point here, honestly.

Thanks,
Rafael

