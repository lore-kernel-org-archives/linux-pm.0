From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [RFC PATCH 1/2] platform/x86: add Atom PMC quirk to disable SATA
Date: Wed, 13 Dec 2017 12:13:05 +0100
Message-ID: <20171213111305.GA20260@sig21.net>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
 <20170925191749.2oamusbajgs6clcg@sig21.net>
 <20170925192109.rty2fnm7c4jnj3vx@sig21.net>
 <34396652.fljU28PShI@aspire.rjw.lan>
 <a2c8d724-015a-e6c3-23ab-4b6036cc22eb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a2c8d724-015a-e6c3-23ab-4b6036cc22eb@redhat.com>
Sender: linux-clk-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 13, 2017 at 09:53:21AM +0100, Hans de Goede wrote:
> On 13-12-17 01:00, Rafael J. Wysocki wrote:
> > On Monday, September 25, 2017 9:21:09 PM CET Johannes Stezenbach wrote:
> > > SATA controller is enabled on Asus E200HA even though the
> > > machine doesn't use it (it has eMMC storage), however
> > > SATA being on blocks S0ix entry so we need to disable it.
> > > 
> > > Signed-off-by: Johannes Stezenbach <js@sig21.net>
> > 
> > Mika, Andy, Hans, any comments on this one?
> 
> Seems sensible to me, I'm afraid we may need the same quirk on
> other devices, but I see no way around this.
> 
> Although, maybe we need to have a specialized (derived)
> ahci driver for these Atom SoCs and in there if no
> disk is detected do this through the clock framework?
> 
> That may be better then a long list of quirks.
> 
> Johannes, question how did you test this and figure out
> which clocks to disable, a quick howto on this, I think
> a patch adding a little howto / README as say
> Documentation/power/intel-S0ix-debugging.txt
> documenting this would be great. I'm certainly interested
> in trying to reproduce this on some of my own Bay Trail and
> Cherry Trail devices and add fixes for those if necessary.

I put my E200HA aside due to lack of time, so it's
unlikely I'll send documentation patches anytime soon.

Basically everything is documented in bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=193891

For the SATA issue I just poked wildly around in registers using
busybox devmem, after applying S0ix blocker debug patch
I tried to disable some devices which were printed:
https://bugzilla.kernel.org/show_bug.cgi?id=193891#c53
(Obviously bug 193891 is misnamed, most of what's
discussed there doesn't directly relate to PMIC. Sorry
for creating a mess, but my understanding of the platform
was very low when I created it.)

The thing is that the public CHT datasheet (atom-z8000-datasheet-vol-1.pdf + vol-2)
doesn't even mention SATA, and there is no PCI device for it.
OTOH, baytrail datasheet (atom-e3800-family-datasheet.pdf)
specifies SATA and BIT_SATA was already defined in pmc_atom.h.

Besides SATA, I also needed to disable dw DMA, using a
hack patch or devmem, but eventually it might be solved properly:
https://bugzilla.kernel.org/show_bug.cgi?id=196861


Thanks,
Johannes
