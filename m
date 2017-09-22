From: Johannes Stezenbach <js@sig21.net>
Subject: Re: S0ix failure due to "clk: x86: Do not gate clocks enabled by the
 firmware"
Date: Fri, 22 Sep 2017 23:04:16 +0200
Message-ID: <20170922210416.bqbuzgsa5gzfvnrx@sig21.net>
References: <20170906204237.24x6fzlfmq7jmuce@sig21.net>
 <4036229.gTT6xKEFIS@aspire.rjw.lan>
 <20170921162307.amdz2uyei7eackhs@sig21.net>
 <4254964.MfDMP6QAfg@aspire.rjw.lan>
 <20170922080453.3bwad4ale4zizf42@sig21.net>
 <s5hzi9mdik2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:41239 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752055AbdIVVFC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Sep 2017 17:05:02 -0400
Content-Disposition: inline
In-Reply-To: <s5hzi9mdik2.wl-tiwai@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, Carlo Caione <carlo@endlessm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-acpi@vger.kernel.org

On Fri, Sep 22, 2017 at 02:27:57PM +0200, Takashi Iwai wrote:
> On Fri, 22 Sep 2017 10:04:53 +0200,
> Johannes Stezenbach wrote:
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

If I understand correctly, the clk-pmc-atom.c clocks are not used
by the SoC itself but provided for devices added to system by OEM.
So I don't think its platform (BYT vs. CHT) specific.

Meanwhile I have doubts about d31fd43c0f9a41, though.

The original issue mentioned by Carlo:
https://www.spinics.net/lists/platform-driver-x86/msg12092.html

>>> We have a quirk downstream in place where we basically modified the
>>> r8169 driver to claim the 25MHz pmc_plt_clk_4 clock, and this seems to
>>> work fine, but we really want to find a more upstreamable and
>>> definitive solution.

It seems to me that this quirk to claim pmc_plt_clk_4 would
actually be a better solution than just keeping
clocks enabled.  And you'd need to handle the clock
during suspend for S0ix to work, if Baytrail pmc_plt_clk_4
has the same S0ix blocking behaviour as Cherrytrail CLK3.
IOW, the driver which uses the pmc_plt_clk_4 clock needs
to handle it if ACPI DSDT doesn't handle it via _PRx.


Thanks,
Johannes
