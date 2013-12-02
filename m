From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V4 7/9] cpuidle/powernv: Add "Fast-Sleep" CPU idle
 state
Date: Mon, 2 Dec 2013 19:00:20 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1312021859440.30673@ionos.tec.linutronix.de>
References: <20131129104010.651.23117.stgit@preeti.in.ibm.com> <20131129104319.651.29563.stgit@preeti.in.ibm.com> <alpine.DEB.2.02.1311291301300.30673@ionos.tec.linutronix.de> <529CA219.20109@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <529CA219.20109@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: fweisbec@gmail.com, paul.gortmaker@windriver.com, paulus@samba.org, shangw@linux.vnet.ibm.com, rjw@sisk.pl, paulmck@linux.vnet.ibm.com, arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au, john.stultz@linaro.org, chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2 Dec 2013, Preeti U Murthy wrote:
> On 11/29/2013 08:09 PM, Thomas Gleixner wrote:
> > This supports HIGHRES and NO_HZ if done right, without polling at
> > all. So you can even let the last CPU which handles the broadcast
> > hrtimer go for a long sleep, just not in the deepest idle state.
> 
> Thank you for the review. The above points are all valid. I will rework
> the design to:
> 
> 1. Eliminate the concept of a broadcast CPU and integrate its
> functionality in the timekeeping CPU.
> 
> 2. Avoid polling by using IPIs to communicate the next wakeup of the
> CPUs in deep idle state so as to reprogram the broadcast hrtimer.
> 
> 3. Make this feature generic and not arch-specific.

Great. If you need help with the generic bits, please let me know.

Thanks,

	tglx
