From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 6/7] cpufreq: intel_pstate: Trivial code cleanup
Date: Wed, 11 Jun 2014 02:24:25 +0200
Message-ID: <5053297.QO4RhmD3mT@vostro.rjw.lan>
References: <5396208F.6070400@semaphore.gr> <1894836.tjrHdJ7Duz@vostro.rjw.lan> <53977A1D.9010202@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54698 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752087AbaFKAHB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 20:07:01 -0400
In-Reply-To: <53977A1D.9010202@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, dirk.j.brandewie@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wednesday, June 11, 2014 12:35:25 AM Stratos Karafotis wrote:
> On 11/06/2014 12:38 =CF=80=CE=BC, Rafael J. Wysocki wrote:
> > On Wednesday, June 11, 2014 12:02:09 AM Stratos Karafotis wrote:
> >> On 10/06/2014 11:43 =CE=BC=CE=BC, Rafael J. Wysocki wrote:
> >>> On Tuesday, June 10, 2014 11:14:53 PM Stratos Karafotis wrote:
> >>>> On 10/06/2014 11:17 =CE=BC=CE=BC, Rafael J. Wysocki wrote:
> >>>>> On Tuesday, June 10, 2014 10:26:44 AM Dirk Brandewie wrote:
> >>>>>> On 06/10/2014 08:31 AM, Rafael J. Wysocki wrote:
> >>>>>>> On Tuesday, June 10, 2014 08:12:48 AM Dirk Brandewie wrote:
> >>>>>>>> On 06/09/2014 02:01 PM, Stratos Karafotis wrote:
> >>>>>>>>> Remove unnecessary blank lines.
> >>>>>>>>> Remove unnecessary parentheses.
> >>>>>>>>> Remove unnecessary braces.
> >>>>>>>>> Put the code in one line where possible.
> >>>>>>>>> Add blank lines after variable declarations.
> >>>>>>>>> Alignment to open parenthesis.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> I don't have an issue with this patch in general but I would=
 rather
> >>>>>>>> the cleanup be done when there is a functional change in the=
 given
> >>>>>>>> hunk of code otherwise you are setting up a fence for stable=
/backporters
> >>>>>>>> of functional changes in the future.
> >>>>>>>
> >>>>>>> I actually prefer separate cleanups so as to avoid doing mult=
iple things
> >>>>>>> in one patch.
> >>>>>>>
> >>>>>>> Rafael
> >>>>>>>
> >>>>>> I don't have strong feelings either way I was just trying to b=
e kind
> >>>>>> to the maintainers of distro kernels.
> >>>>>
> >>>>> And mixing fixes with cleanups in one patch doesn't do any good=
 to them.
> >>>>>
> >>>>> Trust me, I used to work for a distro. :-)
> >>>>>
> >>>>
> >>>> So, should I proceed and split the patch or drop it? :)
> >>>
> >>> I'm not sure why you'd want to split it?
> >>
> >> Forgive me, but I'm totally confused. I asked because you mentione=
d that
> >> you prefer separate cleanups.
> >=20
> > That was in a reply to Dirk who suggested doing cleanups along with
> > fixes (or at least I understood what he said this way).
> >=20
> > I tried to explain why I didn't think that this was a good idea.
> >=20
> >> So, my question was if you want me to separate this patch into mor=
e (one
> >> per change) or entirely drop it (because it would cause problems t=
o backporters
> >> or maintainers).
> >=20
> > Cleanups are generally OK, but it's better to do one kind of a clea=
nup
> > per patch.  Like whitespace fixes in one patch, cleanup of expressi=
ons in
> > another.
> >=20
>=20
> OK, thanks for the clarification! I will do it in separate patches.
>=20
> >>
> >>> That said you're changing things that are intentional.  For examp=
le,
> >>> the
> >>>
> >>> 	if (acpi_disabled
> >>> 	    || ...)
> >>>
> >>> is.  And the result of (a * 100) / b may generally be different f=
rom
> >>> a * 100 / b for integers (if the division is carried out first).
> >>
> >> I thought that (a * 100) / b is always equivalent to a * 100 / b.
> >=20
> > I'm not actually sure if that's guaranteed by C standards.  It sure=
ly
> > wasn't some time ago (when there was no formal C standard).
> >
>=20
> I think it is, according to C precedence table.
> But, anyway my motivation to the specific cleanup was the different s=
tyle
> in the same block code:
>=20
>         limits.min_perf_pct =3D (policy->min * 100) / policy->cpuinfo=
=2Emax_freq;
> 	...
>         limits.max_policy_pct =3D policy->max * 100 / policy->cpuinfo=
=2Emax_freq;

Yes, it's better to make them consistent, but perhaps the other way aro=
und? :-)

Rafael

