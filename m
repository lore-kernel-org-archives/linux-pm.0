From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: Avoid attempts to create duplicate symbolic
 links
Date: Sat, 25 Jul 2015 18:30:02 +0530
Message-ID: <20150725130002.GC1691@linux>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan>
 <20150724140943.GC16336@linux>
 <1509688.KKhdi8M36y@vostro.rjw.lan>
 <11080992.c5Q5Du7n5n@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11080992.c5Q5Du7n5n@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On 25-07-15, 00:17, Rafael J. Wysocki wrote:
> To avoid that warning, use the observation that cpufreq doesn't
> need to care about CPUs that have never been online.

I have concerns over the very philosophy behind the patch and so
wanted to discuss more on that.

It will be really confusing to have a scenario where:
- we have a four related CPUs: 0-3.
- 0-1 are online and have /sys/devices/system/cpu/cpuX/cpufreq directory
- 2 is offline but was once online and so still has a directory
- 3 never came online after the cpufreq driver is registered (we need
  to think about cpufreq driver being a module here, its possible CPU
  was online earlier) and so it doesn't have a directory.

How will the user distinguish between cpu 3 and 4, both being offline
and user may not know one of them was never online. And the related
CPUs of 0-2 will include CPU 3 as well..

I think, we just moved into the wrong direction. We have a valid
policy for CPU4, with all valid data. Why not show it up in sysfs?

So, what we discussed over IRC earlier was, cpufreq shouldn't care
about CPUs, which are offline and that don't have a policy allocated
for them. So if all the CPUs of a policy never came online after the
driver is registered, we shouldn't care about them.

I think, for know your earlier version of the patch was just fine,
with the improvements I suggested. And we should go ahead with
solution like what I gave, the diff of that was quite big for an rc
fix and so I said your patch looks better.

-- 
viresh
