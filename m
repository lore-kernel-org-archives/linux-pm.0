From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 0/5] PM / devfreq: remove modular references from
 non-modules
Date: Tue, 21 Jun 2016 15:17:01 +0900
Message-ID: <5768DBDD.6030704@samsung.com>
References: <CGME20160621051708epcas1p4d2bacb86070cd65ec1fba990e108425e@epcas1p4.samsung.com>
 <20160621051501.18396-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160621051501.18396-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Paul,

It is good for devfreq/devfreq-event framework(patch1/patch2).

But, I think that the device driver (patch3/4/5) should change
the type from 'bool' to 'tristate' instead of using the .

Thanks,
Chanwoo Choi

On 2016=EB=85=84 06=EC=9B=94 21=EC=9D=BC 14:14, Paul Gortmaker wrote:
> For anyone new to the underlying goal of this cleanup, we are trying =
to
> not use module support for code that can never be built as a module s=
ince:
>=20
>  (1) it is easy to accidentally write unused module_exit and remove c=
ode
>  (2) it can be misleading when reading the source, thinking it can be
>      modular when the Makefile and/or Kconfig prohibit it
>  (3) it requires the include of the module.h header file which in tur=
n
>      includes nearly everything else, thus adding to CPP overhead.
>  (4) it gets copied/replicated into other code and spreads like weeds=
=2E
>=20
> We have already merged over 100 of these for mainline to date, so the=
re
> is really nothing new to see here, in terms of the type of change.
>=20
> That said, devfreq changes seen here cover the following categories:
>=20
>   -just replacement of modular macros with their non-modular
>    equivalents that CPP would have inserted anyway
>=20
>   -the removal of including module.h ; replaced with init.h
>    and/or export.h as required based on whether the file used it.
>=20
>   -the removal of any/all unused/orphaned __exit functions that
>    would never be called.
>=20
>   -the removal of any ".remove" functions that were hooked into
>    the driver struct.   This ".remove" function would of
>    course not be called from the __exit function since that was
>    never run.  However in theory, someone could have triggered it
>    via sysfs unbind, even though there isn't a sensible use case
>    for doing so.  So to cover that possibility, we've also disabled
>    sysfs unbind in the driver.
>=20
> There are no initcall level changes here; everything stays at the lev=
el
> of initcall it was previously - either by not using modular versions =
to
> begin with, or by using the builtin level equivalents.
>=20
> Build tested for arm and arm64 allmodconfig (for which all the driver=
s
> touched here get coverage) on the linux-next tree from today to ensur=
e
> no silly typos crept in.
>=20
> If there is a desire for any of these to be modular, we can definitel=
y
> consider that, but by default the changes here keep the code consiste=
nt
> with existing behaviour.  Thus I do not expand functionality into the
> modular realm that I can't run time test, or even know if the modular
> instance has a sensible modular use case.
>=20
> Paul.
> ---
>=20
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
>=20
>=20
> Paul Gortmaker (5):
>   PM / devfreq: make devfreq explicitly non-modular
>   PM / devfreq: make devfreq-event explicitly non-modular
>   PM / devfreq: make exynos-bus explicitly non-modular
>   PM / devfreq: make event/exynos-nocp explicitly non-modular
>   PM / devfreq: make event/exynos-ppmu explicitly non-modular
>=20
>  drivers/devfreq/devfreq-event.c     | 12 +-----------
>  drivers/devfreq/devfreq.c           | 13 +------------
>  drivers/devfreq/event/exynos-nocp.c | 19 +++----------------
>  drivers/devfreq/event/exynos-ppmu.c |  8 ++------
>  drivers/devfreq/exynos-bus.c        |  9 ++-------
>  5 files changed, 9 insertions(+), 52 deletions(-)
>=20
