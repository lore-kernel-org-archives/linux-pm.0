From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/3] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
Date: Wed, 6 Mar 2019 16:31:40 +0530
Message-ID: <20190306110140.weyktajj7ty7vuxn@vireshk-i7>
References: <1755407.S0oJirvq9V@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1755407.S0oJirvq9V@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 05-03-19, 11:23, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is a follow-up to the RFT patch set posted previously:
> https://lore.kernel.org/lkml/9956076.F4luUDm1Dq@aspire.rjw.lan/
> 
> Patch [1/3] causes intel_pstate to update all policies if it gets a _PPC change
> notification and sees a global turbo disable/enable change.
> 
> Patch [2/3] adds cpufreq_cpu_acquire() and cpufreq_cpu_release() to reduce
> code duplication after the next patch a bit (and Srinivas wanted the rwsem
> manipulation to not be done directly by the driver).
> 
> Patch [3/3] makes intel_pstate update cpuinfo.max_freq for all policies in
> those cases.
> 
> I've atted Tested-by tags to patches [1/3] and [3/3], because there are only
> cosmetic differences between them and what has been tested.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
