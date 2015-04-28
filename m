From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC/RFT 2/6] clk: qcom: Add runtime support to handle clocks
 using PM clocks
Date: Tue, 28 Apr 2015 09:25:35 +0200
Message-ID: <CAMuHMdW8OKDODHTw=A=vCFR9PN3KUr_fiGSiNkn0Q7Q16axU6g@mail.gmail.com>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
	<1429778744-13352-3-git-send-email-rnayak@codeaurora.org>
	<CAPDyKFpVXWGeO_kbOvPbdy83aN6wxkC77ydH_2C3Bo=5QsspoA@mail.gmail.com>
	<553A21C7.4060506@codeaurora.org>
	<CAMuHMdV_WD7vay-5VC20izUWFjc8rSW4wZQq6Y3xAa+SU0Quig@mail.gmail.com>
	<7hh9s1xrut.fsf@deeprootsystems.com>
	<553EF5D4.60900@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <553EF5D4.60900@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rajendra,

On Tue, Apr 28, 2015 at 4:52 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>>> But that would mean I repeat the same code in all drivers to do a
>>>> clk_get/prepare/enable/disable/unprepare of the same "core" and "iface"
>>>> clocks. I thought we have clock_ops.c just to avoid that (atleast up
>>>> until we have a better way of doing it)
>>>> And there are atleast a few architecture which have used it to avoid the
>>>> duplication across all drivers (omap1/davinci/sh/keystone)
>>>
>>>
>>> At least for arm/shmobile, we're planning to move away from this, cfr.
>>> http://www.spinics.net/lists/linux-sh/msg41114.html

The above are for the pure-clock domain case (no power areas), on R-Car
Gen2.

>> Just to clarify for Rajendra's sake...
>>
>> SH is moving away from the pm_clk_add_notifier(), but not duplicating
>> the clk_get/prepare/enable/disable/unprepare across all the drivers.
>>
>> Rather, they're using a genpd to model the clock domain, and taking
>> advantage of the pm_domain speciic attach callback to attach the PM
>> clocks.
>>
>> This should work for qcom also assuming that these device nodes don't
>> also need to belong to a different PM domain.
>
> Thanks Kevin, I did look up the patches that Geert pointed me to, and
> figured I can do something similar for qcom as well like you said.
>
> There are 2 types of devices that I will need to handle, one which have
> clocks and also a power switch to turn the power domain on/off (camera,
> graphics, display), and others which only have clocks and no power
> switch to control the power domain (serial, sdhc, i2c, spi).
>
> I was already using genpd attach/detach to handle clocks for the
> devices with a power switch and genpd on/off to turn the PD on and off.

Good.

> I guess I can also control the rest of the devices the same way, just
> that the genpd on/off for them would do nothing.
> That way I don't have to use pm_clk_add_notifier() and can also
> associate the power domain (with no on/off control) to devices
> through DT (and there isn;t any duplication of code in the drivers)

That looks similar to what we have on R-Mobile: some devices are in
controllable power areas, other are in an "always on" power area. All (most)
devices have controllable clocks, which we also control through the PM
domain. "git grep sysc-rmobile" will point you to the related code and DTS.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
