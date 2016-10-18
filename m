From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCHv2] cpufreq: fix overflow in cpufreq_table_find_index_dl()
Date: Tue, 18 Oct 2016 12:07:18 +0530
Message-ID: <20161018063718.GN2991@vireshk-i7>
References: <20161017151456.3573-1-sergey.senozhatsky@gmail.com>
 <20161017154112.1111-1-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34398 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbcJRGhX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2016 02:37:23 -0400
Received: by mail-pf0-f171.google.com with SMTP id r16so65455131pfg.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2016 23:37:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161017154112.1111-1-sergey.senozhatsky@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

On 18-10-16, 00:41, Sergey Senozhatsky wrote:
> 'best' is always less or equals to 'pos', so `best - pos' returns
> a negative value which is then getting casted to `unsigned int'
> and passed to __cpufreq_driver_target()->acpi_cpufreq_target()
> for policy->freq_table selection. This results in
> 
>  BUG: unable to handle kernel paging request at ffff881019b469f8
>  IP: [<ffffffffa00356c1>] acpi_cpufreq_target+0x4f/0x190 [acpi_cpufreq]
>  PGD 267f067
>  PUD 0
> 
>  Oops: 0000 [#1] PREEMPT SMP
>  CPU: 6 PID: 70 Comm: kworker/6:1 Not tainted 4.9.0-rc1-next-20161017-dbg-dirty
>  Workqueue: events dbs_work_handler
>  task: ffff88041b808000 task.stack: ffff88041b810000
>  RIP: 0010:[<ffffffffa00356c1>]  [<ffffffffa00356c1>] acpi_cpufreq_target+0x4f/0x190 [acpi_cpufreq]
>  RSP: 0018:ffff88041b813c60  EFLAGS: 00010282
>  RAX: ffff880419b46a00 RBX: ffff88041b848400 RCX: ffff880419b20f80
>  RDX: 00000000001dff38 RSI: 00000000ffffffff RDI: ffff88041b848400
>  RBP: ffff88041b813cb0 R08: 0000000000000006 R09: 0000000000000040
>  R10: ffffffff8207f9e0 R11: ffffffff8173595b R12: 0000000000000000
>  R13: ffff88041f1dff38 R14: 0000000000262900 R15: 0000000bfffffff4
>  FS:  0000000000000000(0000) GS:ffff88041f000000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ffff881019b469f8 CR3: 000000041a2d3000 CR4: 00000000001406e0
>  Stack:
>   ffff88041b813cb0 ffffffff813347f9 ffff88041b813ca0 ffffffff81334663
>   ffff88041f1d4bc0 ffff88041b848400 0000000000000000 0000000000000000
>   0000000000262900 0000000000000000 ffff88041b813d00 ffffffff813355dc
>  Call Trace:
>   [<ffffffff813347f9>] ? cpufreq_freq_transition_begin+0xf1/0xfc
>   [<ffffffff81334663>] ? get_cpu_idle_time+0x97/0xa6
>   [<ffffffff813355dc>] __cpufreq_driver_target+0x3b6/0x44e
>   [<ffffffff81336ca3>] cs_dbs_timer+0x11a/0x135
>   [<ffffffff81336fda>] dbs_work_handler+0x39/0x62
>   [<ffffffff81057823>] process_one_work+0x280/0x4a5
>   [<ffffffff81058719>] worker_thread+0x24f/0x397
>   [<ffffffff810584ca>] ? rescuer_thread+0x30b/0x30b
>   [<ffffffff81418380>] ? nl80211_get_key+0x29/0x36a
>   [<ffffffff8105d2b7>] kthread+0xfc/0x104
>   [<ffffffff8107ceea>] ? put_lock_stats.isra.9+0xe/0x20
>   [<ffffffff8105d1bb>] ? kthread_create_on_node+0x3f/0x3f
>   [<ffffffff814b2092>] ret_from_fork+0x22/0x30
>  Code: 56 4d 6b ff 0c 41 55 41 54 53 48 83 ec 28 48 8b 15 ad 1e 00 00 44 8b 41
>  08 48 8b 87 c8 00 00 00 49 89 d5 4e 03 2c c5 80 b2 78 81 <46> 8b 74 38 04 45
>  3b 75 00 75 11 31 c0 83 39 00 0f 84 1c 01 00
>  RIP  [<ffffffffa00356c1>] acpi_cpufreq_target+0x4f/0x190 [acpi_cpufreq]
>   RSP <ffff88041b813c60>
>  CR2: ffff881019b469f8
>  ---[ end trace 16d9fc7a17897d37 ]---
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  include/linux/cpufreq.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 5fa55fc..32dc0cbd 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -677,10 +677,10 @@ static inline int cpufreq_table_find_index_dl(struct cpufreq_policy *policy,
>  		if (best == table - 1)
>  			return pos - table;
>  
> -		return best - pos;
> +		return best - table;
>  	}
>  
> -	return best - pos;
> +	return best - table;
>  }
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
