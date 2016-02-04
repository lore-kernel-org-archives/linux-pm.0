From: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Thu, 4 Feb 2016 15:46:15 -0800
Message-ID: <CALAqxLVyznpLd2MLgGr28TDECpLZ=RpmhxH-SHqntXfBsctcmQ@mail.gmail.com>
References: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
 <1454407151-4751-1-git-send-email-andy.yan@rock-chips.com>
 <20160204230814.GA4847@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20160204230814.GA4847@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Moritz
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 4, 2016 at 3:08 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Feb 02, 2016 at 05:59:11PM +0800, Andy Yan wrote:
>> add device tree bindings document for reboot-mode driver
>>
>> Signed-off-by: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>
>> ---
>>
>> Changes in v3:
>> - descirbe all reboot mode as properity instead of subnode
>>
>> Changes in v2: None
>> Changes in v1: None
>>
>>  .../bindings/power/reset/reboot-mode.txt           | 26 ++++++++++++++++
>>  .../bindings/power/reset/syscon-reboot-mode.txt    | 36 ++++++++++++++++++++++
>>  2 files changed, 62 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>> new file mode 100644
>> index 0000000..517080f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
>> @@ -0,0 +1,26 @@
>> +Generic reboot mode core map driver
>> +
>> +This driver get reboot mode arguments and call the write
>> +interface to stores the magic value in special register
>> +or ram . Then the bootloader can read it and take different
>> +action according the argument stored.
>> +
>> +All mode properties are vendor specific, it is a indication to tell
>
> The values should be vendor specific. The property names should not. We
> can allow vendor specific ones, but we need to have a common set.
>
>> +the bootloder what to do when the system reboot, and should be named
>> +as mode-xxx = <magic> (xxx is mode name).
>> +
>> +- mode-normal: Normal reboot mode, system reboot with command "reboot".
>> +- mode-recovery: Android Recovery mode, it is a mode to format the device or update a new image.
>> +- mode-fastboot: Android fastboot mode, it's a mode to  re-flash partitions on the device.
>> +- mode-loader: A bootloader mode, it's a mode used to download image on Rockchip platform,
>> +            usually used in development.
>> +- mode-maskrom: It's a mode to download bootloader on Rockchip platform.
>> +
>> +Example:
>> +     reboot-mode {
>> +             mode-normal = <BOOT_NORMAL>;
>> +             mode-recovery = <BOOT_RECOVERY>;
>> +             mode-fastboot = <BOOT_FASTBOOT>;
>
> I tend to agree with John on calling this mode-bootloader.
>
> OTOH, fastboot is more specific about what the mode is. The name in DT
> and the userspace name don't necessarily have to be the same.

Wait. This is a bit confusing. The utility of adding a property name
and using that name be the reboot command parsed for made sense
(compared to earlier versions which had command strings) as it made
the dts more terse.   But it sounds here like you're suggesting we
should have some logic in the driver that translates "reboot fastboot"
to mode-bootloader or vice versa.

>> +             mode-loader = <BOOT_LOADER>;
>
> This one needs a better name. Maybe it should be 'rockchip,mode-loader'
> as it is vendor specific. Either way, loader is vague. Perhaps
> rockchip,mode-bl-download?

Hrm. So how what reboot command do you expect to trigger that?

Though I do like the vendor specific prefix here, as it clarifies how
universal the command is (and its easy add standard commands if they
become more established and remap things in the future).

>
>> +             mode-maskrom = <BOOT_MASKROM>;
>
> I think this should be "mode-rom-download".

I think one of the difficult things here is that there's no real
standards for all bios/bootloader modes. So they are somewhat
firmware/bootloader/device specific, and thus we need something that
is flexible enough to allow lots of different modes to be easily
specified.  That said, this does expose a userspace interface (though
one could argue kernel ABI doesn't cross reboots :) so we should try
to have some consistency so the same userspace can work on various
devices.

I do think the "bootloader" and "recovery" arguments are somewhat
defacto standards, well established on most android devices.

I think here the concern is rockchip probably has some userspace that
is already using "reboot maskrom" or "reboot loader" for their own
uses. And its a bit of a pain to ask that userspace to be reworked to
use "reboot rom-download" or "reboot rockchip,rom-download" depending
on how we try to deal with these.  (Granted, non-upstream interfaces
aren't official, so that is their risk somewhat, but we avoid being
smug about that :)

Another part of the issue is there isn't really a way to probe for
reboot cmd capability here. As much as I'd rather not complicate
things, one couldn't easily extend existing userspace to work with
current kernels as well as future kernels, since the reboot with an
invalid command won't fail. The machine still resets. So you can't try
one and fallback to the other.

Maybe there needs to be a sysfs entry with the list of the supported commands?

thanks
-john
