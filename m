From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Tue, 29 Aug 2006 16:34:56 +0000
Message-ID: <20060829163455.GA4821@ucw.cz>
References: <221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
	<b324b5ad0608182319y307210a3w6389c83482e43ab8@mail.gmail.com>
	<20060819184843.GB15644@redhat.com>
	<b324b5ad0608192020n6584f749h501e05e141b1f557@mail.gmail.com>
	<20060820033044.GA24928@redhat.com>
	<b324b5ad0608262137y24cfb843kb03476a22e462516@mail.gmail.com>
	<20060827154151.GA4158@ucw.cz>
	<b324b5ad0608290855h19a12a86ucfd831fcd9bab498@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <b324b5ad0608290855h19a12a86ucfd831fcd9bab498@mail.gmail.com>
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

Hi!
> >>         point, by name. There is a new =

> >/sys/power/operating_points directory
> >>         that shows all the operating points the =

> >system supports. An
> >>         exampled from my centrino laptop shows:
> >>
> >>         /sys/power/operating_points/high
> >>         /sys/power/operating_points/highest
> >>         /sys/power/operating_points/low
> >>         /sys/power/operating_points/lowest
> >>         /sys/power/operating_points/medium
> >>         /sys/power/operating_points/mem
> >>         /sys/power/operating_points/standby
> >
> >What makes you think that mixing operating and sleep =

> >states is good
> >idea?
> =

> They are all power states managed by the kernel and in =

> the operating
> point concept they are all operating points the system =

> supports.

That does not make mixing them right.

> The system can be set to any of the supported states by
> setting their name in the /sys/power/state file.  I find =

> simplicity
> is usually a good thing.

I believe the quote is 'make it as simple as possible but not
simpler'.

> >And '600MHz' makes lot more sense than 'lowest' on =

> >centrino.
> =

> Perhaps, but the common name space makes it easy for the =

> power manager
> daemon to perform the same functions without having to =

> know that the lowest
> speed on my laptop is 600Mhz.

And enumerate english strings in power daemon? Limiting the numver of
states?

> >
> >>         /sys/power/operating_points/high/frequency
> >>         /sys/power/operating_points/high/voltage
> >>         /sys/power/operating_points/high/latency
> >
> >What is voltage for 'mem'?
> =

> I don't know what the voltage or latency is for mem.  =

> Perhaps Intel could better
> say what the voltage is in the suspend state and what =

> the latency was
> for transistion to that state.  I didn't have the data =

> available when
> I wrote the code.

And you will not have data available even if intel helps you. What is
_frequency_ for mem? These fields are meaningless for sleep states;
that should tell you that mixing sleep and operating states is bad
idea.

-- =

Thanks for all the (sleeping) penguins.
