From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 2/2] tick/cpuidle: Initialize hrtimer mode of
 broadcast
Date: Tue, 4 Feb 2014 21:18:40 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402042118220.24986@ionos.tec.linutronix.de>
References: <20140124065501.17564.39363.stgit@preeti.in.ibm.com> <20140124065820.17564.83076.stgit@preeti> <alpine.DEB.2.02.1402041101330.24986@ionos.tec.linutronix.de> <52F11ECE.605@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49146 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932288AbaBDUTM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2014 15:19:12 -0500
In-Reply-To: <52F11ECE.605@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: daniel.lezcano@linaro.org, peterz@infradead.org, fweisbec@gmail.com, agraf@suse.de, paul.gortmaker@windriver.com, paulus@samba.org, mingo@kernel.org, mikey@neuling.org, shangw@linux.vnet.ibm.com, rafael.j.wysocki@intel.com, paulmck@linux.vnet.ibm.com, arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au, john.stultz@linaro.org, anton@samba.org, chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org

On Tue, 4 Feb 2014, Preeti U Murthy wrote:
> Do you want me to send out the next version with the above corrections
> including the patch added to this thread where we handle archs setting
> the CPUIDLE_FLAG_TIMER_STOP flag?

Yes please.
