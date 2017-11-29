From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Wed, 29 Nov 2017 10:24:51 +0100
Message-ID: <CAPDyKFoG2-mVGDtzPyg2FDVbXnsWGy543craKqeBVE_awKpf8Q@mail.gmail.com>
References: <1713438.irjm9MTSvo@aspire.rjw.lan> <CAMuHMdV4LV2Uzh2oGdaPiS4W4dfsZ-pn3rGcJNiZLStfo39How@mail.gmail.com>
 <TY1PR06MB09928D43D4E5E5752A6A604ED83A0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <CAPDyKFoF0WMSTuK4AAyDzerpVpnfEq=Hn1n9kDJM0fYMkFL_wA@mail.gmail.com> <TY1PR06MB09924E4F66C6FCF131EE71CFD83B0@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <TY1PR06MB09924E4F66C6FCF131EE71CFD83B0@TY1PR06MB0992.apcprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, USB list <linux-usb@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29 November 2017 at 09:21, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Hi,
>
>> From: Ulf Hansson, Sent: Wednesday, November 29, 2017 2:23 AM
>>
>> On 28 November 2017 at 13:48, Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> > Hi Geert-san,
>> >
>> >> From: Geert Uytterhoeven, Sent: Tuesday, November 28, 2017 7:58 PM
>> >>
>> >> Hi Rafael, Shimoda-san,
>> >>
>> >> On Sun, Nov 12, 2017 at 1:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> <snip>
>> >> JFTR, this triggered before during system resume on e.g. Salvator-XS with
>> >> R-Car H3:
>> >>
>> >>     ohci-platform ee080000.usb: runtime PM trying to suspend device
>> >> but active child
>> >>     phy_rcar_gen3_usb2 ee080200.usb-phy: runtime PM trying to suspend
>> >> device but active child
>> >>     ohci-platform ee0c0000.usb: runtime PM trying to suspend device
>> >> but active child
>> >>     ohci-platform ee0a0000.usb: runtime PM trying to suspend device
>> >> but active child
>> >>     phy_rcar_gen3_usb2 ee0c0200.usb-phy: runtime PM trying to suspend
>> >> device but active child
>> >>     phy_rcar_gen3_usb2 ee0a0200.usb-phy: runtime PM trying to suspend
>> >> device but active child
>> >>
>> >> so this was an existing issue with USB before.
>> >
>> > Thank you for the report!
>> > I know that, but since this didn't cause any trouble until now,
>> > I postponed to investigate the issue... But, I investigate it today.
>> > I don't find the root cause yet. However, it seems related to usb host and/or usb core.
>> > --> USB host related devices' child_count will be 1 in suspend timing.
>> >  --> I guess remote wakeup feature is enabled? But, I don't find the point yet.
>>
>> I am guessing the issue is triggered by genpd in the suspend noirq
>> phase (genpd_suspend_noirq()). In there,  there is a call to
>> pm_runtime_force_suspend() (which calls pm_runtime_set_suspended() and
>> which triggered the earlier error messages being printed).
>>
>> The reason why genpd calls pm_runtime_force_suspend(), is because when
>> validating wakeup configurations for the device "if
>> (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))", it's
>> thinks wakeup isn't configured while it probably should be.
>>
>> An additional note, only when genpd has the GENPD_FLAG_PM_CLK set,
>> which makes the genpd->dev_ops.stop|start() being assigned, genpd
>> calls pm_runtime_force_suspend() - else it doesn't.
>>
>> Perhaps try out the series I recently posted improving the code
>> dealing with wakeups in genpd and the PM core:
>> https://www.spinics.net/lists/linux-renesas-soc/msg20122.html
>> To that, you need to set the new flag (invented in the above series)
>> DPM_FLAG_IN_BAND_WAKEUP in the driver that configures wakeup of its
>> device.
>>
>> Hope this helps!
>
> Thank you for the comments!
> I tried DPM_FLAG_IN_BAND_WAKEUP, but the issue still exists.
> I added the flag in the [eo]hci-platform driver and usb/core/driver.c.
> I also added the flag in the phy_rcar_gen3_usb2 driver except usb host drivers.

First, did you confirm that genpd was used? Then for what device?

Second, did you check the call to pm_runtime_force_suspend() called by
genpd, is the reason to the error messages?

Third, it should be sufficient to add DPM_FLAG_IN_BAND_WAKEUP for the
driver that is actually dealing with the wakeup. Although, does this
driver's system ->suspend() callback check device_may_wakeup(), before
it decides to enable wakeup?
If not, the PM core and genpd don't notice that wakeup is enabled for
the device.

>
>> > The renesas_usbhs also uses the phy_rcar_gen3_usb2 driver.
>> > --> If I only used the renesas_usbhs driver (in other words, I don't install
>> >     [eo]hci-{hcd,platform} drivers), the issue disappeared.
>> >  --> So, I think the phy_rcar_gen3_usb2 driver doesn't cause this issue.
>> >     (But, it is possible to be related though.)
>> >
>> > I'll continue to investigate this issue tomorrow.
>>
>> Please keep me posted, I am interested about the why the problem exists. :-)
>
> Sure! :)

Great, thanks.

Kind regards
Uffe
