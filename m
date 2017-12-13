From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [RFC PATCH 1/2] platform/x86: add Atom PMC quirk to disable SATA
Date: Wed, 13 Dec 2017 17:22:06 +0100
Message-ID: <20171213162206.GA7337@sig21.net>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
 <20170925191749.2oamusbajgs6clcg@sig21.net>
 <20170925192109.rty2fnm7c4jnj3vx@sig21.net>
 <34396652.fljU28PShI@aspire.rjw.lan>
 <a2c8d724-015a-e6c3-23ab-4b6036cc22eb@redhat.com>
 <CAEG3pNDL-8srk_JwqtZxs_waHAPfmRC_5Orhs_=XUhwdHTdM-g@mail.gmail.com>
 <e4760a03-b6af-00fc-6c26-9fff8ed6c378@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e4760a03-b6af-00fc-6c26-9fff8ed6c378@redhat.com>
Sender: linux-clk-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Michael Turquette <mturquette@baylibre.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk <linux-clk@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Takashi Iwai <tiwai@suse.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wed, Dec 13, 2017 at 05:04:34PM +0100, Hans de Goede wrote:
> On 13-12-17 16:25, Michael Turquette wrote:
> > On Wed, Dec 13, 2017 at 12:53 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> > > Although, maybe we need to have a specialized (derived)
> > > ahci driver for these Atom SoCs and in there if no
> > > disk is detected do this through the clock framework?
> > 
> > Yes please. x86 is already modeling some clocks properly through the
> > clock framework. During late init we clean up any clocks that were
> > enabled out of reset or by the firmware/bootloader but not claimed and
> > enabled by any Linux driver. That should ideally disable this
> > particular clock for the case when no SATA drive is present, and
> > require no quirk logic in the driver.
> 
> Ah so you're thinking a special ahci driver which knows about
> the clock, yes I think that could work.
> 
> Or maybe do a match on the CPU model and if it is know to
> not have SATA (or not routed to the outside), disable
> the clock? That seems better because if I understood Johannes
> correctly there is no SATA/AHCI PCI device (so nothing for
> a driver to bind to) but the clock is still enabled, although
> in that case the clock framework should do the right thing
> if we revert commit d31fd43c0f9a "clk: x86: Do not gate clocks enabled by the firmware"

Please don't get confused with the other thread about clocks.
This issue sets the "disable IP" bit, found by doing stupid
experiments to enable S0ix on E200HA.

1. no idea if Cherry Trail even has SATA IP, maybe this is a
   meaningless bit but PMC firmware carried over from
   Bay Trail looks at it

2. BIOS should have set the bit, so it is a BIOS quirk

3. or maybe there is a much better solution that I don't know about

https://bugzilla.kernel.org/show_bug.cgi?id=193891
also has lspci output


Thanks,
Johannes
