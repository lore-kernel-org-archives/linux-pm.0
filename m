From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v2 1/2] cpufreq: Make iowait boost a policy option
Date: Fri, 19 May 2017 10:04:28 -0700
Message-ID: <CAJWu+opefgyzER6jKTa1ktrT4pGL=bKdhAP2+i40k5tYAR38wA@mail.gmail.com>
References: <20170519062344.27692-1-joelaf@google.com> <20170519062344.27692-2-joelaf@google.com>
 <20170519094245.ztm6tt2iwkaiwsya@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519094245.ztm6tt2iwkaiwsya@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi Peter,

On Fri, May 19, 2017 at 2:42 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, May 18, 2017 at 11:23:43PM -0700, Joel Fernandes wrote:
>> Make iowait boost a cpufreq policy option and enable it for intel_pstate
>> cpufreq driver. Governors like schedutil can use it to determine if
>> boosting for tasks that wake up with p->in_iowait set is needed.
>
> Rather than just flat out disabling the option, is there something
> better we can do on ARM?
>
> The reason for the IO-wait boost is to ensure we feed our external
> devices data ASAP, this reduces wait times, increases throughput and
> decreases the duration the devices have to operate.

Can you help understand how CPU frequency can affect I/O? The ASAP
makes me think of it as a latency thing than a throughput in which
case there should a scheduling priority increase? Also, to me it
sounds more like memory instead of CPU frequency should be boosted
instead so that DMA transfers happen quicker to feed devices data
faster.

Are you trying to boost the CPU frequency so that a process waiting on
I/O does its next set of processing quickly enough after iowaiting on
the previous I/O transaction, and is ready to feed I/O the next time
sooner?

The case I'm seeing a lot is a background thread does I/O request and
blocks for short period, and wakes up. All this while the CPU
frequency is low, but that wake up causes a spike in frequency. So
over a period of time, you see these spikes that don't really help
anything.

>
> I realize max freq/volt might not be the best option for you, but is
> there another spot that would make sense? I can imagine you want to
> return your MMC to low power state ASAP as well.
>
>
> So rather than a disable flag, I would really rather see an IO-wait OPP
> state selector or something.

We never had this in older kernels and I don't think we ever had an
issue where I/O was slow because of CPU frequency. If a task is busy a
lot, then its load tracking signal should be high and take care of
keeping CPU frequency high right? If PELT is decaying the load
tracking of iowaiting tasks too much, then I think that it should be
fixed there (probably decay an iowaiting task lesser?). Considering
that it makes power worse on newer kernels, it'd probably be best to
disable it in my opinion for those who don't need it.

thanks,

-Joel
