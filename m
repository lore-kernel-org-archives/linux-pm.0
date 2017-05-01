From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 13/14] power: max17042_battery: Add support for the
 SCOPE property
Date: Mon, 1 May 2017 13:41:17 +0200
Message-ID: <20170501114117.ccff6ajwohxlnkqt@earth>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-13-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qf7pr6ahlv6nodkb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57746 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbdEALlU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:41:20 -0400
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-13-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org


--qf7pr6ahlv6nodkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 08:32:58PM +0200, Hans de Goede wrote:
> Add support for the SCOPE property, always return SCOPE_SYSTEM,
> as the max170xx is used for the main battery on all known systems
> with a max170xx.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, queued.

-- Sebastian

--qf7pr6ahlv6nodkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHt0ACgkQ2O7X88g7
+prrFg/5AdE1EA5js8/26OD6A7od40uDQcZ4QgUFTQ/ZZ01BvEfo74LKaZFovjEb
FQlFRXmhKKdtDLrxCTG8q4nONKtoGPUQ1/dp5/36sdlF4GCo0au17k9LiSirzu0j
FzlsUR2/KEWE+31Rugv+ueSEFJ1gpjeA2HsbLHCesLQMZP3feZ+H0gIWcLKBN78t
yCT7B7hxFwUCyUK53CebMPMwsSkV3MiKLEhR+xM8TPZr+Sa3NBtfMD508wWCKSWn
ibtkKxw8JMXPEE/rhokO6uUkkjxfYt8O4vERu8esmOj4CZ4b8rQbmH/+wruyNsUa
m164FT0Vu+o4/vdLn5KR8Ie6sN5c7Hy5pCAWcul+wiQJ4Z/2ZzP374f0k+JcqUk2
/12tbIabMLtINxKNkFTxkkwoDpH9KQQcuOxfIen9nW3Y0p89LzwXBK39Zp6Rcm8k
dlgXs7fbdCKkuO1bIsyT5QmQDCvfRrIgPEQ26YwIhyb5OJg30HaI+DJvJ0HyHiU2
kYkzUWd0ylmGgAvWRGPY2AYyp3Nw3xfCFhRGtLJF1oAEtYqVMuTAqby4CDEnM+An
8xcR3w8xnXYqpWOQJgxkFhKt5eTT+wFbgVnVDh8UxmQnBdnbCZmhZxu6nZLOckhf
iQtxMq6BICl+EvEssSKB8jcjN5bRVMPOxHHfgJfgkP8m/8wqnsk=
=2AKM
-----END PGP SIGNATURE-----

--qf7pr6ahlv6nodkb--
