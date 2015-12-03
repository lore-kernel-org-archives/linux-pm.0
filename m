From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: [PATCH 02/12] clk: samsung: exynos5420: add cpu clock configuration data and instantiate cpu clock
Date: Thu, 03 Dec 2015 11:30:16 +0100
Message-ID: <874mfz4yfb.fsf@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org> <1449091167-20758-3-git-send-email-ben@smart-cactus.org> <565FDC5A.1010504@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <565FDC5A.1010504@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Mike Turquette <mturquette@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> On 03.12.2015 06:19, Ben Gamari wrote:
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>=20
>> With the addition of the new Samsung specific cpu-clock type, the
>> arm clock can be represented as a cpu-clock type. Add the CPU clock
>> configuration data and instantiate the CPU clock type for Exynos5420.
>>=20
>> Changes by Bartlomiej:
>> - split Exynos5420 support from the original patches
>> - moved E5420_[EGL,KFC]_DIV0() macros to clk-exynos5420.c
>>=20
>> Changes by Ben Gamari:
>> - Rebased
>
> If only rebasing then you should retain the Lukasz's review tag. He
> doesn't have to review it again, right? :)

Yep, very true.

>> +static const struct exynos_cpuclk_cfg_data exynos5420_eglclk_d[] __init=
const =3D {
>> +	{ 1800000, E5420_EGL_DIV0(3, 7, 7, 4), },
>> +	{ 1700000, E5420_EGL_DIV0(3, 7, 7, 3), },
>> +	{ 1600000, E5420_EGL_DIV0(3, 7, 7, 3), },
>> +	{ 1500000, E5420_EGL_DIV0(3, 7, 7, 3), },
>> +	{ 1400000, E5420_EGL_DIV0(3, 7, 7, 3), },
>> +	{ 1300000, E5420_EGL_DIV0(3, 7, 7, 2), },
>> +	{ 1200000, E5420_EGL_DIV0(3, 7, 7, 2), },
>> +	{ 1100000, E5420_EGL_DIV0(3, 7, 7, 2), },
>> +	{ 1000000, E5420_EGL_DIV0(3, 6, 6, 2), },
>> +	{  900000, E5420_EGL_DIV0(3, 6, 6, 2), },
>> +	{  800000, E5420_EGL_DIV0(3, 5, 5, 2), },
>> +	{  700000, E5420_EGL_DIV0(3, 5, 5, 2), },
>> +	{  600000, E5420_EGL_DIV0(3, 4, 4, 2), },
>> +	{  500000, E5420_EGL_DIV0(3, 3, 3, 2), },
>> +	{  400000, E5420_EGL_DIV0(3, 3, 3, 2), },
>> +	{  300000, E5420_EGL_DIV0(3, 3, 3, 2), },
>> +	{  200000, E5420_EGL_DIV0(3, 3, 3, 2), },
>> +	{  0 },
>
> The vendor code (Galaxy S5 with Exynos5422) sets pclk_dbg divider to 7.
> In the same time APLL divider is only 1.
>
> For the ACLK divider (of KFC below) the vendor sets 3, not 2.
>
> The values also don't match the Exynos5420 from Note 3.
>
> The Exynos5800 apparently has values more similar to 5422.
>
> The question is: for which exact model this is? We can of course choose
> the safest values here but probably these would be with the highest
> dividers?
>
I'm afraid I can't comment here. Thomas, perhaps you could offer some
insight?

Cheers,

=2D Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJWYBm4AAoJEHPt6ejPuu8BIXcH/iC91p+CIajGAdHt02GN197d
gU1TdvdBDR8sDGEYoA1G0VJaRHShF3WUJtWQsxZw7VsqnClAYQaaTp8CHtuHBrlH
sMyjR0Y6JS9WYNdG6FYXTyh1NBgIoX/30re3nbZ8lEO7MSLXo3JtZE9RDnkqobrA
t/ilAB2KBFb2OrnlKsuu9D18XtzBdVHWv6yPSnKT17cxT0ods3a3y/eG4+Ff+Mgs
7Ix2rlST3nZ89CLs0TdC09cbcnOwfvRn3nLrUuXL4kr3ddP0nWOWsvs5m775b3UO
jEl55fPc+rUc+FO9hhZFJ/t2KJvQI3c47mFSJ86qTXbyecaSFPuXAVwaVdQ5TGY=
=Sdg2
-----END PGP SIGNATURE-----
--=-=-=--
