From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: [PATCH v5 0/12] cpufreq: Add support for Exynos 5800, 5420, and 5422
Date: Thu, 03 Dec 2015 11:26:31 +0100
Message-ID: <877fkv4ylk.fsf@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org> <20151203060527.GH4302@ubuntu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151203060527.GH4302@ubuntu>
Sender: linux-clk-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>
Cc: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Viresh Kumar <viresh.kumar@linaro.org> writes:

> Hi Ben,

Hi Viresh,

> On 02-12-15, 22:19, Ben Gamari wrote:
>>=20
>> This patch series adds cpufreq support for the Exynos 5800, 5420, and 54=
22
>> SOCs. In particular, it adds support for operating-points-v2 bindings to=
 the
>> arm-big-little cpufreq driver and updates the above-mentioned SOCs' devi=
cetrees
>> to take advantage of this support. There are also a couple of patches im=
proving
>> the clarify of the arm-big-little implementation. It is built on a set p=
osted
>> by Bartlomiej Zolnierkiewicz in April 2015.
>>=20
>> The most signficant change from the original series is porting to the
>> operating-points-v2 devicetree bindings. The series has been tested by m=
e on
>> and Odroid XU4 and by Javier Martinez Canillas on a Peach Pit.
>
> Thanks for working with opp-v2 bindings, really appreciate it.

My pleasure.

> But, before I start reviewing this series, I have few comments.
> - We weren't able to use cpufreq-dt driver for big LITTLE platforms
>   earlier, as it never had multi cluster support and we wanted
>   clock-sharing information via DT.

Fair enough.

> - That is all fixed now.

I did not see any mention of this in the cpufreq-dt driver binding
documentation, otherwise I would have tried going this route.

Do you have any references? I'd be happy to examine what would be
necessary to go this route although, being an independent contributor,
it may take time.

> - I want Samsung's big LITTLE platforms to use cpufreq-dt and drop
>   arm_big_little driver completely.

That sounds like a great direction going forward. However, I would still
kindly request that you consider this series.

The existence of future plans of course does not change the fact that
users have real hardware today; hardware that they have spent money on
and would like to use. Cpufreq support has already been deferred once
for similar reasons of interface churn which essentially forestalled
working functionality from entering the kernel by eight months; I'd
really like to avoid having this happen again.

> - The only case for which it (arm_big_little) driver might be useful
>   is the IKS solution. Which I don't believe you are going to use in
>   future :)

Indeed.

> My plan for the arm-big-little driver:
> - Migrate all platforms to use cpufreq-dt instead for non-IKS
>   solution
> - Make arm-big-little driver arm-big-little-iks only driver.

Sounds reasonable to me. However, I'd just like to reiterate that this
line of work can be pursued independently from the upstreaming of this
series.

Thanks for your time,

=2D Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJWYBjXAAoJEHPt6ejPuu8BMwgH/2wRShAxTQm02bJ0bnfi6LQc
zcE5H6jhAr5GLneojfiPHyZmLcO9eD1l7G0BXQIYIEYN+b+dDYb4hDowl8F5Xa7f
KofQxesWjBEFc4ENKlkpnYKlm9Ou+eOAlY0hcibCcT+LdG8qvGsuC3lIfxqfiz0d
EwL70kGiJVctguapKuqY58/O8P7YF48ayew0KfmhBpGCbeQpeTSW6eIcLfGbYwGf
QSTA9Vl42Ft6PffHxNq07zxUhBnlHStTyM+bIKJ7s6MzY0MRloG3eUQNT39yetKI
CAcJHnbU+LI5OVzFiczmq915dLUwiwOgZBsyzVLlgB5wv6cTsHUi6k2CIzu6NmE=
=YVtd
-----END PGP SIGNATURE-----
--=-=-=--
