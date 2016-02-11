From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] cpufreq: Replace timers with utilization update
 callbacks
Date: Thu, 11 Feb 2016 18:38:37 +0100
Message-ID: <20160211173837.GQ6357@twins.programming.kicks-ass.net>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <56B93548.9090006@linaro.org>
 <CAJZ5v0gJwLVezLTLwGX=GDrsGeH6X040JmOaW6_uX2XzQwO9mg@mail.gmail.com>
 <5387313.xAhVpzgZCg@vostro.rjw.lan>
 <56BA8C29.4090905@linaro.org>
 <20160211115959.GI6357@twins.programming.kicks-ass.net>
 <56BCBF7C.2080404@linaro.org>
 <20160211173033.GP6357@twins.programming.kicks-ass.net>
 <CAJZ5v0hKjgmnTtxD5nHZfixFCPVoFhG6H_VnUJUkhaJ4wJef-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hKjgmnTtxD5nHZfixFCPVoFhG6H_VnUJUkhaJ4wJef-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 11, 2016 at 06:34:05PM +0100, Rafael J. Wysocki wrote:
> I've updated the patch in the meantime
> (https://patchwork.kernel.org/patch/8283431/).
> 
> Should I move the RT/DL hooks to task_tick_rt/dl(), respectively?

Probably, this really is about kicking cpufreq to do something, right?
update_curr_*() seems overkill for that.
