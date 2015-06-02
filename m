From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6] Support CPR on MSM8916
Date: Tue, 2 Jun 2015 19:20:59 +0100
Message-ID: <20150602182059.GD14071@sirena.org.uk>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
 <20150602105328.GJ14071@sirena.org.uk>
 <20150602175654.GA24349@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FexDM9E/OpjgUmaq"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150602175654.GA24349@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org


--FexDM9E/OpjgUmaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2015 at 10:56:54AM -0700, Stephen Boyd wrote:
> On 06/02, Mark Brown wrote:

> > These two patches don't seem to be tied to the rest of the series at all
> > (they certainly trigger already for some systems).

> The series causes these warning to trigger on devices with CPR
> and these patches silence them. So it is related, but the patches
> aren't necessary for compilation. They should go through the
> regulator tree, if that's what you're asking.

I wasn't really asking, more saying that they should not have been sent
in the same series, especially not a series listing such a complicated
set of external dependencies.

--FexDM9E/OpjgUmaq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbfQLAAoJECTWi3JdVIfQ6u0H/2oMqMFT2W2mA1UOxtISqtfj
+DI8fHN9PO40LPNb6WTTIU3Idji4yIvWup6iGa8tFA1w5Na/xSaRLEuK/rKyAZ+v
IML7V0Zc+v5xQDaaed3erqkyKNFBx2v3ZqAJnDHCOCKZsfrIt+30tzk5oTT4cmt6
pzyvAiFV8A6+2zlTt3OZ7m+6wGc3TjJI9QX3Sw4hSmy4EVDV01iGutvx+kbnP2Mz
rVd1StJ0NygFDmPNvhboJGcxJmRggNEtsolh6GAcxljP04wOC+A9MN2zzQ+y8o9D
EBTtquwiIBCIQERe7b5mH7eh7fP2bh/FKoTsQuDuGBL1IxBzXP/jLakrgMtm/Hg=
=LH0h
-----END PGP SIGNATURE-----

--FexDM9E/OpjgUmaq--
