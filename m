From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 06/31] drivers/cpuidle: Replace __get_cpu_var uses for
 address calculation
Date: Fri, 18 Jul 2014 19:28:35 -0400
Message-ID: <20140718232835.GM5739@htj.dyndns.org>
References: <20140620193115.547427118@linux.com>
 <20140620193125.567452655@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140620193125.567452655@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <cl@linux.com>
Cc: akpm@linuxfoundation.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 20, 2014 at 02:31:21PM -0500, Christoph Lameter wrote:
> All of these are for address calculation. Replace with
> this_cpu_ptr().
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> [cpufreq changes]
> Signed-off-by: Christoph Lameter <cl@linux.com>

Applied to wq/for-3.17-consistent-ops.  If this patch should be routed
differently, please holler.

Thanks.

-- 
tejun
