From: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Thu, 21 Jan 2016 14:27:57 +0800
Message-ID: <56A07A6D.3010406@rock-chips.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
 <1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
 <20160120182840.GA15741@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160120182840.GA15741@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org, cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Rob:
    thanks for your review.
On 2016=E5=B9=B401=E6=9C=8821=E6=97=A5 02:28, Rob Herring wrote:
> On Tue, Jan 12, 2016 at 07:29:49PM +0800, Andy Yan wrote:
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
>> +	reboot_mode {
> reboot-mode instead please.
>

     Sorry, I have already correct it in DT file, forget it here. It=20
will be changed in next version.

>> +		compatible =3D "syscon-reboot-mode";
>> +		offset =3D <0x40>;
> This doc by itself is a little confusing. For example, is a child of =
the
> syscon node? I would remove offset (and perhaps compatible) from this
> example.

    Yes, is a child of a syscon mapped node. For example, Rockchip=20
platform use a register of PMU(rk3066/rk3288) or GRF(rk3036), PMU and=20
GRF are aleady mapped by syscon.
    offset and compatible are used by write interface driver like=20
syscon-reboot-mode.c. If you don't like it appear in the core map doc, =
I=20
will move it to the syscon-reboot-mode.txt?
>> +
>> +		loader {
>> +			linux,mode =3D "loader";
>> +			loader,magic =3D <BOOT_LOADER>;
>> +		};
> Sorry, my previous suggestion was not clear. I'm suggesting get rid o=
f
> the subnodes and just do properties like this:
>
> loader =3D <BOOT_LOADER>;
> maskrom =3D <BOOT_MASKROM>;
>
> That's the same amount of information unless node names and linux,mod=
e
> values are going to diverge. Do they need to? I can't see a reason.

     Because the command"linux,mode" and value"loader,magic" is vendor=20
specific. I don't know what commands and how many mode other platform=20
will use. So as John says in his reply, this sort of flexibility help u=
s=20
adapt the driver to different hardware/system environments.
>
> We need to be clear what loader means. More specifically, it is boot
> into bootloader shell.
     Actually, Rockchip platform will reboot into a bootloader download=
=20
mode with this command. This mode can download faster than maskrom=20
download mode.
>> +
>> +		maskrom {
> In theory, the bootrom could have multiple modes. This typically mean=
s a
> USB download mode. So perhaps a more precise name would be
> "rom-download".
>
> In chips I'm familiar with the bootrom mode is selected via a differe=
nt
> mechanism than the secondary bootloader modes, but I suppose the same
> mechanism could be used.
    Yes , they use the same mechanism.
>> +			linux,mode =3D "maskrom";
>> +			loader,magic =3D <BOOT_MASKROM>;
>> +		};
>> +
>> +		recovery {
>> +			linux,mode =3D "recovery";
>> +			loader,magic =3D <BOOT_RECOVERY>;
>> +		};
>> +
>> +		fastboot {
>> +			linux,mode =3D "fastboot";
>> +			loader,magic =3D <BOOT_FASTBOOT>;
>> +		};
>
>
>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
