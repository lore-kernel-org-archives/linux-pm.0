From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: S0ix failure due to "clk: x86: Do not gate clocks enabled by the firmware"
Date: Fri, 22 Sep 2017 00:35:15 +0200
Message-ID: <4254964.MfDMP6QAfg@aspire.rjw.lan>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net> <4036229.gTT6xKEFIS@aspire.rjw.lan> <20170921162307.amdz2uyei7eackhs@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170921162307.amdz2uyei7eackhs@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, September 21, 2017 6:23:07 PM CEST Johannes Stezenbach wrote:
> On Thu, Sep 21, 2017 at 04:21:46PM +0200, Rafael J. Wysocki wrote:
> > So I would be inclined to think of that as a BIOS issue.
> 
> OK, wrt $Subject it sparks the question how to fix the
> issue exposed by commit d31fd43c0f9a4 "clk: x86: Do not
> gate clocks enabled by the firmware".  Add quirks to
> the drivers for the devices that have the dangling
> PowerResources and manually call _OFF/_ON during suspend/resume?
> 
> I must admit I haven't looked deeper into the issue yet,
> i.e. I don't know which clock causes S0ix failure.
> If I understand correctly, before d31fd43c0f9a4 the
> clk framework would just disable all unused clocks
> registered by clk-pmc-atom.c, which are all of then except
> CLK3 which is used by the audio codec. And the audio codec
> would disable CLK3 during suspend.
> After d31fd43c0f9a4 all clocks that BIOS had enabled during boot
> are kept running.  Presumably we could also add the quirk to
> clk-pmc-atom.c to bypass what d31fd43c0f9a4 added on Asus E200HA?

Since this is S0ix, the "system level" is 0 all the time (as I said in a
previous message).

So there seem to be two possible ways to address this, unfortunately both
based on white- or blacklisting.

One of them would be to only do the d31fd43c0f9a4 approach for selected
systems where it needs to be done to avoid breakage.  The other one would
be to do it for all systems by default and blacklist the ones where that
leads to problems.

IMO it is better to disable clocks over suspend-resume, because that reduces
the system's power draw while suspended.  So that's what I would do and then
keep the clocks running only if that is known to be necessary.

Thanks,
Rafael

