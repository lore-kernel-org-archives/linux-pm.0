From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] cpufreq: schedutil: Avoid missing updates for one-CPU
 policies
Date: Wed, 23 May 2018 17:56:27 -0700
Message-ID: <20180524005627.GB171060@joelaf.mtv.corp.google.com>
References: <1672734.JYOlA1IWnU@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1672734.JYOlA1IWnU@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>, claudio@evidence.eu.com, Todd Kjos <tkjos@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, May 23, 2018 at 11:47:45AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 152db033d775 (schedutil: Allow cpufreq requests to be made
> even when kthread kicked) made changes to prevent utilization updates
> from being discarded during processing a previous request, but it
> left a small window in which that still can happen in the one-CPU
> policy case.  Namely, updates coming in after setting work_in_progress
> in sugov_update_commit() and clearing it in sugov_work() will still
> be dropped due to the work_in_progress check in sugov_update_single().
> 
> To close that window, rearrange the code so as to acquire the update
> lock around the deferred update branch in sugov_update_single()
> and drop the work_in_progress check from it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
 
