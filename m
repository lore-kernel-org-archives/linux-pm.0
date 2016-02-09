From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Mon, 8 Feb 2016 16:39:36 -0800
Message-ID: <56B93548.9090006@linaro.org>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <18671470.kF8gVcBlTg@vostro.rjw.lan> <6398636.DlBgLvxltE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6398636.DlBgLvxltE@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 02/08/2016 03:06 PM, Rafael J. Wysocki wrote:
> Now that all review comments have been addressed in patch [3/3], I'm going to
> put this series into linux-next.
> 
> There already is 20+ patches on top of it in the queue including fixes for
> bugs that have haunted us for quite some time (and that functionally depend on
> this set) and I'd really like all that to get enough linux-next coverage, so
> there really isn't more time to wait.

Sorry for the late reply. As Juri mentioned I was OOO last week and
really just got to look at this today.

One concern I had was, given that the lone scheduler update hook is in
CFS, is it possible for governor updates to be stalled due to RT or DL
task activity?

thanks,
Steve
