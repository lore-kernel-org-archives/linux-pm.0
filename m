From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 3/5] thermal: exynos: increase the number of trips for exynos542x
Date: Wed, 18 Jul 2018 01:29:53 +0530
Message-ID: <CANAwSgTx=vYcQ4zrcBQ=GpQ9gXJ+26T7zCF-_zLAh8SxVmcv=A@mail.gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
 <1531822342-4293-3-git-send-email-linux.amoon@gmail.com> <CAJKOXPe_omjhLMfMScTeXG2k908WT4MesMK5obpA0ejBs=vrfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPe_omjhLMfMScTeXG2k908WT4MesMK5obpA0ejBs=vrfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 17 July 2018 at 17:55, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 17 July 2018 at 12:12, Anand Moon <linux.amoon@gmail.com> wrote:
>> increase the number of trips to support more polling modes,
>> changes help supress following warning.
>>
>> [    4.231731] thermal thermal_zone0: failed to read out thermal zone (-22)
>> [    4.237190] exynos-tmu 10060000.tmu: More trip points than supported by this TMU.
>> [    4.244661] exynos-tmu 10060000.tmu: 2 trip points should be configured in polling mode.
>> [    4.254821] thermal thermal_zone1: failed to read out thermal zone (-22)
>> [    4.260370] exynos-tmu 10064000.tmu: More trip points than supported by this TMU.
>> [    4.267631] exynos-tmu 10064000.tmu: 2 trip points should be configured in polling mode.
>> [    4.277551] thermal thermal_zone2: failed to read out thermal zone (-22)
>> [    4.283090] exynos-tmu 10068000.tmu: More trip points than supported by this TMU.
>> [    4.290438] exynos-tmu 10068000.tmu: 2 trip points should be configured in polling mode.
>> [    4.300280] thermal thermal_zone3: failed to read out thermal zone (-22)
>> [    4.305711] exynos-tmu 1006c000.tmu: More trip points than supported by this TMU.
>> [    4.313171] exynos-tmu 1006c000.tmu: 2 trip points should be configured in polling mode.
>> [    4.323002] thermal thermal_zone4: failed to read out thermal zone (-22)
>>
>> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>
> NAK
>
> Exynos5420/5422/5800 has 4 trip points (understood as in current driver design).
>

Ok no issue.

Best Regards
-Anand
