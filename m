From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: cpufreq/ondemand: unpinning an unpinned lock.
Date: Thu, 16 Jul 2015 02:13:42 +0200
Message-ID: <3682267.1lcDzeZuDs@vostro.rjw.lan>
References: <20150715220422.GA13789@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43154 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753905AbbGOXrF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 19:47:05 -0400
In-Reply-To: <20150715220422.GA13789@codemonkey.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Cc: Viresh as he's been working on governors recently.

On Wednesday, July 15, 2015 06:04:22 PM Dave Jones wrote:
> WARNING: CPU: 1 PID: 29529 at kernel/locking/lockdep.c:3497 lock_unpin_lock+0x109/0x110()
> unpinning an unpinned lock
> CPU: 1 PID: 29529 Comm: kworker/1:1 Not tainted 4.2.0-rc2-think+ #3
> Workqueue: events od_dbs_timer
>  0000000000000009 ffff880094d5baa8 ffffffffae7f5e6f 0000000000000007
>  ffff880094d5baf8 ffff880094d5bae8 ffffffffae07b91a 0000000000000118
>  00000000000000e0 ffff880507bd5c58 0000000000000092 0000000000000004
> Call Trace:
>  [<ffffffffae7f5e6f>] dump_stack+0x4f/0x7b
>  [<ffffffffae07b91a>] warn_slowpath_common+0x8a/0xc0
>  [<ffffffffae07b996>] warn_slowpath_fmt+0x46/0x50
>  [<ffffffffae0d0ec9>] lock_unpin_lock+0x109/0x110
>  [<ffffffffae7f93cc>] __schedule+0x3ac/0xb60
>  [<ffffffffae7f9c41>] schedule+0x41/0x90
>  [<ffffffffae7f9ff8>] schedule_preempt_disabled+0x18/0x30
>  [<ffffffffae7fbcef>] mutex_lock_nested+0x16f/0x3e0
>  [<ffffffffae69207f>] ? gov_queue_work+0x2f/0xf0
>  [<ffffffffae690ec7>] ? od_check_cpu+0x57/0xd0
>  [<ffffffffae69207f>] ? gov_queue_work+0x2f/0xf0
>  [<ffffffffae69207f>] gov_queue_work+0x2f/0xf0
>  [<ffffffffae6918dd>] od_dbs_timer+0xbd/0x150
>  [<ffffffffae099613>] process_one_work+0x1f3/0x7a0
>  [<ffffffffae099582>] ? process_one_work+0x162/0x7a0
>  [<ffffffffae099cb9>] ? worker_thread+0xf9/0x470
>  [<ffffffffae099c29>] worker_thread+0x69/0x470
>  [<ffffffffae0ad993>] ? preempt_count_sub+0xa3/0xf0
>  [<ffffffffae099bc0>] ? process_one_work+0x7a0/0x7a0
>  [<ffffffffae09fddf>] kthread+0x11f/0x140
>  [<ffffffffae09fcc0>] ? kthread_create_on_node+0x250/0x250
>  [<ffffffffae80090f>] ret_from_fork+0x3f/0x70
>  [<ffffffffae09fcc0>] ? kthread_create_on_node+0x250/0x250
> ---[ end trace 86cca931caec9193 ]---

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
