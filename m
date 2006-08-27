From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Sun, 27 Aug 2006 15:41:52 +0000
Message-ID: <20060827154151.GA4158@ucw.cz>
References: <c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
	<b324b5ad0608182319y307210a3w6389c83482e43ab8@mail.gmail.com>
	<20060819184843.GB15644@redhat.com>
	<b324b5ad0608192020n6584f749h501e05e141b1f557@mail.gmail.com>
	<20060820033044.GA24928@redhat.com>
	<b324b5ad0608262137y24cfb843kb03476a22e462516@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <b324b5ad0608262137y24cfb843kb03476a22e462516@mail.gmail.com>
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

> > The other alternative as suggested earlier this week would be archictur=
es
> > getting to 'opt out' of powerop for their cpufreq drivers where it does=
n't
> > necessarily bring anything but the layer of indirection.
> >
> > I'm about to disappear for two weeks for a much needed vacation, but
> > I'll be interested to see other folks comments/opinions on this
> > when I get back.
> =

>         This week I got some really good feedback and suggestions
>         from Mark Gross on the kernel interface and usability and
>         I have two new additions for this patch set.  So I spend the week
>         working on a well thought out kernel interface.
> =

>         1) I believe I now have the right kernel interface for a common
>         power management infrastructure.
> =

>         The new kernel interface still uses /sys/power/state to both
>         show the current operating point and set a desired operating
>         point, by name. There is a new /sys/power/operating_points direct=
ory
>         that shows all the operating points the system supports. An
>         exampled from my centrino laptop shows:
> =

>         /sys/power/operating_points/high
>         /sys/power/operating_points/highest
>         /sys/power/operating_points/low
>         /sys/power/operating_points/lowest
>         /sys/power/operating_points/medium
>         /sys/power/operating_points/mem
>         /sys/power/operating_points/standby

What makes you think that mixing operating and sleep states is good
idea?

And '600MHz' makes lot more sense than 'lowest' on centrino.

>         /sys/power/operating_points/high/frequency
>         /sys/power/operating_points/high/voltage
>         /sys/power/operating_points/high/latency

What is voltage for 'mem'?

>         I've finally had a bit of time to get the sysfs one file - one
>         value system in place for OpPoint.
> =

>         2) The really good news is there is a now a power manager for
> OpPoint now,
>         both in rpm and src rpm form.  And since the new power manager ru=
ns off
>         the new kernel interface and actually does what the cpuspeed daem=
on does
>         I think the kernel interface is sound.
> =

>         I took the cpuspeed power manager daemon, version 1.2.1, and modi=
fied
>         it Friday to use the oppoint interface. It supports all the
>         options the cpuspeed daemon does, (and can actually still be comp=
iled to
>         be the original cpuspeed daemon) it just uses the interface
>         described above instead of the cpufreq interfaces.

Congratulations, you now have inferior version of cpufreq ondemand
governor.
						Pavel
-- =

Thanks for all the (sleeping) penguins.
