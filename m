From: Tony Lindgren <tony@atomide.com>
Subject: Re: Crashes in arm qemu emulations due to 'cpufreq: governor:
 Replace timers with utilization ...'
Date: Mon, 15 Feb 2016 11:58:40 -0800
Message-ID: <20160215195839.GA19432@atomide.com>
References: <20160215170527.GA24453@roeck-us.net>
 <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
 <20160215190116.GX19432@atomide.com>
 <56C229A5.8020901@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56C229A5.8020901@roeck-us.net>
Sender: linux-next-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [160215 11:41]:
> On 02/15/2016 11:01 AM, Tony Lindgren wrote:
> >
> >https://kernelci.org/boot/all/job/next/kernel/next-20160215/
> >
> >The SMP ones seem to fail with some regulator issues?
> >
> 
> There is another problem, introduced with 6a0712f6f199e ("PM / OPP: Add
> dev_pm_opp_set_rate()"). The kernelci boot log for next-20160212:omap3-overo-tobi
> and others experience that problem.
> 
> Essentially, the code now assumes that a CPU clock always has a voltage
> regulator attached to it, which is not correct. I sent out a patch to fix
> that problem a minute ago.

Yes that fixed it thanks.

Tony
