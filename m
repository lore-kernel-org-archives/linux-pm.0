From: Thomas Renninger <trenn@suse.de>
Subject: Re: [RFC] cpufreq: governor: Set MIN_LATENCY_MULTIPLIER to 20
Date: Tue, 26 Feb 2013 11:44:19 +0100
Message-ID: <1993068.XZh8f6yGqe@skinner.arch.suse.de>
References: <472e2bac1fc4a2589651beddbfaf6da53500d12e.1361871582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <472e2bac1fc4a2589651beddbfaf6da53500d12e.1361871582.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 26, 2013 03:13:32 PM Viresh Kumar wrote:
> Currently MIN_LATENCY_MULTIPLIER is set defined as 100 and so on a system
> with transition latency of 1 ms, the minimum sampling time comes to be
> around 100 ms. That is quite big if you want to get better performance for
> your system.
> 
> Redefine MIN_LATENCY_MULTIPLIER to 20 so that we can support 20ms sampling
> rate for such platforms.

Redefining MIN_LATENCY_MULTIPLIER shouldn't hurt that much, but this looks
like a workaround.
It only modifies the minimal sampling rate that userspace can set.
You would still need to set something from userspace to get the perfect 
sampling rate for this platform.

I wonder where the cpufreq driver does get the 1ms latency from?
Is this value valid?
The driver should return the correct latency, then there is no need for
workarounds like this.

      Thomas
