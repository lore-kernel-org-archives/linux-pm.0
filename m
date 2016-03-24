From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Thu, 24 Mar 2016 15:27:55 +0800
Message-ID: <56F396FB.8030402@rock-chips.com>
References: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
 <1458646592-540-1-git-send-email-andy.yan@rock-chips.com>
 <CAJKOXPdUW5f6_sz14NMU8LP+QoKStB9omXticMkQX4D866okWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.131]:40683 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbcCXH2V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 03:28:21 -0400
In-Reply-To: <CAJKOXPdUW5f6_sz14NMU8LP+QoKStB9omXticMkQX4D866okWw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: robh+dt@kernel.org, sre@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, olof@lixom.net, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, jun.nie@linaro.org, pawel.moll@arm.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, f.fainelli@gmail.com, linux@arm.linux.org.uk, mbrugger@suse.com, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, linux-kernel@vger.kernel.org, wxt@rock-chips.com, dwmw2@infradead.org, mark.rutland@arm.com

Hi Krzysztof:

On 2016=E5=B9=B403=E6=9C=8824=E6=97=A5 10:27, Krzysztof Kozlowski wrote=
:
> Interesting idea. While looking at the code I stumped over few things=
 below:
>
> On Tue, Mar 22, 2016 at 8:36 PM, Andy Yan <andy.yan@rock-chips.com> w=
rote:
>> add device tree bindings document for reboot-mode driver
> s/add/Add/
> Plus a full-stop at the end of sentence.
     okay, I will do it in next version.
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> binding
> What is that?

     This will be removed
>
>> ---
>>
>> Changes in v6:
>> - fix a typo with "property"
>> - describe property "mask" more clear
>>
>> Changes in v5:
>> - delete a unnecessary blank line in syscon-reboot-mode.txt
>> - rename mode-fastoboot to mode-bootloader in syscon-reboot-mode.txt
>> - rename macro BOOT_LOADER to BOOT_BL_DOWNLOAD, which gives a more c=
lear mean
>>
>> Changes in v4:
>> - remove mode-maskrom
>> - rename mode-fastboot to mode-bootloader to keep compatible with th=
e exiting Android device
>>
>> Changes in v3:
>> - descirbe all reboot mode as properity instead of subnode
>>
>> Changes in v2: None
>> Changes in v1: None
>>
>>   .../bindings/power/reset/reboot-mode.txt           | 24 ++++++++++=
+++++
>>   .../bindings/power/reset/syscon-reboot-mode.txt    | 35 ++++++++++=
++++++++++++
>>   2 files changed, 59 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/reset/r=
eboot-mode.txt
>>   create mode 100644 Documentation/devicetree/bindings/power/reset/s=
yscon-reboot-mode.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mo=
de.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>> new file mode 100644
>> index 0000000..3457949
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>> @@ -0,0 +1,24 @@
>> +Generic reboot mode core map driver
>> +
>> +This driver get reboot mode arguments and call the write
>> +interface to stores the magic value in special register
> s/stores/store/
>> +or ram . Then the bootloader can read it and take different
> s/ram ./ram./
>
>> +action according the argument stored.
> according to
>
>> +
>> +All mode properties are vendor specific, it is a indication to tell
>> +the bootloder what to do when the system reboot, and should be name=
d
> s/bootloder/bootloader/
> s/reboot/reboots/
>
>> +as mode-xxx =3D <magic> (xxx is mode name).
>> +
> These are examples? If yes then add a note, like:
>
> +For example modes common on Android platform:

     Thanks for your carefully review, all these will be fixed in next=20
version.
>> +- mode-normal: Normal reboot mode, system reboot with command "rebo=
ot".
>> +- mode-recovery: Android Recovery mode, it is a mode to format the =
device or update a new image.
>> +- mode-bootloader: Android fastboot mode, it's a mode to re-flash p=
artitions on the Android based device.
>> +- mode-loader: A bootloader mode, it's a mode used to download imag=
e on Rockchip platform,
>> +              usually used in development.
> The "bootloader" and "loader" examples are very confusing. Maybe just
> name the first one as "mode-fastboot" and second as
> "rockchip-download"? The term "loader" does not look for me as
> anything related to uploading/downloading new firmware.

     About these two modes, we have a long discussion with Rob and John=
 [0]
     We keep them as what you see now to keep compatibility with exitin=
g=20
devices.

  [0] https://lkml.org/lkml/2016/2/2/128
>
>> +
>> +Example:
>> +       reboot-mode {
>> +               mode-normal =3D <BOOT_NORMAL>;
>> +               mode-recovery =3D <BOOT_RECOVERY>;
>> +               mode-bootloader =3D <BOOT_FASTBOOT>;
>> +               mode-loader =3D <BOOT_BL_DOWNLOAD>;
>> +       }
>> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-re=
boot-mode.txt b/Documentation/devicetree/bindings/power/reset/syscon-re=
boot-mode.txt
>> new file mode 100644
>> index 0000000..eb28469
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot-mo=
de.txt
>> @@ -0,0 +1,35 @@
>> +SYSCON reboot mode driver
>> +
>> +This driver get reboot mode magic value form reboot-mode driver
> s/get/gets/
>
>> +and stores it in a SYSCON mapped register. Then the bootloader
>> +can read it and take different action according to the magic
>> +value stored.
>> +
>> +This DT node should be represented as a sub-node of a "syscon", "si=
mple-mfd"
>> +node.
>> +
>> +Required properties:
>> +- compatible: should be "syscon-reboot-mode"
>> +- offset: offset in the register map for the storage register (in b=
ytes)
>> +
>> +Optional property:
>> +- mask: bits mask of the bits in the register to store the reboot m=
ode magic value,
>> +  default set to 0xffffffff if missing.
>> +
>> +The rest of the properties should follow the generic reboot-mode di=
scription
> s/discription/description/
>
> Please, run the spell check...
>
> Best regards,
> Krzysztof
>
>
>
>



