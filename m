From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: [PATCH v5 0/12] cpufreq: Add support for Exynos 5800, 5420, and 5422
Date: Mon, 07 Dec 2015 22:19:05 +0100
Message-ID: <87mvtm9cty.fsf@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org> <20151203060527.GH4302@ubuntu> <877fkv4ylk.fsf@smart-cactus.org> <20151203103703.GC2097@ubuntu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20151203103703.GC2097@ubuntu>
Sender: linux-clk-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 03-12-15, 11:26, Ben Gamari wrote:
>> Sounds reasonable to me. However, I'd just like to reiterate that this
>> line of work can be pursued independently from the upstreaming of this
>> series.
>
> I think this is the right time to upstream the right solution. Just
> try it once, if you face lots of difficulties or issues, then we can
> ofcourse see..
>
It looks like Bartlomiej has picked up this set. Regardless, while
tracking down various devicetree issues I noticed that the cpu-supply
and cpu%d-supply bindings appear to be completely undocumented. It
seem as though this ought to be fixed.

Cheers,

- Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJWZffJAAoJEHPt6ejPuu8B55wIAKhCh+3B6L0jnOwpTB01ThWf
1x+S2hVSklTT8Fsr/kqvmYtl0rQzuEiZYU5/KcZBGA2Mys5bpLQz+kY84jQ94lvh
J7QSoZ1kieWFtKE41MZ+TfqJ1k2/xKZ9TIllkl2yNq89zEbIjF+ePgO2j5l+jH81
s1RK0IbHbmlLhcnqRVUmSBuB+nsvHPVCHWOQvpfIsWQdQmqpYhIPoAZe9UdbjPTC
qF58N5EPrhTty/1dxQOlXm1LhxGunmSvtsfUGbXAOyuS5PQDph0RDDSCOR5OZmKg
QW0b8r7Qgz0P3XAOsP4sCT+tk2H6rrWz4BUw5yNPFLcHO+0crZWzZSTvW/2lP0s=
=on3T
-----END PGP SIGNATURE-----
--=-=-=--
