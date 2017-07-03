From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] coccinelle: api: detect unnecessary le16_to_cpu
Date: Mon, 3 Jul 2017 15:36:02 +0200
Message-ID: <20170703133602.ejcdu35ku3i63cj2@earth>
References: <1498937290-12285-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bh35jazzbablkmhm"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52345 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753447AbdGCNgH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 09:36:07 -0400
Content-Disposition: inline
In-Reply-To: <1498937290-12285-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Bastien Nocera <hadess@hadess.net>, Stephen Just <stephenjust@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-pm@vger.kernel.org


--bh35jazzbablkmhm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Julia,

On Sat, Jul 01, 2017 at 09:28:10PM +0200, Julia Lawall wrote:
> As reported by Sebastian Reichel, i2c_smbus_read_word_data() returns nati=
ve
> endianness for little-endian bus (it basically has builtin
> le16_to_cpu). Calling le16_to_cpu on the result breaks support on big
> endian machines by converting it back.

Thanks, you are fast :)

> This semantic patch give no reports on kernel code currently, but the
> issue is somewhat obscure and has occurred in a sumitted patch, so it cou=
ld
> be good to have a check for it.

Ok, so problem is not as bad as I feared. I found a few issues with
simple git grep, though:

git grep -C100 i2c_smbus_read_word_data | grep le16_to_cpu
git grep -C100 i2c_smbus_write_word_data | grep cpu_to_le16

It returned just a few files on v4.12 and all of them look buggy
after manual inspection:

 * drivers/macintosh/windfarm_lm75_sensor.c (line 71)
 * drivers/macintosh/windfarm_smu_sat.c (line 80-91)
 * drivers/gpio/gpio-pca953x.c (line 190-192)
 * drivers/power/supply/bq24735-charger.c
   - fixed in linux-next by 48f680c0a9ca
 * drivers/power/supply/sbs-battery.c
   - fixed in linux-next by a1bbec72f9fe

> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
>=20
> The rule could easily be extended with more such functions.  Let me know =
if
> anything else should be taken into account.

I guess the write function should also be covered.

-- Sebastian

>  scripts/coccinelle/api/smbus_word.cocci |   45 +++++++++++++++++++++++++=
+++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/scripts/coccinelle/api/smbus_word.cocci b/scripts/coccinelle=
/api/smbus_word.cocci
> new file mode 100644
> index 0000000..b167cf0
> --- /dev/null
> +++ b/scripts/coccinelle/api/smbus_word.cocci
> @@ -0,0 +1,45 @@
> +/// i2c_smbus_read_word_data() returns native endianness for little-endi=
an
> +/// bus (it basically has builtin le16_to_cpu). Calling le16_to_cpu on t=
he
> +/// result breaks support on big endian machines by converting it back.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2017 Julia Lawall, Inria. GPLv2.
> +// URL: http://coccinelle.lip6.fr/
> +// Options: --no-includes --include-headers
> +// Keywords: i2c_smbus_read_word_data, le16_to_cpu
> +
> +virtual context
> +virtual org
> +virtual report
> +
> +// ---------------------------------------------------------------------=
-------
> +
> +@r depends on context || org || report exists@
> +expression e, x;
> +position j0, j1;
> +@@
> +
> +* x@j0 =3D i2c_smbus_read_word_data(...)
> +... when !=3D x =3D e
> +* le16_to_cpu@j1(x)
> +
> +// ---------------------------------------------------------------------=
-------
> +
> +@script:python r_org depends on org@
> +j0 << r.j0;
> +j1 << r.j1;
> +@@
> +
> +msg =3D "le16_to_cpu not needed on i2c_smbus_read_word_data result."
> +coccilib.org.print_todo(j0[0], msg)
> +coccilib.org.print_link(j1[0], "")
> +
> +// ---------------------------------------------------------------------=
-------
> +
> +@script:python r_report depends on report@
> +j0 << r.j0;
> +j1 << r.j1;
> +@@
> +
> +msg =3D "le16_to_cpu not needed on i2c_smbus_read_word_data result aroun=
d line %s." % (j1[0].line)
> +coccilib.report.print_report(j0[0], msg)
>=20

--bh35jazzbablkmhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllaSD4ACgkQ2O7X88g7
+ppmnA/8C+N/4AqBw81+Gc4ZscPU5IuydzcGKoVUqpA5Fo3Qkye7IbGIghS7hGub
U2of/+N8sE/kUa4nRrLyIfe3QK/3KfgVi+4gWRe7WaWGUUJbZys2ontyBie2f94n
I4KdKVf4dfNx+K6Zaac0JNcgGqVUMfTGRvxEaUALpaMiw/edPbF6enLsOa5xchXx
KgpIG9uR+NuMDrSSVPM9jdm8jachSbU4iTpjsq3MrK8SIuja4bP3Tr5BogzRhCJR
nrE1FfQnhdoQStKl2kM3yNgI90Eusrvdw6bbKr4TE6GazPZJKrIs22YCOKfe6/S1
bNDMQpzPy3PPF9R/6qt7WsWyou38VbhnjbUn0+mwy6Fnh78JEUdeP6w1mjjyzUvh
e6sKbvIAoRFSMTvoU9ce+sZQy7whOoNzA06BmXb0IioLYjf3edYpbn4iRUz7rVq0
Kzj8q5LARz4vGDuPWjgyT2PqSOboYHLu7IjtWSvFRTrHa0xQLqny78nrOCYFEIpF
if/3yl19vxmEYvSNmtumXIFNlsi8CeYIv+7KCKCUPi9ljnuzKZCmcBTpCztKHcj5
oLX8UMOpX7r5Cl8XubpmE/c9m+iUQJD+p1bLgEqB0C8yRL5wKOPPFp3OtExsGvgO
7DX/+6hUSfYw+nhpmTjf9/OKuID9ksLAR4Yu1WZIH8L7I3U+xXc=
=1wgC
-----END PGP SIGNATURE-----

--bh35jazzbablkmhm--
