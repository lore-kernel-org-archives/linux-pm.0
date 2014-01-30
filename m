From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH 1/3] cpuidle: split cpuidle_idle_call main function
 into functions
Date: Thu, 30 Jan 2014 16:39:58 +0100
Message-ID: <52EA724E.8080107@linaro.org>
References: <1391090962-15032-1-git-send-email-daniel.lezcano@linaro.org> <1391090962-15032-2-git-send-email-daniel.lezcano@linaro.org> <20140130152721.GC5002@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140130152721.GC5002@laptop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: nicolas.pitre@linaro.org, mingo@redhat.com, tglx@linutronix.de, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 01/30/2014 04:27 PM, Peter Zijlstra wrote:
> On Thu, Jan 30, 2014 at 03:09:20PM +0100, Daniel Lezcano wrote:
>> +EXPORT_SYMBOL(cpuidle_select);
>> +EXPORT_SYMBOL(cpuidle_enter);
>> +EXPORT_SYMBOL(cpuidle_reflect);
>
> $ grep EXPORT_SYMBOL drivers/cpuidle/cpuidle.c
> EXPORT_SYMBOL_GPL(cpuidle_pause_and_lock);
> EXPORT_SYMBOL_GPL(cpuidle_resume_and_unlock);
> EXPORT_SYMBOL_GPL(cpuidle_enable_device);
> EXPORT_SYMBOL_GPL(cpuidle_disable_device);
> EXPORT_SYMBOL_GPL(cpuidle_register_device);
> EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
> EXPORT_SYMBOL_GPL(cpuidle_unregister);
> EXPORT_SYMBOL_GPL(cpuidle_register);

Ah, right.

Thanks!


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
