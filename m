From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: power: Introduce one property to
 present the battery internal resistance
Date: Fri, 26 Oct 2018 09:57:05 +0800
Message-ID: <CAMz4ku+a8if7oO1mbG=0xeEYE0poi1K_UDcT5AsXxBGjXss9HA@mail.gmail.com>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
 <CAMz4kuJCS1_E+CUdANepYe+WpYSOwovZ9Rnu85zvTgmV9BE5+g@mail.gmail.com> <20181025201349.c4564dgc7743kosx@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025201349.c4564dgc7743kosx@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>, Craig Tatlor <ctatlor97@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 26 October 2018 at 04:13, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> Hi Baolin,
>
> On Thu, Oct 25, 2018 at 10:01:55AM +0800, Baolin Wang wrote:
>> Hi Sebastian,
>>
>> On 22 October 2018 at 15:43, Baolin Wang <baolin.wang@linaro.org> wrote:
>> > The internal resistance of a battery is not a constant in its life cycle,
>> > this varies over the age of the battery or temperature and so on. But we
>> > just want use one constant battery internal resistance to estimate the
>> > battery capacity. Thus this patch introduces one property to present
>> > the battery factory internal resistance for battery information.
>> >
>> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> > ---
>> > Changes from v5:
>> >  - None.
>> >
>> > Changes from v4:
>> >  - None.
>> >
>> > Changes from v3:
>> >  - Split binding into one separate patch.
>> >  - Add LinusW reviewed tag.
>> >
>> > Changes from v2:
>> >  - Rename the property.
>> >  - Improve the commit message.
>> >
>> > Changes from v1:
>> >  - New patch in v2.
>> > ---
>>
>> I think this v6 patch set have addressed your comments on v5, so could
>> you apply this patch set if there are no other comments? I hope this
>> driver can be merged into 4.20 finally. Thanks.
>
> Everything looks fine to me. I will merge this directly after the
> 4.20 merge window has been closed and linux-next is open again.
> I'm not merging non-trivial, non-bugfix patches this lates during the
> release process.

Understood. Thanks Sebastian.

-- 
Baolin Wang
Best Regards
