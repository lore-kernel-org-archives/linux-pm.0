From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH 1/2] thermal: exynos: Fix wrong control of power down
 detection mode for Exynos7
Date: Wed, 25 Feb 2015 17:39:06 +0530
Message-ID: <CAM4voakf6oeSEdtGtHRzQ-tC6XMbsU+VNtBnqeed8J4btKA3Yg@mail.gmail.com>
References: <1424753815-15113-1-git-send-email-cw00.choi@samsung.com>
	<1424753815-15113-2-git-send-email-cw00.choi@samsung.com>
	<20150225100330.0ef63a95@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150225100330.0ef63a95@amdc2363>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Amit Kachhap <amit.daniel@samsung.com>, inki.dae@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On Wed, Feb 25, 2015 at 2:33 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Abhilash,
>
>> This patch fixes the wrong control of PD_DET_EN (power down detection
>> mode) for Exynos7 because exynos7_tmu_control() always enables the
>> power down detection mode regardless 'on' parameter.
>>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/thermal/samsung/exynos_tmu.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/samsung/exynos_tmu.c
>> b/drivers/thermal/samsung/exynos_tmu.c index 933cd80..a60f527 100644
>> --- a/drivers/thermal/samsung/exynos_tmu.c
>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>> @@ -682,6 +682,7 @@ static void exynos7_tmu_control(struct
>> platform_device *pdev, bool on)
>>       if (on) {
>>               con |= (1 << EXYNOS_TMU_CORE_EN_SHIFT);
>> +             con |= (1 << EXYNOS7_PD_DET_EN_SHIFT);
>>               interrupt_en =
>>                       (of_thermal_is_trip_valid(tz, 7)
>>                       << EXYNOS7_TMU_INTEN_RISE7_SHIFT) |
>> @@ -704,9 +705,9 @@ static void exynos7_tmu_control(struct
>> platform_device *pdev, bool on) interrupt_en <<
>> EXYNOS_TMU_INTEN_FALL0_SHIFT; } else {
>>               con &= ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
>> +             con &= ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
>>               interrupt_en = 0; /* Disable all interrupts */
>>       }
>> -     con |= 1 << EXYNOS7_PD_DET_EN_SHIFT;
>>
>>       writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
>>       writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
>
> Could you test this patch if it isn't introducing any regression on your
> HW?

The patch does not cause any regression on exynos7 and seems logically correct.

Tested-by: Abhilash Kesavan <a.kesavan@samsung.com>


Regards,
Abhilash
>
> --
> Best regards,
>
> Lukasz Majewski
>
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
