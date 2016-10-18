From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 5/6] clk: pxa: transfer CPU clock setting from pxa2xx-cpufreq
Date: Tue, 18 Oct 2016 09:00:28 +0200
Message-ID: <87zim23zw3.fsf@belgarion.home>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
        <1476130149-31834-6-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1476130149-31834-6-git-send-email-robert.jarzmik@free.fr>
        (Robert Jarzmik's message of "Mon, 10 Oct 2016 22:09:08 +0200")
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> This is the initial stage to transfer the pxa25x and pxa27x CPU clocks
> handling from cpufreq to the clock API. More precisely, the clocks
> transferred are :
>  - cpll : core pll, known also as the CPU core turbo frequency
>  - core : core, known also as the CPU actual frequency, being either the
>           CPU core turbo frequency or the CPU core run frequency
>
> This transfer is a prequel to shrink the code in pxa2xx-cpufreq.c, so
> that it can become, at least in devicetree builds, the casual cpufreq-dt
> driver.

Hi Michael and Stephen,

I'm planing on sending a v2 next week with minor corrections, mostly in the data
tables (pxa25x_freqs and pxa27x_freqs), as testing prooved some values were wrong.

If you want me modify this serie, will you have time to review for next week or
should I delay the v2 posting ?

Cheers.

--
Robert
