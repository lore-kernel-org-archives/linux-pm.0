From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv3] thermal: exynos: Add support for TRIM_RELOAD feature at
 Exynos3250
Date: Thu, 21 Aug 2014 10:38:14 +0900
Message-ID: <53F54D86.9070601@samsung.com>
References: <1408450078-6296-1-git-send-email-cw00.choi@samsung.com>
 <1408492364-8012-1-git-send-email-cw00.choi@samsung.com>
 <CAC-25o9LjKwjBwwxcOvV75bXEHGdUh2vU=ae1STsXxD6q4YsiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAC-25o9LjKwjBwwxcOvV75bXEHGdUh2vU=ae1STsXxD6q4YsiA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "edubezval@gmail.com" <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Valentin, Eduardo" <eduardo.valentin@ti.com>, Amit Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, l.majewski@samsung.com, naveen krishna <ch.naveen@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Dear Eduardo,

On 08/20/2014 10:38 PM, edubezval@gmail.com wrote:
> Hello Chanwoo,
> 
> On Tue, Aug 19, 2014 at 7:52 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch add support for TRIM_RELOAD feature at Exynos3250. The TMU of
>> Exynos3250 has two TRIMINFO_CON register.
> 
> Can you please split the two changes above into two patches? Meaning,
> one that adds TRIMINFO_CON2 and another that adds TRIM_RELOAD?

OK, I'll split this patch as two patches.

> 
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>> Changes from v2:
>> - Fix build break because of missing 'or' operation.
>> Changes from v1:
>> - Add missing 'TMU_SUPPORT_TRIM_RELOAD' feature
>>
>>  drivers/thermal/samsung/exynos_tmu.c      |  7 +++++--
>>  drivers/thermal/samsung/exynos_tmu.h      |  5 +++--
>>  drivers/thermal/samsung/exynos_tmu_data.c | 11 +++++++++--
>>  drivers/thermal/samsung/exynos_tmu_data.h |  7 +++++--
>>  4 files changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
>> index acbff14..ed01606 100644
>> --- a/drivers/thermal/samsung/exynos_tmu.c
>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>> @@ -164,8 +164,11 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>                 }
>>         }
>>
>> -       if (TMU_SUPPORTS(pdata, TRIM_RELOAD))
>> -               __raw_writel(1, data->base + reg->triminfo_ctrl);
>> +       if (TMU_SUPPORTS(pdata, TRIM_RELOAD)) {
>> +               for (i = 0; i < pdata->triminfo_reload_count; i++)
>> +                       __raw_writel(pdata->triminfo_reload[i],
>> +                                       data->base + reg->triminfo_ctrl[i]);
>> +       }
> 
> What is the logic behind the trim reload feature? Which SoCs support it?

TRIMINFO_CONTROL register has 'RELOAD' field. TMU of Exynos SOC have to set
'RELOAD' field of TRIMINFO_CONTROL register before reading TRIMINFO register.

As I know, Exynos4412/Exynos4212 and Exynos3250 SoC need RELOAD feature.

