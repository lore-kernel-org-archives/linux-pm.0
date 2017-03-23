From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/7] power: supply: bq24190_charger: Use i2c-core
 irq-mapping code
Date: Thu, 23 Mar 2017 12:11:59 +0100
Message-ID: <20170323111159.hdhtpqlzht74cgec@earth>
References: <20170322145536.30570-1-hdegoede@redhat.com>
 <20170322145536.30570-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j2c26b3xoiyijtuy"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752023AbdCWLMF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Mar 2017 07:12:05 -0400
Content-Disposition: inline
In-Reply-To: <20170322145536.30570-2-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>, Tony Lindgren <tony@atomide.com>


--j2c26b3xoiyijtuy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 22, 2017 at 03:55:30PM +0100, Hans de Goede wrote:
> The i2c-core already maps of irqs before calling the driver's probe
> function and there are no in tree users of
> bq24190_platform_data->gpio_int.
>=20
> Remove the redundant custom irq-mapping code and just use client->irq.
>=20
> Cc: Liam Breck <kernel@networkimprov.net>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> ---
> Changes in v2:
> -Completely drop platform_data and include/linux/power/bq24190_charger.h
> ---

Thanks, queued.

-- Sebastian

--j2c26b3xoiyijtuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljTrXwACgkQ2O7X88g7
+po/cg/9FOHOL6528qOmGTgJHRJUVs04Pkx2YMdc42KEIF1b20CcOtPxi2zQFINW
ZdObeXXWGG0TbY/rizjTUOvdd8NTcg55OSROqmGpO0MXBj0fiXiKQgZNCirEWfiF
hhVtFVdm2U693TW0Je6trjAPnbMYnslYuzBhvUim9LwiNST29iqRSn4IAsbHG7cD
QQ+e09AKUgfc/RvrJkHoUDRo8KkXwzchQYoOeY/xIu8ddNimH1RzDZz6K+65o6xF
hWv+0DODqqpzGvrfLpjJ81eYcgVPsPnyQwU07uLjWAiNv4rqf3RYKtdXV/bh6dm8
vKZV5B9A1rfc8n2A/MzHTyORA8Pi+9o0GcMQ2Nl9X+b+rnhbNYwFoTQsecVjyanD
1UBTpd5MayC8+25LsioDp9PgQOf98mKh4mnqndYKA4EPYgLPhLwA+sIzJnj2Hb+O
8SDLEBPC9OXgE5eZiilA75gnz6zTmKqnBOZJjch9IOypmuY6qAxv2vI2p61GZtUL
BJBd69PUY6OMHcm0hUEPY4U6rSAzRuYXF9F+rSKHgp/WwJRLAY02it3nAtou+snp
RQEdi+ROtSu5xBINrHHNN6AzLZKEHMzT6x459J46+TPd4bLo/ahkXrnyWH9/shMH
rsgFMpwrt493E9tb4gdOusq7LxIEcjophZwjFGvUOR8i/pERzMo=
=4nXC
-----END PGP SIGNATURE-----

--j2c26b3xoiyijtuy--
