From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Wed, 29 Nov 2017 15:09:03 +0100
Message-ID: <CAMuHMdU0tDFWUAWjzY7WS58pDGwhtUZyxqdLVOKRqfhWxiv1Wg@mail.gmail.com>
References: <1713438.irjm9MTSvo@aspire.rjw.lan> <CAMuHMdV4LV2Uzh2oGdaPiS4W4dfsZ-pn3rGcJNiZLStfo39How@mail.gmail.com>
 <TY1PR06MB09928D43D4E5E5752A6A604ED83A0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFoF0WMSTuK4AAyDzerpVpnfEq=Hn1n9kDJM0fYMkFL_wA@mail.gmail.com>
 <TY1PR06MB09924E4F66C6FCF131EE71CFD83B0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFoG2-mVGDtzPyg2FDVbXnsWGy543craKqeBVE_awKpf8Q@mail.gmail.com>
 <CAMuHMdViD3vqzits=th52+01d5y3p5iwbAg0jbUBcoGvYfULuA@mail.gmail.com> <CAPDyKFpRrQr3LRXH_CoLSYe2a=2PnUqvuNWUYSuh0wm+rBJ0dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43351 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbdK2OJF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Nov 2017 09:09:05 -0500
In-Reply-To: <CAPDyKFpRrQr3LRXH_CoLSYe2a=2PnUqvuNWUYSuh0wm+rBJ0dw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, USB list <linux-usb@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Ulf,

On Wed, Nov 29, 2017 at 10:59 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 29 November 2017 at 10:43, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Wed, Nov 29, 2017 at 10:24 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 29 November 2017 at 09:21, Yoshihiro Shimoda
>>> <yoshihiro.shimoda.uh@renesas.com> wrote:
>>>>> From: Ulf Hansson, Sent: Wednesday, November 29, 2017 2:23 AM
>>>>> On 28 November 2017 at 13:48, Yoshihiro Shimoda
>>>>> <yoshihiro.shimoda.uh@renesas.com> wrote:
>>>>> >> From: Geert Uytterhoeven, Sent: Tuesday, November 28, 2017 7:58 PM
>>>>> >> On Sun, Nov 12, 2017 at 1:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>>> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> <snip>
>>>>> >> JFTR, this triggered before during system resume on e.g. Salvator-XS with
>>>>> >> R-Car H3:
>>>>> >>
>>>>> >>     ohci-platform ee080000.usb: runtime PM trying to suspend device
>>>>> >> but active child
>>>>> >>     phy_rcar_gen3_usb2 ee080200.usb-phy: runtime PM trying to suspend
>>>>> >> device but active child
>>>>> >>     ohci-platform ee0c0000.usb: runtime PM trying to suspend device
>>>>> >> but active child
>>>>> >>     ohci-platform ee0a0000.usb: runtime PM trying to suspend device
>>>>> >> but active child
>>>>> >>     phy_rcar_gen3_usb2 ee0c0200.usb-phy: runtime PM trying to suspend
>>>>> >> device but active child
>>>>> >>     phy_rcar_gen3_usb2 ee0a0200.usb-phy: runtime PM trying to suspend
>>>>> >> device but active child
>>>>> >>
>>>>> >> so this was an existing issue with USB before.
>>>>> >
>>>>> > Thank you for the report!
>>>>> > I know that, but since this didn't cause any trouble until now,
>>>>> > I postponed to investigate the issue... But, I investigate it today.
>>>>> > I don't find the root cause yet. However, it seems related to usb host and/or usb core.
>>>>> > --> USB host related devices' child_count will be 1 in suspend timing.
>>>>> >  --> I guess remote wakeup feature is enabled? But, I don't find the point yet.
>>>>>
>>>>> I am guessing the issue is triggered by genpd in the suspend noirq
>>>>> phase (genpd_suspend_noirq()). In there,  there is a call to
>>>>> pm_runtime_force_suspend() (which calls pm_runtime_set_suspended() and
>>>>> which triggered the earlier error messages being printed).
>>>>>
>>>>> The reason why genpd calls pm_runtime_force_suspend(), is because when
>>>>> validating wakeup configurations for the device "if
>>>>> (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))", it's
>>>>> thinks wakeup isn't configured while it probably should be.
>>>>>
>>>>> An additional note, only when genpd has the GENPD_FLAG_PM_CLK set,
>>>>> which makes the genpd->dev_ops.stop|start() being assigned, genpd
>>>>> calls pm_runtime_force_suspend() - else it doesn't.
>>>>>
>>>>> Perhaps try out the series I recently posted improving the code
>>>>> dealing with wakeups in genpd and the PM core:
>>>>> https://www.spinics.net/lists/linux-renesas-soc/msg20122.html
>>>>> To that, you need to set the new flag (invented in the above series)
>>>>> DPM_FLAG_IN_BAND_WAKEUP in the driver that configures wakeup of its
>>>>> device.
>>>>>
>>>>> Hope this helps!
>>>>
>>>> Thank you for the comments!
>>>> I tried DPM_FLAG_IN_BAND_WAKEUP, but the issue still exists.
>>>> I added the flag in the [eo]hci-platform driver and usb/core/driver.c.
>>>> I also added the flag in the phy_rcar_gen3_usb2 driver except usb host drivers.
>>>
>>> First, did you confirm that genpd was used? Then for what device?
>>
>> All 6 devices are part of the SYSC PM Domain.
>
> Okay!
>
> Can you perhaps clarify which 6 devices/drivers that are involved, and
> perhaps also point out if their child devices?

