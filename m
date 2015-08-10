From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH] thermal: rockhip: fix setting thermal shutdown polarity
Date: Mon, 10 Aug 2015 14:37:42 +0800
Message-ID: <55C846B6.2050303@rock-chips.com>
References: <20150807210052.GA34032@dtor-ws> <55C84611.10904@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C84611.10904@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Eduardo Valentin <edubezval@gmail.com>, dianders@chromium.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Sorry, forgot it!
\s 'rockhip' to 'rockchip' :-)

=E5=9C=A8 2015=E5=B9=B408=E6=9C=8810=E6=97=A5 14:34, Caesar Wang =E5=86=
=99=E9=81=93:
> Dear Dmitry,
>
> Thanks to work for it.
>
> =E5=9C=A8 2015=E5=B9=B408=E6=9C=8808=E6=97=A5 05:00, Dmitry Torokhov =
=E5=86=99=E9=81=93:
>> When requested thermal shutdown signal polarity is low we need to ma=
ke
>> sure that the bit representing high level of signal is reset, and no=
t
>> set all other bits in that register.
>>
>> Also rename TSADCV2_INT_PD_CLEAR to TSADCV2_INT_PD_CLEAR_MASK to bet=
ter
>> reflect its nature.
>>
>> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
>
>  Acked-by: Caesar Wang <wxt@rock-chips.com>
>
> --=20
> Thanks,
> Caesar
>
>> ---
>>   drivers/thermal/rockchip_thermal.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/thermal/rockchip_thermal.c=20
>> b/drivers/thermal/rockchip_thermal.c
>> index 93ee307..4d5b7d4 100644
>> --- a/drivers/thermal/rockchip_thermal.c
>> +++ b/drivers/thermal/rockchip_thermal.c
>> @@ -106,16 +106,14 @@ struct rockchip_thermal_data {
>>   #define TSADCV2_AUTO_PERIOD_HT            0x6c
>>     #define TSADCV2_AUTO_EN                BIT(0)
>> -#define TSADCV2_AUTO_DISABLE            ~BIT(0)
>>   #define TSADCV2_AUTO_SRC_EN(chn)        BIT(4 + (chn))
>>   #define TSADCV2_AUTO_TSHUT_POLARITY_HIGH    BIT(8)
>> -#define TSADCV2_AUTO_TSHUT_POLARITY_LOW        ~BIT(8)
>>     #define TSADCV2_INT_SRC_EN(chn)            BIT(chn)
>>   #define TSADCV2_SHUT_2GPIO_SRC_EN(chn)        BIT(4 + (chn))
>>   #define TSADCV2_SHUT_2CRU_SRC_EN(chn)        BIT(8 + (chn))
>>   -#define TSADCV2_INT_PD_CLEAR            ~BIT(8)
>> +#define TSADCV2_INT_PD_CLEAR_MASK        ~BIT(8)
>>     #define TSADCV2_DATA_MASK            0xfff
>>   #define TSADCV2_HIGHT_INT_DEBOUNCE_COUNT    4
>> @@ -244,10 +242,10 @@ static void rk_tsadcv2_initialize(void __iomem=
=20
>> *regs,
>>                     enum tshut_polarity tshut_polarity)
>>   {
>>       if (tshut_polarity =3D=3D TSHUT_HIGH_ACTIVE)
>> -        writel_relaxed(0 | (TSADCV2_AUTO_TSHUT_POLARITY_HIGH),
>> +        writel_relaxed(0U | TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
>>                      regs + TSADCV2_AUTO_CON);
>>       else
>> -        writel_relaxed(0 | (TSADCV2_AUTO_TSHUT_POLARITY_LOW),
>> +        writel_relaxed(0U & ~TSADCV2_AUTO_TSHUT_POLARITY_HIGH,
>>                      regs + TSADCV2_AUTO_CON);
>>         writel_relaxed(TSADCV2_AUTO_PERIOD_TIME, regs +=20
>> TSADCV2_AUTO_PERIOD);
>> @@ -264,7 +262,7 @@ static void rk_tsadcv2_irq_ack(void __iomem *reg=
s)
>>       u32 val;
>>         val =3D readl_relaxed(regs + TSADCV2_INT_PD);
>> -    writel_relaxed(val & TSADCV2_INT_PD_CLEAR, regs + TSADCV2_INT_P=
D);
>> +    writel_relaxed(val & TSADCV2_INT_PD_CLEAR_MASK, regs +=20
>> TSADCV2_INT_PD);
>>   }
>>     static void rk_tsadcv2_control(void __iomem *regs, bool enable)
>
