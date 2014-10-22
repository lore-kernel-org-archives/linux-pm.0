From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: lockdep splat in CPU hotplug
Date: Wed, 22 Oct 2014 16:45:01 +0200
Message-ID: <5447C2ED.5020707@linaro.org>
References: <alpine.LNX.2.00.1410211255531.24255@pobox.suse.cz> <alpine.LNX.2.00.1410221125280.22681@pobox.suse.cz> <5447BEFE.2040806@linaro.org> <alpine.LNX.2.00.1410221634550.22681@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:37577 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbaJVOpG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Oct 2014 10:45:06 -0400
Received: by mail-wg0-f50.google.com with SMTP id a1so3928730wgh.33
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2014 07:45:04 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1410221634550.22681@pobox.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>, Dave Jones <davej@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 10/22/2014 04:36 PM, Jiri Kosina wrote:
> On Wed, 22 Oct 2014, Daniel Lezcano wrote:
>
>>>> I am seeing the lockdep report below when resuming from suspend-to=
-disk
>>>> with current Linus' tree (c2661b80609).
>>>>
>>>> The reason for CCing Ingo and Peter is that I can't make any sense=
 of one
>>>> of the stacktraces lockdep is providing.
>>>>
>>>> Please have a look at the very first stacktrace in the dump, where=
 lockdep
>>>> is trying to explain where cpu_hotplug.lock#2 has been acquired. I=
t seems
>>>> to imply that cpuidle_pause() is taking cpu_hotplug.lock, but that=
's not
>>>> the case at all.
>>>>
>>>> What am I missing?
>>>
>>> Okay, reverting 442bf3aaf55a ("sched: Let the scheduler see CPU idl=
e
>>> states") and followup 83a0a96a5f26 ("sched/fair: Leverage the idle =
state
>>> info when choosing the "idlest" cpu") which depends on it makes the=
 splat
>>> go away.
>>
>> Are you able to reproduce it by offlining the cpu and onlining it ag=
ain ?
>
> No, that doesn't trigger it (please note that all the relevant stackt=
races
> from lockdep are going through hibernation).

Ok, thanks.


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

