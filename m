From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: stats: Make the stats code non-modular
Date: Tue, 31 May 2016 22:47:18 +0200
Message-ID: <2881201.0GRyZLBx91@vostro.rjw.lan>
References: <1482863.aVJEuqdboc@vostro.rjw.lan> <5665576.VhylybbIm6@vostro.rjw.lan> <20160531104434.GE9463@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160531104434.GE9463@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 31, 2016 04:14:34 PM Viresh Kumar wrote:
> On 28-05-16, 15:15, Rafael J. Wysocki wrote:
> > -static int __init cpufreq_stats_init(void)
> > -{
> > -	int ret;
> > -	unsigned int cpu;
> > -
> > -	spin_lock_init(&cpufreq_stats_lock);
> 
> My bad for ignoring this, but the spin lock is left uninitialized now

That's embarrassing.

Should be fixed now, thanks!
