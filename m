From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [RFC V2 1/6] cpufreq: Replace "max_transition_latency" with
 "dynamic_switching"
Date: Sat, 15 Jul 2017 07:08:28 +0200
Message-ID: <20170715050828.GA9760@light.dominikbrodowski.net>
References: <cover.1499853492.git.viresh.kumar@linaro.org>
 <20170714070142.GA14515@isilmar-4.linta.de>
 <CAJZ5v0hagTXFmV94abxeEL5=dPn0FQtW7SogyK6iJd6ika+GUQ@mail.gmail.com>
 <2309380.IRBF8BkiFH@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:51686 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbdGOFOZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Jul 2017 01:14:25 -0400
Content-Disposition: inline
In-Reply-To: <2309380.IRBF8BkiFH@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 15, 2017 at 12:06:24AM +0200, Rafael J. Wysocki wrote:
> On Friday, July 14, 2017 01:11:58 PM Rafael J. Wysocki wrote:
> > On Fri, Jul 14, 2017 at 9:01 AM, Dominik Brodowski
> > <linux@dominikbrodowski.net> wrote:
> > > On Thu, Jul 13, 2017 at 06:19:53PM +0200, Rafael J. Wysocki wrote:
> > >> On Thu, Jul 13, 2017 at 7:40 AM, Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
> > >> > There is no limitation in the ondemand or conservative governors w=
hich
> > >> > disallow the transition_latency to be greater than 10 ms.
> > >> >
> > >> > The max_transition_latency field is rather used to disallow automa=
tic
> > >> > dynamic frequency switching for platforms which didn't wanted these
> > >> > governors to run.
> > >> >
> > >> > Replace max_transition_latency with a boolean (dynamic_switching) =
and
> > >> > check for transition_latency =3D=3D CPUFREQ_ETERNAL along with tha=
t. This
> > >> > makes it pretty straight forward to read/understand now.
> > >>
> > >> Well, using CPUFREQ_ETERNAL for that on the driver side is still not
> > >> particularly straightforward IMO, so maybe add a
> > >> "no_dynamic_switching" to the driver structure and set it to "true"
> > >> for the one driver in question?
> > >
> > > IIRC it's not just one driver which sets the latency to CPUFREQ_ETERN=
AL, and
> > > where dynamic switching might be harmful or at least lead to undefined
> > > behavior.
> >=20
> > OK
> >=20
> > Still, though, using CPUFREQ_ETERNAL to indicate the "no dynamic
> > switching" condition is somewhat convoluted, so why don't we have a
> > flag to *explicitly* say that instead?
> >=20
> > Do you know which drivers they are or is it just all drivers that use
> > CPUFREQ_ETERNAL?
>=20
> Well, after the $subject patch it effectively is all drivers that use
> CPUFREQ_ETERNAL anyway, so it looks like we actually can do a complete
> switch-over.

Exactly. But lets take a quick look at the drivers ussing CPUFREQ_ETERNAL:

Using CPUFREQ_ETERNAL, as policy-setting drivers:

- intel_pstate.c - for the intel_pstate driver, which defers to the hardware
  to do frequency selection.

- longrun.c - hardware-based frequency selection.

=3D> Those drivers are not interested in kernel-based dynamic frequency
selection anyway.


Using CPUFREQ_ETERNAL as a fallback if transition_latency is unknown:
- arm_big_little.c
- arm_big_little_dt.c
- cpufreq-dt.c
- imx6q-cpufreq.c
- spear_cpufreq.c

=3D> As it seems to be an error case, it seems best to bail out on the
safe side and disallow dynamic frequency scaling. Platform experts might
know better, though.


Using CPUFREQ_ETERNAL unconditionally:
- cpufreq-nforce2.c - over a decade old driver; has a commented-out hack
  to mdelay(10ms) after each frequency transition. This smells like it might
  be unsafe to do dynamic switching more often than that.

- elanfreq.c - Has udelay(1ms+10ms) in transition path, so the same terms
  and conditions seem to apply.

- gx-suspmod.c - works by a mechanism which reminds me of CPU frequency
  throttling, but chipset- and not CPU-based.

- pmac32-cpufreq.c - for some models, it sets latency to ETERNAL. In some
  frequency switchign code, it has mdelay(10ms) calls.

- speedsstep-smi.c - this case was discussed previously.

=3D> For those drivers, dynamic frequency scaling should not be enabled IMO.


- sa1100-cpufreq.c and
- sa1110-cpufreq.c - If I remember correctly, those drivers were used for
  fast user-space based frequency scaling in the past.=20

=3D> For these two drivers, enabling DFVS might be an option.


- sh-cpufreq.c - looks fast, but I have no clue.

- unicore2-cpufreq.c - same.

=3D> For those drivers, I have no clue. So to be on the safe side, I'd opt =
for
dynamic frequency scaling to be set to off.


To summarize: At first, I'd propose a *complete* switch-over from
CPUFREQ_ETERNAL to setting the flag "no DVFS" you have proposed. Then, one
might discuss with the maintainers of individual drivers/platforms on
whether to relax this rule for a few of those drivers (sa11x0, sh-cpufreq,
unicore2-cpufreq and the drivers using CPUFREQ_ETERNAL as a fallback).

Best,
	Dominik

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmgXaWKgmjrvkPhLCmpdgiUyNow0FAllpo0YACgkQmpdgiUyN
ow26IxAAs4LDfKw6W7TXgqPUwYezv/AD67D+3toHCzfTIs8yFGNkouMcAgi3WGvf
mGjRBsn10AxCN4m94nyx6N4F3GsbyMrjY6ldhv+4RVFYIlA5b1XsqsLmWNkyuTvw
3YvgUWWnPAaEThfLeWWhy1Y6GMOacgmZf0NFnQuaapfH+BSlhb70ipeEH9BewaPV
EVCgGiyHyZbjTpLdL66XVP4JKgGYwiyJZaspArC4thY3+nziI52ipPYYE7xQRLfa
pSHMCJm8xaeyyFgGvNHrSaQvM9z5JktVs+eMAPisRaxp4IGyO3rF4TTHh7UbFmdY
sKSXkdxd+gvxWuJwb+Dh1ISBRO5NB7mX6lNAmAMCb7I0BbH4ieSg/wQlONDRHC3j
w9uFXBNspax3ReKdzERtkSp2s+FYlYpzdK7OrGcTZfkqhhQfHmPtcZPZPUXLbVOv
BffgDO6dH/Hjg+4h2JrD1sUBK9HXLLz5aCnOz0H76dSu6V9c6F2hx0u2hKd0jmG4
x4SbXViBq19vZVxAYS40y2eMiCjvPU9JhwmhrLPbrAFQiMUj7zzhSPVyl6PhfVeD
A0A2bsdwAbVrJbnb9I74VSranFwsbQTYtwdWxcoqD6jO5OiTR/fvyq++BNk6x2p/
qEHSckUxLcFB60itfNWwHbN+ULLA8syKTGedgmp0fNCtLv8qdsw=
=Xzyp
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
