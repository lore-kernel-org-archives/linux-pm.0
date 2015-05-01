From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: bq27x00_battery: Add missing MODULE_ALIAS
Date: Fri, 1 May 2015 23:03:41 +0200
Message-ID: <20150501210340.GB27735@earth>
References: <1430252586-5104-1-git-send-email-marek@goldelico.com>
 <1430424358-30244-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430424358-30244-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com
List-Id: linux-pm@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Apr 30, 2015 at 10:05:58PM +0200, Marek Belisko wrote:
> Without MODULE_ALIAS bq27x00_battery module won't get loaded
> automatically.

Thanks, queued into fixes.

-- Sebastian

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVQ+osAAoJENju1/PIO/qamcEP/iPt2GZeBmWLc+3Rekos+OF/
TsvUphJHHy+chrbQIqzJKV9tIurRiQKhgffKZUVz31F+SFsOjEAfqxIk9+iACgM+
21WpU3Ok0oc888s+m22BnGcSGEDnYn6VsvPlhtsZojHZ63vzbAnsqNAAmDR46JgG
HLd/RJZ8aPhqfw7lmPMI0IoLEl44lcVfdZH4+ueijOD4f2BgyFnaV0GUVAC4Pu3Y
w3mrz3sAsJDgYiZ2xbQUFVwlmDTu5Govm11IenanVgpGOnWUPxV+f1/Z8QYMs4In
/BBTlFI0Iih2Z1SmIT30BfP53KQ428sB7wU1/8BGD6Ac7SFbBiPyxQjL+UjrCd/h
GtwgEVpn5jYzoRrfpiohONlonUw/7wEu8lBNs6+oSWaK3CKpsX7TDAx0ydkZ6XiN
co6sUmPPAV3wRyd8md5MgsWKp3BHZMDPEA2HsnzY14NNvw/TCVIQTVIJktjo0eMu
zM5bfrtiT93ySCabQ1k+XWuSXbkdhxY1b1prKoWt/tQiwqi8EqIzOJz8gfUtAu2g
JhSHpFKiVIL7X60UE673vl/KG+RUbNqEn4Hx3WplOadq5BU+V359tjYZK2SIhbOw
PIEeFj7FcdsRRVWvlVdxPVkXnWv6wEOVdYFrkHmwAJJuWZIKXL1VBS28/CQT1P8s
sQRzDpICpLlzGyxQoKHs
=ha3N
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
