From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] cpufreq: Disallow ->resolve_freq() for drivers providing ->target_index()
Date: Fri, 22 Jul 2016 01:22:22 +0200
Message-ID: <1490801.bHMYROVPDC@vostro.rjw.lan>
References: <065301260510fbca81f5481b27b0de956073068a.1469137133.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <065301260510fbca81f5481b27b0de956073068a.1469137133.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, Juri.Lelli@arm.com, patrick.bellasi@arm.com
List-Id: linux-pm@vger.kernel.org

On Thursday, July 21, 2016 02:39:26 PM Viresh Kumar wrote:
> The handlers provided by cpufreq core are sufficient for resolving the
> frequency for drivers providing ->target_index(), as the core already
> has the frequency table and so ->resolve_freq() isn't required for such
> platforms.
> 
> This patch disallows drivers with ->target_index() callback to use the
> ->resolve_freq() callback.
> 
> Also, it fixes a potential kernel crash for drivers providing ->target()
> but no ->resolve_freq().
> 
> Fixes: e3c062360870 ("cpufreq: add cpufreq_driver_resolve_freq()")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

OK, applied.

Thanks,
Rafael
