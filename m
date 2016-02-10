From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] irq_work: unhide irq_work_queue_on declaration on non-SMP
Date: Wed, 10 Feb 2016 18:10:15 +0000
Message-ID: <20160210181015.GA13270@sirena.org.uk>
References: <E1aTQoy-0005cH-Tr@optimist>
 <20160210095252.GS13270@sirena.org.uk>
 <CAJZ5v0iamr-b5h=eS1SWo6WMj_NNOqnXoxnC6R03VmtLBG5dEA@mail.gmail.com>
 <4447865.IoQjlk8ngP@wuerfel>
 <CAJZ5v0h41Xm4LAZB_XiDjZih6g7W5aJjA-t3f=HFo1zGkAPSgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="edESjMboOAwUFn6i"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h41Xm4LAZB_XiDjZih6g7W5aJjA-t3f=HFo1zGkAPSgA@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, kernel-build-reports@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-next@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--edESjMboOAwUFn6i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 10, 2016 at 04:27:42PM +0100, Rafael J. Wysocki wrote:

> > +#else
> > +static inline bool irq_work_queue_on(struct irq_work *work, int cpu)
> > +{
> > +       return irq_work_queue(work);
> > +}
> >  #endif

> I was thinking about this too, but then cpufreq will be the only user of it.

> In any case can do it at any time later. :-)

Well, there's currently only two other users of irq_work_queue_on()
anyway so that's a third of the userbase and it does seem the obvious
way to support any other future users that want to scale down to !SMP
cases painlessly.

Reviwed-by: Mark Brown <broonie@kernel.org>

FWIW.

--edESjMboOAwUFn6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWu30GAAoJECTWi3JdVIfQTugH/Rt57SHLz4sNFbSNFs/v5JOw
p9TF+JsvqvrODqrU0xOXXvrwtneFSw2eNsNFdz4a2NL4bCdnQkFDtoSMSzwialDR
0MZprKb4HAAmUlVvsTN1z2DvMfwGx73SdkQBrHN3lahwugC/v7Ho4S2dPWWREurK
eueeQQgEkXmp31qQhI9LoB30WP+VbUc5K+M42SmUsAEsB6eZ2GnxstC4iQdyjkZN
sHkhcfrHvQ3BbEskAq3btSSXasHwd8NDBzvvnUd4Lf/HimLcX1k+RlOv2meR6u7C
YWCQsW7yUDEH00+IlWGb7MWdUS9fjJjlLnveOlSC5BbjllPSUAy99uSxmKiT4uY=
=z+CZ
-----END PGP SIGNATURE-----

--edESjMboOAwUFn6i--
