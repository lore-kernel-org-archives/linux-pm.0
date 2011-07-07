From: asinghal@codeaurora.org
Subject: Re: [RFC] Unprepare callback for cpuidle_device
Date: Thu, 7 Jul 2011 12:52:59 -0700 (PDT)
Message-ID: <82b596dce7b84db206d3afb6da564fb9.squirrel@www.codeaurora.org>
References: <a619d8bbefd2f390a13d09084583dd39.squirrel@www.codeaurora.org>
	<4E15516E.5040209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4E15516E.5040209@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Trinabh Gupta <g.trinabh@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, asinghal@codeaurora.org, johlstei@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Hello Trinabh,
              i cannot use the enter callback due to the following reason:

the residency calculation(tick)nohz_get_sleep_length) and the idle state
selection happens in the menu governor. The enter callback is called with
the selected state.

So cancelling the hrtimer that would affect the residency value calculated
in the menu governor, in the enter callback is not possible. The timer
needs to be cancelled before the select call is made.

thanks,
amar



> On 07/06/2011 04:23 PM, asinghal@codeaurora.org wrote:
>> We plan to use high resolution timers in one of our modules, with the
>> requirement that we cancel these timers when the cpu goes idle and
>> restart
>> them when the cpu comes out of idle.
>>
>> We are cancelling the timers in cpuidle prepare callback. The problem is
>> that if the need_resched() call in drivers/cpuidle/cpuidle.c returns
>> true,
>> how do we restart the timer? If the call returns false, we can restart
>> the
>> timer in the cpuidle enter callback.
>
> Hi Amar,
>
> I think you should not use cpuidle prepare callback at all. It may be
> removed soon (see https://lkml.org/lkml/2011/6/6/261) and I think
> there are better ways to achieve what you are trying to do.
>
> I think everything should go into the enter routines (the idle routines
> provided by the driver). That way you would not have to worry about
> need_resched() in cpuidle.c. Also it would be a cleaner implementation
> as you wouldn't touch generic cpuidle code.
>
>>
>> The solution to the problem that we have in mind is adding an unprepare
>> callback to the cpuidle_device struct, and calling it if needs_resched()
>> returns true. Another option is to implement deferred timers for
>> hrtimers.
>> Which of the two options is the better solution, or is there another
>> feasible alternative?
>
> As i said, everything should go inside enter routine and
> you wouldn't have to use/implement prepare/unprepare callbacks.
>
> Thanks
> -Trinabh
>
