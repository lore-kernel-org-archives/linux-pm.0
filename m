From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 01/22] dt-bindings: iio: adc: add AXP20X/AXP22X ADC DT
 binding
Date: Thu, 5 Jan 2017 12:05:24 +0800
Message-ID: <CAGb2v64d4tsQHkXRG9PMFTqG0k9sgut5zBeaQRCo-kVA1W8LhQ@mail.gmail.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-2-quentin.schulz@free-electrons.com>
 <20170103232035.wwsqmea5dxzu2r5m@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170103232035.wwsqmea5dxzu2r5m@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-iio@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Russell King <linux@armlinux.org.uk>, Quentin Schulz <quentin.schulz@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Lee Jones <lee.jones@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jonathan Cameron <jic23@kernel.org>, Icenowy Zheng <icenowy@aosc.xyz>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 4, 2017 at 7:20 AM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Jan 02, 2017 at 05:37:01PM +0100, Quentin Schulz wrote:
>> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
>> battery voltage, battery charge and discharge currents, AC-in and VBUS
>> voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
>>
>> This adds the device tree binding documentation for the X-Powers AXP20X
>> and AXP22X PMICs ADCs.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  .../devicetree/bindings/iio/adc/axp20x_adc.txt     | 24 ++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
>> new file mode 100644
>> index 0000000..1b60065
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt
>> @@ -0,0 +1,24 @@
>> +X-Powers AXP20X and AXP22X PMIC Analog to Digital Converter (ADC)
>> +
>> +The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
>> +battery voltage, battery charge and discharge currents, AC-in and VBUS
>> +voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
>> +
>> +The AXP22X PMICs do not have all ADCs of the AXP20X though.
>> +
>> +Required properties:
>> + - compatible, one of:
>> +                     "x-powers,axp209-adc"
>> +                     "x-powers,axp221-adc"
>> + - #io-channel-cells = <1>;
>> +
>> +This is a subnode of the AXP20X PMIC.
>> +
>> +Example:
>> +
>> +&axp209 {
>> +     axp209_adc: axp209_adc {
>
> Use 'adc' for node name:
>
> With that,
>
> Acked-by: Rob Herring <robh@kernel.org>

Same comments as Rob.

Acked-by: Chen-Yu Tsai <wens@csie.org>

>
>> +             compatible = "x-powers,axp209-adc";
>> +             #io-channel-cells = <1>;
>> +     };
>> +};
>> --
>> 2.9.3
>>
