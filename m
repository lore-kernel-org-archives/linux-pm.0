From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Ottawa Linux Power Management Summit, June 25-26,
	2007 - Minutes
Date: Tue, 25 Sep 2007 14:00:41 +0200
Message-ID: <1190721641.4035.311.camel@chaos>
References: <200709050426.04793.lenb@kernel.org>
	<200709091426.39854.rjw@sisk.pl> <20070924194102.GH8127@redhat.com>
	<200709251339.37601.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709251339.37601.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2007-09-25 at 13:39 +0200, Rafael J. Wysocki wrote:
> On Monday, 24 September 2007 21:41, Dave Jones wrote:
> > On Sun, Sep 09, 2007 at 02:26:39PM +0200, Rafael J. Wysocki wrote:
> > 
> >  > > Dave mentioned that Fedora Core 7 32-bit is now shipping with
> >  > > CONFIG_NOHZ=y and CONFIG_HZ=1000.
> >  > 
> >  > CONFIG_NOHZ is known to break suspend and resume on some machines.  These
> >  > problems are being fixed over time, but that's a risky decision for a
> >  > distribution to switch it on by default.
> > 
> > Expect to see everyone else doing the same thing in the next versions.
> > Without field-testing this stuff it remains busted.  A lot of bugs got
> > found and fixed by having this in Fedora that weren't tripped over
> > by linux-kernel testers at all.
> 
> Well, that's certainly true.
> 
> Still, we have open suspend bugs in which NO_HZ appears to be the culprit,
> eg. http://bugzilla.kernel.org/show_bug.cgi?id=8680

Grr, kernel.org bugzilla is down. I take a look later.

Btw. I got an interesting private response to the latest ACPI fixes:

> >    ACPI: disable lower idle C-states across suspend/resume
> > 
> > Finally, the weird suspend/resume behavior of my Dell-420 laptop has
> > disapeared (no way to adjust brightness after a suspend when not in the
> > docking station). It was always dark after a resume and made the laptop
> > unuseable in practice.
> 
> I cheered too early:
> I just discovered that suspending to ram works well for the first time,
> but after that it's still the same problem. Suspend to disk always
> worked well btw. But somehow there is a difference now: when switching
> to a normal console (ctrl-alt-F1 e.g.) and switching back to X the
> brightness works again. Another thing: I now can also suspend *in* the
> docking station, take it *out* and resume without problems, which never
> worked before :)

Len, did you / Venki look into a similar solution for cpuidle yet ? I'd
like to update -hrt ASAP. If not I just hack it in for now.

	tglx
