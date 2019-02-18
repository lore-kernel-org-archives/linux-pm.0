From: <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 3/3] dt-bindings: arm: atmel: add binding for SAM9X60
 shutdown controller
Date: Mon, 18 Feb 2019 14:47:22 +0000
Message-ID: <44adcef4-a3df-f906-2d69-f357af1ebfaf@microchip.com>
References: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
 <1550143407-26109-4-git-send-email-claudiu.beznea@microchip.com>
 <97af1d45-d74b-87d3-c934-baae80307e1d@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <97af1d45-d74b-87d3-c934-baae80307e1d@microchip.com>
Content-Language: en-US
Content-ID: <B7B81ABD4F21E44BA0081B373E7CD1CA@namprd11.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas.Ferre@microchip.com, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, sre@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 18.02.2019 13:01, Nicolas Ferre - M43238 wrote:
> On 14/02/2019 at 12:24, Claudiu Beznea - M18063 wrote:
>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> Add documentation for SAM9X60 shutdown controller.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>   Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
>> index 14f319f694b7..9711052c5800 100644
>> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
>> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
>> @@ -83,7 +83,7 @@ SHDWC SAMA5D2-Compatible Shutdown Controller
>>   1) shdwc node
>>   
>>   required properties:
>> -- compatible: should be "atmel,sama5d2-shdwc".
>> +- compatible: should be "atmel,sama5d2-shdwc" or "microchip,sam9x60-shdwc".
>>   - reg: should contain registers location and length
>>   - clocks: phandle to input clock.
>>   - #address-cells: should be one. The cell is the wake-up input index.
>> @@ -95,6 +95,10 @@ optional properties:
>>     microseconds. It's usually a board-related property.
>>   - atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
>>   
>> +optional properties for microchip,sam9x60-shdwc:
> 
> is it for sam9x60 only or is the optional property "debounce-delay-us" 
> applicable to this SoC?

No, I meant only to RTC and RTT.

> 
>> +- atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
>> +- atmel,wakeup-rtt-timer: boolean to enable Real-time Timer Wake-up.
> 
> Well, I would make clear that the only additional optional property is 
> "atmel,wakeup-rtt-timer" while the 2 other optional properties still 
> apply...

Ok, I will take care of this in next version.

Thank you,
Claudiu Beznea

> 
> 
>>   The node contains child nodes for each wake-up input that the platform uses.
>>   
>>   2) input nodes
>>
> 
> 
