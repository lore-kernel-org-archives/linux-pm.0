From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/5] cpuidle: idle: menu: Don't reflect when a state selection
 failed
Date: Fri, 24 Oct 2014 15:32:52 +0200
Message-ID: <544A5504.2090706@linaro.org>
References: <1413822343-1972-1-git-send-email-daniel.lezcano@linaro.org> <1413822343-1972-3-git-send-email-daniel.lezcano@linaro.org> <20141024132428.GJ12706@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141024132428.GJ12706@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 10/24/2014 03:24 PM, Peter Zijlstra wrote:
> On Mon, Oct 20, 2014 at 06:25:41PM +0200, Daniel Lezcano wrote:
>> -	if (index > 0)
>> -	if (index >=3D 0)
>
> That's not the same condition.

Yes and it is wrong. That is the result of the=20
CPUIDLE_DRIVER_STATE_START dance.

The ladder governor is avoiding to use the POLL state as it was running=
=20
on x86. But on, eg. ARM, we will never reflect the state 0 because=20
CPUIDLE_DRIVER_STATE_START is equal to zero for all non-x86 platform.

If I am not wrong the ladder select function will never choose the stat=
e=20
0 for x86, so it will never reflect the state 0 (after applying the=20
patch 1/5). For the other arch it will reflect the state 0 as it should=
=2E

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
