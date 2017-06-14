From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V2 0/2] PM / Domains: Expand generic power domain debugfs.
Date: Wed, 14 Jun 2017 10:24:49 +0200
Message-ID: <CAMuHMdXYkXm3NKE=MT0dF+x-wNHWDjYJ+bbO9gWEwwuFwYUKmA@mail.gmail.com>
References: <1497385659-2356-1-git-send-email-thara.gopinath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36490 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754646AbdFNIY4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2017 04:24:56 -0400
Received: by mail-io0-f193.google.com with SMTP id i93so15424177iod.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2017 01:24:55 -0700 (PDT)
In-Reply-To: <1497385659-2356-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg KH <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Thara,

On Tue, Jun 13, 2017 at 10:27 PM, Thara Gopinath
<thara.gopinath@linaro.org> wrote:
> This patch set attempts to improve the existing generic power domain
> debugfs capabilities. The first  patch adds various accounting and
> other bits needed to expose out the generic power domain statistics.
> The second patch introduces new debugfs entries and attributes.
>
> V1->V2:
> - Removed calling of update accounting from suspend resume context
>   where time keeping can be disabled.
> - Added back the pm_genpd_summary which was removed by the first version
>   of this patchset.
> - Renamed a few debugfs parameters.

Thanks for your patches!

For reference, I'm adding the output of all new files on a Renesas Salvator-X
board (slightly reformatted, as "idle_states" and "devices" may span multiple
lines):

3dg-a
  active_time : 6231 ms
  current_state : off-0
  devices :
  idle_states : State          Time Spent(ms)
                S0               305565
  sub_domains : 3dg-b
  total_idle_time : 305782 ms
3dg-b
  active_time : 6231 ms
  current_state : off-0
  devices :
  idle_states : State          Time Spent(ms)
                S0               306142
  sub_domains : 3dg-c
  total_idle_time : 306351 ms
3dg-c
  active_time : 6231 ms
  current_state : off-0
  devices :
  idle_states : State          Time Spent(ms)
                S0               306706
  sub_domains : 3dg-d
  total_idle_time : 306923 ms
3dg-d
  active_time : 6231 ms
  current_state : off-0
  devices :
  idle_states : State          Time Spent(ms)
                S0               307299
  sub_domains : 3dg-e
  total_idle_time : 307516 ms
3dg-e
  active_time : 6231 ms
  current_state : off-0
  devices :
  idle_states : State          Time Spent(ms)
                S0               307902
  sub_domains :
  total_idle_time : 308119 ms
a2vc1
  active_time : 6231 ms
  current_state : off-0
  devices :
  idle_states : State          Time Spent(ms)
                S0               308511
  sub_domains :
  total_idle_time : 308722 ms
a3ir
  active_time : 6231 ms
  current_state : off-0
  devices :
  idle_states : State          Time Spent(ms)
                S0               309115
  sub_domains :
  total_idle_time : 309332 ms
a3vc
  active_time : 6231 ms
  current_state : off-0
  devices :
  idle_states : State          Time Spent(ms)
                S0               309705
  sub_domains : a2vc1
  total_idle_time : 309905 ms
a3vp
  active_time : 4552 ms
  current_state : off-0
  devices : /devices/platform/soc/fe92f000.fcp
            /devices/platform/soc/fe950000.fcp
            /devices/platform/soc/fe951000.fcp
            /devices/platform/soc/fe96f000.fcp
            /devices/platform/soc/fe9af000.fcp
            /devices/platform/soc/fe9bf000.fcp
            /devices/platform/soc/fe940000.fdp1
            /devices/platform/soc/fe944000.fdp1
            /devices/platform/soc/fe920000.vsp
            /devices/platform/soc/fe960000.vsp
            /devices/platform/soc/fe9a0000.vsp
            /devices/platform/soc/fe9b0000.vsp
  idle_states : State          Time Spent(ms)
                S0               312002
  sub_domains :
  total_idle_time : 312219 ms
