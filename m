From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 1/2] time: Change the return type of clockevents_notify()
 to integer
Date: Tue, 4 Feb 2014 11:01:26 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402041100250.24986@ionos.tec.linutronix.de>
References: <20140124065501.17564.39363.stgit@preeti.in.ibm.com> <20140124065739.17564.97259.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45165 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbaBDKBx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2014 05:01:53 -0500
In-Reply-To: <20140124065739.17564.97259.stgit@preeti.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: daniel.lezcano@linaro.org, peterz@infradead.org, fweisbec@gmail.com, galak@kernel.crashing.org, paul.gortmaker@windriver.com, paulus@samba.org, mingo@kernel.org, mikey@neuling.org, shangw@linux.vnet.ibm.com, rafael.j.wysocki@intel.com, agraf@suse.de, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au, john.stultz@linaro.org, anton@samba.org, chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org

On Fri, 24 Jan 2014, Preeti U Murthy wrote:
> -extern void tick_broadcast_oneshot_control(unsigned long reason);
> +extern int tick_broadcast_oneshot_control(unsigned long reason);

> -static inline void tick_broadcast_oneshot_control(unsigned long reason) { }
> +static inline int tick_broadcast_oneshot_control(unsigned long reason) { }

> -static inline void tick_broadcast_oneshot_control(unsigned long reason) { }
> +static inline int tick_broadcast_oneshot_control(unsigned long reason) { }

The inline stubs need to return 0.

Thanks,

	tglx
