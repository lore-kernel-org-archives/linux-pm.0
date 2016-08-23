From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 10/16] cpuidle: pseries: Convert to hotplug state machine
Date: Tue, 23 Aug 2016 18:32:06 +0200
Message-ID: <20160823163206.xe7dg7ulzj4pzzrs@linutronix.de>
References: <20160818125731.27256-1-bigeasy@linutronix.de>
 <20160818125731.27256-11-bigeasy@linutronix.de>
 <57BB23CB.2080908@linaro.org>
 <20160822190404.i56qlimrqkhozacn@linutronix.de>
 <57BC5AAC.7070707@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57BC5AAC.7070707@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2016-08-23 16:16:12 [+0200], Daniel Lezcano wrote:
> Yes. If we can limit the number of duplicating enum for the same purpose
> right now, it would be nice.
Okay.

> > We could do that but you would have to ensure that only one CPUIDLE
> > driver registers itself at a time and for those powerpc drivers it looks
> > like you could have two registered (not sure about ARM's little/big (if
> > you could have two of those later at run-time)).
> 
> At the first glance, I don't think it is possible to register the cpu
> hotplug callback twice because the cpuidle drivers are doing:
…
> So if a previous driver was already registered, cpuidle_register will
> fail and register_cpu_notifier won't be hit.
> 
> There is the same scenario for intel_idle and processor_idle (acpi).

I tried to preserve everything as-is during the conversation. However if
you are explicitly asking for this and you are sure that it will work
then you can get it. No problem :)

Sebastian
