From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM discussion notes
Date: Fri, 29 Jul 2011 21:52:26 +0200
Message-ID: <201107292152.27066.rjw__22282.3259573945$1311970665$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
	<201107131104.06995.rjw@sisk.pl> <20110729134015.GA1561@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110729134015.GA1561@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, July 29, 2011, Pavel Machek wrote:
> Hi!
> 
> > > > Actually, it just occurred to me that if we're waiting for a system
> > > > timer and can hand that off to a suitable timer in the PMIC then we can
> > > > do a suspend to RAM for the deep idle state from the hardware point of
> > > > view.
> > > 
> > > Yep.  At LinuxCon Cambridge two years ago, we had a discussion about 
> > > whether it would be possible to enter ACPI S-states from CPUIdle (or some 
> > > idle governor) on Intel chips.  If I remember correctly, the conclusion 
> > > was that ACPI always disables the screen/backlight, so it would only be 
> > > useful for situations where that was acceptable.
> 
> Well, auto suspending when screensaver is active would still be
> useful.
> 
> (And IIRC some machines kept screen on when in S-state unless driver
> powered it down... but that might be S1.
> 
> > The reason why you can't enter ACPI S-states from CPUidle is because you
> > need to go out of the idle loop to execute some ACPI-specific stuff.  Which
> > is not even specific to Intel chips, but to ACPI in general.
> 
> The code was little tricky/unclean, but it "worked" for me at one
> point... I called it  "sleepy linux".

Yes, you can find a system where it might kind of work (just because
_PTS is empty or something like this).  Is it going to work in general?
No way.

So please let's turn into something at least _theoretically_ viable.

Thanks,
Rafael
