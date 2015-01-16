From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: RFC on cpufreq implementation
Date: Fri, 16 Jan 2015 10:08:13 +0100
Message-ID: <1421399293.11224.7.camel@AMDC1943>
References: <54B7F7CD.7030903@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <54B7F7CD.7030903@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Mason <mpeg.blue@free.fr>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On czw, 2015-01-15 at 18:24 +0100, Mason wrote:
> Hello,
> 
> This is a follow-up to my previous thread.
> "How many frequencies would cpufreq optimally like to manage?"
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/373669
> 
> As I originally wrote, I'm running 3.14 on an ARM Cortex-A9
> based SoC (namely Tango4 from Sigma Designs). I'd like to get
> some feedback on the cpufreq driver I wrote for that platform.
> 
> I decided to expose only a small subset of frequencies (namely
> {999,500,333,111} MHz) because, in my tests, the ondemand gov
> chose mostly min and max, and the intermediate frequencies not
> so much; so I figured "2 intermediate freqs" is good enough.
> (I'm ready to hear otherwise.)
> 
> I tried to use as much generic framework as possible, but I've
> read about the clk framework, and it looks to be an even greater
> generalization. Are new platforms encouraged to use that, rather
> than provide a cpufreq driver? Does it work when voltage scaling
> comes in play? (This SoC doesn't have it, but the next will.)

The clock framework generalizes clocks, not cpufreq. Ideally you should
use clock framework in cpufreq driver. So instead manually setting
divider just do something like:

ret = clk_set_rate(cpu_clk, freq_exact);
if (ret) {
	dev_err(cpu_dev, "failed to set clock rate: %d\n", ret);
	return ret;
}

For voltage scaling you should use regulator framework.

Actually I think existing cpufreq-dt could serve your purpose. Why don't
you try it? Or look at it and use as an example.

> I'm also wondering how cpufreq and cpuidle interact? Is one a
> subset of the other? Are they orthogonal?

cpuidle and cpufreq are different subsystems. They don't interact, yet.
There are efforts to combine scheduler, cpufreq and cpuidle but this is
future. If your SoC has some deeper low power states than developing
cpuidle driver makes sense. If not - WFI will be used.

> 
> Regards.

