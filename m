From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/2] cpufreq_stats: Adds sysfs file
 /sys/devices/system/cpu/cpufreq/current_in_state
Date: Fri, 15 May 2015 08:18:43 +0530
Message-ID: <20150515024843.GE6348@linux>
References: <1431648770-7404-1-git-send-email-kandoiruchi@google.com>
 <1431648770-7404-2-git-send-email-kandoiruchi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431648770-7404-2-git-send-email-kandoiruchi@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruchi Kandoi <kandoiruchi@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vladimir Davydov <vdavydov@parallels.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Davidlohr Bueso <dave@stgolabs.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

I am not replying for concept here, as sched maintainers are in a
better position for that, but a nit below..

On 14-05-15, 17:12, Ruchi Kandoi wrote:
> Adds the sysfs file for userspace to initialize the active current
> values for all the cores at each of the frequencies.
> 
> The format for storing the values is as follows:
> echo "CPU<cpu#>:<freq1>=<current in uA> <freq2>=<current>,CPU<cpu#>:
> ..." > /sys/devices/system/cpu/cpufreq/current_in_state

Why this file? And not
/sys/devices/system/cpu/cpuX/cpufreq/stats/current_in_state ? That way
you don't have to replicate the same information for all CPUs, as the
stats folder can be shared by multiple CPUs (which share their
clock/voltage rails)..

-- 
viresh
