From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
Date: Wed, 30 Jan 2019 08:44:31 +0100
Message-ID: <81115ad5-521e-557b-d229-1effb92068a4@linaro.org>
References: <20190109055724.184692-1-pihsun@chromium.org>
 <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANdKZ0fRckMSUwHyChgBw162cVQe9_mnd_G9vwt=+CV+Y0WFfw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Shih <pihsun@chromium.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Michael.Kao@mediatek.com
List-Id: linux-pm@vger.kernel.org

On 30/01/2019 07:04, Peter Shih wrote:
> Adding Michael Kao to cc list.
> 
> On Wed, Jan 9, 2019 at 1:57 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>>
>> The mtk_thermal struct contains a 'struct mtk_thermal_bank banks[];',
>> but the allocation only allocates sizeof(struct mtk_thermal) bytes,
>> which cause out of bound access with the ->banks[] member. Change it to
>> a fixed size array instead.

Even if the fix is correct, it pushes back the bug later in time if a
new board containing more than MAX_NUM_ZONES is introduced. I suggest to
dynamically allocate the array with the 'num_banks' value.


>> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
>> ---
>>  drivers/thermal/mtk_thermal.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
>> index 0691f260f6eabe..ea11edb3fcced6 100644
>> --- a/drivers/thermal/mtk_thermal.c
>> +++ b/drivers/thermal/mtk_thermal.c
>> @@ -159,6 +159,9 @@
>>  #define MT7622_NUM_SENSORS_PER_ZONE    1
>>  #define MT7622_TS1     0
>>
>> +/* The maximum number of banks */
>> +#define MAX_NUM_ZONES          8
>> +
>>  struct mtk_thermal;
>>
>>  struct thermal_bank_cfg {
>> @@ -178,7 +181,7 @@ struct mtk_thermal_data {
>>         const int *sensor_mux_values;
>>         const int *msr;
>>         const int *adcpnp;
>> -       struct thermal_bank_cfg bank_data[];
>> +       struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
>>  };
>>
>>  struct mtk_thermal {
>> @@ -197,7 +200,7 @@ struct mtk_thermal {
>>         s32 vts[MT8173_NUM_SENSORS];
>>
>>         const struct mtk_thermal_data *conf;
>> -       struct mtk_thermal_bank banks[];
>> +       struct mtk_thermal_bank banks[MAX_NUM_ZONES];
>>  };
>>
>>  /* MT8173 thermal sensor data */
>> --
>> 2.20.1.97.g81188d93c3-goog
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
