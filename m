From: Tim Bird <tim.bird-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Subject: Re: [PATCH v2 1/3] dt-binding: power: Add otg regulator binding
Date: Wed, 9 Dec 2015 04:55:09 -0800
Message-ID: <566824AD.4080003@sonymobile.com>
References: <1449621618-11900-1-git-send-email-tim.bird@sonymobile.com>
 <20151209041153.GA29549@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151209041153.GA29549@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, =?UTF-8?Q?Andersson=2c_Bj=c3=b6rn?= <Bjorn.Andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tbird20d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tbird20d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Courtney Cavin <Courtney.Cavin-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 12/08/2015 08:11 PM, Rob Herring wrote:
> On Tue, Dec 08, 2015 at 04:40:16PM -0800, Tim Bird wrote:
>> Add a binding for the regulator which controls the OTG chargepath switch.
>> The OTG switch gets its power from pm8941_5vs1, and that should be
>> expressed as a usb-otg-in-supply property in the DT node for the
>> charger driver.  The regulator name is "otg".
>>
>> Signed-off-by: Tim Bird <tim.bird-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
>> ---
>> Changes since v1
>>  - switch supply name to have dashes instead of underscores
>>  - remove superfluous DT explanations in the otg node description
>> ---
>>  .../devicetree/bindings/power_supply/qcom_smbb.txt    | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt b/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
>> index 65b88fa..28b6da7 100644
>> --- a/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
>> +++ b/Documentation/devicetree/bindings/power_supply/qcom_smbb.txt
>> @@ -105,6 +105,22 @@ PROPERTIES
>>                 regulation must be done externally to fully comply with
>>                 the JEITA safety guidelines if this flag is set.
>>  
>> +- usb-otg-in-supply:
>> +  Usage: optional
>> +  Value type: <phandle>
>> +  Description: Reference to the regulator supplying power to the USB_OTG_IN
>> +               pin.
>> +
>> +child nodes:
>> +- otg:
>> +  Usage: optional
>> +  Description: This node defines a regulator used to control the direction
>> +               of VBUS voltage - specifically: whether to supply voltage
>> +               to VBUS for host mode operation of the OTG port, or allow
>> +               input voltage from external VBUS for charging.  In the
>> +               hardware, the supply for this regulator comes from
>> +               usb-otg-in-supply.
> 
> Doesn't this regulator need to have a name defined?

I'm not sure what you mean.  The regulator name is "otg", defined by the DT node
name. The code requires that the DT node name be "otg", and defines a regulator
with the same name.

As far as I know, you have to define a DT label for the node, in order
to reference this regulator with a phandle.  Is that what you are referring to?
I usually use "chg_otg" as the label.  Are you asking that this be reflected
in the example?

> Disabling this regulator (along with other setup) will enable charging?

Yes.  Enabling it allows the device to power the USB VBUS line for host
mode, and disabling it allows power to flow the other way (into the device)
for charging, when the USB port is in gadget mode.
 -- Tim

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
