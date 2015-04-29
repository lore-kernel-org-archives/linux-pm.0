From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC/RFT 2/6] clk: qcom: Add runtime support to handle clocks
 using PM clocks
Date: Wed, 29 Apr 2015 13:30:02 +0200
Message-ID: <CAMuHMdWWv5qADWP4CMj5Kj62v_FK9JxMP6NXOpyN8GTk05raAQ@mail.gmail.com>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
	<1429778744-13352-3-git-send-email-rnayak@codeaurora.org>
	<CAPDyKFpVXWGeO_kbOvPbdy83aN6wxkC77ydH_2C3Bo=5QsspoA@mail.gmail.com>
	<553A21C7.4060506@codeaurora.org>
	<CAMuHMdV_WD7vay-5VC20izUWFjc8rSW4wZQq6Y3xAa+SU0Quig@mail.gmail.com>
	<7hh9s1xrut.fsf@deeprootsystems.com>
	<553EF5D4.60900@codeaurora.org>
	<CAMuHMdW8OKDODHTw=A=vCFR9PN3KUr_fiGSiNkn0Q7Q16axU6g@mail.gmail.com>
	<5540A923.8000104@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <5540A923.8000104@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rajendra,

On Wed, Apr 29, 2015 at 11:49 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>> I guess I can also control the rest of the devices the same way, just
>>> that the genpd on/off for them would do nothing.
>>> That way I don't have to use pm_clk_add_notifier() and can also
>>> associate the power domain (with no on/off control) to devices
>>> through DT (and there isn;t any duplication of code in the drivers)
>>
>>
>> That looks similar to what we have on R-Mobile: some devices are in
>> controllable power areas, other are in an "always on" power area. All
>> (most)
>> devices have controllable clocks, which we also control through the PM
>> domain. "git grep sysc-rmobile" will point you to the related code and
>> DTS.
>
> Geert, thanks, I was wondering how you handle the !CONFIG_PM case for
> rmobile. I mean who turns the clocks on for the devices when you build
> with CONFIG_PM disabled?

We still use pm_clk_add_notifier() in drivers/sh/pm_runtime.c if
CONFIG_PM_GENERIC_DOMAINS_OF=n. Hence the second instance of
pm_clk_notify() will enable the clocks at driver binding time.
Hardware power domains are assumed enabled by reset state/the boot
loader.

Given the amount of PM infrastructure involved when hardware power and
clock domains are involved, I think at one point we'll have to start restricting
our builds to CONFIG_PM=y.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
