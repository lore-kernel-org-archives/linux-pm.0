From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add Spreadtrum SC27XX fuel gauge
 unit documentation
Date: Thu, 20 Sep 2018 08:53:16 +0800
Message-ID: <CAMz4kuLAga0p-H3UycR1WMBpTHn_VsW8c3c4NjzZYiCgPiqRVg@mail.gmail.com>
References: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
 <20180916135721.rhu3rn4fsrmmgnbf@earth.universe> <CAMz4ku+4pJHivw2FLjtpaBs7yQxgDH-kZ3AgHWWQr5Lb_UcYwg@mail.gmail.com>
 <20180920004612.63biirau5qxnbxxo@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920004612.63biirau5qxnbxxo@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Craig Tatlor <ctatlor97@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

On 20 September 2018 at 08:46, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> Hi,
>
> On Mon, Sep 17, 2018 at 11:43:30AM +0800, Baolin Wang wrote:
>> Hi Sebastian,
>>
>> On 16 September 2018 at 21:57, Sebastian Reichel
>> <sebastian.reichel@collabora.com> wrote:
>> > Hi,
>> >
>> > On Wed, Sep 12, 2018 at 03:29:38PM +0800, Baolin Wang wrote:
>> >> This patch adds the binding documentation for Spreadtrum SC27XX series PMICs
>> >> fuel gauge unit device, which is used to calculate the battery capacity.
>> >>
>> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> >> ---
>> >>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |   55 ++++++++++++++++++++
>> >>  1 file changed, 55 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
>> >> new file mode 100644
>> >> index 0000000..7447bae
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
>> >> @@ -0,0 +1,55 @@
>> >> +Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
>> >> +
>> >> +Required properties:
>> >> +- compatible: Should be one of the following:
>> >> +  "sprd,sc2720-fgu",
>> >> +  "sprd,sc2721-fgu",
>> >> +  "sprd,sc2723-fgu",
>> >> +  "sprd,sc2730-fgu",
>> >> +  "sprd,sc2731-fgu".
>> >> +- reg: The address offset of fuel gauge unit.
>> >> +- bat-detect-gpio: GPIO for battery detection.
>> >> +- io-channels: Specify the IIO ADC channel to get temperature.
>> >> +- io-channel-names: Should be "bat-temp".
>> >> +- sprd,inner-resist: Specify the the battery inner resistance (mOhm).
>> >
>> > This should be a property of the battery.without the sprd, prefix.
>>
>> Right. But I did not find one proper property of the battery, so I
>> will add one new standard property of battery
>
> Thanks.
>
>> named 'inner-resistance-microohm' in next version. Is it OK for you?
>
> The proper suffix is -micro-ohms according to
> Documentation/devicetree/bindings/property-units.txt
>
> Also the proper English term is internal resistance as far
> as I know (and Wikipedia also names it this way), so I
> suggest to name the property 'internal-resistance-micro-ohms'.

Sure.

>
>> >> +- sprd,ocv-cap-table: Provide the battery capacity percent with corresponding
>> >> +  open circuit voltage (ocv) of the battery, which is used to look up current
>> >> +  battery capacity according to current baterry ocv values.
>> >
>> > This should also be part of the battery binding. I just reviewed a
>> > patchset for the Qualcomm Battery Monitoring System, which needs the
>> > same functionality. The Qualcomm binding is more advanced, but
>> > should also support this simpler case. Thus I think it makes sense
>> > to use its description as base for adding support for this feature
>> > to Documentation/devicetree/bindings/power/supply/battery.txt
>>
>> That's great. But could you give me the link of Qualcomm binding,
>> which I can change my bindings. Thanks for your comments.
>
> https://patchwork.kernel.org/patch/10464633/

Thanks.

-- 
Baolin Wang
Best Regards
