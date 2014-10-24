From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/5] cpuidle: idle: menu: Don't reflect when a state selection
 failed
Date: Fri, 24 Oct 2014 15:43:53 +0200
Message-ID: <544A5799.7020405@linaro.org>
References: <1413822343-1972-1-git-send-email-daniel.lezcano@linaro.org> <1413822343-1972-3-git-send-email-daniel.lezcano@linaro.org> <20141024133810.GK12706@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141024133810.GK12706@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 10/24/2014 03:38 PM, Peter Zijlstra wrote:
> On Mon, Oct 20, 2014 at 06:25:41PM +0200, Daniel Lezcano wrote:
>> +++ b/kernel/sched/idle.c
>> @@ -162,7 +162,8 @@ use_default:
>>   	/*
>>   	 * Give the governor an opportunity to reflect on the outcome
>>   	 */
>> -	cpuidle_reflect(dev, entered_state);
>> +	if (entered_state >=3D 0)
>> +		cpuidle_reflect(dev, entered_state);
>>
>
> Given we'll do use_default: when next_state < 0, we actually never ge=
t
> here unless this is true.

There is the 'cpuidle_enter' call in between which may fail.



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
