From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v6 6/6] power: supply: Add Spreadtrum SC27XX fuel gauge
 unit driver
Date: Thu, 1 Nov 2018 14:42:13 +0800
Message-ID: <CAMz4kuLwmk+F8w=3QKTn29OArMfCpZc-429m_nFn8bqFVQekgA@mail.gmail.com>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
 <6a4c15368e0bf34f8e6aad4d788bc899cfb9d61e.1540189330.git.baolin.wang@linaro.org>
 <CACRpkdaDB2f5FTY-sk6Ak49GMtqFzV_5Jkway49zSLA6XJkq0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaDB2f5FTY-sk6Ak49GMtqFzV_5Jkway49zSLA6XJkq0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>, Craig Tatlor <ctatlor97@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 31 October 2018 at 16:56, Linus Walleij <linus.walleij@linaro.org> wrote=
:
> On Mon, Oct 22, 2018 at 9:44 AM Baolin Wang <baolin.wang@linaro.org> wrot=
e:
>
>> This patch adds the Spreadtrum SC27XX serial PMICs fuel gauge support,
>> which is used to calculate the battery capacity.
>>
>> Original-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> Changes from v5:
>>  - Save the OCV values in micro volts for OCV capacity table.
>>  - Use devm_kmemdup() instead of devm_kzalloc() in sc27xx_fgu_hw_init()
>
> Hi Baolin, you can keep my ACK, just adding some nitpicking:

Thanks.

>
>> +struct sc27xx_fgu_data {
>> +       struct regmap *regmap;
>> +       struct device *dev;
>> +       struct power_supply *battery;
>> +       u32 base;
>> +       struct mutex lock;
>> +       struct gpio_desc *gpiod;
>> +       struct iio_channel *channel;
>> +       bool bat_present;
>> +       int internal_resist;
>> +       int total_cap;
>> +       int init_cap;
>> +       int init_clbcnt;
>> +       int max_volt;
>> +       int table_len;
>
> Can  the above really be negative or should these int:s really
> be unsigned int?

 I think the table_len can be changed to u32, but for others, I'd like
to keep consistency with the power supply battery information=E3=80=82

>
>> +static int sc27xx_fgu_adc_to_current(int adc)
>> +{
>> +       return (adc * 1000) / SC27XX_FGU_1000MA_ADC;
>> +}
>> +
>> +static int sc27xx_fgu_adc_to_voltage(int adc)
>> +{
>> +       return (adc * 1000) / SC27XX_FGU_1000MV_ADC;
>> +}
>
> Would you maybe use
> DIV_ROUND_CLOSEST(adc*1000, SC27XX_FGU_1000MV_ADC)
> on these?

Good point. Will change in next version. Thanks for your comments.

>
> Overall this is a very fine driver and really pretty compared to some
> other stuff we have in drivers/power.

Thanks.

--=20
Baolin Wang
Best Regards
