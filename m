From: Ruchi Kandoi <kandoiruchi@google.com>
Subject: Re: [PATCH v2 1/2] cpufreq_stats: Adds sysfs file /sys/devices/system/cpu/cpufreq/current_in_state
Date: Fri, 15 May 2015 17:55:13 -0700
Message-ID: <CAL8qYTO3uurrxQBjfPDNL2hamxh4+GCuzX0mxsEw=+go5CPWcQ@mail.gmail.com>
References: <1431648770-7404-1-git-send-email-kandoiruchi@google.com>
	<1431648770-7404-2-git-send-email-kandoiruchi@google.com>
	<20150515024843.GE6348@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150515024843.GE6348@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vladimir Davydov <vdavydov@parallels.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Kees Cook <keescook@chromium.org>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Davidlohr Bueso <dave@stgolabs.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, May 14, 2015 at 7:48 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> I am not replying for concept here, as sched maintainers are in a
> better position for that, but a nit below..
>
> On 14-05-15, 17:12, Ruchi Kandoi wrote:
>> Adds the sysfs file for userspace to initialize the active current
>> values for all the cores at each of the frequencies.
>>
>> The format for storing the values is as follows:
>> echo "CPU<cpu#>:<freq1>=<current in uA> <freq2>=<current>,CPU<cpu#>:
>> ..." > /sys/devices/system/cpu/cpufreq/current_in_state
>
> Why this file? And not
> /sys/devices/system/cpu/cpuX/cpufreq/stats/current_in_state ? That way
> you don't have to replicate the same information for all CPUs, as the
> stats folder can be shared by multiple CPUs (which share their
> clock/voltage rails)..

Some of the hand-held devices support hot-plugging of the cpus and
when the core is hot-plugged out the
/sys/devices/system/cpu/cpuX/cpufreq directory is removed too. So it
won't be possible to share folders by multiple CPUs.

>
> --
> viresh
