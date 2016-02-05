From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Thu, 4 Feb 2016 22:35:07 -0600
Message-ID: <20160205043507.GB4847@rob-hp-laptop>
References: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
 <1454407151-4751-1-git-send-email-andy.yan@rock-chips.com>
 <20160204230814.GA4847@rob-hp-laptop>
 <CALAqxLVyznpLd2MLgGr28TDECpLZ=RpmhxH-SHqntXfBsctcmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CALAqxLVyznpLd2MLgGr28TDECpLZ=RpmhxH-SHqntXfBsctcmQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, lkml <linux-kernel@vger.kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Richard Weinberger <richard@nod.at>, Linux PM list <linux-pm@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Caesar Wang <wxt@rock-chips.com>, devicetree@vger.kernel.org, =?utf-8?B?UGF3ZcWC?= Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Moritz
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 04, 2016 at 03:46:15PM -0800, John Stultz wrote:
> On Thu, Feb 4, 2016 at 3:08 PM, Rob Herring <robh@kernel.org> wrote:
> > On Tue, Feb 02, 2016 at 05:59:11PM +0800, Andy Yan wrote:
> >> add device tree bindings document for reboot-mode driver
> >>
> >> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> >>
> >> ---
> >>
> >> Changes in v3:
> >> - descirbe all reboot mode as properity instead of subnode
> >>
> >> Changes in v2: None
> >> Changes in v1: None
> >>
> >>  .../bindings/power/reset/reboot-mode.txt           | 26 ++++++++++++++++
> >>  .../bindings/power/reset/syscon-reboot-mode.txt    | 36 ++++++++++++++++++++++
> >>  2 files changed, 62 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> >>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> >> new file mode 100644
> >> index 0000000..517080f
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.txt
> >> @@ -0,0 +1,26 @@
> >> +Generic reboot mode core map driver
> >> +
> >> +This driver get reboot mode arguments and call the write
> >> +interface to stores the magic value in special register
> >> +or ram . Then the bootloader can read it and take different
> >> +action according the argument stored.
> >> +
> >> +All mode properties are vendor specific, it is a indication to tell
> >
> > The values should be vendor specific. The property names should not. We
> > can allow vendor specific ones, but we need to have a common set.
> >
> >> +the bootloder what to do when the system reboot, and should be named
> >> +as mode-xxx = <magic> (xxx is mode name).
> >> +
> >> +- mode-normal: Normal reboot mode, system reboot with command "reboot".
> >> +- mode-recovery: Android Recovery mode, it is a mode to format the device or update a new image.
> >> +- mode-fastboot: Android fastboot mode, it's a mode to  re-flash partitions on the device.
> >> +- mode-loader: A bootloader mode, it's a mode used to download image on Rockchip platform,
> >> +            usually used in development.
> >> +- mode-maskrom: It's a mode to download bootloader on Rockchip platform.
> >> +
> >> +Example:
> >> +     reboot-mode {
> >> +             mode-normal = <BOOT_NORMAL>;
> >> +             mode-recovery = <BOOT_RECOVERY>;
> >> +             mode-fastboot = <BOOT_FASTBOOT>;
> >
> > I tend to agree with John on calling this mode-bootloader.
> >
> > OTOH, fastboot is more specific about what the mode is. The name in DT
> > and the userspace name don't necessarily have to be the same.
> 
> Wait. This is a bit confusing. The utility of adding a property name
> and using that name be the reboot command parsed for made sense
> (compared to earlier versions which had command strings) as it made
> the dts more terse.   But it sounds here like you're suggesting we
> should have some logic in the driver that translates "reboot fastboot"
> to mode-bootloader or vice versa.

I said early on the DT names and kernel-userspace names should not 
necessarily be linked. They can be, but we shouldn't require that.

My concern with mode-bootloader is what if you can boot into multiple 
bootloader modes. Say USB mass storage is one option. "bootloader" is 
not real specific.

> >> +             mode-loader = <BOOT_LOADER>;
> >
> > This one needs a better name. Maybe it should be 'rockchip,mode-loader'
> > as it is vendor specific. Either way, loader is vague. Perhaps
> > rockchip,mode-bl-download?
> 
> Hrm. So how what reboot command do you expect to trigger that?

Whatever your OS has defined to map to that.

We could just decide the kernel will strip <vendor> and 'mode-' and 
match commands against what remains.

> Though I do like the vendor specific prefix here, as it clarifies how
> universal the command is (and its easy add standard commands if they
> become more established and remap things in the future).
> 
> >
> >> +             mode-maskrom = <BOOT_MASKROM>;
> >
> > I think this should be "mode-rom-download".
> 
> I think one of the difficult things here is that there's no real
> standards for all bios/bootloader modes. So they are somewhat
> firmware/bootloader/device specific, and thus we need something that
> is flexible enough to allow lots of different modes to be easily
> specified.  That said, this does expose a userspace interface (though
> one could argue kernel ABI doesn't cross reboots :) so we should try
> to have some consistency so the same userspace can work on various
> devices.

There is: UEFI. Boot mode efivars are standard. But then they are pretty 
much PC oriented though. It is more which device to boot off of, but 
there is network boot or boot to bios setup.

> I do think the "bootloader" and "recovery" arguments are somewhat
> defacto standards, well established on most android devices.

Yes, otherwise I'd be completely against "mode-bootloader" as the 
property.

> I think here the concern is rockchip probably has some userspace that
> is already using "reboot maskrom" or "reboot loader" for their own
> uses. And its a bit of a pain to ask that userspace to be reworked to

Perhaps those are only for development and change would not be so 
painful.

> use "reboot rom-download" or "reboot rockchip,rom-download" depending
> on how we try to deal with these.  (Granted, non-upstream interfaces
> aren't official, so that is their risk somewhat, but we avoid being
> smug about that :)

Or vendor specific modes require vendor specific translation in the 
kernel. 

To some extent we need to design what is right and worry about future 
devices rather than cater to past devices. There's always some 
compromise. What would you design ignoring the existing conditions. 
Start there and then figure out how to make it work with current 
designs.

> Another part of the issue is there isn't really a way to probe for
> reboot cmd capability here. As much as I'd rather not complicate
> things, one couldn't easily extend existing userspace to work with
> current kernels as well as future kernels, since the reboot with an
> invalid command won't fail. The machine still resets. So you can't try
> one and fallback to the other.

Well, that's nice. Maybe we should change that? Or we're stuck with 
that ABI?

> Maybe there needs to be a sysfs entry with the list of the supported commands?

You can just read the DT. Although, the problem then is what happens 
when we move to the next firmware interface. We see that some with 
devices having userspace dependencies on ATAGS.

Rob
