From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: stats: Make the stats code non-modular
Date: Tue, 31 May 2016 16:14:34 +0530
Message-ID: <20160531104434.GE9463@vireshk-i7>
References: <1482863.aVJEuqdboc@vostro.rjw.lan>
 <20160526045945.GO17585@vireshk-i7>
 <5665576.VhylybbIm6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5665576.VhylybbIm6@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On 28-05-16, 15:15, Rafael J. Wysocki wrote:
> -static int __init cpufreq_stats_init(void)
> -{
> -	int ret;
> -	unsigned int cpu;
> -
> -	spin_lock_init(&cpufreq_stats_lock);

My bad for ignoring this, but the spin lock is left uninitialized now
and this is what I get:

[    3.335732] BUG: spinlock bad magic on CPU#0, kworker/0:0/4
[    3.339847]  lock: cpufreq_stats_lock+0x0/0x10, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[    3.348789] CPU: 0 PID: 4 Comm: kworker/0:0 Tainted: G        W       4.7.0-rc1-00046-g6ce5bc9b2166-dirty #148
[    3.358754] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    3.364831] Workqueue: events dbs_work_handler
[    3.369259] [<c010e1ac>] (unwind_backtrace) from [<c010af38>] (show_stack+0x10/0x14)
[    3.376987] [<c010af38>] (show_stack) from [<c03248dc>] (dump_stack+0x88/0x9c)
[    3.384191] [<c03248dc>] (dump_stack) from [<c0159b6c>] (do_raw_spin_lock+0x1ac/0x1b0)
[    3.392089] [<c0159b6c>] (do_raw_spin_lock) from [<c0510b40>] (cpufreq_stats_update+0x24/0x60)
[    3.400682] [<c0510b40>] (cpufreq_stats_update) from [<c0511030>] (cpufreq_stats_record_transition+0x6c/0x9c)
[    3.410581] [<c0511030>] (cpufreq_stats_record_transition) from [<c050d4dc>] (cpufreq_notify_transition+0x94/0x13c)
[    3.420995] [<c050d4dc>] (cpufreq_notify_transition) from [<c050d6b8>] (cpufreq_freq_transition_end+0x24/0x90)
[    3.430975] [<c050d6b8>] (cpufreq_freq_transition_end) from [<c050e954>] (__cpufreq_driver_target+0x124/0x264)
[    3.440957] [<c050e954>] (__cpufreq_driver_target) from [<c051159c>] (od_dbs_timer+0x9c/0x168)
[    3.449550] [<c051159c>] (od_dbs_timer) from [<c0512060>] (dbs_work_handler+0x2c/0x60)
[    3.457449] [<c0512060>] (dbs_work_handler) from [<c0130f68>] (process_one_work+0x124/0x338)
[    3.465867] [<c0130f68>] (process_one_work) from [<c01311b4>] (worker_thread+0x38/0x4d4)
[    3.473943] [<c01311b4>] (worker_thread) from [<c0136490>] (kthread+0xdc/0xf4)
[    3.481145] [<c0136490>] (kthread) from [<c0107978>] (ret_from_fork+0x14/0x3c)

-- 
viresh
