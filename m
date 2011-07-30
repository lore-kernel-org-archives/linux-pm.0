From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Runtime PM discussion notes
Date: Sat, 30 Jul 2011 23:36:06 +0200
Message-ID: <201107302336.06428.rjw__33414.5811306827$1312061728$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
	<201107302309.19169.rjw@sisk.pl>
	<20110730212523.GA10450@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110730212523.GA10450@elf.ucw.cz>
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
> 
> > > > IIRC I solved it by just calling _PTS when sleepy Linux was
> > > > enabled. It had side effect of lighting up moon icon, but otherwise
> > > > seemed to work ok.
> > > > 
> > > > I do not think ACPI says what can and can not be done after _PTS...
> > > 
> > > Yes, it does.
> > 
> > And even if _PTS will work, you're certainly not supposed to execute _WAK
> > with interrupts off.
> 
> It should be ok to execute _WAK in process context once system is
> resumed. ... or maybe not executing _WAK at all. User can probably
> live with moon icon lighted up.

But I don't think the user can live with certain functionality missing,
like battery status or such things.

This is completely unrealistic to think that your prototype can be safely
implemented on _every_ ACPI-based system.  Period.

And that's even without taking SMP into account, BTW.

Thanks,
Rafael
