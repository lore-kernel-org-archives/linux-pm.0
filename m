From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: bcm283x: Add critical thermal zone for GPU
Date: Wed, 8 Feb 2017 10:56:56 +0100
Message-ID: <93f3ecbc-6d28-3e04-d6f3-4c03f8ac7ab3@i2se.com>
References: <E0A4388D-788A-40B4-9193-36FD75284654@martin.sperl.org>
 <1486217787-15703-1-git-send-email-stefan.wahren@i2se.com>
 <1486217787-15703-2-git-send-email-stefan.wahren@i2se.com>
 <20170208041929.GA6809@localhost.localdomain>
 <20170208042351.GB6809@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170208042351.GB6809-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Am 08.02.2017 um 05:23 schrieb Eduardo Valentin:
> On Tue, Feb 07, 2017 at 08:19:31PM -0800, Eduardo Valentin wrote:
>> On Sat, Feb 04, 2017 at 02:16:27PM +0000, Stefan Wahren wrote:
>>> As suggested by Eduardo Valentin this adds the thermal zone for
>>> the bcm2835 SoC. Since we currently don't have any cooling devices
>>> leave this section empty.
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
>>> ---
>>>  arch/arm/boot/dts/bcm283x.dtsi |   19 +++++++++++++++++++
>>>  1 file changed, 19 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
>>> index 9c7ec7e..359da9d 100644
>>> --- a/arch/arm/boot/dts/bcm283x.dtsi
>>> +++ b/arch/arm/boot/dts/bcm283x.dtsi
>>> @@ -19,6 +19,25 @@
>>>  		bootargs = "earlyprintk console=ttyAMA0";
>>>  	};
>>>  
>>> +	thermal-zones {
>>> +		gpu_thermal: gpu-thermal {
>>> +			polling-delay-passive = <0>;
>>> +			polling-delay = <1000>;
>>> +
>>> +			thermal-sensors = <&thermal>;
> Just came to my mind, dont you need to have an id to specify with sensor
> points to gpu?

Sorry, i don't know the exact setup of the single thermal sensor on the
SoC (datasheet doesn't provide any helpful information). I adapted the
Renesas R-Car thermal binding because i think it would be the best match.

@Eric: What's your opinion?

>
>>> +
>>> +			trips {
>>> +				cpu-crit {
>>> +					temperature	= <80000>;
>>> +					hysteresis	= <0>;
>>> +					type		= "critical";
>>> +				};
>>> +			};
>>> +			cooling-maps {
>>> +			};
>>> +		};
>>> +	};
>>> +
>> This is fine with me. Checking the other patches in the series.
>>
>>>  	soc {
>>>  		compatible = "simple-bus";
>>>  		#address-cells = <1>;
>>> -- 
>>> 1.7.9.5
>>>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
