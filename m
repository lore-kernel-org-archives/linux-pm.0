From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Runtime PM discussion notes
Date: Sat, 30 Jul 2011 23:25:23 +0200
Message-ID: <20110730212523.GA10450__33684.718135237$1312061170$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
	<20110730203737.GA8762@elf.ucw.cz> <201107302305.00212.rjw@sisk.pl>
	<201107302309.19169.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201107302309.19169.rjw@sisk.pl>
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


> > > IIRC I solved it by just calling _PTS when sleepy Linux was
> > > enabled. It had side effect of lighting up moon icon, but otherwise
> > > seemed to work ok.
> > > 
> > > I do not think ACPI says what can and can not be done after _PTS...
> > 
> > Yes, it does.
> 
> And even if _PTS will work, you're certainly not supposed to execute _WAK
> with interrupts off.

It should be ok to execute _WAK in process context once system is
resumed. ... or maybe not executing _WAK at all. User can probably
live with moon icon lighted up.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
