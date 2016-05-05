From: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH v3 5/5] ARM: dts: axp209: Enable
 usb_power_supply by default
Date: Thu, 5 May 2016 12:46:27 +0200
Message-ID: <3512867a-a82c-6be7-35ff-a4f6fb48a259@computerlinguist.org>
References: <1462444508-9363-1-git-send-email-haas@computerlinguist.org>
 <1462444508-9363-6-git-send-email-haas@computerlinguist.org>
 <f672f0c7-495c-de63-6115-68d57500d874@redhat.com>
Reply-To: haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCD4V7EG6QFRBCGJVS4QKGQEH4ZJAKQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <f672f0c7-495c-de63-6115-68d57500d874-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Hans,

On 05/05/2016 12:39 PM, Hans de Goede wrote:
> Hi,
> 
> On 05-05-16 12:35, Michael Haas wrote:
>> This node should be enabled by default. A device is likely to have an
>> USB power
>> connection. If USB power is indeed absent, the USB power driver
>> will simply report the power input as offline.
> 
> Nack, as Maxime already said we do not want to enable any optional
> features by default. Many top set boxes do not use the usb power supply,
> and we don't want some userspace power control panel applet showing
> the supply as offline, we want the supply to simply not be there.

it was my understanding that Maxime [0] and ChenYu [1] indicated they
would prefer it to be enabled globally.

Best,

Michael

[0] https://groups.google.com/d/msg/linux-sunxi/cHAlhoIw74g/CbBeoX23AAAJ
[1] https://groups.google.com/d/msg/linux-sunxi/Ee7i8DVI4F8/0b0TBrRkAAAJ

>>
>> Signed-off-by: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/axp209.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/axp209.dtsi
>> b/arch/arm/boot/dts/axp209.dtsi
>> index 7deb7d9..4f16be0 100644
>> --- a/arch/arm/boot/dts/axp209.dtsi
>> +++ b/arch/arm/boot/dts/axp209.dtsi
>> @@ -97,7 +97,7 @@
>>
>>      usb_power_supply: usb_power_supply {
>>          compatible = "x-powers,axp202-usb-power-supply";
>> -        status = "disabled";
>> +        status = "okay";
>>      };
>>
>>  };
>>
