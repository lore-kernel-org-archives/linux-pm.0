From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC] ARM: shmobile: sh7372: Keep D4 pm domain powered
Date: Tue, 28 Oct 2014 09:15:56 +0100
Message-ID: <CAMuHMdU6W_JTYB9S0vUmWckFYFMP4oZuZXcdcEkBshiErZ4YYg@mail.gmail.com>
References: <1414063874-9533-1-git-send-email-geert+renesas@glider.be>
	<20141027010846.GC30485@verge.net.au>
	<CAMuHMdVFTjy5UZEU6azEuXQSKF1msQrQ-cOe2jZzevcpAPfAjw@mail.gmail.com>
	<20141028001642.GA20702@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20141028001642.GA20702@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Simon,

On Tue, Oct 28, 2014 at 1:16 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Oct 27, 2014 at 09:23:14AM +0100, Geert Uytterhoeven wrote:
>> On Mon, Oct 27, 2014 at 2:08 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Thu, Oct 23, 2014 at 01:31:14PM +0200, Geert Uytterhoeven wrote:
>> >> The D4 power domain contains the Coresight-ETM hardware block.
>> >> As long as the ARM debug/perf code doesn't use resource management with
>> >> runtime PM support, the D4 power domain must be kept powered to avoid a
>> >> crash during resume from s2ram (dbg_cpu_pm_notify() calls
>> >> reset_ctrl_regs() unconditionally, causing an undefined instruction
>> >> oops).
>> >>
>> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> >> ---
>> >> Untested on real hardware, but a similar workaround is needed on r8a7740.
>> >
>> > I have hardware in the form of a Mackerel board and I'm happy
>> > to test this if it would help and you give me some guidance on how to do so.
>>
>> That would be great!
>>
>> Test procedure:
>>   1. echo 0 > /sys/module/printk/parameters/console_suspend
>
> I seemed to also need:
>
> echo enabled > /sys/devices/platform/sh-sci.0/tty/ttySC0/power/wakeup

Interesting. On Koelsch and Armadillo receiving a serial interrupt
is sufficient to wake up:

root@armadillo:~# cat /sys/devices/e6c50000.serial/tty/ttySC1/power/wakeup
disabled
root@armadillo:~#

Probably the more advanced wake up sources code on sh7372 honours that.

>>   2. echo mem > /sys/power/state
>>   3. [ Wake up by pressing a key on the serial console.
>>         There's no other wake-up source on mackerel? ]
>
> usbhs seems like a candidate, it has a wakeup node in sysfs.
>
>> Without my patch, I expect it to crash during resume in reset_ctrl_regs().
>
> With the patch and the mackerel defconfig I see this:
>
> # echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.005 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.009 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> dpm_run_callback(): pm_genpd_suspend+0x0/0x44 returns -16
> PM: Device sh_mobile_sdhi.2 failed to suspend: error -16
> PM: Some devices failed to suspend, or early wake event detected
> PM: resume of devices complete after 0.323 msecs
> Restarting tasks ... done.
> -bash: echo: write error: Device or resource busy
> #
>
> So I turned of SDHI support in the kernel config and tried again:

That's the SDHI QoS value, which is lower than the PM domain
suspend/resume time. An alternative should be:

echo 501 > /sys/devices/platform/sh_mobile_sdhi.2/power/pm_qos_resume_latency_us

> # echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.008 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.009 seconds) done.
> renesas_usbhs renesas_usbhs.1: remove, state 4
> usb usb1: USB disconnect, device number 1
> renesas_usbhs renesas_usbhs.1: USB bus 1 deregistered
> PM: suspend of devices complete after 28.959 msecs
> PM: late suspend of devices complete after 0.357 msecs
> PM: noirq suspend of devices complete after 0.512 msecs
>
> [keypress]
>
> sh_tmu sh-tmu.0: ch0: used for periodic clock events
> PM: noirq resume of devices complete after 0.420 msecs
> PM: early resume of devices complete after 0.209 msecs
> PM: resume of devices complete after 0.327 msecs
> Restarting tasks ...
>
> renesas_usbhs renesas_usbhs.1: USB Host Controller
> renesas_usbhs renesas_usbhs.1: new USB bus registered, assigned bus number 1
> done.
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 1 port detected
> asoc-simple-card asoc-simple-card.0: ASoC: CODEC DAI ak4642-hifi not registered
> platform asoc-simple-card.0: Driver asoc-simple-card requests probe deferral
>
>
> Without the patch I see the same as above, module slightly different msec
> values:

OK, so my patch is not needed (yet[*]), please drop it.
Either the Cortex A8 has a different debug module than A9, or what the kernel
uses right now is not in the same D4 PM domain as the Coresight-ETM.

Thanks for testing!

[*] This may change when the full Coresight-ETM patches by Mathieu Poirier
    are in.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
