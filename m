From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Sun, 25 Mar 2018 22:59:52 -0700
Message-ID: <003401d3c4c7$ab9f82d0$02de8870$@net>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan>  <4731938.EeADOapqQb@aspire.rjw.lan> <1522008952.6308.46.camel@surriel.com>      <5810003.D8QGLjubHr@aspire.rjw.lan> 0DSBfDrt1Ffdw0DSCfOhiN
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: 0DSBfDrt1Ffdw0DSCfOhiN
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Rik van Riel' <riel@surriel.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Linux PM' <linux-pm@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.03.25 14:25 Rik van Riel wrote:
> On Sun, 2018-03-25 at 23:34 +0200, Rafael J. Wysocki wrote:
>> On Sunday, March 25, 2018 10:15:52 PM CEST Rik van Riel wrote:
>>> 
>>> --=-e8yLbs0aoH4SrxOskwwl
>>> Content-Type: text/plain; charset="UTF-8"
>>> Content-Transfer-Encoding: quoted-printable
>>> 
>>> On Thu, 2018-03-22 at 18:09 +0100, Rafael J. Wysocki wrote:
>>>> =20
>>>> +++ linux-pm/drivers/cpuidle/poll_state.c
>>>> @@ -10,6 +10,7 @@
>>>>  #include <linux/sched/idle.h>
>>>> =20
>>>>  #define POLL_IDLE_TIME_LIMIT	(TICK_NSEC / 16)
>>>> +#define POLL_IDLE_COUNT		1000
>>>> =20
>>>>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>>>>  			       struct cpuidle_driver *drv, int
>>>> index)
>>>> @@ -18,9 +19,14 @@ static int __cpuidle poll_idle(struct cp
>>>>
>>>>  	local_irq_enable();
>>>>  	if (!current_set_polling_and_test()) {
>>>> +		unsigned int loop_count =3D 0;
>>>> +
>>>>  		while (!need_resched()) {
>>>>  			cpu_relax();
>>>> +			if (loop_count++ < POLL_IDLE_COUNT)
>>>> +				continue;
>>>>
>>>> +			loop_count =3D 0;
>>>>  			if (local_clock() - time_start >
>>>> POLL_IDLE_TIME_LIMIT)
>>>>  				break;
>>>>  		}
>>> 
>>> OK, I am still seeing a performance
>>> degradation with the above, though
>>> not throughout the entire workload.
>>> 
>>> It appears that making the idle loop
>>> do anything besides cpu_relax() for
>>> a significant amount of time slows
>>> things down.
>> 
>> I see.
>> 

I have no proof, but I do not see that as
the problem.

I think the issue is the overall exiting
and then re-entering idle state 0 much
more often, and the related overheads, where
interrupts are disabled for short periods.

My jury rigged way of trying to create similar
conditions seems to always have the ISR return with
the need_resched() flag set, so there is no difference
in idle state 0 entries per unit time between kernel
4.16-rc6 and one with the poll fixes added.

i.e. the difference between these numbers over some time:

cat /sys/devices/system/cpu/cpu*/cpuidle/state0/usage

Rik, I wonder if you see a difference with your real
workflow?

... Doug
