From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: update the Allwinner GPADC device
 tree binding for H3
Date: Mon, 3 Apr 2017 17:31:11 +0800
Message-ID: <e4d50e78-afe7-6107-6d9a-15e4c732d79a@aosc.io>
References: <20170402133304.56824-1-icenowy@aosc.io>
 <20170402133304.56824-2-icenowy@aosc.io>
 <20170403091523.6atl7nq4m2qkpn3d@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170403091523.6atl7nq4m2qkpn3d@lukather>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org



在 2017年04月03日 17:15, Maxime Ripard 写道:
> On Sun, Apr 02, 2017 at 09:33:01PM +0800, Icenowy Zheng wrote:
>> Allwinner H3 features a thermal sensor like the one in A33, but has its
>> register re-arranged, the clock divider moved to CCU (originally the
>> clock divider is in ADC) and added a pair of bus clock and reset.
>>
>> Update the binding document to cover H3.
>>
>> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
>> ---
>>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 23 ++++++++++++++++++++--
>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> index badff3611a98..7753133ca0ff 100644
>> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>> @@ -4,12 +4,20 @@ The Allwinner SoCs all have an ADC that can also act as a thermal sensor
>>  and sometimes as a touchscreen controller.
>>
>>  Required properties:
>> -  - compatible: "allwinner,sun8i-a33-ths",
>> +  - compatible: must contain one of the following compatibles:
>> +		- "allwinner,sun8i-a33-ths"
>> +		- "allwinner,sun8i-h3-ths"
>>    - reg: mmio address range of the chip,
>>    - #thermal-sensor-cells: shall be 0,
>>    - #io-channel-cells: shall be 0,
>>
>> -Example:
>> +Required properties for the following compatibles:
>> +		- "allwinner,sun8i-h3-ths"
>> +  - clocks: the bus clock and the input clock of the ADC,
>> +  - clock-names: should be "bus" and "ths",
>
> I guess mod instead of ths would be more consistent.

In fact I will prefer "sample" here if not "ths", as it's used
for the sampling, not like other mod clocks, which controls
all the IP block's logic.

>
> Maxime
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
