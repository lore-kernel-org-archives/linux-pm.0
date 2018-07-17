From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos platform
Date: Wed, 18 Jul 2018 01:53:59 +0530
Message-ID: <CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com> <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPdP78VFQgSQ9z9WsgYY_YhEKPUt=0MOra6Pz6smQeiNGg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof

On 17 July 2018 at 17:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Hi Anand,
>
> Thanks for patch.
>
> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>> clk_summary do not show tmu_apbif clk enable, so replace
>> the clk_prepare with clk_prepare_enables to enable tmu clk.
>
> This is not valid reason to do a change. What is clk_summary does not
> really matter. Your change has negative impact on power consumption as
> the clock stays enabled all the time. This is not what we want... so
> please explain it more - why you need the clock to be enabled all the
> time? What is broken (clk_summary is not broken in this case)?
>

Opps I could not explain some more in my commit message.

Actually TMU sensor for Exynos process are controlled by so external clk

Exynos4412 have VDD18_TS sensor which controls the CLK_SENSE tmu.
Exynos5422 have VDD18_TS01 / VDD18_TS23 / VDD18_TS4 sensor which
control the CLK_SENSE tmu.

So as per my understanding tmu is clk driver which control the flow  PMIC.

clk_prepare_enable combine clk_prepare and clk_enable
and clk_disable_unprepare combine clk_disable and clk_unprepare.

most of the driver prefer clk_prepare_enable and clk_disable_unprepare.

clk_summary is just a reference looking point where we could check the
clk is enable/disable.

what is broken ?
I still few more parameter need to tuned to configure the tmu driver.

>> simplify the enable of tmu_triminfo_apbif clk, also fixed
>> the order of goto error for failed cases.
>
> This has to be split into separate change.
>
> Best regards,
> Krzysztof

Best Regards
-Anand
