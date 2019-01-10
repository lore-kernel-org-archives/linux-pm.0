From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 4/4] dt-bindings: mfd: max8998: Add charger subnode
 binding
Date: Thu, 10 Jan 2019 18:47:11 +0100
Message-ID: <5765349a-c94d-49c1-45b5-ab7ac09f9923@samsung.com>
References: <1524844982-4714-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
        <1524844982-4714-5-git-send-email-pawel.mikolaj.chmiel@gmail.com>
        <20180501124540.3icpjevaxp44ew2e@earth.universe>
        <CGME20180501144322epcas2p39f8413a212ad5d3ec7b06f0a164d0908@epcas2p3.samsung.com>
        <2089055.mctyXeETjz@acerlaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <2089055.mctyXeETjz@acerlaptop>
Content-language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pawe=c5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 5/1/18 16:43, Paweł Chmiel wrote:
> On Tuesday, May 1, 2018 2:45:40 PM CEST Sebastian Reichel wrote:
>> On Fri, Apr 27, 2018 at 06:03:02PM +0200, Paweł Chmiel wrote:
>>> This patch adds devicetree bindings documentation for
>>> battery charging controller as the subnode of MAX8998 PMIC.
>>> It's based on current behavior of driver.
>>>
>>> Fixes: ee999fb3f17f ("mfd: max8998: Add support for Device Tree")
>>> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/mfd/max8998.txt | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)

>>> --- a/Documentation/devicetree/bindings/mfd/max8998.txt
>>> +++ b/Documentation/devicetree/bindings/mfd/max8998.txt
>>> @@ -50,6 +50,21 @@ Additional properties required if max8998,pmic-buck2-dvs-gpio is defined:
>>>  - max8998,pmic-buck2-dvs-voltage: An array of 2 voltage values in microvolts
>>>    for buck2 regulator that can be selected using dvs gpio.
>>>  
>>> +Charger: Configuration for battery charging controller should be added
>>> +inside a child node named 'charger'.
>>> +  Required properties:
>>> +  - max8998,charge-eoc: Setup "End of Charge". If value equals 0,
>>> +    remain value set from bootloader or default value will be used.
>>> +    Valid values: 0, 10 - 45
>>> +
>>> +  - max8998,charge-restart: Setup "Charge Restart Level". If value equals 0,
>>> +    remain value set from bootloader or default value will be used.
>>> +    Valid values: -1, 0, 100, 150, 200

Perhaps change the property name to max8998,charge-restart-threshold, 
in include/linux/mfd/max8998.h we have:

 * @restart: Restart Level in mV: 100, 150, 200, and -1 for disable.
 *   If it equals 0, leave it unchanged.

Then we could make it an optional property:

 - max8998,charge-restart-threshold: Charge restart threshold in millivolts. 
   Valid values are: 0, 100, 150, 200. If the value equals 0 the charger 
   restart will be disabled.

If the property is missing the charger restart threshold configuration would
be left unchanged.

>>> +  - max8998,charge-timeout: Setup "Charge Full Timeout". If value equals 0,
>>> +    remain value set from bootloader or default value will be used.
>>> +    Valid values: -1, 0, 5, 6, 7
>>
>> What are those values? seconds?
>>
> Honestly i don't know. I've just documented values accepted currently 
> by charger driver, so we can use it from devicetree.
> I couldn't find any max8998 datasheet with this information (units, possible 
> values etc for those properties).

The charge timeout is in hours, as described in include/linux/mfd/max8998.h:


"* @timeout: Full Timeout in hours: 5, 6, 7, and -1 for disable.
 *   If it equals 0, leave it unchanged.
 *   Otherwise, leave it unchanged."

We could change description of the property to something along the lines of:

Optional properties:

  - max8998,charge-timeout: Charge timeout in hours. Valid values are:
    0, 5, 6, 7. If the value is 0 the charge timer will be disabled.

Then if the property is missing the driver will leave charge timer configuration
unchanged.

-- 
Regards,
Sylwester
