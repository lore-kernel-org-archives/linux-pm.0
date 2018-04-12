From: Francisco Jerez <currojerez@riseup.net>
Subject: Re: [PATCH 0/9] GPU-bound energy efficiency
 improvements for the intel_pstate driver.
Date: Thu, 12 Apr 2018 14:38:04 -0700
Message-ID: <87r2nk2jib.fsf@riseup.net>
References: <20180328063845.4884-1-currojerez@riseup.net>
 <87604ybssf.fsf@riseup.net> <1523416474.2700.2.camel@linux.intel.com>
 <87vacx7mh3.fsf@riseup.net> <87muy97lr0.fsf@riseup.net>
 <20180411173558.GL13334@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1157878778=="
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20180411173558.GL13334@localhost.localdomain>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Juri Lelli <juri.lelli@gmail.com>
Cc: Javi Merino <Javi.Merino@arm.com>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, intel-gfx@lists.freedesktop.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Morten Rasmussen <morten.rasmussen@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Eero Tamminen <eero.t.tamminen@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

--===============1157878778==
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Juri Lelli <juri.lelli@gmail.com> writes:

> Hi,
>
> On 11/04/18 09:26, Francisco Jerez wrote:
>> Francisco Jerez <currojerez@riseup.net> writes:
>>=20
>> > Hi Srinivas,
>> >
>> > Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:
>> >
>> >> On Tue, 2018-04-10 at 15:28 -0700, Francisco Jerez wrote:
>> >>> Francisco Jerez <currojerez@riseup.net> writes:
>> >>>=20
>> >> [...]
>> >>
>> >>
>> >>> For the case anyone is wondering what's going on, Srinivas pointed me
>> >>> at
>> >>> a larger idle power usage increase off-list, ultimately caused by the
>> >>> low-latency heuristic as discussed in the paragraph above.=C2=A0=C2=
=A0I have a
>> >>> v2
>> >>> of PATCH 6 that gives the controller a third response curve roughly
>> >>> intermediate between the low-latency and low-power states of this
>> >>> revision, which avoids the energy usage increase while C0 residency
>> >>> is
>> >>> low (e.g. during idle) expected for v1.=C2=A0=C2=A0The low-latency b=
ehavior of
>> >>> this revision is still going to be available based on a heuristic (in
>> >>> particular when a realtime-priority task is scheduled).=C2=A0=C2=A0W=
e're
>> >>> carrying
>> >>> out some additional testing, I'll post the code here eventually.
>> >>
>> >> Please try sched-util governor also. There is a frequency-invariant
>> >> patch, which I can send you (This eventually will be pushed by Peter).
>> >> We want to avoid complexity to intel-pstate for non HWP power sensiti=
ve
>> >> platforms as far as possible.
>> >>
>> >
>> > Unfortunately the schedutil governor (whether frequency invariant or
>> > not) has the exact same energy efficiency issues as the present
>> > intel_pstate non-HWP governor.  Its response is severely underdamped
>> > leading to energy-inefficient behavior for any oscillating non-CPU-bou=
nd
>> > workload.  To exacerbate that problem the frequency is maxed out on
>> > frequent IO waiting just like the current intel_pstate cpu-load
>>=20
>> "just like" here is possibly somewhat unfair to the schedutil governor,
>> admittedly its progressive IOWAIT boosting behavior seems somewhat less
>> wasteful than the intel_pstate non-HWP governor's IOWAIT boosting
>> behavior, but it's still largely unhelpful on IO-bound conditions.
>
> Sorry if I jump in out of the blue, but what you are trying to solve
> looks very similar to what IPA [1] is targeting as well. I might be
> wrong (I'll try to spend more time reviewing your set), but my first
> impression is that we should try to solve similar problems with a more
> general approach that could benefit different sys/archs.
>

Thanks, seems interesting, I've also been taking a look at your
whitepaper and source code.  The problem we've both been trying to solve
is indeed closely related, there may be an opportunity for sharing
efforts both ways.

Correct me if I didn't understand the whole details about your power
allocation code, but IPA seems to be dividing up the available power
budget proportionally to the power requested by the different actors (up
to the point that causes some actor to reach its maximum power) and
configured weights.  From my understanding of the get_requested_power
implementations for cpufreq and devfreq, the requested power attempts to
approximate the current power usage of each device (whether it's
estimated from the current frequency and a capacitance model, from the
get_real_power callback, or other mechanism), which can be far from the
optimal power consumption in cases where the device's governor is
programming a frequency that wildly deviates from the optimal one (as is
the case with the current intel_pstate governor for any IO-bound
workload, which incidentally will suffer the greatest penalty from a
suboptimal power allocation in cases where the IO device is actually an
integrated GPU).

Is there any mechanism in place to prevent the system from stabilizing
at a power allocation that prevents it from achieving maximum
throughput?  E.g. in a TDP-limited system with two devices consuming a
total power of Pmax =3D P0(f0) + P1(f1), with f0 much greater than the
optimal, and f1 capped at a frequency lower than the optimal due to TDP
or thermal constraints, and assuming that the system is bottlenecking at
the second device.  In such a scenario wouldn't IPA distribute power in
a way that roughly approximates the pre-existing suboptimal
distribution?

If that's the case, I understand that it's the responsibility of the
device's (or CPU's) frequency governor to request a frequency which is
reasonably energy-efficient in the first place for the balancer to
function correctly? (That's precisely the goal of this series) -- Which
in addition allows the system to use less power to get the same work
done in cases where the system is not thermally or TDP-limited as a
whole, so the balancing logic wouldn't have any effect at all.

> I'm Cc-ing some Arm folks...
>
> Best,
>
> - Juri
>
> [1] https://developer.arm.com/open-source/intelligent-power-allocation

--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQST8OekYz69PM20/4aDmTidfVK/WwUCWs/RvAAKCRCDmTidfVK/
W/1/AP0fO3vHa85BHc2BLXT9Vv62iro1E0uT8zfbkNtDwjDnMgEAjIdWoApDKJOj
k7qVTmYQlS590KISTkqmNt3aZISBBxI=
=h4+E
-----END PGP SIGNATURE-----
--==-=-=--

--===============1157878778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--===============1157878778==--
