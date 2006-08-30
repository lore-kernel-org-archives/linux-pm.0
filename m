From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 31 Aug 2006 00:43:52 +0200
Message-ID: <20060830224352.GF3923@elf.ucw.cz>
References: <20060815010020.GA14251@kroah.com>
	<b324b5ad0608182319y307210a3w6389c83482e43ab8@mail.gmail.com>
	<20060819184843.GB15644@redhat.com>
	<b324b5ad0608192020n6584f749h501e05e141b1f557@mail.gmail.com>
	<20060820033044.GA24928@redhat.com>
	<b324b5ad0608262137y24cfb843kb03476a22e462516@mail.gmail.com>
	<20060827154151.GA4158@ucw.cz>
	<b324b5ad0608290855h19a12a86ucfd831fcd9bab498@mail.gmail.com>
	<20060829163455.GA4821@ucw.cz>
	<b324b5ad0608292152s72a8f428wf45e9d4881bb3b5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <b324b5ad0608292152s72a8f428wf45e9d4881bb3b5d@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue 2006-08-29 21:52:26, David Singleton wrote:
> On 8/29/06, Pavel Machek <pavel@ucw.cz> wrote:
> >Hi!

> >> >>         /sys/power/operating_points/high
> >> >>         /sys/power/operating_points/highest
> >> >>         /sys/power/operating_points/low
> >> >>         /sys/power/operating_points/lowest
> >> >>         /sys/power/operating_points/medium
> >> >>         /sys/power/operating_points/mem
> >> >>         /sys/power/operating_points/standby
....
> >That does not make mixing them right.
> =

> Both OpPoint and PowerOp are going to 'mix' frequency, voltage
> and sleep states into their operating point concepts.
> =

> The point was not to make it look like I was mixing sleep states and
> CPU frequency states, but to present all the power states
> supported by the system in one place and with one interface.  It simplifi=
es
> not only kernel code, but power manager code as well.

It is also wrong. And no, I do not think your power manager can
properly use "mem" state.

You see, "mem" is very different from lowest. To exit lowest, you have
to "echo highest > state". To exit "mem", you need power
button. That's very different operation.

> >> Perhaps, but the common name space makes it easy for the
> >> power manager
> >> daemon to perform the same functions without having to
> >> know that the lowest
> >> speed on my laptop is 600Mhz.
> >
> >And enumerate english strings in power daemon? Limiting the numver of
> >states?
> =

> Hah,  I didn't think of it that way.   I was thinking in the same way
> "mem" and "disk" and "standy" are strings in the kernel.

> The names themselves don't mean anything other than to imply an order so =
the
> kernel and power manager can understand the same order.

mem/disk/standby are strings, because they can not be easily turned
into numbers. "low"/"lowest"/"high"/"highest" mess can easily be
turned into numbers. And that's what cpufreq does, btw.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
