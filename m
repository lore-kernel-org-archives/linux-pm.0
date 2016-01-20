From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Wed, 20 Jan 2016 10:47:34 -0800
Message-ID: <CALAqxLVvJqL60nKfrDiZ+p-1ujxuG72iUN3DCvEE3WJ9bpnGLA@mail.gmail.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
	<1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
	<20160120182840.GA15741@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36204 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447AbcATSrf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 13:47:35 -0500
Received: by mail-yk0-f180.google.com with SMTP id v14so20487017ykd.3
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2016 10:47:34 -0800 (PST)
In-Reply-To: <20160120182840.GA15741@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Andy Yan <andy.yan@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>, linux@roeck-us.net, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, geert+renesas@glider.be, sre@kernel.org, Olof Johansson <olof@lixom.net>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jun Nie <jun.nie@linaro.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, Will Deacon <will.deacon@arm.com>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, lorenzo.pieralisi@arm.com

On Wed, Jan 20, 2016 at 10:28 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Jan 12, 2016 at 07:29:49PM +0800, Andy Yan wrote:
>> add device tree binding document for reboot-mode driver
>>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>
>> ---
>>
>> Changes in v2: None
>> Changes in v1: None
>>
>>  .../bindings/power/reset/reboot-mode.txt           | 41 +++++++++++++++++
>>  .../bindings/power/reset/syscon-reboot-mode.txt    | 52 ++++++++++++++++++++++
>>  2 files changed, 93 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
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
>> +- linux,mode: reboot mode command,such as "loader", "recovery", "fastboot".
>> +- loader,magic: magic number for the mode, this is vendor specific.
>> +
>> +Example:
>> +     reboot_mode {
>
> reboot-mode instead please.
>
>> +             compatible = "syscon-reboot-mode";
>> +             offset = <0x40>;
>
> This doc by itself is a little confusing. For example, is a child of the
> syscon node? I would remove offset (and perhaps compatible) from this
> example.
>
>> +
>> +             loader {
>> +                     linux,mode = "loader";
>> +                     loader,magic = <BOOT_LOADER>;
>> +             };
>
> Sorry, my previous suggestion was not clear. I'm suggesting get rid of
> the subnodes and just do properties like this:
>
> loader = <BOOT_LOADER>;
> maskrom = <BOOT_MASKROM>;
>
> That's the same amount of information unless node names and linux,mode
> values are going to diverge. Do they need to? I can't see a reason.


It seems like devices already have a number of various different
vendor specific commands.  So this sort of flexibility helps us adapt
the driver to different hardware/system environments (which may use
different conventions then what Android commonly uses).

Unless I'm misunderstanding you and you're instead suggesting we can
dynamically parse the command mode from the node name?

That said, I agree we should try to push vendors to using the same
conventions when they are providing the same functionality. But I'm
not sure we should enforce that by making vendors introduce a new dt
binding for every new reboot command they want to implement.

thanks
-john
