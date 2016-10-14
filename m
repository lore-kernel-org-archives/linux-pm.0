From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] power: reset: Add qcom reboot mode driver
Date: Fri, 14 Oct 2016 15:15:16 +0200
Message-ID: <20161014131516.bkyi3tsx2nhqfyhm@earth>
References: <1476410823-8912-1-git-send-email-xiaogang@codeaurora.org>
 <54841aee-34ec-2776-e802-9e36d12e77c2@rock-chips.com>
 <9c8d80ce39a10274da06e99735944ffa@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oupzpfgts3fmfvym"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9c8d80ce39a10274da06e99735944ffa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: xiaogang-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Chris Brand <chris.brand-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--oupzpfgts3fmfvym
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 14, 2016 at 11:06:14AM +0800, xiaogang-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org wrote:
> =E5=9C=A8 2016-10-14 10:41=EF=BC=8CAndy Yan =E5=86=99=E9=81=93=EF=BC=9A
> > On 2016=E5=B9=B410=E6=9C=8814=E6=97=A5 10:02, Xiaogang Cui wrote:
> > > This is a initial version so it's very similar with syscon
> > > reboot mode driver. We will add more functionalities in the
> > > further after dependency is ready.
> > >=20
> > > Signed-off-by: Xiaogang Cui <xiaogang-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > > ---
> >=20
> > As your commit messages said, "it's very similar with syscon
> > reboot mode driver", so maybe we can try to reuse the syscon
> > reboot mode driver, and extend your new function on it.
>=20
> Since it will heavily depend on Qualcomm qpnp and download mode
> driver. I prefer to add a new driver for this.

So use syscon driver until then. In its current state is more
or less a copy of syscon driver with s/syscon/qcom/g. I will
not queue that.

Just add a more specific compatible value in addition to the
syscon one:

compatible =3D "qcom,reboot-mode", "syscon-reboot-mode";

Then syscon driver is used and if something more complex
is required later we can easily switch to it.

-- Sebastian

--oupzpfgts3fmfvym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYANphAAoJENju1/PIO/qaKwkP/juhatAbBGpmsf3rX4CnBa8s
qAvN4iSuBb+oY3V0Dd/ZfeKHMxBlG3H95HHCqm3iHYMTQdD51SsPOVTfz2UTcUDt
ds7/N4Hvs0pgICisnHadNQ1HPt/FBMc0hgGxlxgYMjZnhmp2uDAURJpPtFU/e/wx
zVrtmxPdCTI7UpFpfLlItaPWPleDDJ+dueEhXQgrjnWHuyyC1QPFdo5jkAofFn6e
ivFjSNxq7b7RiebdBuhvGAPAqUmTbLhKrZEFZlqf/3DsPnp0tfSi+u4xnuTZ4SzD
6/MeL7VGZIBu+lU+Zouxva4LpaZSZaDVYgZlvsVb5D+5MKbZMf8At51opFGn9uAV
r4w7Ohx4evNogimzacwXKvu0N/DfUN+xW+NQlKcIo+J+dzbs7m28rKwNbAcE0YIL
xgJD1dZRFBrzYu1NnhFFLH+G1Va/xo1IvSH4acccol0ueXTd3iaoiuErYs59PqpO
IipFfH9woLZAvLoStDgOjmTcoPBF18oN1nwNQW+H6drFuU0d6cr7JN5djhHvw1Ua
SrPpRUe0AwVTR6/uvgS2PIoKnbb3i+YaRZr//4Mx7dvmj5BYXr1FWzTxTuK6mKlg
mvS8YudfmvYQMUVzGmWrVb+NOgi7gCfFERtHBZ4Z75qEJ3cAlwk+Otwn4tjxtK+b
knqlwyD1Nc6gnW624AVg
=pBAM
-----END PGP SIGNATURE-----

--oupzpfgts3fmfvym--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
