From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [Resend][PATCH V2] cpufreq: intel_pstate: allow trace in
 passive mode
Date: Fri, 05 Jan 2018 13:06:46 -0800
Message-ID: <1515186406.26317.38.camel@linux.intel.com>
References: <1513384980-3428-1-git-send-email-dsmythies@telus.net>
         <1513639857.31113.12.camel@linux.intel.com>
         R5i6epWR47WleR5i7eE79h <001501d38661$f82af1b0$e880d510$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001501d38661$f82af1b0$e880d510$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2018-01-05 at 12:15 -0800, Doug Smythies wrote:
> > 

[...]

> On 2017.12.18 16:25 Rafael J. Wysocki wrote:
> > > > +     from = cpu->pstate.current_pstate;
> > > > +     time = ktime_get();
> > > > +     sample_taken = intel_pstate_sample(cpu, time);
> > > > +
> > > This is quite a bit of overhead for tracing.
> Yes, it is a bit of added code, but without tracing abilities I
> do not know how to investigate passive operation.
> 
> > 
> > > 
> > > Why not fold the above two
> > > statements in the next if () with conditional tracing?
> No, I specifically want to do a trace sample, even if the target
> is the same as last time. Why? Because we want to know the time
> between calls to the driver, i.e. the duration. That information
> is incredibly useful.

I am not saying you don't need trace. But you can do all processing
when just trace is enabled. Which can be done by
if (trace_pstate_sample_enabled())

The above function should return true when trace is enabled.

So in your v3,

in intel_cpufreq_trace() you can simply return if
trace_pstate_sample_enabled() is false, without
calling intel_pstate_sample().


Thanks,
Srinivas
