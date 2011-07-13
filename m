From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM discussion notes
Date: Wed, 13 Jul 2011 11:04:06 +0200
Message-ID: <201107131104.06995.rjw__14599.2839396515$1310547869$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
	<20110711112619.GH5092@opensource.wolfsonmicro.com>
	<alpine.DEB.2.00.1107130105530.30229@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1107130105530.30229@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 13, 2011, Paul Walmsley wrote:
> (cc'ing Len)
> 
> Hi Mark,
> 
> On Mon, 11 Jul 2011, Mark Brown wrote:
> 
> > The interesting bits are things like being able to kill lots of the SoC
> > core supplies when the RAM is in retention mode - the CPU needs to go
> > through its shutdown procedures.
> 
> This is indeed possible on OMAP3+ chips with TWL4030+ PMICs.  Probably 
> other PMICs also.  TI calls it "off-mode."  The N900 shipped with this 
> feature enabled.  Not sure how many other similar products did.
> 
> This can be enabled in mainline, but not all of the mainline drivers have 
> context save/restore code merged yet, so in mainline it only works with a 
> subset of drivers.
> 
> > Actually, it just occurred to me that if we're waiting for a system
> > timer and can hand that off to a suitable timer in the PMIC then we can
> > do a suspend to RAM for the deep idle state from the hardware point of
> > view.
> 
> Yep.  At LinuxCon Cambridge two years ago, we had a discussion about 
> whether it would be possible to enter ACPI S-states from CPUIdle (or some 
> idle governor) on Intel chips.  If I remember correctly, the conclusion 
> was that ACPI always disables the screen/backlight, so it would only be 
> useful for situations where that was acceptable.

The reason why you can't enter ACPI S-states from CPUidle is because you
need to go out of the idle loop to execute some ACPI-specific stuff.  Which
is not even specific to Intel chips, but to ACPI in general.

So entering ACPI S-states from idle is a no-no and I don't think it'll
change in foreseeable future.

> To the best of my (limited) knowledge, that's the only case I know of 
> where there's a hardware limitation that prevents dynamic idle from 
> reaching the same low power state as system suspend.  If someone has hard 
> details of a similar example, it would be great to know about it.

Google G1 had this problem IIRC, but I don't have any details.

Thanks,
Rafael
