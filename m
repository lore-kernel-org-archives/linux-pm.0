From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 0/4] ARM: EXYNOS: cpuidle: fix AFTR mode on boards
 with secure firmware enabled
Date: Wed, 30 Jul 2014 18:30:47 +0200
Message-ID: <53D91DB7.8050806@linaro.org>
References: <1404926274-18411-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1404926274-18411-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org


Hi Bartlomiej,

I tried to apply this patchset on top of next-20140708 but it does not=20
apply.

Do you have a more recent version ?

Thanks in advance

   -- Daniel

On 07/09/2014 07:17 PM, Bartlomiej Zolnierkiewicz wrote:
> Hi,
>
> This patch series adds support for AFTR idle mode on boards with
> secure firmware enabled and allows EXYNOS cpuidle driver usage on
> Exynos4x12 SoCs.
>
> It has been tested on Trats2 board (using Exynos4412 SoC with secure
> firmware enabled) on which AFTR mode reduces power consumption by ~12=
%
> when EXYNOS cpuidle driver is enabled (in both cases the default
> exynos_defconfig config is used and CPU1-3 are offlined).
>
> v3:
> - rebased on top of next-20140708 +
>    http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg3=
2809.html
>    (with rejects fixed)
>    http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg3=
2808.html
>    http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg3=
2991.html
>    (with rejects fixed in patch #2)
> - addressed review comments from Tomasz Figa and Daniel Lezcano
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
>
> Bartlomiej Zolnierkiewicz (4):
>    ARM: EXYNOS: PM: replace EXYNOS_BOOT_VECTOR_* macros by static inl=
ines
>    ARM: EXYNOS: add AFTR mode support to firmware do_idle method
>    ARM: EXYNOS: cpuidle: add secure firmware support to AFTR mode cod=
e
>    ARM: EXYNOS: cpuidle: allow driver usage on Exynos4x12 SoCs
>
>   arch/arm/include/asm/firmware.h  |  2 +-
>   arch/arm/mach-exynos/common.h    |  7 ++++++-
>   arch/arm/mach-exynos/exynos.c    |  3 ++-
>   arch/arm/mach-exynos/firmware.c  | 36 ++++++++++++++++++++++++++---=
-------
>   arch/arm/mach-exynos/pm.c        | 39 +++++++++++++++++++++++++++++=
----------
>   drivers/cpuidle/cpuidle-exynos.c |  6 +++---
>   6 files changed, 67 insertions(+), 26 deletions(-)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
