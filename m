From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v2 05/11] Doc: DT: thermal: new irq-mode for trip point
Date: Tue, 13 Nov 2018 11:13:31 +0100
Message-ID: <64aaa2aa-00ad-643f-3b44-f505a31f2ee8@partner.samsung.com>
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b@eucas1p2.samsung.com>
        <1541610593-28542-6-git-send-email-l.luba@partner.samsung.com>
        <5bea0ecd.1c69fb81.d5613.1c9e@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5bea0ecd.1c69fb81.d5613.1c9e@mx.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com, krzk@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 11/12/18 8:09 PM, Rob Herring wrote:
> On Wed, Nov 07, 2018 at 06:09:47PM +0100, Lukasz Luba wrote:
>> Thermal trip point gets new flag in DT: irq-mode.
>> Trip point may have a new explicit flag which indicate
>> IRQ support when the temperature is met (so the thermal framework
>> deos not need to set polling for it).
>> It is useful for 'passive' cooling trip point,
>> which now will not register for polling the temperature.
>>
>> Update documentation about irq-mode for trip points.
> 
> This patch should come before you use it.
OK, I will re-order the patch set in v3.
> 
>>
>> Cc: Zhang Rui <rui.zhang@intel.com>
>> Cc: Eduardo Valentin <edubezval@gmail.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   Documentation/devicetree/bindings/thermal/thermal.txt | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
>> index ca14ba9..bee21e3 100644
>> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
>> @@ -90,6 +90,10 @@ Required properties:
>>   	"critical":	Hardware not reliable.
>>     Type: string
>>   
>> +- irq-mode:		A flag indicating that trip rises irq, so there is no
>> +  Type: bool		need of polling in thermal framework.
>> +  Size: one cell
> 
> Should be optional, right?
Yes, it is optional. I will mention about it in change v3.

Thank you for the review.

Regards,
Lukasz
