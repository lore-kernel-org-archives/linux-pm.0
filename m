From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: [PATCH v5 0/12] cpufreq: Add support for Exynos 5800, 5420, and 5422
Date: Thu, 03 Dec 2015 12:21:33 +0100
Message-ID: <87y4db3hhe.fsf@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org> <20151203060527.GH4302@ubuntu> <877fkv4ylk.fsf@smart-cactus.org> <20151203103703.GC2097@ubuntu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:50948 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbbLCLVk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2015 06:21:40 -0500
In-Reply-To: <20151203103703.GC2097@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <Sudeep.Holla@arm.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 03-12-15, 11:26, Ben Gamari wrote:
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>> > But, before I start reviewing this series, I have few comments.
>> > - We weren't able to use cpufreq-dt driver for big LITTLE platforms
>> >   earlier, as it never had multi cluster support and we wanted
>> >   clock-sharing information via DT.
>>=20
>> Fair enough.
>>=20
>> > - That is all fixed now.
>>=20
>> I did not see any mention of this in the cpufreq-dt driver binding
>> documentation, otherwise I would have tried going this route.
>>=20
>> Do you have any references? I'd be happy to examine what would be
>> necessary to go this route although, being an independent contributor,
>> it may take time.
>
> You wouldn't find in cpufreq-dt documentation as its not specific to
> that. I have seen you DT patches now, and you have created the OPP
> tables mostly correctly. Just create the cpufreq-platform device for
> cpufreq-dt instead of arm-big-little one. And it should just work.
>
Do you mean something along these lines? [1]

>> Sounds reasonable to me. However, I'd just like to reiterate that this
>> line of work can be pursued independently from the upstreaming of this
>> series.
>
> I think this is the right time to upstream the right solution. Just
> try it once, if you face lots of difficulties or issues, then we can
> ofcourse see..
>
Sure. I didn't realize things were so close to being functional. Thanks
for the hint. I'll give it a shot next time my XU4 is free.

> NOTE: Check how OPP nodes are required to be created now in
> linux-next. They should be named like opp@<freq-hz>. Something I
> noticed in your DTs.
>
I've fixed this in the branch.

Thanks again.

Cheers,

=2D Ben


[1] https://github.com/bgamari/linux/commit/285778aaff464d4dcf152f3e9e0df3d=
8c6909576

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJWYCW9AAoJEHPt6ejPuu8BPhoH/2+2XCkVE9oKeowoiQyN2Bf6
43IVULYS/gO6MNJ4k3ix42D0Tz2690ty85XOP7U7Zih400ddkjV68r0w9Wo8BzCi
9oCxJc59JnmCYLOgFfGH7mJmwW2KCcBdUDAXwmURQyXQ7R7BZY8iOzl0ukhJMw/B
UzAXLCMclSiZgRc8DND2NncgLKuUbBS7nl7JnImeNhlNlC+YGlLBkRSTdewYHlXE
nc8lK+1EsiOnmkoEheVld3TDU81++IPij9p0CmE/gbS2RadpbL/c39PzMokipI50
7uaZGrNXnu2J1IhvUujsROPU+5MJk6jOZenUEbDSJOW9JaQqSykld3pZ/9K5IRY=
=ZFig
-----END PGP SIGNATURE-----
--=-=-=--
