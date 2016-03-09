From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 0/6]  thermal: add devm_ version of thermal_zone
 register and driver for max77620
Date: Wed, 9 Mar 2016 11:32:50 -0800
Message-ID: <20160309193249.GE2422@localhost.localdomain>
References: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, rklein@nvidia.com
List-Id: linux-pm@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 06:40:04PM +0530, Laxman Dewangan wrote:
> The series add the devm_ version of thermal_zone_of_sensor_register/
> unregister, interface details, and use this in new thermal driver
> for max77620.
>=20
> The header file for max77620 is part of MFD patch
> 	https://lkml.org/lkml/2016/2/11/186
>=20
> Changes from V1:
> - Run checkpatch with --strict and fix all warnings.
> - Added details of interfaces in spifs-api.txt
> - Added DT binding doc.
>=20
> Laxman Dewangan (6):
>   thermal: doc: Add details of
>     thermal_zone_of_sensor_{register,unregister}
>   thermal: of-thermal: Add devm version of
>     thermal_zone_of_sensor_register
>   thermal: Add devm_thermal_zone_of_sensor_register() in managed devices
>     list
>   thermal: doc: Add details of
>     devm_thermal_zone_of_sensor_{register,unregister}
>   thermal: max77620: Add thermal driver for reporting junction temp
>   thermal: Add DT binding doc for thermal of PMIC max77620


Add patches 1-3 in my tree. Patch 4 should probably go via documentation
tree. And patch 5 needs dependency to be sorted, and 6 need minor changes.


--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW4HpgAAoJEMLUO4d9pOJW04IH+wfJkUI9YeVdmLWXBDb6YgHV
2Co3IoMWmhBhU2Zt/vZuIZzIhNt3kV1DL18hLCNSxS2IhBjuESu4KEjfpw/iyn+Z
NegR2eDfWvoWgseq0WI0+lKESxkmjqL6ivvXQ4vUEdT2ZshteqlZRMMC0nAczNMV
Gv2IBxg4s6rsBAMqME06O8O/Vph24fU63seBCy1IJKbfzSUkr/XM2pSJOzh/LcT6
NOwNr55tfvCW+J1j3ehMdoDsr2CRHui0caahAmLVDoNf5a0KaIWNbnTNT2o2HBui
QyTu43O4ap/PInYuyM3Rue493TZfGHo0lUrxGLoXyyw2HLRlvbtVldBiCS0qJyE=
=GmR+
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
