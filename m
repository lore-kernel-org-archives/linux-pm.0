From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][RFC v4] ACPI throttling: Disable the MSR T-state if
 enabled after resumed
Date: Tue, 14 Mar 2017 18:38:03 +0100
Message-ID: <20170314173803.GA17126@amd>
References: <1487320050-22894-1-git-send-email-yu.c.chen@intel.com>
 <20170218090207.GB8937@amd>
 <20170219043718.GA4953@yu-desktop-1.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170219043718.GA4953@yu-desktop-1.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > However there are still three problems left:
> > > 1. More and more reports show that other platforms also
> > >    encountered the same issue, so the quirk list might
> > >    be endless.
> > > 2. Each CPUs should take the save/restore operation into
> > >    consideration, rather than the boot CPU alone.
> > > 3. Normally ACPI T-state re-evaluation is done on resume,
> > >    however there is no _TSS on the bogus platform, thus
> > >    above re-evaluation code does not run on that machine.
> > >=20
> > > Solution:
> > > This patch is based on the fact that, we generally should not
> > > expect the system to come back from resume with throttling
> > > enabled, but leverage the OS components to deal with it,
> > > such as thermal event. So we simply clear the MSR T-state
> > > and print the warning if it is found to be enabled after
> > > resumed back. Besides, we can remove the quirk in previous patch
> > > later.
> >=20
> > What if the machine _is_ hot?=20
> >=20
> Later the linux has a chance to adjust the tstate if the system is too ho=
t,
> with the help of thermal framework.

Will it adjust the tstate? Normally, we do such stuff when tresholds
are exceeded. If we are already above the threshold, we'll see no
reason to=20

> But if the cpu is not inside any thermal zone, then there is no way for t=
he
> OS to adjust the tstate after resume, however in this case I think it is =
up
> to the user space to adjust the tstate msr, for example, by using thermald
> daemon to bind the cpu to the thermal zone.

Umm. Userland should not access MSRs. And we certainly should not
depend on userland adjusting the MSRs!

> > Should we introduce generic framework to "fix" all the cpus? Actually,
> > should this be done right on cpu hotplug?
> Do you mean, fix other MSR-inconsistent issues, not only the tstate MSR?
> Currently the tstate re-adjusting is invoked in cpuhotplug notifier
> after each nonboot cpus are brought up:
> acpi_soft_cpu_online -> acpi_processor_reevaluate_tstate -> adjust_tstate=
_msr

Ok.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljIKnsACgkQMOfwapXb+vKrUACfVmvwRCNVAXGOC2wh6J9aOkSM
hRoAn3eME4/Gxrzz2KW3rTpttExgtxps
=uLEd
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
