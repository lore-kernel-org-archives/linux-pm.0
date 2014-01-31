From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC PATCH 3/3] idle: store the idle state index in the struct
 rq
Date: Fri, 31 Jan 2014 07:07:15 -0800
Message-ID: <52EBBC23.8020603@linux.intel.com>
References: <1391090962-15032-1-git-send-email-daniel.lezcano@linaro.org> <1391090962-15032-4-git-send-email-daniel.lezcano@linaro.org> <20140130153150.GD5002@laptop.programming.kicks-ass.net> <52EA7D8A.6080604@linaro.org> <20140130163501.GG5002@laptop.programming.kicks-ass.net> <52EA8B07.6020206@linaro.org> <CAM4v1pPwmRUOtNeGh5sZmj+wAsC8RstofNA5Gx862SEECvW-Lg@mail.gmail.com> <20140131090230.GM5002@laptop.programming.kicks-ass.net> <52EB6F65.8050008@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52EB6F65.8050008@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>
Cc: Preeti Murthy <preeti.lkml@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, nicolas.pitre@linaro.org, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

>>>
>>> Hence I think this patch would make sense only with additional information
>>> like exit_latency or target_residency is present for the scheduler. The idle
>>> state index alone will not be sufficient.
>>
>> Alternatively, can we enforce sanity on the cpuidle infrastructure to
>> make the index naturally ordered? If not, please explain why :-)
>
> The commit id 71abbbf856a0e70 says that there are SOCs which could have
> their target_residency and exit_latency values change at runtime. This
> commit thus removed the ordering of the idle states according to their
> target_residency/exit_latency. Adding Len and Arjan to the CC.

the ARM folks wanted a dynamic exit latency, so.... it makes much more sense
to me to store the thing you want to use (exit latency) than the number of the state.

more than that, you can order either by target residency OR by exit latency,
if you sort by one, there is no guarantee that you're also sorted by the other

(for example, you can on a hardware level make a "fast exit" state, and burn power for this faster exit,
which means your break even gets longer to recoup this extra power compared to the same state without
the fast exit)
