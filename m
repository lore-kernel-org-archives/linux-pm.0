From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 15:01:38 +0100
Message-ID: <20070322140138.GB7693@elf.ucw.cz>
References: <200703221339.l2MDdejg007459@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200703221339.l2MDdejg007459@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> | > Yes, we may just not close a sound device file, but phone
> | > applications I've seen, do close the file.
> | =

> | Fix the app, then.
> ---
> =

> I would normally call designs that expect important functions (like
> power on/power off) to happen as side effects of other operations (like
> opening and closing files) broken to begin with. It's still a bad idea
> to hide policy inside the driver.

Then you are welcome to go design your own operating system.

I certinaly do not want open() on powered down /dev/dsp to succeed
with /dev/dsp powered down.

> There's nothing contrived or corner-case-ish about cyclic operations in
> a world where media players, animations, etc., are utterly
> commonplace.

Yep? And you close your sound device between those?

> And latency may be ignorable in a laptop environment, but it absolutely
> isn't in embedded devices, which users expect to operate immediately, as
> though they were gear-driven rather than computer-driven.

What latency are you talking about? Powering up piece of hw takes one
milisecond or something. If your /dev/dsp takes 3 seconds to power up,
you probably need userspace policy daemon. But that is not the case,
hw takes few miliseconds to wake up.
								Pavel
				thinking about "don't feed the Trolls" label
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
