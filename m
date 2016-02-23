From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V3 2/2] sched: idle: IRQ based next prediction for idle
 period
Date: Tue, 23 Feb 2016 11:13:11 +0100
Message-ID: <56CC30B7.8090304@linaro.org>
References: <1455637383-14412-1-git-send-email-daniel.lezcano@linaro.org>
 <1455637383-14412-2-git-send-email-daniel.lezcano@linaro.org>
 <56CC2F38.5070507@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56CC2F38.5070507@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.pitre@linaro.org, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

On 02/23/2016 11:06 AM, Shreyas B Prabhu wrote:
>
>
> On 02/16/2016 09:13 PM, Daniel Lezcano wrote:
> [...]
>> +	if (index < 0) {
>> +		/*
>> +		 * No idle callbacks fulfilled the constraints, jump
>> +		 * to the default function like there wasn't any
>> +		 * cpuidle driver.
>> +		 */
>> +		goto default_idle;
>> +	} else {
>> +		/*
>> +		 * Enter the idle state previously returned by the
>> +		 * governor decision.  This function will block until
>> +		 * an interrupt occurs and will take care of
>> +		 * re-enabling the local interrupts
>> +		 */
>> +		return cpuidle_enter(drv, dev, index);
>
> Minor point. You are not calling rcu_idle_exit() in else block. This
> should probably be
> 		ret =3D cpuidle_enter(drv, dev, index);
>                  goto out;

Yes. Right.

Thanks for the review.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
