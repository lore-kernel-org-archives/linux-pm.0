From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Fri, 23 Jun 2006 09:31:36 +1000
Message-ID: <1151019097.4046.69.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
	<1150938119.16303.99.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
	<1150952298.3633.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
	<1151014893.4046.24.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221527590.6483@g5.osdl.org>
	<1151017911.4046.55.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221614280.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606221614280.6483@g5.osdl.org>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


> Why? Because if you do it the old way, STR will still happen to work. I'm =

> just giving you a separate phase.
> =

> But you're not interested in facts, are you? Nope.

Oh come on... you know my point, no use in repeating it again and again.
You think I'm wrong, that's your right. I'll continue making sure
powerbooks sleep and wakeup fine with whatever model is in there.
					 and 2- won't
> > help with the actual problems :)
> =

> So you say. Have you actually ever done anything to make debugging easier?

I've implemented suspend/resume for a whole range of machiens where
everything goes down and all I have to debug on resume is ... sending
commands to a chip to blink a LED. So yes, I have. Remember things like
firescope etc ? I've hooks to wakeup the video chip earlier too, I've
done everything that is reasonably possible to make the things
debuggable as much as can be. And guess what ? None of the problems I've
had were ever related to something that would be in save_state. Most of
the problems where the driver being hit by something while asleep
(remember on powerpc I don't freeze processes, so I have a requirement
of being more "correct" than what happens on x86).

> Nope. In the years I've been frustrated with suspend, nobody has ever don=
e =

> anything to this. And now I have to push through changes, just because =

> people think that "status quo" is acceptable.

In fact, most of the problem is resume, not suspend. Most of the time,
the machine goes to sleep... it just doesn't wakeup. From my experience
over the years, the main culprit for that have been

 - USB (anything that bus masters while the memory controller is asleep
will trash your RAM and we had issues with USB being kicked back into
bus mastering (ignoring the command register bus master bit off) after
suspended).

 - USB (again, sorry David) races and deadlocks etc... though most of
these have been fixed by now.

 - CPU cache flush issues (mostly CPU erratas)

 - Video (I've had to reverse engineer the POST code out of the macos
drivers for a range of radeon chips to get them back, that wasn't fun
and had issues for a while), plus problems with X and AGP that are
unrelated to the model

 - cpufreq (this is a design bug with cpufreq with the "core/midlayer"
trying to get in charge instead of the driers and registering a sysdev
which is very wrong).

 - occasional random drivers not properly handling getting a request
from userland after being put to sleep.

The #1 thing that helps for debugging is that hook I added to bring the
video chip back (and thus printk) very very very early (even before I
bring the L2 cache back). This is possible on machines where the video
card is not behind 3 layers of bridges (and even in this case, it's
generally possible to have a small hack that bring those bridges back
early). That's because 99% of the problems happen on resume not sleep.
When a driver crashes during sleep, debugging is easy: just do a fake
sleep (don't actually put the machine to sleep, just run through driver
suspend) and skip the video driver.

> > I've brought a real concern that you'll resume devices in a different
> > state than what was last set at suspend time and change a model that
> > isn't broken.
> =

> And I've explained several times that your concerns aren't problems. You =

> just ignore it.

No, I didn't ignore it. I however beleive that you are wrong and that
they are a problem :) And that the supposed benefit of splitting
save_state doesn't outweight that risk.

Ben.
