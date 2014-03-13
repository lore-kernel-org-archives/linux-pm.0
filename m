From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC] cpufreq-cpu0: allow OPP table supplied by platform
Date: Thu, 13 Mar 2014 16:25:54 +0530
Message-ID: <CAKohpokLv0m+Cky7nCUOgP-djTMrA6jyka_EZ07+_exCAexXXg@mail.gmail.com>
References: <20140313184859.7d6f6512@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20140313184859.7d6f6512@xhacker>
Sender: cpufreq-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 13 March 2014 16:18, Jisheng Zhang <jszhang@marvell.com> wrote:
> Hi all,
>
> cpufreq-cpu0 is suitable for Marvell Berlin SoC. But there's one issue to address.
> The opp is different between chips even on the same step SoC, BG2Q for example.
> we can calculate the OPP table from the value of one OTP register. We have two
> solutions:
>
> 1. bootloader reads OTP register and calculate the OPP table then change dtb
> danamically
>
> 2. supply one driver in mach-berlin to initialize the OPP table; and modify
> cpufreq-cpu0 to allow platform supply OPP table, fall back to of_init_opp_table()
> if there's no OPP table.
>
> Which solution is better?

I think we can go ahead with second option here. We can just check if opp tables
are already initialized or not. In case they are, don't probe from dt..

But lets see with others have to say here..

--
viresh
