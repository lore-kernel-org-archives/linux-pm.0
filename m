From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 07/14] power: max17042_battery: Add
 external_power_changed callback
Date: Mon, 1 May 2017 13:38:33 +0200
Message-ID: <20170501113833.vbqai6rymltltns7@earth>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-7-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qbu6wgjfccqwwarc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57723 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756743AbdEALim (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:38:42 -0400
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-7-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org


--qbu6wgjfccqwwarc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 08:32:52PM +0200, Hans de Goede wrote:
> If our supplier changes status, chances are we've changed status too,
> let any listeners know about this.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, queued.

-- Sebastian

--qbu6wgjfccqwwarc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHjkACgkQ2O7X88g7
+poisA//Y/mkdklltTUSYrdb3gmPudMwm09KIcMIy4IPR6tQmsAIn40BE6zXGcaj
2UX96kctdsuCBGcGtyY+N19dRn8E8+5nEAHoAGI/+QzwoasK+o47R7VSlMAENXyB
P4bhHneAZhnAOb56gLytHOln3+MkW8Lpjykus36ncEXC9Wme9eMhHUYpUXhh1N95
epZwNU8eKaNmydStyI6cyID2gfxUpJE5DE5aykY+aEBmKInKuCyqNjUfMLgR1sBk
Rev9O2BQCFPrgcBsaq2h2qfDm/rKGf6CUUAxvS9wxY00HwMvvy2Fz9kOWeCMJfX8
Qt5D2WFAwT90OvPI2C6cHO6PQwqcOs+QjDk9kRGGzUkDM3nfzVLpVXYQq+HnojGg
l41BHnLjoXay3LLUhwXNhiuzrKqkeT/3MtgXQXLtaxqDoxNJNtBj6fcpe3m/SbYy
holdVlDZKSufg/RNW8ALSG6ZRb4f2LfdsZpaLA7m/E9qkKx7CL6lZwBtQzQqWz+7
cqOLMTJKbbWGFsvPrMllFfJ0ikU5OAWV4ai7S0DS5qW4IaIMSkN6j0aSP9hSb9Jp
xvd/lntjZhzX8Ja21+pJH3q2nktnYXO4RzPiH8lUAdkWWf/1olbZwio8VweOZ/U0
0c8N/DU+Ew2ZmbUE+86GVrYVZt0AqEeT4YovZrqOQ7WOvv9Ag4M=
=5VzG
-----END PGP SIGNATURE-----

--qbu6wgjfccqwwarc--
