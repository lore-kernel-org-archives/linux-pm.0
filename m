From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 5/6] thermal:exynos4: Enable support for Exynos4412 SoCs
Date: Mon, 22 Apr 2013 12:10:06 +0530
Message-ID: <CAK9yfHzbwOaSBuObhZEbX-CuZKNx7XRH++NbttKNYm-HB-mg-g@mail.gmail.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
	<1366389493-8239-6-git-send-email-l.majewski@samsung.com>
	<CADGdYn5LTq7iwuP0Hx=7BpdgQBU=Q7L-3pnSyu8MfQ0v3vVS1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CADGdYn5LTq7iwuP0Hx=7BpdgQBU=Q7L-3pnSyu8MfQ0v3vVS1A@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: amit kachhap <amit.kachhap@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 22 April 2013 11:55, amit kachhap <amit.kachhap@gmail.com> wrote:
> Hi,
>
> I have one suggestion,
>
> On Fri, Apr 19, 2013 at 10:08 PM, Lukasz Majewski
> <l.majewski@samsung.com> wrote:
>> Enable TMU support for Exynos4412 based target with device tree.
>>
>> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/thermal/exynos_thermal.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
>> index e922fa4..f54066d 100644
>> --- a/drivers/thermal/exynos_thermal.c
>> +++ b/drivers/thermal/exynos_thermal.c
>> @@ -819,6 +819,10 @@ static const struct of_device_id exynos_tmu_match[] = {
>>                 .data = (void *)EXYNOS4210_TMU_DRV_DATA,
>>         },
>>         {
>> +               .compatible = "samsung,exynos4412-tmu",
>> +               .data = (void *)EXYNOS_TMU_DRV_DATA,
>> +       },
> Instead of adding a new compatible string, "exynos5250-tmu" name can
> be re-used in the 4412 DT node file as 4412 and 5250 TMU controller
> are same.

In cases where they are the same, it was generally the previous
version of SoC that was added to the compatible list and re-used in
the higher ones. IIRC, in cases where exynos5 based string was already
defined a separate compatible string was added for exynos4 too (even
if they used same driver data).

-- 
With warm regards,
Sachin