always-on
  active_time : 316884 ms
  current_state : on
  devices : /devices/platform/soc/e60b0000.i2c
            /devices/platform/soc/ee0a0200.usb-phy
            /devices/platform/soc/ee0c0200.usb-phy
            /devices/platform/soc/e6050000.gpio
            /devices/platform/soc/e6051000.gpio
            /devices/platform/soc/e6052000.gpio
            /devices/platform/soc/e6053000.gpio
            /devices/platform/soc/e6054000.gpio
            /devices/platform/soc/e6055000.gpio
            /devices/platform/soc/e6055400.gpio
            /devices/platform/soc/e6055800.gpio
            /devices/platform/soc/e6700000.dma-controller
            /devices/platform/soc/e7300000.dma-controller
            /devices/platform/soc/e7310000.dma-controller
            /devices/platform/soc/ec700000.dma-controller
            /devices/platform/soc/ec720000.dma-controller
            /devices/platform/soc/e65a0000.dma-controller
            /devices/platform/soc/e65b0000.dma-controller
            /devices/platform/soc/e6e68000.serial
            /devices/platform/soc/e6e88000.serial
            /devices/platform/soc/fead0000.hdmi0
            /devices/platform/soc/feae0000.hdmi1
            /devices/platform/soc/e6800000.ethernet
            /devices/platform/soc/ee0a0100.usb
            /devices/platform/soc/ee0c0100.usb
            /devices/platform/soc/ee0a0000.usb
            /devices/platform/soc/ee0c0000.usb
            /devices/platform/soc/e6510000.i2c
            /devices/platform/soc/e66d8000.i2c
            /devices/platform/soc/fea27000.fcp
            /devices/platform/soc/fea2f000.fcp
            /devices/platform/soc/fea37000.fcp
            /devices/platform/soc/fea28000.vsp
            /devices/platform/soc/fea30000.vsp
            /devices/platform/soc/e6198000.thermal
            /devices/platform/soc/e6020000.watchdog
            /devices/platform/soc/ee140000.sd
            /devices/platform/soc/ec500000.sound
            /devices/platform/soc/e61c0000.interrupt-controller
            /devices/platform/soc/ee080200.usb-phy
            /devices/platform/soc/ee080100.usb
            /devices/platform/soc/ee080000.usb
            /devices/platform/soc/ee100000.sd
            /devices/platform/soc/ee160000.sd
  idle_states : State          Time Spent(ms)
                S0               0
  sub_domains : ca57-scu, ca53-scu, a3vp, cr7, a3vc, 3dg-a, a3ir
  total_idle_time : 0 ms
ca53-cpu0
  active_time : 317535 ms
  current_state : on
  devices :
  idle_states : State          Time Spent(ms)
                S0               0
  sub_domains :
  total_idle_time : 0 ms
ca53-cpu1
  active_time : 318121 ms
  current_state : on
  devices :
  idle_states : State          Time Spent(ms)
                S0               0
  sub_domains :
  total_idle_time : 0 ms
ca53-cpu2
  active_time : 318691 ms
  current_state : on
  devices :
  idle_states : State          Time Spent(ms)
                S0               0
  sub_domains :
  total_idle_time : 0 ms
ca53-cpu3
  active_time : 319273 ms
  current_state : on
  devices :
  idle_states : State          Time Spent(ms)
                S0               0
  sub_domains :
  total_idle_time : 0 ms
ca53-scu
  active_time : 319874 ms
  current_state : on
  devices :
  idle_states : State          Time Spent(ms)
                S0               0
  sub_domains : ca53-cpu0, ca53-cpu1, ca53-cpu2, ca53-cpu3
  total_idle_time : 0 ms
ca57-cpu0
  active_time : 320455 ms
  current_state : on
  devices :
  idle_states : State          Time Spent(ms)
                S0               0
  sub_domains :
  total_idle_time : 0 ms
ca57-cpu1
  active_time : 321014 ms
  current_state : on
  devices :
  idle_states : State          Time Spent(ms)
                S0               0
  sub_domains :
  total_idle_time : 0 ms
ca57-cpu2
  active_time : 321569 ms
  current_state : on
  devices :
  idle_states : State          Time Spent(ms)
                S0               0
  sub_domains :
  total_idle_time : 0 ms
ca57-cpu3
  active_time : 322147 ms
  current_state : on
  devices :
  idle_states : State          Time Spent(ms)
                S0               0
  sub_domains :
  total_idle_time : 0 ms
ca57-scu
  active_time : 322748 ms
  current_state : on
  devices :
  idle_states : State          Time Spent(ms)
                S0               0
  sub_domains : ca57-cpu0, ca57-cpu1, ca57-cpu2, ca57-cpu3
  total_idle_time : 0 ms
clock-controller
  active_time : 323302 ms
  current_state : on
  devices :
  idle_states : State          Time Spent(ms)
                S0               0
  sub_domains :
  total_idle_time : 0 ms
cr7
  active_time : 6231 ms
  current_state : off-0
  devices :
  idle_states : State          Time Spent(ms)
                S0               318018
  sub_domains :
  total_idle_time : 318237 ms

