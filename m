From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 3/3] intel_pstate: Declare pid_params/pstate_funcs/hwp_active __read_mostly
Date: Tue, 28 Jun 2016 13:43:05 +0200
Message-ID: <27685849.lNYHADO2Ux@vostro.rjw.lan>
References: <1467022038-924-1-git-send-email-jszhang@marvell.com> <1467048594.8970.81.camel@linux.intel.com> <20160628102927.4d74fb2c@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42741 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752336AbcF1Lij (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2016 07:38:39 -0400
In-Reply-To: <20160628102927.4d74fb2c@xhacker>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, June 28, 2016 10:29:27 AM Jisheng Zhang wrote:
> Dear Rafael,
> 
> On Mon, 27 Jun 2016 10:29:54 -0700
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> > On Mon, 2016-06-27 at 18:07 +0800, Jisheng Zhang wrote:
> > > pid_params is written once by copy_pid_params() during
> > > initialization,
> > > and thereafter is mostly read by hot path intel_pstate_update_util().
> > > The read of pid_params gets more after commit a4675fbc4a7a ("cpufreq:
> > > intel_pstate: Replace timers with utilization update callbacks")
> > > 
> > > pstate_funcs is written once by copy_cpu_funcs() during
> > > initialization,
> > > and thereafter is mostly read by hot path intel_pstate_update_util()
> > > 
> > > hwp_active is written to once during initialization and thereafter is
> > > mostly read by hot path intel_pstate_update_util().
> > > 
> > > The fact that they are mostly read and not written to makes them
> > > candidates for __read_mostly declarations.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>  
> > Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> oops, I missed Viresh's Ack in this patch, so can you please add the missing
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

I've added it already.

Thanks,
Rafael

