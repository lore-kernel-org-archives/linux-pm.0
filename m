From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V3] cpuidle: Handle tick_broadcast_enter() failure gracefully
Date: Fri, 08 May 2015 13:43:38 +0100
Message-ID: <554CAF7A.6060609@arm.com>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52887 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490AbbEHMnm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 8 May 2015 08:43:42 -0400
In-Reply-To: <20150508073418.28491.4150.stgit@preeti.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "rlippert@google.com" <rlippert@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>



On 08/05/15 08:35, Preeti U Murthy wrote:
> When a CPU has to enter an idle state where tick stops, it makes a call
> to tick_broadcast_enter(). The call will fail if this CPU is the
> broadcast CPU. Today, under such a circumstance, the arch cpuidle code
> handles this CPU.  This is not convincing because not only do we not
> know what the arch cpuidle code does, but we also do not account for the
> idle state residency time and usage of such a CPU.
>
> This scenario can be handled better by simply choosing an idle state
> where in ticks do not stop. To accommodate this change move the setting
> of runqueue idle state from the core to the cpuidle driver, else the
> rq->idle_state will be set wrong.
>
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

I gave it a spin on ARM64 Juno platform with one of the CPU in broadcast
mode and Vexpress TC2 with broadcast timer. I found no issues in both
the cases. So, you can add:

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
