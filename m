From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 0/2] Adds cpu power accounting per-pid basis.
Date: Fri, 15 May 2015 08:34:18 +0200
Message-ID: <5555936A.7040304@gmx.de>
References: <1431648770-7404-1-git-send-email-kandoiruchi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:50314 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724AbbEOGfV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 15 May 2015 02:35:21 -0400
In-Reply-To: <1431648770-7404-1-git-send-email-kandoiruchi@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ruchi Kandoi <kandoiruchi@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vladimir Davydov <vdavydov@parallels.com>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Davidlohr Bueso <dave@stgolabs.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 15.05.2015 02:12, Ruchi Kandoi wrote:
> These patches add a mechanism which will accurately caculate the CPU power
> used by all the processes in the system. In order to account for the power
> used by all the processes a data field "cpu_power" has been added in the
> task_struct.

Hello Ruchi,

could you, please, explain why the CPU power consumption per task
information is needed. Please, consider that the CPU causes only part of
the total system power consumption which also comprises GPU, cooling,
RAM, etc.

The patch series increases the memory size of the kernel, the memory
consumption per thread and the thread switching time. So, please,
introduce a configuration switch to enable/disable the function.

> This field adds power for both the system as well as user
> time. cpu_power contains the total amount of charge(in uAmsec units) used
> by the process.

Is there any reasonable way to assign the power consumption to a single
task if multiple tasks are executed on the same core at the same time
(e.g. using hyperthreading)?

> This model takes into account the frequency at which the
> process was running(i.e higher power for processes running at higher
> frequencies). It requires the cpufreq_stats module to be initialized with
> the current numbers for each of the CPU core at each frequency. This will
> be initialized during init time.

This does not account for power consumption depending on anything else
but frequency, e.g. floating point commands consuming more power than NOPs.

Best regards

Heinrich Schuchardt
> 
> Ruchi Kandoi (2):
>   cpufreq_stats: Adds sysfs file    
>     /sys/devices/system/cpu/cpufreq/current_in_state
>   sched: cpufreq: Adds a field cpu_power in the task_struct
> 
>  drivers/cpufreq/cpufreq_stats.c | 191 +++++++++++++++++++++++++++++++++++++++-
>  include/linux/cpufreq.h         |   8 ++
>  include/linux/sched.h           |   2 +
>  kernel/fork.c                   |   1 +
>  kernel/sched/cputime.c          |   7 ++
>  5 files changed, 207 insertions(+), 2 deletions(-)
> 