Plain pm_genpd_summary:

domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
clock-controller                on
a3ir                            off-0
3dg-e                           off-0
3dg-d                           off-0           3dg-e
3dg-c                           off-0           3dg-d
3dg-b                           off-0           3dg-c
3dg-a                           off-0           3dg-b
a2vc1                           off-0
a3vc                            off-0           a2vc1
cr7                             off-0
a3vp                            off-0
    /devices/platform/soc/fe92f000.fcp                  suspended
    /devices/platform/soc/fe950000.fcp                  suspended
    /devices/platform/soc/fe951000.fcp                  suspended
    /devices/platform/soc/fe96f000.fcp                  suspended
    /devices/platform/soc/fe9af000.fcp                  suspended
    /devices/platform/soc/fe9bf000.fcp                  suspended
    /devices/platform/soc/fe940000.fdp1                 suspended
    /devices/platform/soc/fe944000.fdp1                 suspended
    /devices/platform/soc/fe920000.vsp                  suspended
    /devices/platform/soc/fe960000.vsp                  suspended
    /devices/platform/soc/fe9a0000.vsp                  suspended
    /devices/platform/soc/fe9b0000.vsp                  suspended
ca53-cpu3                       on
ca53-cpu2                       on
ca53-cpu1                       on
ca53-cpu0                       on
ca53-scu                        on              ca53-cpu0, ca53-cpu1,
ca53-cpu2, ca53-cpu3
ca57-cpu3                       on
ca57-cpu2                       on
ca57-cpu1                       on
ca57-cpu0                       on
ca57-scu                        on              ca57-cpu0, ca57-cpu1,
ca57-cpu2, ca57-cpu3
always-on                       on              ca57-scu, ca53-scu,
a3vp, cr7, a3vc, 3dg-a, a3ir
    /devices/platform/soc/e60b0000.i2c                  suspended
    /devices/platform/soc/ee0a0200.usb-phy              active
    /devices/platform/soc/ee0c0200.usb-phy              active
    /devices/platform/soc/e6050000.gpio                 suspended
    /devices/platform/soc/e6051000.gpio                 suspended
    /devices/platform/soc/e6052000.gpio                 active
    /devices/platform/soc/e6053000.gpio                 active
    /devices/platform/soc/e6054000.gpio                 active
    /devices/platform/soc/e6055000.gpio                 active
    /devices/platform/soc/e6055400.gpio                 active
    /devices/platform/soc/e6055800.gpio                 suspended
    /devices/platform/soc/e6700000.dma-controller       active
    /devices/platform/soc/e7300000.dma-controller       active
    /devices/platform/soc/e7310000.dma-controller       suspended
    /devices/platform/soc/ec700000.dma-controller       suspended
    /devices/platform/soc/ec720000.dma-controller       suspended
    /devices/platform/soc/e65a0000.dma-controller       suspended
    /devices/platform/soc/e65b0000.dma-controller       suspended
    /devices/platform/soc/e6e68000.serial               active
    /devices/platform/soc/e6e88000.serial               active
    /devices/platform/soc/fead0000.hdmi0                unsupported
    /devices/platform/soc/feae0000.hdmi1                unsupported
    /devices/platform/soc/e6800000.ethernet             active
    /devices/platform/soc/ee0a0100.usb                  unsupported
    /devices/platform/soc/ee0c0100.usb                  unsupported
    /devices/platform/soc/ee0a0000.usb                  suspended
    /devices/platform/soc/ee0c0000.usb                  suspended
    /devices/platform/soc/e6510000.i2c                  suspended
    /devices/platform/soc/e66d8000.i2c                  suspended
    /devices/platform/soc/fea27000.fcp                  suspended
    /devices/platform/soc/fea2f000.fcp                  suspended
    /devices/platform/soc/fea37000.fcp                  suspended
    /devices/platform/soc/fea28000.vsp                  suspended
    /devices/platform/soc/fea30000.vsp                  suspended
    /devices/platform/soc/e6198000.thermal              active
    /devices/platform/soc/e6020000.watchdog             active
    /devices/platform/soc/ee140000.sd                   active
    /devices/platform/soc/ec500000.sound                suspended
    /devices/platform/soc/e61c0000.interrupt-controller  active
    /devices/platform/soc/ee080200.usb-phy              active
    /devices/platform/soc/ee080100.usb                  unsupported
    /devices/platform/soc/ee080000.usb                  suspended
    /devices/platform/soc/ee100000.sd                   active
    /devices/platform/soc/ee160000.sd                   active

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
