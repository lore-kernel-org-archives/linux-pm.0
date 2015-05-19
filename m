From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/2] power_supply: Add support for TI BQ25890 charger chip
Date: Tue, 19 May 2015 19:03:40 +0900
Message-ID: <CAJKOXPfRUePLAjiFU_V0p1n0sfJXqmk0dUBbq16nfFJeJai+Ww@mail.gmail.com>
References: <1431698778-29462-1-git-send-email-laurentiu.palcu@intel.com>
	<1431698778-29462-3-git-send-email-laurentiu.palcu@intel.com>
	<CAJKOXPfDcTMEd576cVspXKT2kb__49rQSk-BbxXy5ZinO8n5yA@mail.gmail.com>
	<20150519091442.GF14396@lpalcu-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150519091442.GF14396@lpalcu-linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurentiu Palcu <laurentiu.palcu@intel.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

2015-05-19 18:14 GMT+09:00 Laurentiu Palcu <laurentiu.palcu@intel.com>:
> Hi Krzysztof,
>
> On Tue, May 19, 2015 at 05:40:25PM +0900, Krzysztof Kozlowski wrote:
>> > +
>> > +static int bq25890_chip_reset(struct bq25890_device *bq)
>> > +{
>> > +       int ret;
>> > +
>> > +       ret = bq25890_field_write(bq, F_REG_RST, 1);
>> > +       if (ret < 0)
>> > +               return ret;
>> > +
>> > +       do {
>> > +               ret = bq25890_field_read(bq, F_REG_RST);
>> > +               if (ret < 0)
>> > +                       return ret;
>> > +
>> > +               usleep_range(5, 10);
>> > +       } while (ret == 1);
>>
>> Is it possible to loop here indefinetely?
> According to specifications, this field is "Reset to 0 after register
> reset is completed", so I'm trusting the chip will behave as advertised!
> :) We could implement a safety mechanism to avoid looping in case the
> chip misbehaves but I don't think it's worth it. What do you think?

I just prefer to use some retry counter because it would be better to
fail the reset instead of being stuck here. The chip may behave
correctly but still a bug could exist in the driver. The retry counter
won't be much complicated here also. But I do not insist so if you
really think it is not worth it then I am fine.

Best regards,
Krzysztof
