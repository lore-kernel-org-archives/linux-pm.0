From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add Spreadtrum SC2731 charger documentation
Date: Thu, 30 Aug 2018 11:03:10 +0800
Message-ID: <CAMz4kuL8cSkBRb1C779u4gi93TwJ1M0aNV_nkRQoX16=7HK5wA@mail.gmail.com>
References: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
 <CAJKOXPd9-aLYFLBHwUyNecneHA6X+VbnZSK4paXsMcmvobnGhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPd9-aLYFLBHwUyNecneHA6X+VbnZSK4paXsMcmvobnGhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 29 August 2018 at 22:08, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, 28 Aug 2018 at 11:04, Baolin Wang <baolin.wang@linaro.org> wrote:
>>
>> This patch adds the binding documentation for Spreadtrum SC2731 charger
>> device.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  .../bindings/power/supply/sc2731_charger.txt       |   14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
>> new file mode 100644
>> index 0000000..02b616c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
>> @@ -0,0 +1,14 @@
>> +Spreadtrum SC2731 PMIC battery charger binding
>> +
>> +Required properties:
>> + - compatible: Should be "sprd,sc2731-charger".
>> + - reg: Address offset of charger register.
>> + - phys: Contains a phandle to the USB phy.
>> +
>> +Example:
>> +
>> +       charger@0 {
>> +               compatible = "sprd,sc2731-charger";
>> +               reg = <0x0>;
>
> Can you include also few lines of parent node? You use this "reg"
> later as a base address so probably your parent node requires address
> mapping. It would be nice to see it in example.
>

Sorry that I forgot adding the parent node, and will add it in next
version. Thanks.

-- 
Baolin Wang
Best Regards
