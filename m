From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 2/2] power: supply: Add Spreadtrum SC27XX fuel gauge unit driver
Date: Thu, 20 Sep 2018 08:40:46 +0800
Message-ID: <CAMz4kuKboR+QBJ9sQoiSA0SQHGioufpjgv7nKYCugfDewx5PLA@mail.gmail.com>
References: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
 <1295864a38810a6db6c97e298c6663ae2b1350c1.1536736399.git.baolin.wang@linaro.org>
 <20180916143552.3oxjqpo6vravh5cy@earth.universe> <CAMz4kuJcA-Oo1vTtW=gf_oFmZ3TmgNxYPxO5wuWpy0Kcg2LFDw@mail.gmail.com>
 <20180920003630.ygvjnuutmd5n2vre@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920003630.ygvjnuutmd5n2vre@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 20 September 2018 at 08:36, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> Hi,
>
> On Mon, Sep 17, 2018 at 12:01:51PM +0800, Baolin Wang wrote:
> [...]
>> >> +static int sc27xx_fgu_parse_dt(struct sc27xx_fgu_data *data,
>> >> +                            struct device_node *np)
>> >> +{
>> >> +     const __be32 *list;
>> >> +     int i, len, size, ret;
>> >> +
>> >> +     ret = of_property_read_u32(np, "reg", &data->base);
>> >> +     if (ret) {
>> >> +             dev_err(data->dev, "failed to get fgu address\n");
>> >> +             return ret;
>> >> +     }
>> >> +
>> >> +     data->gpiod = devm_gpiod_get_optional(data->dev, "bat-detect", GPIOD_IN);
>> >> +     if (IS_ERR(data->gpiod)) {
>> >> +             dev_err(data->dev, "failed to get battery detection GPIO\n");
>> >> +             return PTR_ERR(data->gpiod);
>> >> +     }
>> >
>> > According to the binding (and the remaining code!) this gpio is not
>> > optional.
>>
>> Yes, they are not optional. If we can not get the detection GPIO, we
>> will return errors. So am I missing something else?
>>
>> Thanks for your comments.
>
> devm_gpiod_get_optional => devm_gpiod_get
>
> The _optional variant will return NULL if the GPIO is not specified in DT.
> The variant without _optional will return an error instead.

Ah, you are definitely correct. I missed _optional and thanks for
pointing this out.

-- 
Baolin Wang
Best Regards
