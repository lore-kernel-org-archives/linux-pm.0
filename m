From: Radivoje Jovanovic <radivoje.jovanovic@linux.intel.com>
Subject: Re: [PATCH] thermal/cpu_cooling: remove local cooling state
 variable
Date: Fri, 31 Jul 2015 08:30:03 -0700
Message-ID: <20150731083003.2f47ca5f@radivoje-desk2>
References: <1437516835-198750-1-git-send-email-radivoje.jovanovic@linux.intel.com>
	<9hhegjxbmqz.fsf@e105922-lin.cambridge.arm.com>
	<20150724100905.7e2e53f4@radivoje-desk2>
	<9hhoaiuap3m.fsf@e105922-lin.cambridge.arm.com>
	<20150730080541.GD31351@linux>
	<20150730132130.3c957267@radivoje-desk2>
	<20150731031841.GH17794@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150731031841.GH17794@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Punit Agrawal <punit.agrawal@arm.com>, rjw@rjwysocki.net, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Radivoje Jovanovic <radivoje.jovanovic@intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 31 Jul 2015 08:48:41 +0530
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Thanks.
> 
> I will try to add more layman terms here to map cooling state with
> frequencies. So, the cooling state 0 maps to the highest frequency the
> cpufreq table supports, and the highest cooling state n maps to the
> lowest frequency. Right ?
> 
> On 30-07-15, 13:21, Radivoje Jovanovic wrote:
> > In this case both userspace thermal solution and cpu_cooling are
> > changing policy->max and the userspace solution will let governor
> > or HW (depends on architecture) decide the clipped-freq. Now let us
> > say that cpu_cooling has 4 available states 0-3
> 
> Lets say: 0 == 1.2 GHz
>           1 == 1.1 GHz
>           2 == 1 GHz
>           3 == 800 MHz
> 
> > and let us say that cpu_cooling
> > has set the state 1 as the last state.
> 
> i.e. cpu_cooling says "don't go over 1.1 GHz"..
> 
> > Now userspace component comes in
> > and changes the state of the system that matches cpu_cooling state
> > 0.
> 
> So, policy->max reaches 1.2 GHz and that is not in sync with
> cpu_cooling. Right ?
> 
> > cpu_cooling is unaware of this change and does not change the local
> > cur_state.
> 
> That's where I think you one of us might be incorrect. At this point
> when policy->max is changed to 1.2 GHz, a notifier will get issued to
> cpu_cooling, which will bring policy->max again to 1.1 GHz and so
> things will be back in control.
I just looked over the notifier in the current upstream (my patch was
made on our production kernel which is 3.14 and has old notifier
implementation with notifier_device in place) and I see your point.
I agree with you that this patch is trivial for the current
implementation since the notifier, as it is currently, will enforce
cpu_cooling policy change at every CPUFREQ_ADJUST which would cause
problems in our current implementation. In our implementation there is
a cpufreq driver that will also change policies during CPUFREQ_ADJUST,
once the request comes from the underlying FW so there would be a fight
who gets there first since cpu_cooling will change the policy in
CPUFREQ_ADJUST notifier_chain and the driver would do the same thing.
It seems to me that better implementation of the cpu_cooling notifer
would be to keep the flag and change the policy in CPUFREQ_ADJUST only
when the change was requested by cpu_cooling, and update the current
state of cpufreq_cooling_device during CPUFREQ_NOTIFY event.
What do you think?

> 
> > Now the temperature changes and cpu_cooling should change
> > the system state to 1 (userspace component malfunctioned and is not
> > picking up this change) but since the cur_state is already at 1
> > cpu_cooling will not do anything since it believes it is in the
> > correct state. Hope this explains it better
> 
