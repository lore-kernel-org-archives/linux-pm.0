From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] drivers: cpufreq: exynos: update related_cpus mask to fix hotplug dump
Date: Mon, 28 Jan 2013 14:14:52 +0100
Message-ID: <7822336.I5LaeuXXgz@vostro.rjw.lan>
References: <1359000647-8366-1-git-send-email-inderpal.singh@linaro.org> <5258369.So5tj1UHcd@vostro.rjw.lan> <CAKohpokHXWh9ZCUK7jV3WHm2WMszO9e9UAmb1Wy0DdqeCWHNqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAKohpokHXWh9ZCUK7jV3WHm2WMszO9e9UAmb1Wy0DdqeCWHNqA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Inderpal Singh <inderpal.singh@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On Monday, January 28, 2013 06:29:35 PM Viresh Kumar wrote:
> On 28 January 2013 17:56, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > So here's a deal: I'll drop "cpufreq: Simplify cpufreq_add_dev()" for now and
> > you'll generate a new patch that won't cause the WARN_ON() to trigger.  OK?
> 
> :(
> 
> Or what about set all cpus from policy->cpus into related_cpus in our core code?
> So, if platform sets any additional cpus, they would be retained?

Well, that might work.

Please do whatever you think is the most appropriate and doesn't introcude any
regressions.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
