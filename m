From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Async resume patch (was: Re: [GIT PULL] PM updates
	for 2.6.33)
Date: Wed, 9 Dec 2009 18:27:32 +0000
Message-ID: <20091209182731.GL9018__37136.6066196517$1260383317$gmane$org@sirena.org.uk>
References: <20091209160256.GA3229@rakim.wolfsonmicro.main>
	<Pine.LNX.4.44L0.0912091117080.4120-100000@iolanthe.rowland.org>
	<20091209164653.GI9018@sirena.org.uk>
	<alpine.LFD.2.00.0912090851540.3560@localhost.localdomain>
	<20091209174537.GJ9018@sirena.org.uk>
	<alpine.LFD.2.00.0912090953200.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0912090953200.3560@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 09, 2009 at 09:57:22AM -0800, Linus Torvalds wrote:
> On Wed, 9 Dec 2009, Mark Brown wrote:

> > The problem comes when you've got audio outputs referenced to something
> > other than ground which used to happen because no negative supplies were
> > available in these systems.  To bring these up from cold you need to
> > bring the outputs up to the reference level but if you do that by just
> > turning on the power you get an audible (often loud) noise in the output
> > from the square(ish) waveform that results which users don't find
> > acceptable.

> Ouch. A second still sounds way too long - but whatever.

Yes, I think there's pretty much universal agreement on that :)

Hardware that needs a few hundred miliseconds is much more common at the
minute (and like I say current generation hardware is basically
unaffected), but it's the number I keep in mind when considering how bad
things might be.

> However, it sounds like the nice way to do that isn't by doing it 
> synchronously in the suspend/resume code itself, but simply ramping it 
> down (and up) from a timer. It would be asynchronous, but not because the 
> suspend itself is in any way asynchronous.

We don't actually need a timer for most of this - generally the ramp is
done by charging or discharging a capacitor through a resistor so you
just set it going then wait, possibly in several stages with a little
bit twiddling in the middle to speed things up which could be done off a
timer.

> Done right, it might even result in a nice volume fade of the sound (ie if 
> the hw allows for it, stop the actual sound engine late on suspend, and 
> start it early on resume, so that sound works _while_ the whole reference 
> volume rampdown/up is going on)

The big issue with running off a partially ramped supply is that it can
upset the analogue components - for example, if an amplifier is trying
to handle a signal with an amplitude outside the supply range then it'll
clip.  But sometimes that approach does work and it does get used.

For resume we're pretty much taking care of it already by moving the
resume out of the main device resume and using ALSA-specific stuff to
keep audio streams stopped until we're done but for suspend we don't
know the system is going down until the suspend starts and we do want to
make sure we got the analogue into a known poweroff state so that we can
control powerup properly.
