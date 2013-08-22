From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [RFC V2 PATCH 4/6] cpuidle/ppc: Add longnap state to the idle
 states on powernv
Date: Thu, 22 Aug 2013 14:39:20 +0530
Message-ID: <5215D540.9020309@linux.vnet.ibm.com>
References: <20130814115311.5193.32212.stgit@preeti.in.ibm.com> <20130814115623.5193.36974.stgit@preeti.in.ibm.com> <1377142130.25016.273.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377142130.25016.273.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: fweisbec@gmail.com, paul.gortmaker@windriver.com, paulus@samba.org, shangw@linux.vnet.ibm.com, galak@kernel.crashing.org, deepthi@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com, arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org, rjw@sisk.pl, john.stultz@linaro.org, tglx@linutronix.de, chenhui.zhao@freescale.com, michael@ellerman.id.au, r58472@freescale.com, geoff@infradead.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

Hi Ben,

On 08/22/2013 08:58 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2013-08-14 at 17:26 +0530, Preeti U Murthy wrote:
>> This patch hooks into the existing broadcast framework along with the support
>> that this patchset introduces for ppc, and the cpuidle driver backend
>> for powernv(posted out by Deepthi Dharwar:https://lkml.org/lkml/2013/7/23/128)
>> to add sleep state as one of the deep idle states, in which the decrementer
>> is switched off.
>>
>> However in this patch, we only emulate sleep by going into a state which does
>> a nap with the decrementer interrupts disabled, termed as longnap. This enables
>> focus on the timer broadcast framework for ppc in this series of patches ,
>> which is required as a first step to enable sleep on ppc.
> 
> This is only for debug / proof of concept right ? We should use a real
> sleep here.
> 
> If we need to know whether the FW supports it (PORE etc...) we shall add
> a device-tree property from the FW to indicate that fact.

We also need the sleep support right? The context management, I mean.
Yes it is a debug patch, so as to first ensure that we have the hook up
to the broadcast framework done right.

Regards
Preeti U Murthy
