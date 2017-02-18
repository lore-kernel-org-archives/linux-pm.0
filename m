From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][RFC v4] ACPI throttling: Disable the MSR T-state if
 enabled after resumed
Date: Sat, 18 Feb 2017 10:02:07 +0100
Message-ID: <20170218090207.GB8937@amd>
References: <1487320050-22894-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487320050-22894-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-02-17 16:27:30, Chen Yu wrote:
> Previously a bug was reported that on certain Broadwell
> platform, after resumed from S3, the CPU is running at
> an anomalously low speed, due to the BIOS has enabled the
> MSR throttling across S3. The solution to this was to introduce
> a quirk framework to save/restore tstate MSR register around
> suspend/resume, in Commit 7a9c2dd08ead ("x86/pm:
> Introduce quirk framework to save/restore extra MSR
> registers around suspend/resume").
>=20
> However there are still three problems left:
> 1. More and more reports show that other platforms also
>    encountered the same issue, so the quirk list might
>    be endless.
> 2. Each CPUs should take the save/restore operation into
>    consideration, rather than the boot CPU alone.
> 3. Normally ACPI T-state re-evaluation is done on resume,
>    however there is no _TSS on the bogus platform, thus
>    above re-evaluation code does not run on that machine.
>=20
> Solution:
> This patch is based on the fact that, we generally should not
> expect the system to come back from resume with throttling
> enabled, but leverage the OS components to deal with it,
> such as thermal event. So we simply clear the MSR T-state
> and print the warning if it is found to be enabled after
> resumed back. Besides, we can remove the quirk in previous patch
> later.

What if the machine _is_ hot?=20

> +static int acpi_throttling_init_ops(void)
> +{
> +	/*
> +	 * Reevaluate on boot CPU. Since it is not always CPU0,
> +	 * we can not invoke throttling_msr_reevaluate(0) directly.
> +	 */

Boot cpu is not cpu#0? How can that be?

Should we introduce generic framework to "fix" all the cpus? Actually,
should this be done right on cpu hotplug?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlioDY8ACgkQMOfwapXb+vK0zwCgmNYBCYnuyrmqRUuh/zOG2Zbk
96IAn1V5osZHJNk91ZbdtZVUB2U0V05A
=6NOW
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
