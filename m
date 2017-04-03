From: Jon Mason <jon.mason@broadcom.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: thermal: add support for Broadcom's
 Northstar thermal
Date: Sun, 2 Apr 2017 23:07:16 -0400
Message-ID: <CAC3K-4r7xGoSSBwHKZjrS27jMFr_RYp1n4nRo2aAHzVAVbVi_A@mail.gmail.com>
References: <20170331073132.21457-2-zajec5@gmail.com> <20170331201124.656-1-zajec5@gmail.com>
 <20170401195136.GD28514@localhost.localdomain> <6dd907e4-c213-3174-8613-99427e6ea0e9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:35766 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdDCDHR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Apr 2017 23:07:17 -0400
Received: by mail-it0-f54.google.com with SMTP id y18so39551313itc.0
        for <linux-pm@vger.kernel.org>; Sun, 02 Apr 2017 20:07:17 -0700 (PDT)
In-Reply-To: <6dd907e4-c213-3174-8613-99427e6ea0e9@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-pm@vger.kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>

On Sat, Apr 1, 2017 at 5:50 PM, Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> =
wrote:
> On 04/01/2017 09:51 PM, Eduardo Valentin wrote:
>>
>> On Fri, Mar 31, 2017 at 10:11:23PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
>>>
>>> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>>>
>>> This commit documents binding for thermal used in Northstar family SoCs=
.
>>>
>>> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>>> ---
>>> V3: Add thermal-zones to the example
>>>     Rob: Because of this update, I didn't include Acked-by I got for V2
>>> ---
>>>  .../devicetree/bindings/thermal/brcm,ns-thermal    | 26
>>> ++++++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/thermal/brcm,ns-thermal
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
>>> b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
>>> new file mode 100644
>>> index 000000000000..c561c7349f17
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/thermal/brcm,ns-thermal
>>> @@ -0,0 +1,26 @@
>>> +* Broadcom Northstar Thermal
>>> +
>>> +This binding describes thermal sensor that is part of Northstar's DMU
>>> (Device
>>> +Management Unit).
>>> +
>>> +Required properties:
>>> +- compatible : Must be "brcm,ns-thermal"
>>> +- reg : iomem address range of PVTMON registers
>>> +- #thermal-sensor-cells : Should be <0>
>>> +
>>> +Example:
>>> +
>>> +thermal: thermal@1800c2c0 {
>>> +       compatible =3D "brcm,ns-thermal";
>>> +       reg =3D <0x1800c2c0 0x10>;
>>> +       #thermal-sensor-cells =3D <0>;
>>> +};
>>> +
>>> +thermal-zones {
>>> +       cpu_thermal: cpu-thermal {
>>> +               polling-delay-passive =3D <0>;
>>> +               polling-delay =3D <1000>;
>>> +               coefficients =3D <(-556) 418000>;
>>> +               thermal-sensors =3D <&thermal>;
>>
>>
>> You need to define trips and cooling devices here. Otherwise, makes
>> little sense to have this device in thermal subsystem. Here is an
>> example of minimal set:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-therm=
al.git/commit/?h=3Dlinus&id=3D1e2ac9821de6a85d3e8358f238436708d1d46869
>>
>> The above has no passive action. It is just gonna shutdown the system if
>> temperature crosses a threshold.
>>
>> But, a typical cooling device would be CPU frequency throttling. Do you
>> have
>> that up and running in your routers?
>
>
> I don't have CPU freq throttling, so shutdown will be the only solution f=
or
> critical temp right now.
>
> I know I should have at least a trip for critical temperature, but the
> problem
> is I don't know what value to use. There isn't any info about this in pub=
lic
> datasheets. Broadcom's SDK doesn't mention it. Vendors share only the max
> environment temp, not the max CPU temp.
>
> So for now I only meant to provide user space access to reading current C=
PU
> temperature. I could do some stress tests and ask other users to do it as
> well.
>
> Or maybe I could just put in Documentation some round value that makes mo=
re
> or
> less sense and then work on a proper content of real DTS files?
>
> Unless we can get some hint from Broadcom people. Jon? Florian? Anyone?

I'll poke around and see if I can find a datasheet for NS/NSP.  Worst
case, I can ask one of the HW engineers for NSP, and we can use the
same value for NS.
