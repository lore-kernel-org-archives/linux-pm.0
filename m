From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 03/22] iio: adc: add support for X-Powers AXP20X and
 AXP22X PMICs ADCs
Date: Thu, 5 Jan 2017 16:27:50 +0800
Message-ID: <CAGb2v66n46KQAzQBUrDwx7sYADkRm3_XyCHf9imN+FiDkHfP1w@mail.gmail.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-4-quentin.schulz@free-electrons.com>
 <CAGb2v67S==AG=jZA=mO-bB4u1F2TOwhmBXg385W1xhUa3RAFbA@mail.gmail.com>
 <9acfe5e0-dc56-bd63-02b4-7bf34d49d62c@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <9acfe5e0-dc56-bd63-02b4-7bf34d49d62c@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-iio@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Lee Jones <lee.jones@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jonathan Cameron <jic23@kernel.org>, Icenowy Zheng <icenowy@aosc.xyz>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 5, 2017 at 4:06 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> Hi Chen-Yu,
>
> On 05/01/2017 06:42, Chen-Yu Tsai wrote:
>> On Tue, Jan 3, 2017 at 12:37 AM, Quentin Schulz
>> <quentin.schulz@free-electrons.com> wrote:
> [...]
>>> +
>>> +#define AXP20X_ADC_RATE_MASK                   (3 << 6)
>>> +#define AXP20X_ADC_RATE_25HZ                   (0 << 6)
>>> +#define AXP20X_ADC_RATE_50HZ                   BIT(6)
>>
>> Please be consistent with the format.
>>
>>> +#define AXP20X_ADC_RATE_100HZ                  (2 << 6)
>>> +#define AXP20X_ADC_RATE_200HZ                  (3 << 6)
>>> +
>>> +#define AXP22X_ADC_RATE_100HZ                  (0 << 6)
>>> +#define AXP22X_ADC_RATE_200HZ                  BIT(6)
>>> +#define AXP22X_ADC_RATE_400HZ                  (2 << 6)
>>> +#define AXP22X_ADC_RATE_800HZ                  (3 << 6)
>>
>> These are power-of-2 multiples of some base rate. May I suggest
>> a formula macro instead. Either way, you seem to be using only
>> one value. Will this be made configurable in the future?
>>
>
> Yes, I could use a formula macro instead. No plan to make it
> configurable, should I make it configurable?

I don't see a use case for that atm.

>>> +
>>> +#define AXP20X_ADC_CHANNEL(_channel, _name, _type, _reg)       \
>>> +       {                                                       \
>>> +               .type = _type,                                  \
>>> +               .indexed = 1,                                   \
>>> +               .channel = _channel,                            \
>>> +               .address = _reg,                                \
>>> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |  \
>>> +                                     BIT(IIO_CHAN_INFO_SCALE), \
>>> +               .datasheet_name = _name,                        \
>>> +       }
>>> +
>>> +#define AXP20X_ADC_CHANNEL_OFFSET(_channel, _name, _type, _reg) \
>>> +       {                                                       \
>>> +               .type = _type,                                  \
>>> +               .indexed = 1,                                   \
>>> +               .channel = _channel,                            \
>>> +               .address = _reg,                                \
>>> +               .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |  \
>>> +                                     BIT(IIO_CHAN_INFO_SCALE) |\
>>> +                                     BIT(IIO_CHAN_INFO_OFFSET),\
>>> +               .datasheet_name = _name,                        \
>>> +       }
>>> +
>>> +struct axp20x_adc_iio {
>>> +       struct iio_dev          *indio_dev;
>>> +       struct regmap           *regmap;
>>> +};
>>> +
>>> +enum axp20x_adc_channel {
>>> +       AXP20X_ACIN_V = 0,
>>> +       AXP20X_ACIN_I,
>>> +       AXP20X_VBUS_V,
>>> +       AXP20X_VBUS_I,
>>> +       AXP20X_TEMP_ADC,
>>
>> PMIC_TEMP would be better. And please save a slot for TS input.
>>
>
> ACK.
>
> Hum.. I'm wondering what should be the IIO type of the TS input channel
> then? The TS Pin can be used in two modes: either to monitor the
> temperature of the battery or as an external ADC, at least that's what I
> understand from the datasheet.

AFAIK the battery charge/discharge high/low temperature threshold
registers take values in terms of voltage, not actual temperature.
And the temperature readout kind of depends on the thermoresistor
one is using. So I think "voltage" would be the proper type.

>
>>> +       AXP20X_GPIO0_V,
>>> +       AXP20X_GPIO1_V,
>>
>> Please skip a slot for "battery instantaneous power".
>>
>>> +       AXP20X_BATT_V,
>>> +       AXP20X_BATT_CHRG_I,
>>> +       AXP20X_BATT_DISCHRG_I,
>>> +       AXP20X_IPSOUT_V,
>>> +};
>>> +
>>> +enum axp22x_adc_channel {
>>> +       AXP22X_TEMP_ADC = 0,
>>
>> Same comments as AXP20X_TEMP_ADC.
>>
>>> +       AXP22X_BATT_V,
>>> +       AXP22X_BATT_CHRG_I,
>>> +       AXP22X_BATT_DISCHRG_I,
>>> +};
>>
>> Shouldn't these channel numbers be exported as part of the device tree
>> bindings? At the very least, they shouldn't be changed.
>>
>
> I don't understand what you mean by that. Do you mean you want a
> consistent numbering between the AXP20X and the AXP22X, so that
> AXP22X_BATT_V would have the same channel number than AXP20X_BATT_V?
>
> Could you explain a bit more your thoughts on the channel numbers being
> exported as part of the device tree bindings?

