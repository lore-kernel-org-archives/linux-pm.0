From: Johannes Stezenbach <js@sig21.net>
Subject: Re: S0ix failure due to "clk: x86: Do not gate clocks enabled by the
 firmware"
Date: Fri, 8 Sep 2017 15:49:20 +0200
Message-ID: <20170908134920.qia2bdjvpahe3zvi@sig21.net>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
 <5bb7e3ca-38fc-1184-3bca-f666275c6180@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:38128 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbdIHNt6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 8 Sep 2017 09:49:58 -0400
Content-Disposition: inline
In-Reply-To: <5bb7e3ca-38fc-1184-3bca-f666275c6180@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org

(adding linux-acpi)

On Wed, Sep 06, 2017 at 04:02:10PM -0500, Pierre-Louis Bossart wrote:
> On 9/6/17 3:42 PM, Johannes Stezenbach wrote:
> > I'm poking around on Asus E200HA, based on Atom x5-Z8300 (Cherrytrail),
> > trying to get S0ix working, atm with gross hacks that are recorded in
> > https://bugzilla.kernel.org/show_bug.cgi?id=193891
> > 
> > 
> > I found commit d31fd43c0f9a4 "clk: x86: Do not gate clocks enabled by the firmware"
> > prevents S0i3 entry.  Unfortunately the commit message doesn't explain
> > the problem it fixes, nor does it mention the platform.
> > 
> > How can we fix d31fd43c0f9a4 to not break S0i3?
> 
> In the existing audio machine drivers, I only use the clock framework for
> Baytrail. on Cherrytrail, the pmc_platform_clk3 used for the audio MCLK is
> actually managed by the BIOS (look for CLK3 in the DSDT) so there is no
> activity in the drivers, the audio don't even get/prepare/enable the
> pmc_platform_clk3 so I would guess there is an issue with a non-audio driver
> or the BIOS. Put differently, it may be so that by allowing the drivers to
> gate an unused clock we allowed you to enter S0i3 even if the bios didn't
> enable this mode. I would remove all pmc-clock related stuff and see what
> happens.

Thanks for this info and Carlo's reply.  I've been busy reading
source code, DSDT and ACPI spec, and now I'm confused. ;-/

As you say, these clocks are managed by BIOS and
clk-pmc-atom.c shouldn't mess with them, thus
d31fd43c0f9a4 is correct.  Nothing else in the
system besides sound/soc/intel/boards/ uses
pmc_plt_clk_3 (or other pmc_plt_clk*).

Now the question is why ACPI doesn't handle the clocks.

E200HA DSDT https://bugzilla.kernel.org/attachment.cgi?id=253921
has PowerResource defintions for the clocks
(where _ON and _OFF just set the same registers that
clk-pmc-atom.c uses, e.g. CKC3 at 0x6c for CLK3).
However, these PowerResources are only listed as child nodes
of the devices that use them, but are not referenced by _PR[0-3],
with the exception of CLK3 used by the audio codec.

The power resources exist in /sys as LNXPOWER:xx subnodes
of the device (e.g. i2c 809622C1:02/LNXPOWER:05) and are
also listed during boot.

acpi_bus_init_power_state() sets device->power.flags.power_resources = 1
only if _PR[0-3] exist.  Then acpi_device_set_power() only
calls acpi_power_transition() if power_resource == 1,
and acpi_power_transition() would only call acpi_power_off_list()
for the resources according to _PR[0-3].

I think this is all OK, maybe the BIOS is not optimal in
making the clocks available for device runtime pm.
What doesn't seem to happen, though, is that the PowerResources
are turned _OFF when system transitions to S0ix.  The PowerResources
have systemlevel == 0, meaning they should be turned off when the
system transitions out of S0, if I'm understanding the ACPI (6.1)
spec correctly in section 7.2 Declaring a Power Resource Object.
Well, actually I'm not sure, the wording of the ACPI spec is:

  "Systemlevel is the deepest system sleep level OSPM must maintain to keep
  this power resource on (0 equates to S0, 1 equates to S1, and so on)."

FWIW, I used "echo 0x00800000 >/sys/module/acpi/parameters/debug_layer"
to confirm devices transition between D0 and D3hot, but clock
resources are never turned off.


Johannes
