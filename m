From: Francisco Jerez <currojerez@riseup.net>
Subject: Re: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
Date: Tue, 11 Sep 2018 10:35:15 -0700
Message-ID: <87in3c7x9o.fsf@riseup.net>
References: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com> <8c56f28c2cc11de37fa3517348559eb040894702.camel@linux.intel.com> <87in3j9s07.fsf@riseup.net> <23293649.J1qzPCXian@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <23293649.J1qzPCXian@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Eero Tamminen <eero.t.tamminen@intel.com>, lenb@kernel.org, viresh.kumar@linaro.org, mgorman@techsingularity.net, ggherdovich@suse.cz, peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Thursday, September 6, 2018 6:20:08 AM CEST Francisco Jerez wrote:
>>=20
>> --=3D=3D-=3D-=3D
>> Content-Type: multipart/mixed; boundary=3D"=3D-=3D-=3D"
>>=20
>> --=3D-=3D-=3D
>> Content-Type: text/plain; charset=3Dutf-8
>> Content-Disposition: inline
>> Content-Transfer-Encoding: quoted-printable
>>=20
>> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
>>=20
>> > [...]
>> >
>> >> > >=3D20
>> >> > > This patch causes a number of statistically significant
>> >> > > regressions
>> >> > > (with significance of 1%) on the two systems I've tested it
>> >> > > on.  On
>> >> > > my
>> >> >=3D20
>> >> > Sure. These patches are targeted to Atom clients where some of
>> >> > these
>> >> > server like workload may have some minor regression on few watts
>> >> > TDP
>> >> > parts.
>> >>=3D20
>> >> Neither the 36% regression of fs-mark, the 21% regression of sqlite,
>> >> nor
>> >> the 10% regression of warsaw qualify as small.  And most of the test
>> >> cases on the list of regressions aren't exclusively server-like, if
>> >> at
>> >> all.  Warsaw, gtkperf, jxrendermark and lightsmark are all graphics
>> >> benchmarks -- Latency is as important if not more for interactive
>> >> workloads than it is for server workloads.  In the case of a conflict
>> >> like the one we're dealing with right now between optimizing for
>> >> throughput (e.g. for the maximum number of requests per second) and
>> >> optimizing for latency (e.g. for the minimum request duration), you
>> >> are
>> >> more likely to be concerned about the former than about the latter in
>> >> a
>> >> server setup.
>> >
>> > Eero,
>> > Please add your test results here.
>> >
>> > No matter which algorithm you do, there will be variations. So you have
>> > to look at the platforms which you are targeting. For this platform=3D=
20
>> > number one item is use of less turbo and hope you know why?
>>=20
>> Unfortunately the current controller uses turbo frequently on Atoms for
>> TDP-limited graphics workloads regardless of IOWAIT boosting.  IOWAIT
>> boosting simply exacerbated the pre-existing energy efficiency problem.
>
> My current understanding of the issue at hand is that using IOWAIT boosti=
ng
> on Atoms is a regression relative to the previous behavior.

Not universally.  IOWAIT boosting helps under roughly the same
conditions on Atom as it does on big core, so applying this patch will
necessarily cause regressions too (see my reply from Sep. 3 for some
numbers), and won't completely restore the previous behavior since it
simply decreases the degree of IOWAIT boosting applied without being
able to avoid it (c.f. the series I'm working on that does something
similar to IOWAIT boosting when it's able to determine it's actually
CPU-bound, which prevents energy inefficient behavior for non-CPU-bound
workloads that don't benefit from a higher CPU clock frequency anyway).

> That is what Srinivas is trying to address here AFAICS.
>
> Now, you seem to be saying that the overall behavior is suboptimal and the
> IOWAIT boosting doesn't matter that much,

I was just saying that IOWAIT boosting is less than half of the energy
efficiency problem, and this patch only partially addresses that half of
the problem.

> so some deeper changes are needed anyway.  That may be the case, but
> if there is a meaningful regression, we should first get back to the
> point where it is not present and then to take care of the more
> general problems.
>
> So, I'd like to understand how much of a problem the IOWAIT boosting real=
ly is
> in the first place.  If it is significant enough, let's address it first,=
 this
> way or another, and move on to the other problems subsequently.
>

See the Unigine and Gfxbench numbers I provided in my reply from Sep. 3
to get an idea of the magnitude of the IOWAIT boosting problem vs. the
overall energy efficiency problem addressed by my series.

> Thanks,
> Rafael

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCW5f80wAKCRCDmTidfVK/
W8S4AP0cnxEpgO73ANrB1TmDP62h0lKLBOPwKFBvHNZfawNlRAD+KZvQAzXBlHCI
bMismxrY5c/lDO5IqBHRQ7fssIcRLkk=
=HDCK
-----END PGP SIGNATURE-----
--==-=-=--
