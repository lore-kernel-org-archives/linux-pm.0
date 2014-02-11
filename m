From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V4 2/3] tick/cpuidle: Initialize hrtimer mode of broadcast
Date: Tue, 11 Feb 2014 23:01:18 +0100
Message-ID: <52FA9DAE.1040603@linaro.org>
References: <20140207075618.17187.20149.stgit@preeti.in.ibm.com> <20140207080632.17187.80532.stgit@preeti.in.ibm.com> <52F9F896.4020402@linaro.org> <alpine.DEB.2.02.1402111654190.21991@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1402111654190.21991@ionos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, peterz@infradead.org, benh@kernel.crashing.org, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org, deepthi@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com, fweisbec@gmail.com, paulus@samba.org, srivatsa.bhat@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

On 02/11/2014 04:58 PM, Thomas Gleixner wrote:
> On Tue, 11 Feb 2014, Daniel Lezcano wrote:
>> On 02/07/2014 09:06 AM, Preeti U Murthy wrote:
>> Setting the smp affinity on the earliest timer should be handled aut=
omatically
>> with the CLOCK_EVT_FEAT_DYNIRQ flag. Did you look at using this flag=
 ?
>
> How should this flag help? Not at all, because the hrtimer based
> broadcast device cannot assign affinities.
>
>> Another comment is the overall approach. We enter the cpuidle idle f=
ramework
>> with a specific state to go to and it is the tick framework telling =
us we
>> mustn't go to this state. IMO the logic is wrong, the decision to no=
t enter
>> this state should be moved somewhere else.
>>
>> Why don't you create a cpuidle driver with the shallow idle states a=
ssigned to
>> a cpu (let's say cpu0) and another one with all the deeper idle stat=
es for the
>> rest of the cpus ? Using the multiple cpuidle driver support makes i=
t
>> possible. The timer won't be moving around and a cpu will be dedicat=
ed to act
>> as the broadcast timer.
>>
>> Wouldn't make sense and be less intrusive than the patchset you prop=
osed ?
>
> How do you arm the broadcast timer on CPU0 from CPU1? You can't!
>
> You cannot access the cpu local timer on a different cpu. So you woul=
d
> have to send an IPI over to CPU0 so that it can reevaluate and
> schedule the broadcast. That's even more backwards than telling the
> cpuidle code that the CPU is not in a state to go deep.

Indeed :)

Thanks for the clarification.

   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
