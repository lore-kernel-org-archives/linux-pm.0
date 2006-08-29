From: "David Singleton" <daviado@gmail.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Tue, 29 Aug 2006 08:55:30 -0700
Message-ID: <b324b5ad0608290855h19a12a86ucfd831fcd9bab498@mail.gmail.com>
References: <c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com> <20060815010020.GA14251@kroah.com>
	<b324b5ad0608182319y307210a3w6389c83482e43ab8@mail.gmail.com>
	<20060819184843.GB15644@redhat.com>
	<b324b5ad0608192020n6584f749h501e05e141b1f557@mail.gmail.com>
	<20060820033044.GA24928@redhat.com>
	<b324b5ad0608262137y24cfb843kb03476a22e462516@mail.gmail.com>
	<20060827154151.GA4158@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060827154151.GA4158@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On 8/27/06, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> > > The other alternative as suggested earlier this week would be archict=
ures
> > > getting to 'opt out' of powerop for their cpufreq drivers where it do=
esn't
> > > necessarily bring anything but the layer of indirection.
> > >
> > > I'm about to disappear for two weeks for a much needed vacation, but
> > > I'll be interested to see other folks comments/opinions on this
> > > when I get back.
> >
> >         This week I got some really good feedback and suggestions
> >         from Mark Gross on the kernel interface and usability and
> >         I have two new additions for this patch set.  So I spend the we=
ek
> >         working on a well thought out kernel interface.
> >
> >         1) I believe I now have the right kernel interface for a common
> >         power management infrastructure.
> >
> >         The new kernel interface still uses /sys/power/state to both
> >         show the current operating point and set a desired operating
> >         point, by name. There is a new /sys/power/operating_points dire=
ctory
> >         that shows all the operating points the system supports. An
> >         exampled from my centrino laptop shows:
> >
> >         /sys/power/operating_points/high
> >         /sys/power/operating_points/highest
> >         /sys/power/operating_points/low
> >         /sys/power/operating_points/lowest
> >         /sys/power/operating_points/medium
> >         /sys/power/operating_points/mem
> >         /sys/power/operating_points/standby
>
> What makes you think that mixing operating and sleep states is good
> idea?

They are all power states managed by the kernel and in the operating
point concept they are all operating points the system supports.

The system can be set to any of the supported states by
setting their name in the /sys/power/state file.  I find simplicity
is usually a good thing.

>
> And '600MHz' makes lot more sense than 'lowest' on centrino.

Perhaps, but the common name space makes it easy for the power manager
daemon to perform the same functions without having to know that the lowest
speed on my laptop is 600Mhz.

I have the same power manager running on my laptop as on my ARM pxa27x
board and it's performing the same operations, even though there are differ=
ent
frequencies behind the name "lowest".

The frequency is available in the
/sys/power/operating_points/lowest/frequency file,
which the power manager reads when it starts up.

>
> >         /sys/power/operating_points/high/frequency
> >         /sys/power/operating_points/high/voltage
> >         /sys/power/operating_points/high/latency
>
> What is voltage for 'mem'?

I don't know what the voltage or latency is for mem.  Perhaps Intel could b=
etter
say what the voltage is in the suspend state and what the latency was
for transistion to that state.  I didn't have the data available when
I wrote the code.


>
> >         I've finally had a bit of time to get the sysfs one file - one
> >         value system in place for OpPoint.
> >
> >         2) The really good news is there is a now a power manager for
> > OpPoint now,
> >         both in rpm and src rpm form.  And since the new power manager =
runs off
> >         the new kernel interface and actually does what the cpuspeed da=
emon does
> >         I think the kernel interface is sound.
> >
> >         I took the cpuspeed power manager daemon, version 1.2.1, and mo=
dified
> >         it Friday to use the oppoint interface. It supports all the
> >         options the cpuspeed daemon does, (and can actually still be co=
mpiled to
> >         be the original cpuspeed daemon) it just uses the interface
> >         described above instead of the cpufreq interfaces.
>
> Congratulations, you now have inferior version of cpufreq ondemand
> governor.

Perhaps inferior, but definitely simpler, and its outside of the kernel.

And it's able to also work on a wider range of system power states
than just scaling
frequency.  The PXA27x controls a lot more clock state than a centino
or powernow
system.  The next set of  systems I'm working on have separate power
domains that
are individually controllable out side of the processor speed and they
fit nicely within
the same framework and can work with the same power manager daemon.

A single power management infrastructure for the kernel would not be an inf=
erior
nor a bad thing.

David


>                                                 Pavel
> --
> Thanks for all the (sleeping) penguins.
>
