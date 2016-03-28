From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 5/7][Resend] cpufreq: Move governor symbols to
 cpufreq.h
Date: Mon, 28 Mar 2016 11:05:01 +0530
Message-ID: <20160328053501.GH32495@vireshk-i7>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <1586499.XsEFRqGpvD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1586499.XsEFRqGpvD@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 22-03-16, 02:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move definitions of symbols related to transition latency and
> sampling rate to include/linux/cpufreq.h so they can be used by
> (future) goverernors located outside of drivers/cpufreq/.

s/goverernors/governors

> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This patch was new in v4, no changes since then.
> 
> ---
>  drivers/cpufreq/cpufreq_governor.h |   14 --------------
>  include/linux/cpufreq.h            |   14 ++++++++++++++
>  2 files changed, 14 insertions(+), 14 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
