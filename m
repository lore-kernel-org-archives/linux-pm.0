From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC/RFT 2/6] clk: qcom: Add runtime support to handle clocks
 using PM clocks
Date: Sun, 26 Apr 2015 10:49:26 +0200
Message-ID: <CAMuHMdV_WD7vay-5VC20izUWFjc8rSW4wZQq6Y3xAa+SU0Quig@mail.gmail.com>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
	<1429778744-13352-3-git-send-email-rnayak@codeaurora.org>
	<CAPDyKFpVXWGeO_kbOvPbdy83aN6wxkC77ydH_2C3Bo=5QsspoA@mail.gmail.com>
	<553A21C7.4060506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <553A21C7.4060506@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 24, 2015 at 12:58 PM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>> Second, I want to see less users of pm_clk_add_notifier() since it's
>> not the proper/long-term way of how to assign PM domain pointers to a
>> device. Instead that shall be done at device registration point. In
>> your case while parsing the DT nodes and adding devices onto to their
>> buses.
>
> but these are devices which do not really have a controllable power
> domain, they just have controllable clocks.
>
>> Yes, I understand that it will requires quite some work to adopt to
>> this behaviour - but that how it shall be done.
>>
>> Finally, an important note, you don't need to use PM domains for these
>> devices at all and thus you don't need to fix what I propose. Instead
>> you only have to implement the runtime PM callbacks for each driver
>> and manage the clocks from there. That is probably also a easier
>> solution.
>
> But that would mean I repeat the same code in all drivers to do a
> clk_get/prepare/enable/disable/unprepare of the same "core" and "iface"
> clocks. I thought we have clock_ops.c just to avoid that (atleast up
> until we have a better way of doing it)
> And there are atleast a few architecture which have used it to avoid the
> duplication across all drivers (omap1/davinci/sh/keystone)

At least for arm/shmobile, we're planning to move away from this, cfr.
http://www.spinics.net/lists/linux-sh/msg41114.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
