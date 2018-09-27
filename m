From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 1/4] power: supply: core: Introduce one property to
 present the battery internal resistance
Date: Thu, 27 Sep 2018 09:06:05 +0800
Message-ID: <CAMz4kuLt4ReL=fAY9kAnTQpoq3nY-7NU7S91QsWC03JeF+H=vw@mail.gmail.com>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <CACRpkdY3YsXsJy0OwGYLuB+x32hbkAHum4w5KQTCGoi-OXt-QA@mail.gmail.com>
 <CAMz4ku+H5Z_W5rE0b3GDz2E0YSZshEerufZ41yeh_E5omD6KLA@mail.gmail.com> <20180926124510.2ewnaw3jyzm3qkbm@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926124510.2ewnaw3jyzm3qkbm@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>, Craig Tatlor <ctatlor97@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 26 September 2018 at 20:45, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Wed, Sep 26, 2018 at 04:30:39PM +0800, Baolin Wang wrote:
>> Hi Linus,
>>
>> On 26 September 2018 at 16:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>> > On Wed, Sep 26, 2018 at 4:59 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>> >
>> >> Introduce one property to present the battery internal resistance for battery
>> >> information.
>> >>
>> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> >> ---
>> >> Changes from v1:
>> >>  - New patch in v2.
>> >
>> > I'm a bit confused by the physics in this patch.
>> >
>> > The internal resistance of a battery is not a constant in its life cycle,
>> > this varies over the age of the battery, and the reason I thing is
>> > chemical residuals accumulating on the anode and cathode inside
>> > the battery and the energy storage medium aging. (Plus/minus my
>> > ignorance about how batteries actually work.)
>>
>> Yes, you are right. The internal resistance can be affected by
>> temperature or battery age or other factors. But our solution just
>> uses one constant internal resistance to calculate OCV value to look
>> up the capacity table when system boots on, in this case we do not
>> need one more accuracy OCV, since we will calculate the battery
>> capacity in future. So we just introduce one estimation constant
>> internal resistance.
>>
>> >
>> > AFAIK the fact that the internal resistance varies is of high
>> > importance for people developing algorithms of battery capacity
>> > and longevity. Such that some (hardware) capacity monitors go
>> > to great lengths to measure with high precision the current
>> > internal resistance of the battery for their algorithms.
>> >
>> > Sorry for making things more complex, but should it be named
>> > "factory-internal-resistance-micro-ohms" or
>> > "typical-internal-resistance-micro-ohms"?
>>
>> I am fine with this change. If Sebastian also agree with this change,
>> I will fix. Thanks for your reviewing and comments.
>
> Ack.
>
> FWIW for proper battery status you need to collect battery specific
> statistics, that is the reason fuel gauge chip providers recommend to
> combine the chip with the battery cells into a "smart battery".

OK. I will rename it as "factory-internal-resistance-micro-ohms" in
next version. Thanks.

-- 
Baolin Wang
Best Regards
