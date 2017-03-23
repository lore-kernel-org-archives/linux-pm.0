From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3] power: supply: bq24190_charger: Use extcon to
 determine ilimit, 5v boost
Date: Thu, 23 Mar 2017 12:16:16 +0100
Message-ID: <20170323111616.nj2utzk3lf5u6jyj@earth>
References: <20170323083235.15072-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k5n3b2mygamqwuod"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754625AbdCWLQV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 07:16:21 -0400
Content-Disposition: inline
In-Reply-To: <20170323083235.15072-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>


--k5n3b2mygamqwuod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 23, 2017 at 09:32:35AM +0100, Hans de Goede wrote:
> Add support for monitoring an extcon device with USB SDP/CDP/DCP and HOST
> cables and adjust ilimit and enable/disable the 5V boost converter
> accordingly. This is necessary on systems where the PSEL pin is hardwired
> high and ILIM needs to be set by software based on the detected charger
> type, as well as on systems where the 5V boost converter is used, as
> that always needs to be enabled from software.
>=20
> Cc: Liam Breck <kernel@networkimprov.net>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> ---
> Changes in v2:
> -Use a device-property for extcon-name instead of platform_data
> -Delay 300ms before applying the extcon detected charger-type to iinlim
>  (see the added comment for why this is done)
> Changes in v3:
> -Print a msg with dev_info when an extcon is used do determine iinlim
> ---

Thanks, queued.

-- Sebastian

--k5n3b2mygamqwuod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTroAACgkQ2O7X88g7
+ppEpxAAnr8kx3fedVoiEDk/m9LvO6Sf7dy8OFFWu7JDGyAWFYiNved2fqCok0T4
78HKc9XHBcnSh3QYrdk5Lm7V8Y1TcnB95Zfm58jrqshKbfUG8CWHsi+VhuVHaWKK
FBIYPoa1jK43KN2kNH59Ajp/HBcrWGjWvPv0BnCiQHplZexqUseaMRpBzBtp4dtK
6GW6aVxZruVzzzgftxZ7VDm9cUOIMNXHBscLisENLSqn9t4beubCa4x0WTsoz05U
XomW2Cij5xYcmWoM9ixnbdOoogCKDCnKtOUci+GnMHvyzdMg1RGqdZw/Y24NMRdQ
EYzw80syiExmPdg8MPmV8TD/23mYzRqmUGyIwxntMHdI/+DQZj/ews7aZ1hkTl7u
8JCXuk3ZGDulBcQb4m9UUhZ89GQNAvCELfqSDvuYYNMVzH/FGzLJB1jnMS38lsPu
ibWoZzd5KswXCYC+lHPm+uAjEf0ox75OBMvc4DZ86qszRHcnxrm+wNop1AtymfU4
/+ZdVCzcdRTv/PCyPtMimJkI9yBZUeW2kyV3MByr/MydiI5M9mAWfFq5JspKb2ld
1xaEsfPiML2KW5jSP60Y3A3Lu6hc0RmTxlnnI/7nWiPPfxZX9fKTOQ9lruIKYszQ
Z1BzRyYtooRDMIkUEHELd1pS83cJN2dKUTLD1UYUnUiMZgsNa1E=
=aMnI
-----END PGP SIGNATURE-----

--k5n3b2mygamqwuod--
