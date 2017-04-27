From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] soc/tegra: bpmp: Update ABI header
Date: Thu, 27 Apr 2017 16:19:49 +0200
Message-ID: <20170427141949.GB21118@ulmo.ba.sec>
References: <20170329163452.10761-1-thierry.reding@gmail.com>
 <20170329163452.10761-3-thierry.reding@gmail.com>
 <10169152.Khpl4fl1AK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <10169152.Khpl4fl1AK-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stefan Kristiansson <stefank-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 02:44:48AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, March 29, 2017 06:34:51 PM Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > Update the BPMP ABI header to a more recent version. The new version
> > adds support for a new powergating ABI as well as access to the ring
> > buffer console, which allows debug messages to be output to the BPMP
> > debug console.
> >=20
> > Some of the previously undocumented fields have been documented and
> > missing bitmasks have been added. Furthermore the MRQ_RESET request
> > now has a sub-command that allows to determine the maximum ID which
> > in turn allows the resets to be enumerated, thereby allowing drivers
> > to become agnostic of the Tegra generation.
> >=20
> > Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> I could queue up the [1,3/3] with the Ulf's ACKs, but I can't really say
> whether or not this one makes sense. :-)
>=20
> Any chance to ask the ARM/soc people for an ACK?

Sorry for the late reply. I think at this point it might make the most
sense if you queued up 1/3 for 4.12 and I can take 2/3 and 3/3 into
linux-next shortly after v4.12-rc1, then merge this through ARM SoC
along with any other patches for v4.13.

Does that sound reasonable?

Thanks,
Thierry

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlkB/gQACgkQ3SOs138+
s6G0jg//ar5KECrPF9Cp3xgwX3btwIzannnZXZ5rbo9H+zBuJyZ92u4S7w3xbiSK
nCL6QG7Jm70HhpDdkzbr82MvAZg8lRmCSIM+rMUk9wIUbjS6u04T/gS58exqkbrB
lrTRp266AtuUdEZ8uWQxL0SW0svWhMfZpQJI4AIRnEUgTYEVrwSh2P+UF1p4ohRA
DXrSX+KzhfKa1DbJGZxG3sQq9SasJKstOcqtPkcjxrgXU3ugTHGGUB/cdkvEqKHz
vbXduv4Q6tBlbSb7dteXKnCkf9r3/23SlRI6WRoOHpNQeTfa5zAPZJj3WkyRzrNb
v0k3+momc2uf3pOc9f74ViLuR8zxY9+imviO9W6Bnsmm6oTLuGc39jV7i8TmBq2Y
IRGtkpSVxlop+aE0gm4mDIxKDaoOLVMiVuo7qEbxXxSw2cLTVISNlPN3MMF7zxur
1KQjwEBxoMCO3w2C2tyWDTxgXlxYzaQ3QU+qM1smQeIJFja3302jyGLwDCKS1t3Q
AgASJOntItE8bpoZimFv8y+92jB976u0uO8LuZ+qM5T21Aoxn8boFxRwjqhuDikh
tt5zc+B19SyzHzf2lA2gOImGwP2NnHwB7/WwFWyjABAW8NP0jGZ24ziTk9p3G00/
fwcXM4NR2+XkAfJrJSdjLF1rL9I57Fnpf6d2TX1ZJTUaRnbxNOE=
=Dca6
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
