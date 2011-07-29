From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Runtime PM discussion notes
Date: Fri, 29 Jul 2011 15:41:05 +0200
Message-ID: <20110729134015.GA1561__38543.3718831793$1311946931$gmane$org@ucw.cz>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
	<20110711112619.GH5092@opensource.wolfsonmicro.com>
	<alpine.DEB.2.00.1107130105530.30229@utopia.booyaka.com>
	<201107131104.06995.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201107131104.06995.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > Actually, it just occurred to me that if we're waiting for a system
> > > timer and can hand that off to a suitable timer in the PMIC then we can
> > > do a suspend to RAM for the deep idle state from the hardware point of
> > > view.
> > 
> > Yep.  At LinuxCon Cambridge two years ago, we had a discussion about 
> > whether it would be possible to enter ACPI S-states from CPUIdle (or some 
> > idle governor) on Intel chips.  If I remember correctly, the conclusion 
> > was that ACPI always disables the screen/backlight, so it would only be 
> > useful for situations where that was acceptable.

Well, auto suspending when screensaver is active would still be
useful.

(And IIRC some machines kept screen on when in S-state unless driver
powered it down... but that might be S1.

> The reason why you can't enter ACPI S-states from CPUidle is because you
> need to go out of the idle loop to execute some ACPI-specific stuff.  Which
> is not even specific to Intel chips, but to ACPI in general.

The code was little tricky/unclean, but it "worked" for me at one
point... I called it  "sleepy linux".
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
