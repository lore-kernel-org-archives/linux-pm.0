From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Mon, 15 Feb 2016 17:43:06 +0800
Message-ID: <56C19DAA.5030602@rock-chips.com>
References: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
 <1454407151-4751-1-git-send-email-andy.yan@rock-chips.com>
 <20160204230814.GA4847@rob-hp-laptop>
 <CALAqxLVyznpLd2MLgGr28TDECpLZ=RpmhxH-SHqntXfBsctcmQ@mail.gmail.com>
 <20160205043507.GB4847@rob-hp-laptop>
 <CALAqxLUnbFHjTuJXYXSruV3W0JJ09Fxz=KBe69tZDTd_3_+rxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:40506 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbcBOJnU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 04:43:20 -0500
In-Reply-To: <CALAqxLUnbFHjTuJXYXSruV3W0JJ09Fxz=KBe69tZDTd_3_+rxw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Richard Weinberger <richard@nod.at>, Linux PM list <linux-pm@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, =?UTF-8?Q?Pawe=c5=82_Moll?= <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Moritz

Hi Rob & John:

On 2016=E5=B9=B402=E6=9C=8805=E6=97=A5 13:03, John Stultz wrote:
> On Thu, Feb 4, 2016 at 8:35 PM, Rob Herring <robh@kernel.org> wrote:
>> On Thu, Feb 04, 2016 at 03:46:15PM -0800, John Stultz wrote:
>>> On Thu, Feb 4, 2016 at 3:08 PM, Rob Herring <robh@kernel.org> wrote=
:
>>>> On Tue, Feb 02, 2016 at 05:59:11PM +0800, Andy Yan wrote:
>>>>> +Example:
>>>>> +     reboot-mode {
>>>>> +             mode-normal =3D <BOOT_NORMAL>;
>>>>> +             mode-recovery =3D <BOOT_RECOVERY>;
>>>>> +             mode-fastboot =3D <BOOT_FASTBOOT>;
>>>> I tend to agree with John on calling this mode-bootloader.
>>>>
>>>> OTOH, fastboot is more specific about what the mode is. The name i=
n DT
>>>> and the userspace name don't necessarily have to be the same.
>>> Wait. This is a bit confusing. The utility of adding a property nam=
e
>>> and using that name be the reboot command parsed for made sense
>>> (compared to earlier versions which had command strings) as it made
>>> the dts more terse.   But it sounds here like you're suggesting we
>>> should have some logic in the driver that translates "reboot fastbo=
ot"
>>> to mode-bootloader or vice versa.
>> I said early on the DT names and kernel-userspace names should not
>> necessarily be linked. They can be, but we shouldn't require that.
> Sigh. Ok. It seemed it was due to earlier comments (maybe from others=
,
> but I thought it was you), that we moved from specifying a command
> string, to using the label. But if you think the label name and the
> commands shouldn't be linked, it seems like we should re-introduce
> that. No?
>
> Unless your thinking we need some sort of static in-kernel mapping of
> commands to label names? But that just seems painfully indirect for
> little gain ("Its obvious! For that mode, you use this term here, and
> that different term over there!").
>
>> My concern with mode-bootloader is what if you can boot into multipl=
e
>> bootloader modes. Say USB mass storage is one option. "bootloader" i=
s
>> not real specific.
> True. But as I think we agreed below, "bootloader" and "recovery" are
> basically defacto standards, and I think it would be a bad idea to tr=
y
> to declare all the existing android tooling and docs wrong just
> because the command is vague, technically.
>
>
>>>>> +             mode-loader =3D <BOOT_LOADER>;
>>>> This one needs a better name. Maybe it should be 'rockchip,mode-lo=
ader'
>>>> as it is vendor specific. Either way, loader is vague. Perhaps
>>>> rockchip,mode-bl-download?
>>> Hrm. So how what reboot command do you expect to trigger that?
>> Whatever your OS has defined to map to that.
>>
>> We could just decide the kernel will strip <vendor> and 'mode-' and
>> match commands against what remains.
> That part sounds sane, although I do think having vendor prefixes are
> reasonable for actual commands as well.
>
>
>>> I think one of the difficult things here is that there's no real
>>> standards for all bios/bootloader modes. So they are somewhat
>>> firmware/bootloader/device specific, and thus we need something tha=
t
>>> is flexible enough to allow lots of different modes to be easily
>>> specified.  That said, this does expose a userspace interface (thou=
gh
>>> one could argue kernel ABI doesn't cross reboots :) so we should tr=
y
>>> to have some consistency so the same userspace can work on various
>>> devices.
>> There is: UEFI. Boot mode efivars are standard. But then they are pr=
etty
>> much PC oriented though. It is more which device to boot off of, but
>> there is network boot or boot to bios setup.
> Well, there's a partial standard there.  I'm told for android on x86,
> there is no UEFI standard way to communicate rebooting to fastboot or
> recovery. Every device does its own device specific driver.
>
>
>>> I do think the "bootloader" and "recovery" arguments are somewhat
>>> defacto standards, well established on most android devices.
>> Yes, otherwise I'd be completely against "mode-bootloader" as the
>> property.
> Ok.
>
>>> I think here the concern is rockchip probably has some userspace th=
at
>>> is already using "reboot maskrom" or "reboot loader" for their own
>>> uses. And its a bit of a pain to ask that userspace to be reworked =
to
>> Perhaps those are only for development and change would not be so
>> painful.
> Andy: Can you comment here? How critical are the specific commands
> you've used here for your userspace?
>
     Have some discussion with my colleague, we decided remove the"=20
maskrom" mode in next version.
   Actually, this mode is not so used so often.
     But "reboot loader" is frequently used  in development by all the=20
rockchip platform related people, even
some widely used factory tools use this command.So we really hope it ca=
n=20
compatible with the existing tools
and user experience.
>>> use "reboot rom-download" or "reboot rockchip,rom-download" dependi=
ng
>>> on how we try to deal with these.  (Granted, non-upstream interface=
s
>>> aren't official, so that is their risk somewhat, but we avoid being
>>> smug about that :)
>> Or vendor specific modes require vendor specific translation in the
>> kernel.
> True.
>
>
>> To some extent we need to design what is right and worry about futur=
e
>> devices rather than cater to past devices. There's always some
>> compromise. What would you design ignoring the existing conditions.
>> Start there and then figure out how to make it work with current
>> designs.
> Fair enough. I just want to make sure we're not getting too caught up
> with design purity and are willing the meet the world where it is.
>
>>> Another part of the issue is there isn't really a way to probe for
>>> reboot cmd capability here. As much as I'd rather not complicate
>>> things, one couldn't easily extend existing userspace to work with
>>> current kernels as well as future kernels, since the reboot with an
>>> invalid command won't fail. The machine still resets. So you can't =
try
>>> one and fallback to the other.
>> Well, that's nice. Maybe we should change that? Or we're stuck with
>> that ABI?
> Maybe? I'm not sure what might have trouble with reboot failing if it
> sticks any extra noise in the reboot command.
> I'd probably lean towards sticking with the existing behavior.
>
>>> Maybe there needs to be a sysfs entry with the list of the supporte=
d commands?
>> You can just read the DT. Although, the problem then is what happens
>> when we move to the next firmware interface. We see that some with
>> devices having userspace dependencies on ATAGS.
> Heh. I guess. Thought I suspect "Just read the DT to sort out the
> available reboot modes" is probably not what most userspace wants to
> hear. :)
>
> thanks
> -john
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
>
>


