From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 0/5] Frequency resolution in CCF vs. cpufreq
Date: Thu, 15 May 2014 11:42:09 +0530
Message-ID: <CAKohpokm3WVnu_DggKc4PbhVAKNexrJ4051F-gnVFFTDOyz9ew@mail.gmail.com>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: cpufreq-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 15 May 2014 04:00, Soren Brinkmann <soren.brinkmann@xilinx.com> wrote:
> I have one or two problems with cpufreq and the CCF, which are caused by
> rounding/different frequency resolutions.
>
> cpufreq works with kHz, while the CCF uses Hz. On Zynq our default frequency is
> 666666666 Hz which the CCF, due to rounding, reports as 666666660. And for
> cpufreq, which simply divides values it obtains through clk_round_rate() by
> 1000, 666666.
> Since passing 666666 to clk_round_rate() does not result in 666666660
> (clk_round_rate() always rounds down!), we chose to put 666667 in the OPP. This
> causes issue 1: cpufreq stats are broken.

I know it might a big exercise, but wouldn't it be worth to make cpufreq start
using frequencies in Hz ?
