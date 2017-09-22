From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: S0ix failure due to "clk: x86: Do not gate clocks enabled by the firmware"
Date: Sat, 23 Sep 2017 00:12:35 +0200
Message-ID: <5668556.iq4Amxhha7@aspire.rjw.lan>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net> <20170922080453.3bwad4ale4zizf42@sig21.net> <s5hzi9mdik2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <s5hzi9mdik2.wl-tiwai@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>Takashi Iwai <tiwai@suse.de>
Cc: Johannes Stezenbach <js@sig21.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-acpi@vger.kernel.orgJohannes Stezenbach <js@sig21.net>Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>linux-clk@vger.kernel.orglinux-pm@vger.kernel.orgCarlo Caione <carlo@endlessm.com>Andy Shevchenko <andriy.shevchenko@linux.intel.com>Darren Hart <dvhart@infradead.org>Enric Balletbo i Serra <enric.balletbo@collabora.com>linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, September 22, 2017 2:27:57 PM CEST Takashi Iwai wrote:
> On Fri, 22 Sep 2017 10:04:53 +0200,
> Johannes Stezenbach wrote:
> > 
> > On Fri, Sep 22, 2017 at 12:35:15AM +0200, Rafael J. Wysocki wrote:
> > > On Thursday, September 21, 2017 6:23:07 PM CEST Johannes Stezenbach wrote:
> > > > On Thu, Sep 21, 2017 at 04:21:46PM +0200, Rafael J. Wysocki wrote:
> > > > > So I would be inclined to think of that as a BIOS issue.
> > > > 
> > > > OK, wrt $Subject it sparks the question how to fix the
> > > > issue exposed by commit d31fd43c0f9a4 "clk: x86: Do not
> > > > gate clocks enabled by the firmware".  Add quirks to
> > > > the drivers for the devices that have the dangling
> > > > PowerResources and manually call _OFF/_ON during suspend/resume?
> > > > 
> > > > I must admit I haven't looked deeper into the issue yet,
> > > > i.e. I don't know which clock causes S0ix failure.
> > > > If I understand correctly, before d31fd43c0f9a4 the
> > > > clk framework would just disable all unused clocks
> > > > registered by clk-pmc-atom.c, which are all of then except
> > > > CLK3 which is used by the audio codec. And the audio codec
> > > > would disable CLK3 during suspend.
> > > > After d31fd43c0f9a4 all clocks that BIOS had enabled during boot
> > > > are kept running.  Presumably we could also add the quirk to
> > > > clk-pmc-atom.c to bypass what d31fd43c0f9a4 added on Asus E200HA?
> > > 
> > > Since this is S0ix, the "system level" is 0 all the time (as I said in a
> > > previous message).
> > 
> > Damn.  Reading ACPI spec (6.1 and 6.2), it talks about _LPI and _RDI
> > but E200HA doesn't have that in any ACPI table.
> > The table in section 7.1 Power Resource Objects and the Power Management Models
> > says "Choose a supported device state to enable a targeted system sleep or
> > Low- power Idle state ... [use] _PRx".
> > 
> > > So there seem to be two possible ways to address this, unfortunately both
> > > based on white- or blacklisting.
> > > 
> > > One of them would be to only do the d31fd43c0f9a4 approach for selected
> > > systems where it needs to be done to avoid breakage.  The other one would
> > > be to do it for all systems by default and blacklist the ones where that
> > > leads to problems.
> > > 
> > > IMO it is better to disable clocks over suspend-resume, because that reduces
> > > the system's power draw while suspended.  So that's what I would do and then
> > > keep the clocks running only if that is known to be necessary.
> > 
> > d31fd43c0f9a4 was added to fix a "hard hangup on boot" issue,
> > so I guess the default should be to keep clocks enabled.
> > 
> > BTW, in E200HA DSDT, the PowerResources in question are children of
> > the I2Cx devices, presumably it means these clocks are to be used by
> > devices connected to the i2c busses.  Maybe it's a left over from devices
> > that are not present in E200HA, and we should ignore them.
> > 
> > In conclusion the BIOS bug is that it enables these clocks at boot,
> > and the correct quirk is to make clk-pmc-atom.c disable them during init,
> > but leave the _PRx handling for the used clocks (CLK3) to ACPI.
> 
> Well, I can't say which is the buggy behavior, but at least, I agree
> with Rafael that white/blacklisting is likely the way to go.
> 
> One thing I'm wondering is whether it's specific to device or specific
> to platform.  The ASUS one that showed a regression Johannes and I
> have is the Cherrytrail, while the device showed the hang-at-boot was
> Baytrail, IIRC.

If I were to place bets, I'd bet on platform-specific and not machine model-
specific.

Thanks,
Rafael

