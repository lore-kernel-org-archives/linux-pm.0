From: Johannes Stezenbach <js@sig21.net>
Subject: Re: S0ix failure due to "clk: x86: Do not gate clocks enabled by the
 firmware"
Date: Thu, 21 Sep 2017 18:23:07 +0200
Message-ID: <20170921162307.amdz2uyei7eackhs@sig21.net>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
 <20170908134920.qia2bdjvpahe3zvi@sig21.net>
 <20170921094013.hznamkxx5md4yhgf@sig21.net>
 <4036229.gTT6xKEFIS@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4036229.gTT6xKEFIS@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 21, 2017 at 04:21:46PM +0200, Rafael J. Wysocki wrote:
> So I would be inclined to think of that as a BIOS issue.

OK, wrt $Subject it sparks the question how to fix the
issue exposed by commit d31fd43c0f9a4 "clk: x86: Do not
gate clocks enabled by the firmware".  Add quirks to
the drivers for the devices that have the dangling
PowerResources and manually call _OFF/_ON during suspend/resume?

I must admit I haven't looked deeper into the issue yet,
i.e. I don't know which clock causes S0ix failure.
If I understand correctly, before d31fd43c0f9a4 the
clk framework would just disable all unused clocks
registered by clk-pmc-atom.c, which are all of then except
CLK3 which is used by the audio codec. And the audio codec
would disable CLK3 during suspend.
After d31fd43c0f9a4 all clocks that BIOS had enabled during boot
are kept running.  Presumably we could also add the quirk to
clk-pmc-atom.c to bypass what d31fd43c0f9a4 added on Asus E200HA?


Thanks,
Johannes
