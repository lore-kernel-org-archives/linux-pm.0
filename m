From: Pavel Machek <pavel@suse.cz>
Subject: suspend-devices-not-cpu [was Re: [PATCH 2/2] Fix console
	handling during suspend/resume]
Date: Thu, 15 Jun 2006 11:11:46 +0200
Message-ID: <20060615091146.GD9423@elf.ucw.cz>
References: <Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606140820420.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<20060614214048.GG4950@ucw.cz>
	<Pine.LNX.4.64.0606141501070.5498@g5.osdl.org>
	<20060614221235.GA7751@elf.ucw.cz>
	<Pine.LNX.4.64.0606141529270.5498@g5.osdl.org>
	<20060615000021.GB24859@elf.ucw.cz>
	<Pine.LNX.4.64.0606141707480.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606141707480.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Power management list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > It's _not_ supposed to be PC-compatible. It just happens to be close =

> > > enough that we can ignore the differences.
> > =

> > Aha, okay. So it basically needs special config to work, and
> > complaining that it does not boot noapic is not helpful.
...
> So it's not a "legacy PC", but it's certainly "standard Intel chipsets =

> with ACPI". So the same image _should_ really work.

Okay, first example of non-legacy PC :-).

> > Actually s2ram used to work for quite long time...
> =

> I know. On _some_ machines. So far, I don't think I've actually ever hit =

> a machine where it "just worked". Every single time there's some module =

> that needs to be unloaded for it to boot, or it needs to use fbcon, or it =

> needs some other magic.
> =

> I'd really like for it to "just work", and having more people who can try =

> to debug why it doesn't work for them is probably the best way to get =

> there. I know from personal experience that at least _one_ reason why =

> people didn't even bother debugging it was that there simply wasn't =

> anythign to debug. There was just a dead brick.
> =

> It's that "it's just a dead brick" part I want to fix. I want to turn tha=
t =

> into "it's a dead brick that I can look inside".

Yes, RTC is a pretty clever hack that should not break anything. I
also used leds on port 80, hardware debugger, and beeps to get same
results.

Actually... I played around with idea "enter low-power mode without
hardware help".. it could be very useful for driver testing.

I imagine something that would suspend all the devices, but instead of
powering cpu down at the end, it would just enter low power mode. That
way, we can rule BIOS interactions etc. Would such patch be
acceptable?
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
