From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 1/2] PM / devfreq: exynos-nocp: Select REGMAP_MMIO
Date: Fri, 30 Sep 2016 23:11:02 +0900
Message-ID: <CAJ0PZbS87NubKvYACd9NG4cb3LKP9mr9Sc=nSmdSEDUh7vFVbg@mail.gmail.com>
References: <CGME20160920085823epcas1p1f0fed4f248efcccccbce71438c03a9a1@epcas1p1.samsung.com>
 <1474361863-2319-1-git-send-email-axel.lin@ingics.com> <57E101CE.4050502@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <57E101CE.4050502@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Axel Lin <axel.lin@ingics.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Kyungmin Park <kyungmin.park@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 20, 2016 at 6:30 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote=
:
> Hi,
>
> On 2016=EB=85=84 09=EC=9B=94 20=EC=9D=BC 17:57, Axel Lin wrote:
>> This drvier uses devm_regmap_init_mmio(), so select REGMAP_MMIO to avoid
>> build failure.
>
> s/drvier/driver
>
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>>  drivers/devfreq/event/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/devfreq/event/Kconfig b/drivers/devfreq/event/Kconf=
ig
>> index 0fdae86..cd94980 100644
>> --- a/drivers/devfreq/event/Kconfig
>> +++ b/drivers/devfreq/event/Kconfig
>> @@ -17,6 +17,7 @@ config DEVFREQ_EVENT_EXYNOS_NOCP
>>       tristate "EXYNOS NoC (Network On Chip) Probe DEVFREQ event Driver"
>>       depends on ARCH_EXYNOS || COMPILE_TEST
>>       select PM_OPP
>> +     select REGMAP_MMIO
>>       help
>>         This add the devfreq-event driver for Exynos SoC. It provides No=
C
>>         (Network on Chip) Probe counters to measure the bandwidth of AXI=
 bus.
>>
>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

>
> --
> Best Regards,
> Chanwoo Choi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-s=
oc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
