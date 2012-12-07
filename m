From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH v2 01/10] CPU hotplug: Provide APIs for "light"
	atomic readers to prevent CPU offline
Date: Fri, 7 Dec 2012 22:01:26 +0100
Message-ID: <20121207210126.GA18520@redhat.com>
References: <20121205184258.3750.31879.stgit@srivatsabhat.in.ibm.com> <50BF96DF.3000500@linux.vnet.ibm.com> <50BF979A.50304@linux.vnet.ibm.com> <50BF982D.7090704@linux.vnet.ibm.com> <50BF98F7.3030600@linux.vnet.ibm.com> <50BF999C.6030707@linux.vnet.ibm.com> <50BFAB17.3090603@linux.vnet.ibm.com> <20121206161850.GA6710@redhat.com> <50C0E88E.9050909@linux.vnet.ibm.com> <50C0EF49.8050700@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50C0EF49.8050700@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tj@kernel.org, tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/07, Srivatsa S. Bhat wrote:
>
> CPU 0                         CPU 1
> ------                        ------
>
> 1. Acquire lock A             Increment CPU1's
>                               atomic counter
>
>
>
> 2. Increment CPU0's            Try to acquire lock A
>    atomic counter
>
>
> Now consider what happens if a hotplug writer (cpu_down) begins,

Exactly. So the fake lockdep_map should be per-cpu as well.

lglock doesn't need this because lg_local_lock() is not recursive
and lockdep can catch the bug like this. So it can look as single
lock for lockdep.

IOW. If you use the global lockdep_map and want lockdep to notice
this deadlock you need rwlock_acquire_read(map, 0, 0, IP). But then
lockdep will complain if the task does "read lock" under "read lock".

Oleg.
