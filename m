From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] bus: subsys: propagate errors from subsys interface's
 ->add_dev()
Date: Fri, 31 Jul 2015 11:39:07 +0530
Message-ID: <20150731060907.GO17794@linux>
References: <aff842c23841a8e61ac17e58fc27c99e052e338b.1435308918.git.viresh.kumar@linaro.org>
 <2113628.vmLC8GdsGl@vostro.rjw.lan>
 <20150730034431.GH5100@linux>
 <8139001.Q4eV8YG1Il@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8139001.Q4eV8YG1Il@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, pi-cheng.chen@linaro.org
List-Id: linux-pm@vger.kernel.org

On 30-07-15, 20:53, Rafael J. Wysocki wrote:
> Well, on ACPI systems we actually do probe CPU devices.  We have a processor
> driver there that binds to CPU devices and the cpufreq driver is just a
> frontend to that.

Hmm, maybe I need to look at that in detail..

> So question is what prevents DT-based systems from doing it analogously.

Don't have an answer to it yet.

> Now, even if you use a fake platform device for that (I'm sure there are
> reasons for doing that, but I'd very much like them to be explained),

The other reason apart from the EPROBE_DEFER thing was to identify the
right driver for a platform. For multiplatform kernels, there can be
multiple cpufreq drivers present in the kernel and there was no other
way to identify the right driver platform wants to probe.

> then
> all of the information on dependencies should already be available to the
> ->probe callback of that device's driver, so it can check them before
> registering the cpufreq interface, can't it?

That's what we try to do today for cpufreq-dt, for example. But that
has to be done for every possible policy the system can have as all
might have separate resources to allocate. For cpufreq-dt, we do it
only for cpu0 today, and assume others will work as well if cpu0 can.

The real deal is that we need a probe() per policy here, for which
init() fitted well :)

> Essentially, what you're suggesting to do is something like: Make the ->probe
> of one device's driver register a subsys interface for a specific bus type
> and check what ->add_dev of that interface returns for each device on that
> bus and if that is -EPROBE_DEFER, return it as its own return value.  Do you
> honestly think this is a good design?

No. I don't really thing so. That's why I was asking for suggestions
to do it proper. Maybe processor driver is the way to look for, I will
investigate further on that.

But until the time that is done, and I expect that to take some time,
can't we check the return value of ->add_dev()?
 
-- 
viresh
