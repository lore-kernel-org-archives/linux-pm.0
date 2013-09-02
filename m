From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] ARM: EXYNOS: add cpuidle-exynos.max_states kernel
 parameter
Date: Mon, 02 Sep 2013 10:54:17 +0200
Message-ID: <52245239.4000903@linaro.org>
References: <4002844.4ZqqJexTv4@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4002844.4ZqqJexTv4@amdc1032>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Tomasz Figa <t.figa@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/30/2013 12:21 PM, Bartlomiej Zolnierkiewicz wrote:
> Add "cpuidle-exynos.max_states=3D" parameter to allow user to specify
> the maximum of allowed CPU idle states for ARM EXYNOS cpuidle driver.
>=20
> This change is needed because C1 state (AFTR mode) is often not able
> to work properly due to incompatibility with some bootloader versions=
=2E
>=20
> Usage examples:
>=20
> "cpuidle-exynos.max_states=3D1" disables C1 state (AFTR mode).
>=20
> "cpuidle-exynos.max_states=3D0" disables the driver completely.
>=20
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>

There is a max_cstate option for acpi and intel idle. There is also the
cpuidle.off=3D1 option. As the semantic is the same, I think adding a
common cpuidle option usable for all the drivers is better.

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
