From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/5] power_supply: charger-manager: add missing
 of_node_put
Date: Thu, 15 Oct 2015 10:56:40 +0200
Message-ID: <20151015085640.GA29200@earth>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
 <1444480254-14399-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58149 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbbJOI4q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Oct 2015 04:56:46 -0400
Content-Disposition: inline
In-Reply-To: <1444480254-14399-3-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>, Jason Cooper <jason@lakedaemon.net>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 10, 2015 at 02:30:51PM +0200, Julia Lawall wrote:
> for_each_child_of_node performs an of_node_get on each iteration, so
> a break out of the loop requires an of_node_put.
>=20
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
>=20
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> @@
>=20
>  for_each_child_of_node(root, child) {
>    ... when !=3D of_node_put(child)
>        when !=3D e =3D child
> (
>    return child;
> |
> +  of_node_put(child);
> ?  return ...;
> )
>    ...
>  }
> // </smpl>

Thanks, queued.

-- Sebastian

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWH2o7AAoJENju1/PIO/qaUaEP/3ztSp8LKOFAAO8ZcNHvh/U+
JcFlKfmj+pJlbOkxxaSBsSLHvl0iKBvL+d6vQOXPDttCZqEjovUeuoP9L8DzNs4y
m49nrn5uZFHqHbIIU+YyUSFzX30WrPu3crGS8IcKCp87MHP3Bw8PngwP8bHVlKGI
rNhboQ/N03m+74lqeYHgZukTQ+EeT88E8X6mwpUvq9PK6mCXRXh+tVJSe6QLsuRz
CXkrBaXTEzosljBKcwpc3UuRVdCGW63B1TqwW6krmR0l+YfGoSuNWJblL/r5GUao
GbqCNX9NPHmhKr0heVUb2ULgIVEFhyyTs1kBeLW/3bgc1a4kVVQouBACmwAwxIAd
0sXBDYl5+izmLLZTtJrT4bPYPoD4PkvwqhfR2e7e2JAFsywQWa34ENYkFPZTdUW8
nBnNMVYJ9GHnjTN9nU3DV9TzIH15VDiDYKMAuO9wdL0n326Hflh0WQq1hAviKMHF
IZLAupDGMf4LWgsiUU45uts8mGzVik00TXsDrzJ8iNvjMwfE6uomiTMMcLmVgv1N
OJgIZzJi3bzK5a6GVj4XTADB3lche6kgdWFybOdpFrUKfWw9GfGXC81RXLKeqy4p
3mb57ML4O8qI4J5tNwi5K79LOpcxlb3z0swhbTp7oaZ8v05CyrgnNnnZqqoGYAMl
DS0ADXSH+iupUzptV89T
=SJLz
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
