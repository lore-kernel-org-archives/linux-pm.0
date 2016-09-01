From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: Re: [PATCH v4 1/2] Documentation: Add sbs-manager device tree node
 documentation
Date: Thu, 1 Sep 2016 17:00:32 +0800
Message-ID: <e8912f2d-66f9-75c5-e0b7-8a33845e8aa2@electromag.com.au>
References: <1bIiDr-0004G1-0P>
 <1472156461-25180-1-git-send-email-karl-heinz@schneider-inet.de>
 <1472156461-25180-2-git-send-email-karl-heinz@schneider-inet.de>
 <20160831144349.GA18510@rob-hp-laptop>
 <1472673151.5102.12.camel@schneider-inet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472673151.5102.12.camel-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 1/09/2016 03:52, Karl-Heinz Schneider wrote:
> Hi Rob,
>
> Am Mittwoch, den 31.08.2016, 09:43 -0500 schrieb Rob Herring:
>> On Thu, Aug 25, 2016 at 10:21:00PM +0200, Karl-Heinz Schneider wrote:
>>>
>>> This patch adds device tree documentation for the sbs-manager
>>>
>>> Reviewed-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
>>> Signed-off-by: Karl-Heinz Schneider <karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org>
>>> ---
>>>  .../devicetree/bindings/power/sbs,sbs-manager.txt  | 53
>>> ++++++++++++++++++++++
>>>  1 file changed, 53 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/sbs,sbs-
>>> manager.txt b/Documentation/devicetree/bindings/power/sbs,sbs-
>>> manager.txt
>>> new file mode 100644
>>> index 0000000..6b1a87ce
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
>>> @@ -0,0 +1,53 @@
>>> +Binding for sbs-manager
>>> +
>>> +Required properties:
>>> +- compatible: should be "lltc,ltc1760" or use "sbs,sbs-manager" as
>>> fallback.
>>> +- reg: integer, i2c address of the device. Should be <0xa>.
>> What happened to adding Phil's interrupt support into this? You
>> don't
>> have to add the whole patch, just the binding part. The driver
>> support
>> can come later.
>
> Phil revoked his patch. Right now it's not clear how the interrupt/gpio
> solution will look like and if they will need an device tree binding at
> all...

I'm getting back to this now.
I think we can use the smbalert driver to handle the source interrupt.
Which I think doesn't need anything in the dt binding. Driver just needs to
implement the alert callback.

I haven't figured out if the smb_alert could be used for the sbs-battery
driver interrupt or if this would make sense. However I think it would still need
to be a gpio controller in either case so that it can report the presence of the
batteries in a manner suitable for the sbs-battery driver to use.
I think the gpio controller approach is the simpler method.

It looks like the smbalert_driver driver needs some updates to work with device trees.
I need a bit more time to investigate this option.


>
>>
>>>
>>> +
>>> +From OS view the device is basically an i2c-mux used to
>>> communicate with up to
>>> +four smart battery devices at address 0xb. The driver actually
>>> implements this
>>> +behaviour. So standard i2c-mux nodes can be used to register up to
>>> four slave
>>> +batteries. See Documentation/devicetree/bindings/i2c/i2c-mux.txt
>>> for more
>>> +information on i2c-mux nodes. Channels will be numerated starting
>>> from 1 to 4.
>>> +
>>> +Example:
>>> +
>>> +batman@0a {
>> drop leading 0.
>
> OK.
>
>>>
>>> +    compatible = "lltc,ltc1760";
>>> +    reg = <0x0a>;
>
> Will remove leading 0 at this places too.
>
>>> +    #address-cells = <1>;
>>> +    #size-cells = <0>;
>>> +
>>> +    i2c@1 {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        reg = <1>;
>>> +
>>> +        battery@0b {
>> and here...
>
> OK.
>
>>>
>>> +            compatible = "ti,bq2060", "sbs,sbs-battery";
>>> +            reg = <0x0b>;
>>> +        };
>>> +    };
>>> +
>>> +    i2c@2 {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        reg = <2>;
>>> +
>>> +        battery@0b {
>>> +            compatible = "ti,bq2060", "sbs,sbs-battery";
>>> +            reg = <0x0b>;
>>> +        };
>>> +    };
>>> +
>>> +    i2c@3 {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        reg = <3>;
>>> +
>>> +        battery@0b {
>>> +            compatible = "ti,bq2060", "sbs,sbs-battery";
>>> +            reg = <0x0b>;
>>> +        };
>>> +    };
>>> +};
>
>
> Thanks for review Rob.
>


-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

3 The Avenue, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
