From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Drivers taking different actions depending on sleep state
Date: Fri, 9 Jun 2017 23:30:49 +0200
Message-ID: <20170609213049.GA28596@amd>
References: <9dc7b7f4-e47d-59f3-3b51-52e0aefd2487@free.fr>
 <0181d683-511e-1ff6-3855-e00849863e74@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49928 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdFIVav (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2017 17:30:51 -0400
Content-Disposition: inline
In-Reply-To: <0181d683-511e-1ff6-3855-e00849863e74@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-06-09 18:27:45, Mason wrote:
> On 09/06/2017 17:20, Mason wrote:
>=20
> > Currently my platform's "mem" is a true suspend-to-RAM trigger,
> > where drivers are supposed to save their state (register values
> > will be lost), then Linux hands control over to firmware which
> > enables RAM self-refresh and powers the chip down. When the system
> > resumes, drivers restore their state from their copy in memory.
> >=20
> > One driver is responsible for loading/unloading microcode running
> > on the DSPs. This operation is required only when powering down
> > the chip, but it should be avoided for "low-latency" sleeps.
> >=20
> > The problem is that, if I understand correctly, drivers have no way
> > of knowing which sleep state is being entered/exited?
> >=20
> > How can I have the microcode driver take different decisions
> > based on the sleep state?
>=20
> FWIW, here's a transcript of a parallel discussion on #armlinux


Well... question "does my chip lose state during standby/mem on _this_
machine" is more complex then "is it standby or mem", right?

You should really ask the regulator framework, not core code.

> Mason385	javier__: there's some authentication required when S2R is invol=
ved (from the firmware)
> javier__	Mason385: ah, Ok. I just asked because if it was the latter, the=
 regulator subsystem has infrastructure to keep the regulators on during S2R
> Mason385	javier__: OK so there's two issues. We are required to
> re-authenticate microcode when resuming from S2R (because someone
> "may" have tampered with the contents) and on suspend, power is cut
> to the DSPs and they lose context

I'm not sure what you are developing. Someone also "may" have modified
the microcode while you were running. Someone also "may" have modified
the kernel in RAM. Not sure what you are developing, but protecting
against attacker with direct hardware access is impossible and not
welcome.

Best regards,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlk7E4kACgkQMOfwapXb+vJm6QCgomerJXbfs2mwiwojNsqA9AYW
h8oAn0nc+dL/zhgMTBjyfpAGeoySi3hK
=717z
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
