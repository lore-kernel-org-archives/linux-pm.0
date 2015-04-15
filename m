From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/3] cpuidle: Store the idle start time stamp
Date: Wed, 15 Apr 2015 14:29:06 +0200
Message-ID: <552E5992.2050404@linaro.org>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org> <20150415102057.GR5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150415102057.GR5029@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org
List-Id: linux-pm@vger.kernel.org

On 04/15/2015 12:20 PM, Peter Zijlstra wrote:
> On Wed, Apr 15, 2015 at 12:00:22PM +0200, Daniel Lezcano wrote:
>> +	target_state->idle_stamp =3D ktime_to_us(ktime_get());
>
> ktime_get_ns();
>

Hmm, sounds like I missed we are dealing with different units (us / ns)=
=20
in cpuidle / sched.

Would it make sense to store the time into a ktime structure instead an=
d=20
use the relevant function depending on the place we are inspecting the=20
value from ?




--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
