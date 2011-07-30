From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM discussion notes
Date: Sat, 30 Jul 2011 23:05:00 +0200
Message-ID: <201107302305.00212.rjw__18337.9958886237$1312061686$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
	<201107292152.27066.rjw@sisk.pl> <20110730203737.GA8762@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110730203737.GA8762@elf.ucw.cz>
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

On Saturday, July 30, 2011, Pavel Machek wrote:
> Hi!
> 
> > > Well, auto suspending when screensaver is active would still be
> > > useful.
> > > 
> > > (And IIRC some machines kept screen on when in S-state unless driver
> > > powered it down... but that might be S1.
> > > 
> > > > The reason why you can't enter ACPI S-states from CPUidle is because you
> > > > need to go out of the idle loop to execute some ACPI-specific stuff.  Which
> > > > is not even specific to Intel chips, but to ACPI in general.
> > > 
> > > The code was little tricky/unclean, but it "worked" for me at one
> > > point... I called it  "sleepy linux".
> > 
> > Yes, you can find a system where it might kind of work (just because
> > _PTS is empty or something like this).  Is it going to work in general?
> > No way.
> 
> IIRC I solved it by just calling _PTS when sleepy Linux was
> enabled. It had side effect of lighting up moon icon, but otherwise
> seemed to work ok.
> 
> I do not think ACPI says what can and can not be done after _PTS...

Yes, it does.

Thanks,
Rafael