> 
>>
>>         if (pdata->cal_mode == HW_MODE)
>>                 goto skip_calib_data;
>> diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
>> index 1b4a644..72cb54e 100644
>> --- a/drivers/thermal/samsung/exynos_tmu.h
>> +++ b/drivers/thermal/samsung/exynos_tmu.h
>> @@ -151,8 +151,7 @@ struct exynos_tmu_registers {
>>         u32     triminfo_25_shift;
>>         u32     triminfo_85_shift;
>>
>> -       u32     triminfo_ctrl;
>> -       u32     triminfo_ctrl1;
>> +       u32     triminfo_ctrl[2];
> 
> 
> The above change needs to be documented.

OK, I'll add it.

> 
>>         u32     triminfo_reload_shift;
>>
>>         u32     tmu_ctrl;
>> @@ -295,6 +294,8 @@ struct exynos_tmu_platform_data {
>>         u8 second_point_trim;
>>         u8 default_temp_offset;
>>         u8 test_mux;
>> +       u8 triminfo_reload[2];
>> +       u8 triminfo_reload_count;
>>
> 
> The above addition needs to be documented too.

OK, I'll add it.

> 
>>         enum calibration_type cal_type;
>>         enum calibration_mode cal_mode;
>> diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
>> index aa8e0de..8cd609c 100644
>> --- a/drivers/thermal/samsung/exynos_tmu_data.c
>> +++ b/drivers/thermal/samsung/exynos_tmu_data.c
>> @@ -95,6 +95,8 @@ static const struct exynos_tmu_registers exynos3250_tmu_registers = {
>>         .triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
>>         .triminfo_25_shift = EXYNOS_TRIMINFO_25_SHIFT,
>>         .triminfo_85_shift = EXYNOS_TRIMINFO_85_SHIFT,
>> +       .triminfo_ctrl[0] = EXYNOS_TMU_TRIMINFO_CON1,
>> +       .triminfo_ctrl[1] = EXYNOS_TMU_TRIMINFO_CON2,
>>         .tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
>>         .test_mux_addr_shift = EXYNOS4412_MUX_ADDR_SHIFT,
>>         .buf_vref_sel_shift = EXYNOS_TMU_REF_VOLTAGE_SHIFT,
>> @@ -160,8 +162,11 @@ static const struct exynos_tmu_registers exynos3250_tmu_registers = {
>>                 .temp_level = 95, \
>>         }, \
>>         .freq_tab_count = 2, \
>> +       .triminfo_reload[0] = 0x1, \
>> +       .triminfo_reload[1] = 0x11, \
> 
> What does 0x1 mean? How about 0x11?

The bit of 'RELOAD' field in TRIMINFO_CONTROL register is [0].
and The bit of 'AC Time' field in TRIMINFO_CONTROL register is [5:4].

0x1 means that set RELOAD field.
0x11 means that set RELOAD field and ACTIME field.

> 
>> +       .triminfo_reload_count = 2, \
> 
> What is count?

Just, the number of TRIMINFO_CONTROL registers.
Exynos4412/4212 has only one TRIMINFO_CONTROL register
and Exynos3250 has two TRIMINFO_CONTROL register.

> 
>>         .registers = &exynos3250_tmu_registers, \
>> -       .features = (TMU_SUPPORT_EMULATION | \
>> +       .features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_TRIM_RELOAD | \
>>                         TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_READY_STATUS | \
>>                         TMU_SUPPORT_EMUL_TIME)
>>  #endif
>> @@ -184,7 +189,7 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
>>         .triminfo_data = EXYNOS_TMU_REG_TRIMINFO,
>>         .triminfo_25_shift = EXYNOS_TRIMINFO_25_SHIFT,
>>         .triminfo_85_shift = EXYNOS_TRIMINFO_85_SHIFT,
>> -       .triminfo_ctrl = EXYNOS_TMU_TRIMINFO_CON,
>> +       .triminfo_ctrl[0] = EXYNOS_TMU_TRIMINFO_CON2,
>>         .triminfo_reload_shift = EXYNOS_TRIMINFO_RELOAD_SHIFT,
>>         .tmu_ctrl = EXYNOS_TMU_REG_CONTROL,
>>         .test_mux_addr_shift = EXYNOS4412_MUX_ADDR_SHIFT,
>> @@ -252,6 +257,8 @@ static const struct exynos_tmu_registers exynos4412_tmu_registers = {
>>                 .temp_level = 95, \
>>         }, \
>>         .freq_tab_count = 2, \
>> +       .triminfo_reload[0] = 0x1, \
>> +       .triminfo_reload_count = 1, \
> 
> 
> Your patch description says nothing about TRIM_RELOAD on 4412, does it?

Exynos3250 has two triminfo_control register, existing exynos_tmu_platform_data
don't support Exynos3250 RELOAD feature because the existing exynos_tmu_platform_data
has only one triminfo_control register.

> 
> What about the other SoCs?

I has only boards based on Exynos4 and Exynos3250 SoC.
I can't test Exynos5 SoC series.

Best Regards,
Chanwoo Choi

> 
>>         .registers = &exynos4412_tmu_registers, \
>>         .features = (TMU_SUPPORT_EMULATION | TMU_SUPPORT_TRIM_RELOAD | \
>>                         TMU_SUPPORT_FALLING_TRIP | TMU_SUPPORT_READY_STATUS | \
>> diff --git a/drivers/thermal/samsung/exynos_tmu_data.h b/drivers/thermal/samsung/exynos_tmu_data.h
>> index f0979e5..e0536c3 100644
>> --- a/drivers/thermal/samsung/exynos_tmu_data.h
>> +++ b/drivers/thermal/samsung/exynos_tmu_data.h
>> @@ -57,8 +57,11 @@
>>  #define EXYNOS4210_TMU_TRIG_LEVEL_MASK 0x1111
>>  #define EXYNOS4210_TMU_INTCLEAR_VAL    0x1111
>>
>> -/* Exynos5250 and Exynos4412 specific registers */
>> -#define EXYNOS_TMU_TRIMINFO_CON        0x14
>> +/* Exynos3250 specific registers */
>> +#define EXYNOS_TMU_TRIMINFO_CON1       0x10
>> +
>> +/* Exynos5250, Exynos4412 and Exynos3250 specific registers */
>> +#define EXYNOS_TMU_TRIMINFO_CON2       0x14
>>  #define EXYNOS_THD_TEMP_RISE           0x50
>>  #define EXYNOS_THD_TEMP_FALL           0x54
>>  #define EXYNOS_EMUL_CON                0x80
>> --
>> 1.8.0
>>
> 
> 
> 
