From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Wed, 20 Jan 2016 13:53:44 -0600
Message-ID: <CAL_Jsq+suCyqSi+cJiVLuA0aZKSciAaeUKW9A5Y_X_3wyW60Ug@mail.gmail.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
 <1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
 <20160120182840.GA15741@rob-hp-laptop> <CALAqxLVvJqL60nKfrDiZ+p-1ujxuG72iUN3DCvEE3WJ9bpnGLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56474 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbcATTyK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Jan 2016 14:54:10 -0500
In-Reply-To: <CALAqxLVvJqL60nKfrDiZ+p-1ujxuG72iUN3DCvEE3WJ9bpnGLA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Andy Yan <andy.yan@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Sebastian Reichel <sre@kernel.org>, Olof Johansson <olof@lixom.net>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jun Nie <jun.nie@linaro.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, Will Deacon <will.deacon@arm.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Wed, Jan 20, 2016 at 12:47 PM, John Stultz <john.stultz@linaro.org> wrote:
> On Wed, Jan 20, 2016 at 10:28 AM, Rob Herring <robh@kernel.org> wrote:
>> On Tue, Jan 12, 2016 at 07:29:49PM +0800, Andy Yan wrote:
>>> add device tree binding document for reboot-mode driver
>>>
>>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>>
>>> ---
>>>
>>> Changes in v2: None
>>> Changes in v1: None
>>>
>>>  .../bindings/power/reset/reboot-mode.txt           | 41 +++++++++++++++++
>>>  .../bindings/power/reset/syscon-reboot-mode.txt    | 52 ++++++++++++++++++++++
>>>  2 files changed, 93 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>>>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>>> new file mode 100644
>>> index 0000000..81d9f66
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>>> @@ -0,0 +1,41 @@
>>> +Generic reboot mode core map driver
>>> +
>>> +This driver get reboot mode arguments and call the write
>>> +interface to stores the magic value in special register
>>> +or ram . Then the bootloader can read it and take different
>>> +action according to the argument stored.
>>> +
>>> +Required properties:
>>> +- compatible: only support "syscon-reboot-mode" now.
>>> +
>>> +Each mode is represented as a sub-node of reboot_mode:
>>> +
>>> +Subnode required properties:
>>> +- linux,mode: reboot mode command,such as "loader", "recovery", "fastboot".
>>> +- loader,magic: magic number for the mode, this is vendor specific.
>>> +
>>> +Example:
>>> +     reboot_mode {
>>
>> reboot-mode instead please.
>>
>>> +             compatible = "syscon-reboot-mode";
>>> +             offset = <0x40>;
>>
>> This doc by itself is a little confusing. For example, is a child of the
>> syscon node? I would remove offset (and perhaps compatible) from this
>> example.
>>
>>> +
>>> +             loader {
>>> +                     linux,mode = "loader";
>>> +                     loader,magic = <BOOT_LOADER>;
>>> +             };
>>
>> Sorry, my previous suggestion was not clear. I'm suggesting get rid of
>> the subnodes and just do properties like this:
>>
>> loader = <BOOT_LOADER>;
>> maskrom = <BOOT_MASKROM>;
>>
>> That's the same amount of information unless node names and linux,mode
>> values are going to diverge. Do they need to? I can't see a reason.
>
>
> It seems like devices already have a number of various different
> vendor specific commands.  So this sort of flexibility helps us adapt
> the driver to different hardware/system environments (which may use
> different conventions then what Android commonly uses).
>
> Unless I'm misunderstanding you and you're instead suggesting we can
> dynamically parse the command mode from the node name?

Yes, except it would be the property name. The driver could either
iterate over the properties of the reboot-mode node or lookup the
property when it has the reboot reason string. We generally like to
parse everything up front at probe, but the latter would be somewhat
easier to implement. Perhaps we would want to prefix nodes with
"mode-" or something.

Vendors can certainly still add their own (e.g.
vendor,halt-and-catch-fire = <0xdead>).

The question here really is will we ever need additional data for each
mode (in the DT) besides "magic". We can do some amount of extending
the property like allowing more that single 32-bit value. We can't mix
strings and integers though. If we don't need that, then lets go with
the more concise approach. This isn't really an evolving area.
Selecting boot mode/device has existed for a long time on PCs (it is
fixed list in the IPMI spec for example). So I can't imagine that we'd
have to extend this, but I'd like to hear thoughts on it. You had
mentioned the Galaxy Nexus having a value and a string, but I'd find
it surprising if the bootloader actually uses the string.

> That said, I agree we should try to push vendors to using the same
> conventions when they are providing the same functionality. But I'm
> not sure we should enforce that by making vendors introduce a new dt
> binding for every new reboot command they want to implement.

Either way they need to document it. It's either a new linux,mode
value or a new property name. Vendors are free to add whatever they
want, but for upstream it has to go thru review.

Rob
