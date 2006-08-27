From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: PowerOP, Intro 0/3
Date: Sun, 27 Aug 2006 14:34:06 -0700
Message-ID: <c55240ed0608271434u624726eaoed9de52b470c078@mail.gmail.com>
References: <44ECFC0E.10803@gmail.com> <20060826082848.GC8538@elf.ucw.cz>
	<44EF3D6F.3030802@gmail.com> <20060826203841.GA4144@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060826203841.GA4144@ucw.cz>
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
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Pavel,

2006/8/26, Pavel Machek <pavel@ucw.cz>:
> Hi!
>
> > >>PowerOP Core upper layer interface provides the
> > >>following capabilities:
> > >>- to register an operating point by passing an
> > >>idenificator of the point
> > >>represened by a string and arbitrary substet of power
> > >>paremeters available on a
> > >>certain platform by a string (parameter name) and
> > >>value pairs.
> > >>- to unregister operating point by name
> > >>- to set operating point by name
> > >>- to get values of arbitrary subset of platform power
> > >>parameters associated
> > >>this  a point (point is passed by name or NULL to get
> > >>current parameter values
> > >>from hw)
> > >
> > >I do not think this can work in notebook world, sorry.
> > >You'll just get
> > >way too many operating points.
> > The only feature for notebook world currently presented
> > in the kernel is CPUFreq. CPUFreq PowerOP integration
>
> Actually no. In the notebook world, we do cpufreq, selective powerdown
> of devices (/sys/**/power/state), and suspend-to-ram/disk (not sure if
> it applies to you, but at least some powerop versions wanted to
> replace that).
integration with legacy PM kernel code is the next step for PowerOP.
There is no chance to address all in one step. We need to go step by
step.
> > series I sent out for discussion is intended to at least
> > provide the same functionality for notebook world as
> > current functionality is. Did you glance at this series?
>
> Yes.
>
> > </personal> Pavel,
> > please stop removing original recipients from either TO:
> > or CC: lists!
> > please, when you snip original message _do_not_ snip
> > names of replied persons!
> > </end>
>
> Do you have example where I did that?
This thread is example of both: original letter in this thread has 3
recepients while in your first reply there is noone.
And there is no a name of reply originator between your 'Hi' and
'>>>>' signes while for example I have  '2006/8/26, Pavel Machek
<pavel@ucw.cz>' in this reply.

Thanks,
Eugeny
>                                                        Pavel
>
> --
> Thanks for all the (sleeping) penguins.
>
