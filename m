From: Markus Mayer <markus.mayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 1/4] Documentation: devicetree: add binding for
 Broadcom STB AVS TMON
Date: Wed, 9 Aug 2017 14:39:28 -0700
Message-ID: <CAGt4E5t5a9JsRcfqhe5cgKHqmS2Hz2Zx-yzENbUhwQCbPVuhgg@mail.gmail.com>
References: <20170731192633.58747-1-code@mmayer.net> <20170731192633.58747-2-code@mmayer.net>
 <1502195795.4296.37.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502195795.4296.37.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Markus Mayer <code-7CzEARzsJhSsTnJN9+BGXg@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Doug Berger <opendmb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Broadcom Kernel List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Power Management List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux
List-Id: linux-pm@vger.kernel.org

On 8 August 2017 at 05:36, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, 2017-07-31 at 12:26 -0700, Markus Mayer wrote:
>> From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> Add binding for Broadcom STB thermal.
>>
>> Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>
> $ file v3-1-4-Documentation-devicetree-add-binding-for-Broadcom-STB-
> AVS-TMON.patch
> unified diff output, UTF-8 Unicode text

It's UTF-8 encoded, because of Rafa=C5=82's name in the recipient list.

> BTW, can you please rebase this patch set on top of v4.13-rc3?
> At least there are some conflicts in MAINTAINER file, introduced in
> -rc2.

I'll send the rebased series shortly.

> thanks,
> rui
>> ---
>>  .../devicetree/bindings/thermal/brcm,avs-tmon.txt    | 20
>> ++++++++++++++++++++
>>  MAINTAINERS                                          |  8 ++++++++
>>  2 files changed, 28 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-
>> tmon.txt b/Documentation/devicetree/bindings/thermal/brcm,avs-
>> tmon.txt
>> new file mode 100644
>> index 0000000..9d43553
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
>> @@ -0,0 +1,20 @@
>> +* Broadcom STB thermal management
>> +
>> +Thermal management core, provided by the AVS TMON hardware block.
>> +
>> +Required properties:
>> +- compatible: must be "brcm,avs-tmon" and/or "brcm,avs-tmon-bcm7445"
>> +- reg: address range for the AVS TMON registers
>> +- interrupts: temperature monitor interrupt, for high/low threshold
>> triggers
>> +- interrupt-names: should be "tmon"
>> +- interrupt-parent: the parent interrupt controller
>> +
>> +Example:
>> +
>> +     thermal@f04d1500 {
>> +             compatible =3D "brcm,avs-tmon-bcm7445", "brcm,avs-
>> tmon";
>> +             reg =3D <0xf04d1500 0x28>;
>> +             interrupts =3D <0x6>;
>> +             interrupt-names =3D "tmon";
>> +             interrupt-parent =3D <&avs_host_l2_intc>;
>> +     };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 205d397..a683d4c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2928,6 +2928,14 @@ S:     Maintained
>>  F:   Documentation/devicetree/bindings/cpufreq/brcm,stb-avs-
>> cpu-freq.txt
>>  F:   drivers/cpufreq/brcmstb*
>>
>> +BROADCOM STB AVS TMON DRIVER
>> +M:   Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
>> +M:   bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
>> +L:   linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> +S:   Maintained
>> +F:   Documentation/devicetree/bindings/thermal/brcm,avs-
>> tmon.txt
>> +F:   drivers/thermal/broadcom/brcmstb*
>> +
>>  BROADCOM SPECIFIC AMBA DRIVER (BCMA)
>>  M:   Rafa=C5=82 Mi=C5=82ecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>  L:   linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