What I meant was that, since you are referencing the channels in the
device tree, the numbering scheme would be part of the device tree
binding, and should never be changed. So either these would be macros
in include/dt-bindings/, or a big warning should be put before it.

But see my reply on patch 7, about do we actually need to expose this
in the device tree.

>> Also please add a comment saying that the channels are numbered
>> in the order of their respective registers, and not the table
>> describing the ADCs in the datasheet (9.7 Signal Capture for AXP209
>> and 9.5 E-Gauge for AXP221).
>>
>
> Yes I can.
>
> What about Rob wanting channel numbers to start at zero for each
> different IIO type (i.e., today we have AXP22X_BATT_CHRG_I being
> exported as in_current1_raw whereas he wants in_current0_raw).

Hmm... I missed this. Are you talking about IIO or hwmon? IIRC
hwmon numbers things starting at 1.

> [...]
>>> +static int axp22x_adc_read_raw(struct iio_dev *indio_dev,
>>> +                              struct iio_chan_spec const *channel, int *val,
>>> +                              int *val2)
>>> +{
>>> +       struct axp20x_adc_iio *info = iio_priv(indio_dev);
>>> +       int size = 12, ret;
>>> +
>>> +       switch (channel->channel) {
>>> +       case AXP22X_BATT_DISCHRG_I:
>>> +               size = 13;
>>> +       case AXP22X_TEMP_ADC:
>>> +       case AXP22X_BATT_V:
>>> +       case AXP22X_BATT_CHRG_I:
>>
>> According to the datasheet, AXP22X_BATT_CHRG_I is also 13 bits wide.
>>
>
> Where did you get that?
>
> Also, the datasheet is inconsistent:
>  - 9.5 E-Gauge Fuel Gauge system => the min value is at 0x0 and the max
> value at 0xfff for all channels, that's 12 bits.
>  - 10.1.4 ADC Data => all channels except battery discharge current are
> on 12 bits (8 high, 4 low).

My datasheets (AXP221 v1.6, AXP221s v1.2, AXP223 v1.1, all Chinese) say
in 10.1.4:

  - 7A: battery charge current high 5 bits
  - 7B: battery charge current low 8 bits
  - 7C: battery discharge current high 5 bits
  - 7D: battery discharge current low 8 bits

>
> [...]
>>> +static int axp22x_read_raw(struct iio_dev *indio_dev,
>>> +                          struct iio_chan_spec const *chan, int *val,
>>> +                          int *val2, long mask)
>>> +{
>>> +       switch (mask) {
>>> +       case IIO_CHAN_INFO_OFFSET:
>>> +               *val = -2667;
>>
>> Datasheet says -267.7 C, or -2677 here.
>>
>
> The formula in the datasheet is (in milli Celsius):
>  processed = raw * 100 - 266700;
>
> while the IIO framework asks for a scale and an offset which are then
> applied as:
>  processed = (raw + offset) * scale;
>
> Thus by factorizing, we get:
>  processed = (raw - 2667) * 100;

What I meant was that your lower end value is off by one degree,
-266.7 in your code vs -267.7 in the datasheet.

>
> [...]
>>> +static int axp20x_remove(struct platform_device *pdev)
>>> +{
>>> +       struct axp20x_adc_iio *info;
>>> +       struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>> +
>>> +       info = iio_priv(indio_dev);
>>
>> Nit: you could just reverse the 2 declarations above and join this
>> line after struct axp20x_adc_iio *info;
>>
>>> +       regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>>> +       regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
>>
>> The existing VBUS power supply driver enables the VBUS ADC bits itself,
>> and does not check them later on. This means if one were to remove this
>> axp20x-adc module, the voltage/current readings in the VBUS power supply
>> would be invalid. Some sort of workaround would be needed here in this
>> driver of the VBUS driver.
>>
>
> That would be one reason to migrate the VBUS driver to use the IIO
> channels, wouldn't it?

It is, preferably without changing the device tree.

Regards
ChenYu

>
> But ACK, I'll think about something to work around this issue.
>
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +static struct platform_driver axp20x_adc_driver = {
>>> +       .driver = {
>>> +               .name = "axp20x-adc",
>>> +               .of_match_table = axp20x_adc_of_match,
>>> +       },
>>> +       .probe = axp20x_probe,
>>> +       .remove = axp20x_remove,
>>> +};
>>> +
>>> +module_platform_driver(axp20x_adc_driver);
>>> +
>>> +MODULE_DESCRIPTION("ADC driver for AXP20X and AXP22X PMICs");
>>> +MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
>>> +MODULE_LICENSE("GPL");
>>> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
>>> index a4860bc..650c6f6 100644
>>> --- a/include/linux/mfd/axp20x.h
>>> +++ b/include/linux/mfd/axp20x.h
>>> @@ -150,6 +150,10 @@ enum {
>>>  #define AXP20X_VBUS_I_ADC_L            0x5d
>>>  #define AXP20X_TEMP_ADC_H              0x5e
>>>  #define AXP20X_TEMP_ADC_L              0x5f
>>> +
>>> +#define AXP22X_TEMP_ADC_H              0x56
>>> +#define AXP22X_TEMP_ADC_L              0x57
>>> +
>>
>> This is in the wrong patch. Also we already have
>>
>> /* AXP22X specific registers */
>> #define AXP22X_PMIC_ADC_H               0x56
>> #define AXP22X_PMIC_ADC_L               0x57
>> #define AXP22X_TS_ADC_H                 0x58
>> #define AXP22X_TS_ADC_L                 0x59
>>
>> If you want, you could just rename them to be consistent.
>>
>
> ACK.
>
> Thanks,
> Quentin
>
> --
> Quentin Schulz, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
