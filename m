From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v1 3/3] thermal: tsens: Fix negative temperature reporting
Date: Thu, 26 Jul 2018 15:47:54 +0530
Message-ID: <CAHLCerO2CyqzLi2MM_58nRGyigSZk4k56EwxqU=zg9Xak5rbzw@mail.gmail.com>
References: <cover.1531898088.git.amit.kucheria@linaro.org>
 <42d6f2a6f9babd6351bd2fcde4000d5ca9c351ce.1531898088.git.amit.kucheria@linaro.org>
 <20180725234936.GT129942@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725234936.GT129942@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Andy Gross <andy.gross@linaro.org>, Douglas Anderson <dianders@chromium.org>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 26, 2018 at 5:19 AM, Matthias Kaehlcke <mka@chromium.org> wrote:
> On Wed, Jul 18, 2018 at 12:55:03PM +0530, Amit Kucheria wrote:
>> The current code will always return 0xffffffff in case of negative
>> temperatures due to a bug in how the binary sign extension is being done.
>>
>> Use sign_extend32() instead.
>>
>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>> ---
>>  drivers/thermal/qcom/tsens-v2.c | 13 +++++--------
>>  1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
>> index 908e3dc..46abc21 100644
>> --- a/drivers/thermal/qcom/tsens-v2.c
>> +++ b/drivers/thermal/qcom/tsens-v2.c
>> @@ -5,19 +5,20 @@
>>   */
>>
>>  #include <linux/regmap.h>
>> +#include <linux/bitops.h>
>>  #include "tsens.h"
>>
>>  #define STATUS_OFFSET                0xa0
>>  #define LAST_TEMP_MASK               0xfff
>>  #define STATUS_VALID_BIT     BIT(21)
>> -#define CODE_SIGN_BIT                BIT(11)
>>
>>  static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>>  {
>>       struct tsens_sensor *s = &tmdev->sensor[id];
>>       u32 code;
>>       unsigned int status_reg;
>> -     int last_temp = 0, last_temp2 = 0, last_temp3 = 0, ret;
>> +     u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0;
>> +     int ret;
>>
>>       status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
>>       ret = regmap_read(tmdev->map, status_reg, &code);
>> @@ -54,12 +55,8 @@ static int get_temp_tsens_v2(struct tsens_device *tmdev, int id, int *temp)
>>       else if (last_temp2 == last_temp3)
>>               last_temp = last_temp3;
>>  done:
>> -     /* Code sign bit is the sign extension for a negative value */
>> -     if (last_temp & CODE_SIGN_BIT)
>> -             last_temp |= ~CODE_SIGN_BIT;
>> -
>> -     /* Temperatures are in deciCelicius */
>> -     *temp = last_temp * 100;
>> +     /* Convert temperatures to milliCelicius */
>
> nits:
>
> s/temperatures/temperature/
> s/milliCelicius/milliCelsius/

Embarrassing to have two typos in a single sentence. :-)

>> +     *temp = sign_extend32(last_temp, fls(LAST_TEMP_MASK) - 1) * 100;
>>
>>       return 0;
>>  }
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Thanks for the review.