/sys/devices/platform/soc/ee080000.usb
/sys/devices/platform/soc/ee0c0000.usb
/sys/devices/platform/soc/ee0a0000.usb

Driver: ohci-platform

The children are usb6/6-0:1.0, usb3/3-0:1.0, resp. usb4/4-0:1.0, all using
the usb "hub" driver

/sys/devices/platform/soc/ee080200.usb-phy
/sys/devices/platform/soc/ee0a0200.usb-phy
/sys/devices/platform/soc/ee0c0200.usb-phy

Driver: phy_rcar_gen3_usb2

The children are:

phy/phy-ee080200.usb-phy.2
phy/phy-ee0a0200.usb-phy.0
phy/phy-ee0c0200.usb-phy.1

all without a driver, according to sysfs.

Note that at first I had missed them, as printing the children using
device_for_each_child() does not print them, unlike the hub devices that
are children of the usb hosts.

With some debug code added, logging inc/dec of child_count:

USB driver init:

 ehci-pci: EHCI PCI platform driver
 ehci-platform: EHCI generic platform driver
+phy_rcar_gen3_usb2 ee0a0200.usb-phy: rpm_resume:830: inc child_count
of parent soc
+phy phy-ee0a0200.usb-phy.0: rpm_resume:830: inc child_count of parent
ee0a0200.usb-phy
+phy phy-ee0a0200.usb-phy.0: rpm_suspend:606: dec child_count of
parent ee0a0200.usb-phy
+phy phy-ee0a0200.usb-phy.0: rpm_resume:759: inc child_count of parent
ee0a0200.usb-phy

+phy_rcar_gen3_usb2 ee0c0200.usb-phy: rpm_resume:830: inc child_count
of parent soc
+phy phy-ee0c0200.usb-phy.1: rpm_resume:830: inc child_count of parent
ee0c0200.usb-phy
+phy phy-ee0c0200.usb-phy.1: rpm_suspend:606: dec child_count of
parent ee0c0200.usb-phy
+phy phy-ee0c0200.usb-phy.1: rpm_resume:759: inc child_count of parent
ee0c0200.usb-phy

+phy phy-ee080200.usb-phy.2: rpm_resume:830: inc child_count of parent
ee080200.usb-phy
+phy phy-ee080200.usb-phy.2: rpm_suspend:606: dec child_count of
parent ee080200.usb-phy
+phy phy-ee080200.usb-phy.2: rpm_resume:759: inc child_count of parent
ee080200.usb-phy

Somehow the phy class phy-ee0*0200.usb-phy.* devices have the platform
ee0*0200.usb-phy devices as parent, but they're not part of the list of
children? Looks like a bug in the USB PHY driver or subsystem.


USB hub instantiation:

+usb usb3: __pm_runtime_set_status:1131: inc child_count of parent ee0a0000.usb
+usb usb3: rpm_suspend:606: dec child_count of parent ee0a0000.usb

+usb usb4: __pm_runtime_set_status:1131: inc child_count of parent ee0c0000.usb
+usb usb4: rpm_suspend:606: dec child_count of parent ee0c0000.usb

+usb usb6: __pm_runtime_set_status:1131: inc child_count of parent ee080000.usb
+usb usb6: rpm_suspend:606: dec child_count of parent ee080000.usb


System suspend:

+usb usb6: rpm_resume:830: inc child_count of parent ee080000.usb
+usb usb3: rpm_resume:830: inc child_count of parent ee0a0000.usb
+usb usb4: rpm_resume:830: inc child_count of parent ee0c0000.usb


System resume:

 Enabling runtime PM for inactive device (ee0c0200.usb-phy) with active children
 Enabling runtime PM for inactive device (ee0c0200.usb-phy) with active children
 Enabling runtime PM for inactive device (ee0a0000.usb) with active children
 Enabling runtime PM for inactive device (ee0c0000.usb) with active children
 Enabling runtime PM for inactive device (ee080200.usb-phy) with active children
 Enabling runtime PM for inactive device (ee080000.usb) with active children

+usb usb4: rpm_suspend:606: dec child_count of parent ee0c0000.usb
+usb usb6: rpm_suspend:606: dec child_count of parent ee080000.usb
+usb usb3: rpm_suspend:606: dec child_count of parent ee0a0000.usb

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
