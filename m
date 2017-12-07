From: James Hogan <james.hogan@mips.com>
Subject: Re: [RFC PATCH] cpuidle/coupled: Handle broadcast enter failures
Date: Thu, 7 Dec 2017 11:47:07 +0000
Message-ID: <20171207114706.GO5027@jhogan-linux.mipstec.com>
References: <20171205225536.21516-1-james.hogan@mips.com>
 <d74c6e8b-3020-6bed-4cf1-132f41a2c5ff@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vru7fAags9pVPvn5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d74c6e8b-3020-6bed-4cf1-132f41a2c5ff@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-pm@vger.kernel.org

--vru7fAags9pVPvn5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 12:17:25PM +0100, Daniel Lezcano wrote:
> On 05/12/2017 23:55, James Hogan wrote:
> > From: James Hogan <jhogan@kernel.org>
> >=20
> > If the hrtimer based broadcast tick device is in use, the enabling of
> > broadcast ticks by cpuidle may fail when the next broadcast event is
> > brought forward to match the next event due on the local tick device,
> > This is because setting the next event may migrate the hrtimer based
> > broadcast tick to the current CPU, which then makes
> > broadcast_needs_cpu() fail.
> >=20
> > This isn't normally a problem as cpuidle handles it by falling back to
> > the deepest idle state not needing broadcast ticks, however when coupled
> > cpuidle is used it can happen after the coupled CPUs have all agreed on
> > a particular idle state, resulting in only one of the CPUs falling back
> > to a shallower state, and an attempt to couple two completely different
> > idle states which may not be safe.
> >=20
> > Therefore extend cpuidle_enter_state_coupled() to be able to handle the
> > enabling of broadcast ticks directly, so that a failure can be detected
> > at the higher level, and all coupled CPUs can be made to fall back to
> > the same idle state.
> >=20
> > This takes place after the idle state has been initially agreed. Each
> > CPU will then attempt to enable broadcast ticks (if necessary), and upon
> > failure it will update the requested_state[] array before a second
> > coupled parallel barrier so that all coupled CPUs can recognise the
> > change.
> >=20
> > Signed-off-by: James Hogan <jhogan@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mips@linux-mips.org
> > ---
> > Is this an acceptable approach in principle?
> >=20
> > Better/cleaner ideas to handle this are most welcome.
> >=20
> > This doesn't directly address the problem that some of the time it won't
> > be possible to enter deeper idle states because of the hrtimer based
> > broadcast tick's affinity. The actual case I'm looking at is on MIPS
> > with cpuidle-cps, where the first core cannot (currently) go into a deep
> > idle state requiring broadcast ticks, so it'd be nice if the hrtimer
> > based broadcast tick device could just stay on core 0.
> > ---
>=20
> Before commenting this patch, I would like to understand why the couple
> idle state is needed for the MIPS, what in the architecture forces the
> usage of the couple idle state?

Hardware multithreading.

Each physical core may have more than one hardware thread (VPE or VP in
MIPS lingo), each of which appears as a separate CPU to Linux. The lower
power states are all effective at the core level though:
- non-coherent wait - the hardware threads share physical caches, so
  coherency can only be turned off when all hardware threads are in a
  safe state, else they (1) wouldn't be coherent with the rest of the
  system and (2) could bring stuff into the cache which isn't kept
  coherent, requiring I presume a second cache flush.
- clock gated - must go non-coherent first, and applies to the whole
  core and all the physical resources shared by the VP(E)s.
- power gated - again must go non-coherent first, and applies to the
  whole core and all the physical resources shared by the VP(E)s.

>=20
> The hrtimer broadcast mechanism is only needed if there isn't a backup
> timer outside of the idle state's power domain. That's the case on this
> platform?

I believe there is an external timer, and I believe we recommend
customers implement one for use as a clocksource anyway (in case of
frequency scaling), but on this particular platform the driver isn't
upstream yet.

If its something that shouldn't be supported in Linux, perhaps a simple
WARN_ON is the better approach (i.e. if the broadcast tick can't be
enabled in the current place and its a coupled idle state), though it
does at least seem to work now with this and a couple of other patches
(though I haven't been able to take any power measurements yet).

Cheers
James

--vru7fAags9pVPvn5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlopKjoACgkQbAtpk944
dnqwRhAAjk16USLKx3/U7l6dZt4h2Y0mp9tW5VLySaKqMrdFlU0sPWG6ufOYh0gW
xnDj3gkpgVYDG/RZZzmtZR2RALr9RGvV5KhKVys4Mz3nKt6Pol9GqFbVsknX0xFe
CneWKksNZdkPNMMvj2B1tp8Wzv+D/aYBDscbgawObfpISMFBEn+6JqzJcT9RG87M
0yx+f5dit2Oyc89uXRyr1dEwQJZ8i00ZiCOdsIPF53ziZkI9YhCjWoV6bfS94P/r
lMCLXAka2cvFRwMAxAeMPYR7pm0B/6JTJQFsIouqW7867CAy8Yy0O4bdr+66wcQ4
npxBtNhfVfR49ahutrsIVa8cf6wOaHKt3GFq87KIExcICqk94imbmywlbNsRyXjY
X7VYdO80oovHxJ78kUUtIKw958L7tplvQ07VBQr6XOSaCx048V7XmJCnZB/p2NT2
fI2oR/EOcI1WvSaGqkvOC0oE693QXXV+9TdGte8Clsyin6NOoG+mhEu5/1rlNn71
7y30bKoUBO8DOnMy7w+NSGMSiJ7Ol7tpDnz7/fywrvFUSK1JmiUd1KGgGAkhGC2o
TYTvYjaLOH5Cd8ha3Imc11TRWdPl4QHMOqP4i4jDQoR0v0U9HEyKKTjzRR4n38ve
/C0m4ufH2IQnTGignbHOH18t+qGfvDfWANoNUrv/nRwog4WkOps=
=//1w
-----END PGP SIGNATURE-----

--vru7fAags9pVPvn5--
