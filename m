From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] power: reset: Couple of POWER_RESET_BRCMSTB Kconfig
 changes
Date: Wed, 7 Jun 2017 22:52:25 +0200
Message-ID: <20170607205225.gxurep7xjtqg7n7a@earth>
References: <20170531203946.32644-1-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="phv3tulylccyllwf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170531203946.32644-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-pm@vger.kernel.org


--phv3tulylccyllwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Wed, May 31, 2017 at 01:39:44PM -0700, Florian Fainelli wrote:
> Here are two small tweaks to the POWER_RESET_BRCMSTB Kconfig selection to=
 allow
> the driver on ARM64 and make it default to BMIPS_GENERIC on MIPS platform=
s.
>=20
> Based on your "for-next" branch.

Thanks, both queued.

-- Sebastian

> Florian Fainelli (2):
>   power: reset: Allow selecting POWER_RESET_BRCMSTB on ARM64
>   power: reset: Default POWER_RESET_BRCMSTB to BMIPS_GENERIC
>=20
>  drivers/power/reset/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

-- Sebastian

--phv3tulylccyllwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk4Z4kACgkQ2O7X88g7
+poTXw/+P0ItCyFfnKR0mfMQrvC40B1cCbMq0pC5l19gKLAcxeYTq+zvmqAWWNxn
hUGOUFlYqPGSZ+hgR8hreBJds3VDHEetAfXPaKFbqe3AhcwHCgRLh/NfmK/6rHlS
zr/qcyujGW6MrobDUlLI8D6d+mhSH/HwGrK9B++AowVM7XG2wzoti6Pjd0s2mlpT
V/x1azyt/7yvZTv+9pPUii2mLjoYfujqmu+Cb++8f8nULNy7J5OHI1R+DiCzTq39
fOhIjk22+blgX+i9tGFf8A9orDlIcnOkwVK4SaylRlPhhe/5OPaHQO15NFideXs5
m+/WXadanqqBACdO4zWr4JeO3mkaPhMI0eEaoT5PQQ/p/e3SaHe7K0LJ+MrDhDVV
nUYQ+/H38wf+Mmvmy50maE2LVr2sN3zscw4OIEzY49c8bfL/3XNjR378NJJzMIeP
2qx3sOZdwZo+VHQpWCZj+x727hTG+DUvciRw/eN4thiM81WjX3gT1ybi7tw+Cg+S
M6l0JxgsArEPR/DfL9tA+VxUyMZAX/ev9BIdStHqaj6CAUsHqQnmNq/qjALnuvF6
cOHmpYMm38BG+BoB4/c7vUf9NNOo8m9UShNnkKQxhKdeCqgTvN5Cg8+trsoK6Rev
IybfjFsEyoqq+xpn7QRYuoyaYr7XTl2YNqnehAZyguyomMRlzA4=
=YyGi
-----END PGP SIGNATURE-----

--phv3tulylccyllwf--
