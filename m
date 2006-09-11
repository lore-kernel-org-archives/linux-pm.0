From: Pavel Machek <pavel@ucw.cz>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 21:36:37 +0200
Message-ID: <20060911193637.GA11901@elf.ucw.cz>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<450530BD.8090101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <450530BD.8090101@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, scott.preece@motorola.com
List-Id: linux-pm@vger.kernel.org

Hi!

> >>>>Are you arguing that the cpufreq interface be morphed to support power
> >>>>op applications?
> >>>No. I'm arguing that
> >>>
> >>>* cpufreq interface should be used for changing cpu frequency
> >>the patch set i sent out has cpufreq used for changing cpu frequency,
> >>hasn't it?
> >
> >I was talking about kernel<->user interface.
> me too. PowerOP is inkernel interface but which _allows_ to build various
> different kernel<->user interfaces on top of it. This PowerOP _advantage_ =

> allows community to experiment with various kernel<->user interfaces
>on top =


Kernel interface is not something to be experimented with.

> and eventually end up with the best solution. The solution can be either =

> one universal, agreed by community kernel<-> user interface on top or I c=
an =

> imaging the approach when kernel<-> user interfaces on top are configurab=
le =

> feature and system designer choses kernel<->user interface which fits bes=
t =

> the systems he/she builds.

...and configurable kernel interfaces are very bad idea.

> >You did echo low > something to change CPU frequency, IIRC.
> My patch set presents two different interfaces built on top of PowerOP - =

> cpufreq and sysfs interfaces. So _no_, PowerOP is not all about

Okay, drop sysfs interface, and we may have something that can be
reviewed.

Actually that's good idea. Submit powerop without doing _any_ kernel
interface changes, so we can see that it makes sense...

> embedded - chose sysfs interface. But with the approach when everything i=
s =

> built on top PowerOP[PM Core, Clock framework] you just eliminate all =

> unnecessary duplication if PM functionality in PM  stack.

...bonus points if your submission actually deletes more code than it
adds.

> >Oh and it would be nice to cc
> >lkml on that document, too. New kernel<->user interface is not
> >decision taken lightly.
> PowerOP Core and PowerOP/cpufreq integration patch sets present two clear =

> and configurable kernel<->user interfaces. I personally feel that =

> interfaces configuration feature allows graceful interface discussion and =

> possibility to get a decision smoothly instead of a flame on a
>list. =


Your code should be good enough to survive some flaming. I do not
think it is, so yes, I think submitting it to lkml is good
idea. You'll have to do that at some point, anyway.

(And note lkml only flames you when you are doing something wrong.)

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
