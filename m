From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 3/6] cpufreq: governor: Drop min_sampling_rate
Date: Thu, 29 Jun 2017 20:01:23 +0200
Message-ID: <20170629180123.GA2443@light.dominikbrodowski.net>
References: <cover.1498733506.git.viresh.kumar@linaro.org>
 <713af1a417a9a77f0c41976b25874687ac235e8e.1498733506.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <713af1a417a9a77f0c41976b25874687ac235e8e.1498733506.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 29, 2017 at 04:29:06PM +0530, Viresh Kumar wrote:
> The cpufreq core and governors aren't supposed to set a limit on how
> fast we want to try changing the frequency. This is currently done for
> the legacy governors with help of min_sampling_rate.
> 
> At worst, we may end up setting the sampling rate to a value lower than
> the rate at which frequency can be changed and then one of the CPUs in
> the policy will be only changing frequency for ever.

Is it safe to issue requests to change the CPU frequency so frequently, even
on historic hardware such as speedstep-{ich,smi,centrino}? In the past,
these checks more or less disallowed the running of dynamic frequency
scaling at least on speedstep-smi[*], but maybe on a few other platforms as
well. That's why I am curious on whether this may break systems potentially
on a hardware level if the hardware was not designed to do dynamic frequency
scaling (and not just frequency switches on battery/AC).

Best,
	Dominik
