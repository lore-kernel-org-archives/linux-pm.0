From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: offer Samsung thermal support only when ARCH_EXYNOS
 is defined
Date: Tue, 26 Nov 2013 09:22:31 -0400
Message-ID: <5294A097.3070903@ti.com>
References: <2958660.aJeCDrTTOe@amdc1032> <CADGdYn4YQL9-8WCDNWP8x9Gec9sMV09q3OsYPz3tTdMxDGnyvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4VVi7QlD6urIRFNS2FQm5NJVhP3htvdSh"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CADGdYn4YQL9-8WCDNWP8x9Gec9sMV09q3OsYPz3tTdMxDGnyvg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Amit Kachhap <amit.kachhap@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

--4VVi7QlD6urIRFNS2FQm5NJVhP3htvdSh
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26-11-2013 02:07, Amit Kachhap wrote:
> On 10/4/13, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> wrote:=

>> Menu for Samsung thermal support is visible on all Samsung
>> platforms while thermal drivers are currently available only
>> for EXYNOS SoCs. Fix it by replacing PLAT_SAMSUNG dependency
>> with ARCH_EXYNOS one.
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Looks good, so
> Acked-by: Amit Daniel Kachhap <amit.daniel@samsung.com>

I will be queuing this one in my tree.

Thanks Bartlomiej.

>=20
>> ---
>>  drivers/thermal/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index a709c63..05cf95c 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -198,7 +198,7 @@ source "drivers/thermal/ti-soc-thermal/Kconfig"
>>  endmenu
>>
>>  menu "Samsung thermal drivers"
>> -depends on PLAT_SAMSUNG
>> +depends on ARCH_EXYNOS
>>  source "drivers/thermal/samsung/Kconfig"
>>  endmenu
>>
>> --
>> 1.8.2.3
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsun=
g-soc"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--4VVi7QlD6urIRFNS2FQm5NJVhP3htvdSh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKUoJcACgkQCXcVR3XQvP0mkAD8CkNGFWvuceTAtZomSCDOR+WZ
Gx4FNdnQFbfpsuAfwx4A/1FKV6e/uL1jV3GSW9Nhm26DsMkWkA4LWYcFDz4DGEVg
=ixY5
-----END PGP SIGNATURE-----

--4VVi7QlD6urIRFNS2FQm5NJVhP3htvdSh--
