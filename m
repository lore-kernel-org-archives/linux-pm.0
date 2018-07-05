From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cpuidle:powernv: Add the CPUIDLE_FLAG_POLLING for snooze
Date: Thu, 05 Jul 2018 16:00:23 +1000
Message-ID: <87a7r6kyrs.fsf@concordia.ellerman.id.au>
References: <1530595456-32352-1-git-send-email-ego@linux.vnet.ibm.com> <20180703140616.GA13660@drishya.in.ibm.com> <20180703150348.GA13348@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703150348.GA13348@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, akshay.adiga@linux.vnet.ibm.com, Nicholas Piggin <npiggin@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> On Tue, Jul 03, 2018 at 07:36:16PM +0530, Vaidyanathan Srinivasan wrote:
>> * Gautham R Shenoy <ego@linux.vnet.ibm.com> [2018-07-03 10:54:16]:
>> 
>> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> > 
>> > In the situations where snooze is the only cpuidle state due to
>> > firmware not exposing any platform idle states, the idle CPUs will
>> > remain in snooze for a long time with interrupts disabled causing the
>> > Hard-lockup detector to complain.
>> 
>> snooze_loop() will spin in SMT low priority with interrupt enabled. We
>> have local_irq_enable() before we get into the snooze loop.
>> Since this is a polling state, we should wakeup without an interrupt
>> and hence we set TIF_POLLING_NRFLAG as well.
>>
>
> You are right. We have a local_irq_enable() inside the snooze_loop.
>> 
>> > watchdog: CPU 51 detected hard LOCKUP on other CPUs 59
>> > watchdog: CPU 51 TB:535296107736, last SMP heartbeat TB:527472229239 (15281ms ago)
>> > watchdog: CPU 59 Hard LOCKUP
>> > watchdog: CPU 59 TB:535296252849, last heartbeat TB:526554725466 (17073ms ago)
>> 
>> hmm.. not sure why watchdog will complain, maybe something more is
>> going on.
>
> Will look into this Vaidy.

I'll wait for a v2.

cheers
