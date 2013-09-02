From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] ARM: EXYNOS: convert cpuidle driver to be a platform
 driver
Date: Mon, 02 Sep 2013 11:09:55 +0200
Message-ID: <522455E3.4020500@linaro.org>
References: <86136702.IKrZfWSsO8@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <86136702.IKrZfWSsO8@amdc1032>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tomasz Figa <t.figa@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/30/2013 12:15 PM, Bartlomiej Zolnierkiewicz wrote:
> ARM EXYNOS cpuidle driver is currently not multiplatform support read=
y
> (as it uses device_initcall() for initialization and doesn't check on
> what platform it is running). Fix it by converting the driver to be
> a platform driver and registering exynos_cpuidle platform device from
> exynos[4,5]_dt_machine_init().
>=20
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
