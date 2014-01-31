From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC PATCH 3/3] idle: store the idle state index in the struct
 rq
Date: Fri, 31 Jan 2014 08:42:18 -0800
Message-ID: <52EBD26A.4060309@linux.intel.com>
References: <1391090962-15032-1-git-send-email-daniel.lezcano@linaro.org> <1391090962-15032-4-git-send-email-daniel.lezcano@linaro.org> <20140130153150.GD5002@laptop.programming.kicks-ass.net> <52EA7D8A.6080604@linaro.org> <20140130163501.GG5002@laptop.programming.kicks-ass.net> <52EA8B07.6020206@linaro.org> <CAM4v1pPwmRUOtNeGh5sZmj+wAsC8RstofNA5Gx862SEECvW-Lg@mail.gmail.com> <20140131090230.GM5002@laptop.programming.kicks-ass.net> <52EB6F65.8050008@linux.vnet.ibm.com> <52EBBC23.8020603@linux.intel.com> <52EBC33A.6080101@linaro.org> <52EBC645.2040607@linux.intel.com> <52EBD0E1.3030508@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52EBD0E1.3030508@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>
Cc: Preeti Murthy <preeti.lkml@gmail.com>, nicolas.pitre@linaro.org, mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

>>
>> on x86 I don't care; we don't actually change these dynamically much[1].
>> But if you have 1 or 2 things in mind to use,
>> I would suggest copying those 2 integers instead as we go, rather than
>> the index.
>> Saves refcounting/locking etc etc nightmare as well on the other
>> subsystems' datastructures..
>> ... which you likely need to do to actually follow that index.
>
> Hmm, yeah. That's a fair argument. That is true, the races and locks/refcnt are something we have to worried about. But also we may want to prevent duplicating the data
> across the subsystems.

there is still one master set of data (cpuidle), just when cpuidle picks a hardware state
that (at that time) has a specific latency/break even, it stores a copy of the data in the rq.
That's not really duplication in the bad sense, there's still only one master copy of the data.
Just you take a snapshot of a value/pair of values at a point in time and effectively
cache it in the rq for lockless access (and to cope with the master changing later
that doesn't reflect the reality of this rq)

I'd say that's a fair tradeoff, esp given the locking/refcount angle
(the fewer outside locks the scheduler level code wants the better off we all are by a lot)
