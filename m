From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] cpufreq: cpufreq-cpu0: No need to check cpu number in
 init()
Date: Mon, 1 Apr 2013 14:44:20 +0800
Message-ID: <20130401064418.GE1693@S2101-09.ap.freescale.net>
References: <3f6e2ec11acfe89c192735f357c830d968daa0fd.1364648083.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3f6e2ec11acfe89c192735f357c830d968daa0fd.1364648083.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 30, 2013 at 06:26:29PM +0530, Viresh Kumar wrote:
> It is not possible for init() to be called for any cpu other than cpu0. During
> bootup whatever cpu is used to boot system will be assigned as cpu0. And later
> on policy->cpu can only change if we hotunplug all cpus first and then hotplug
> them back in different order, which isn't possible (system requires atleast one
> cpu to be up always :)).
> 
> Though I can see one situation where policy->cpu can be different then zero.
> - Hot-unplug cpu 0.
> - rmmod cpufreq-cpu0 module
> - insmod it back
> - hotplug cpu 0 again.
> 
> Here, policy->cpu would be different. But the driver doesn't have any dependency
> on cpu0 as such. We don't mind which cpu of a system is policy->cpu and so this
> check is just not required.
> 
> Remove it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

