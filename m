From: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Tue, 19 Jan 2016 16:31:27 +0800
Message-ID: <569DF45F.3050908@rock-chips.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
 <1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
 <CALAqxLUxh3=LhoHxqiRm_5L4G6m1Vctp=aUg+9_uAtLkFwW9bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CALAqxLUxh3=LhoHxqiRm_5L4G6m1Vctp=aUg+9_uAtLkFwW9bw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, =?UTF-8?Q?Pawe=c5=82_Moll?= <pawel.moll-5wv7dgnIgG8@public.gmane.org>, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org, cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lkml <linux-kernel-u79uwXL29Tb/PtFMR13I2A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi John:

On 2016=E5=B9=B401=E6=9C=8816=E6=97=A5 06:41, John Stultz wrote:
> On Tue, Jan 12, 2016 at 3:29 AM, Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org> w=
rote:
>> add device tree binding document for reboot-mode driver
>>
>> Signed-off-by: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>
>> ---
>>
>> Changes in v2: None
>> Changes in v1: None
>>
>>   .../bindings/power/reset/reboot-mode.txt           | 41 ++++++++++=
+++++++
>>   .../bindings/power/reset/syscon-reboot-mode.txt    | 52 ++++++++++=
++++++++++++
>>   2 files changed, 93 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/reset/r=
eboot-mode.txt
>>   create mode 100644 Documentation/devicetree/bindings/power/reset/s=
yscon-reboot-mode.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mo=
de.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>> new file mode 100644
>> index 0000000..81d9f66
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>> @@ -0,0 +1,41 @@
>> +Generic reboot mode core map driver
>> +
>> +This driver get reboot mode arguments and call the write
>> +interface to stores the magic value in special register
>> +or ram . Then the bootloader can read it and take different
>> +action according to the argument stored.
>> +
>> +Required properties:
>> +- compatible: only support "syscon-reboot-mode" now.
>> +
>> +Each mode is represented as a sub-node of reboot_mode:
>> +
>> +Subnode required properties:
>> +- linux,mode: reboot mode command,such as "loader", "recovery", "fa=
stboot".
>> +- loader,magic: magic number for the mode, this is vendor specific.
>> +
>> +Example:
>> +       reboot_mode {
>> +               compatible =3D "syscon-reboot-mode";
>> +               offset =3D <0x40>;
>> +
>> +               loader {
>> +                       linux,mode =3D "loader";
>> +                       loader,magic =3D <BOOT_LOADER>;
>> +               };
>> +
>> +               maskrom {
>> +                       linux,mode =3D "maskrom";
>> +                       loader,magic =3D <BOOT_MASKROM>;
>> +               };
>> +
>> +               recovery {
>> +                       linux,mode =3D "recovery";
>> +                       loader,magic =3D <BOOT_RECOVERY>;
>> +               };
>> +
>> +               fastboot {
>> +                       linux,mode =3D "fastboot";
>> +                       loader,magic =3D <BOOT_FASTBOOT>;
>> +               };
>> +        };
>
> So one minor thought here. While the commands are somewhat vendor
> specific, would it be a good idea for the example commands to match
> the common commands on Android devices?  For example, usually
> "bootloader" is what gets you into fastboot mode on nexus devices.
>
> thanks
> -john
>
>
>
>

   When I run the "adb help" , I got the following message:
   adb reboot [bootloader|recovery] - reboots the device, optionally=20
into the bootloader or recovery program
   adb reboot-bootloader        - reboots the device into the bootloade=
r

   It  only says "adb reboot-bootloader" will reboot the device into=20
bootloader, not specific to fastboot.

   I add @Simon from Google here, maybe he can give some suggestions.



--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
