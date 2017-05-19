From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] cpufreq: Make iowait boost a policy option
Date: Fri, 19 May 2017 11:42:45 +0200
Message-ID: <20170519094245.ztm6tt2iwkaiwsya@hirez.programming.kicks-ass.net>
References: <20170519062344.27692-1-joelaf@google.com>
 <20170519062344.27692-2-joelaf@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170519062344.27692-2-joelaf@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelaf@google.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 18, 2017 at 11:23:43PM -0700, Joel Fernandes wrote:
> Make iowait boost a cpufreq policy option and enable it for intel_pstate
> cpufreq driver. Governors like schedutil can use it to determine if
> boosting for tasks that wake up with p->in_iowait set is needed.

Rather than just flat out disabling the option, is there something
better we can do on ARM?

The reason for the IO-wait boost is to ensure we feed our external
devices data ASAP, this reduces wait times, increases throughput and
decreases the duration the devices have to operate.

I realize max freq/volt might not be the best option for you, but is
there another spot that would make sense? I can imagine you want to
return your MMC to low power state ASAP as well.


So rather than a disable flag, I would really rather see an IO-wait OPP
state selector or something.
