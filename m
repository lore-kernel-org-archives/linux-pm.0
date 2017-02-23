From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq: get cpufreq_frequency_table from clk driver
Date: Thu, 23 Feb 2017 10:24:45 +0530
Message-ID: <20170223045445.GA21911@vireshk-i7>
References: <1487675614.25108.30.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487675614.25108.30.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vlad Zakharov <Vladislav.Zakharov@synopsys.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 21-02-17, 11:13, Vlad Zakharov wrote:
> Hello,
> 
> I am trying to implement a cpufreq driver for ARCHS cpu.

You mean ARC architecture here ?

> And I faced with one question I am not able to answer myself. cpufreq framework allows us using cpufreq frequency tables
> that store available for current policy range of frequencies with any additional data. As I understand for example it
> can be clock configurations for this particular frequency.

Yes, it can be any platform specific data. Yes, but it is better
handled by the clk driver in your case and cpufreq driver just needs
to call clk_set_rate().

> Also I have a clk driver that manages actual cpu frequency. In fact it uses very similar tables that contain frequencies
> and corresponding values of clock configurations registers that are to be set up with current frequency.

Good.

> So the question is can I get such tables from clk driver somehow? I would be very convenient: this tables differs for
> ARCHS CPU. E.g. on different boards it is clocked by different PLLs and oscillators.

Not that I am aware of. Just make copies for every board or if you can
use device tree, get it using OPP tables.

-- 
viresh
