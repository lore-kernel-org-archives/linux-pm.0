From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v1 5/5] cpufreq: intel_pstate: try load instead of busy_scaled
Date: Mon, 23 Nov 2015 17:33:55 -0800
Message-ID: <001d01d12658$2f9e5c20$8edb1460$@net>
References: <1448284006-13596-1-git-send-email-philippe.longepe@linux.intel.com> <1448284006-13596-11-git-send-email-philippe.longepe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta14.telus.net ([209.171.16.87]:49874 "EHLO cmta14.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752211AbbKXBd6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Nov 2015 20:33:58 -0500
In-Reply-To: <1448284006-13596-11-git-send-email-philippe.longepe@linux.intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Philippe Longepe' <philippe.longepe@linux.intel.com>
Cc: srinivas.pandruvada@linux.intel.com, 'Philippe Longepe' <philippe.longepe@intel.com>, 'Stephane Gasparini' <stephane.gasparini@intel.com>, linux-pm@vger.kernel.org

On 2015.11.23 05:07 Philippe Longepe wrote:

> The time spent in iowait is converted into cycles at max freq,
> so it increases the load during IOs.
...
> +	cummulative_iowait = get_cpu_iowait_time_us(cpu->cpu, &now);
...

Did you consider to use get_cpu_idle_time_us(cpu_num, NULL) instead?
Why? Because it doesn't include iowait time, and thus just subtract
it from the kernel time to get the load, including iowait.

Crudely, below is what I have been trying for a month now (which also
makes the is mpref / tsc allowed or not discussion moot, because it
isn't used). Note, it can include iowait or not, you can observe by the
commented out lines (I have been testing both methods):

@@ -726,21 +737,32 @@ static inline void intel_pstate_sample(struct cpudata *cpu)
 
 	tsc = rdtsc();
 	local_irq_restore(flags);
+	time = ktime_get();
+	idle_us = get_cpu_idle_time_us(cpu_num, NULL);
+//	io_wait_us = get_cpu_iowait_time_us(cpu_num, NULL);
+	if (idle_us == -1ULL) {
+		/* !NO_HZ so we can rely on cpustat.idle */
+		idle = kcpustat_cpu(cpu_num).cpustat[CPUTIME_IDLE];
+//		io_wait = kcpustat_cpu(cpu_num).cpustat[CPUTIME_IOWAIT];
+		idle_us = cputime_to_usecs(idle);
+//		io_wait_us = cputime_to_usecs(io_wait);
+	}
...
+	cpu->sample.duration_us = ktime_us_delta(time, cpu->prev_time);
+	cpu->sample.idle_us = idle_us - cpu->prev_idle_us;
+//	cpu->sample.io_wait_us = io_wait_us - cpu->prev_io_wait_us;

And then the load calculation becomes (I use units of tenths of a percent in my stuff):

-	core_pct = int_tofp(sample->mperf) * int_tofp(1000);
-	core_pct = div64_u64(core_pct, int_tofp(sample->tsc));
+//	core_pct = sample->duration_us - sample->idle_us - sample->io_wait_us;
+	core_pct = sample->duration_us - sample->idle_us;
+	if (core_pct < 0) core_pct = 0;
+	core_pct = int_tofp(core_pct) * int_tofp(1000);
+	core_pct = div64_u64(core_pct, int_tofp(sample->duration_us));

In the above notice the special NO_HZ case. I don't this area well,
but I was of the understanding that the NO_HZ case requires special code.
(see also: fs/proc/stat.c, which is where I stole this stuff.) Note
that I haven't actually tested NO_HZ mode yet.

... Doug


