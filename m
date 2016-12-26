From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 4/9] pinctrl: samsung: Use generic of_device_get_match_data
 helper
Date: Mon, 26 Dec 2016 14:44:26 +0900
Message-ID: <CA+Ln22FfYkxJAOtpfr1UUai6vZej09NSZa6cz2cuO2aHN8Trmw@mail.gmail.com>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122527epcas1p441f0ee34c5738645163ef40c94591183@epcas1p4.samsung.com>
 <1482495889-6201-5-git-send-email-m.szyprowski@samsung.com> <20161225125607.a66kwtweizran4qw@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161225125607.a66kwtweizran4qw@kozik-lap>
Sender: linux-gpio-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

2016-12-25 21:56 GMT+09:00 Krzysztof Kozlowski <krzk@kernel.org>:
> On Fri, Dec 23, 2016 at 01:24:44PM +0100, Marek Szyprowski wrote:
>> Replace custom code with generic helper.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/pinctrl/samsung/pinctrl-samsung.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
>> index 4d9262051ff1..a6c2ea74e0f3 100644
>> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
>> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/err.h>
>>  #include <linux/gpio.h>
>>  #include <linux/irqdomain.h>
>> +#include <linux/of_device.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/syscore_ops.h>
>>
>> @@ -967,15 +968,13 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
>>       return 0;
>>  }
>>
>> -static const struct of_device_id samsung_pinctrl_dt_match[];
>> -
>>  /* retrieve the soc specific data */
>>  static const struct samsung_pin_ctrl *
>>  samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
>>                            struct platform_device *pdev)
>>  {
>>       int id;
>> -     const struct of_device_id *match;
>> +     const struct samsung_pin_ctrl *match_data;
>>       struct device_node *node = pdev->dev.of_node;
>>       struct device_node *np;
>>       const struct samsung_pin_bank_data *bdata;
>> @@ -990,8 +989,8 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
>>               dev_err(&pdev->dev, "failed to get alias id\n");
>>               return ERR_PTR(-ENOENT);
>>       }
>> -     match = of_match_node(samsung_pinctrl_dt_match, node);
>> -     ctrl = (struct samsung_pin_ctrl *)match->data + id;
>> +     match_data = of_device_get_match_data(&pdev->dev);
>> +     ctrl = match_data + id;
>
> Either you need a check for match_data != NULL or just remove match_data
> and:
>         ctrl = of_device_get_match_data();
>         ctrl += id;
>
> Actually match_data can be removed even with the check for non-NULL...

I don't think this function can ever return NULL if the match array
contains a non-NULL value for each compatible string and the driver
can be probed only by DT.
But you still need to cast the match data pointer to the correct type
and using a variable for it IMHO makes the code cleaner.

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
