From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: lockdep splat in CPU hotplug
Date: Wed, 22 Oct 2014 16:28:14 +0200
Message-ID: <5447BEFE.2040806@linaro.org>
References: <alpine.LNX.2.00.1410211255531.24255@pobox.suse.cz> <alpine.LNX.2.00.1410221125280.22681@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1410221125280.22681@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>, Dave Jones <davej@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Nicolas Pitre <nico@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/22/2014 11:53 AM, Jiri Kosina wrote:
> On Tue, 21 Oct 2014, Jiri Kosina wrote:
>
>> Hi,
>>
>> I am seeing the lockdep report below when resuming from suspend-to-d=
isk
>> with current Linus' tree (c2661b80609).
>>
>> The reason for CCing Ingo and Peter is that I can't make any sense o=
f one
>> of the stacktraces lockdep is providing.
>>
>> Please have a look at the very first stacktrace in the dump, where l=
ockdep
>> is trying to explain where cpu_hotplug.lock#2 has been acquired. It =
seems
>> to imply that cpuidle_pause() is taking cpu_hotplug.lock, but that's=
 not
>> the case at all.
>>
>> What am I missing?
>
> Okay, reverting 442bf3aaf55a ("sched: Let the scheduler see CPU idle
> states") and followup 83a0a96a5f26 ("sched/fair: Leverage the idle st=
ate
> info when choosing the "idlest" cpu") which depends on it makes the s=
plat
> go away.

Are you able to reproduce it by offlining the cpu and onlining it again=
 ?

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
