From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Mon, 26 Mar 2018 00:13:48 -0700
Message-ID: <003601d3c4d1$fe4c0440$fae40cc0$@net>
References: <3111105.SmgpqUHPkp@aspire.rjw.lan>  <4731938.EeADOapqQb@aspire.rjw.lan> <1522008952.6308.46.camel@surriel.com>      <5810003.D8QGLjubHr@aspire.rjw.lan> 0DSBfDrt1Ffdw0DSCfOhiN 0LAnfFcYLFfdw0LApfPvKF
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: 0LAnfFcYLFfdw0LApfPvKF
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: 'Rik van Riel' <riel@surriel.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Linux PM' <linux-pm@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Frederic Weisbecker' <fweisbec@gmail.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Paul McKenney' <paulmck@linux.vnet.ibm.com>, 'Thomas Ilsche' <thomas.ilsche@tu-dresden.de>, 'Aubrey Li' <aubrey.li@linux.intel.com>, 'Mike Galbraith' <mgalbraith@suse.de>, 'LKML' <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

On 2018.03.25 23:00 Doug Smythies wrote: 
> On 2018.03.25 14:25 Rik van Riel wrote:
> On Sun, 2018-03-25 at 23:34 +0200, Rafael J. Wysocki wrote:
>> On Sunday, March 25, 2018 10:15:52 PM CEST Rik van Riel wrote:

...[snip]...

>>>> 
>>>> OK, I am still seeing a performance
>>>> degradation with the above, though
>>>> not throughout the entire workload.
>>>> 
>>>> It appears that making the idle loop
>>>> do anything besides cpu_relax() for
>>>> a significant amount of time slows
>>>> things down.
>>> 
>>> I see. 
>
> I have no proof, but I do not see that as
> the problem.
>
> I think the issue is the overall exiting
> and then re-entering idle state 0 much
> more often, and the related overheads, where
> interrupts are disabled for short periods.
>
> My jury rigged way of trying to create similar
> conditions seems to always have the ISR return with
> the need_resched() flag set, so there is no difference
> in idle state 0 entries per unit time between kernel
> 4.16-rc6 and one with the poll fixes added.
>
> i.e. the difference between these numbers over some time:
>
> cat /sys/devices/system/cpu/cpu*/cpuidle/state0/usage
>
> Rik, I wonder if you see a difference with your real
> workflow?

Using iperf, I was able to show a difference on my computer.
Another computer was used as the server, and my test computer
was the client. (the other way around didn't show a difference)

With Kernel 4.16-rc6 I got about ~2000 idle state 0 entries
per minute and ~155 seconds residency. ~32 watts package power.

With the poll stuff included I got ~46000 idle state 0 entries
per minute and ~53 seconds residency. ~20 watts package power.  

... Doug
