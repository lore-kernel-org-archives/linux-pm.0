From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH v2 10/10] cpu: No more __stop_machine() in
	_cpu_down()
Date: Wed, 5 Dec 2012 20:08:36 +0100
Message-ID: <20121205190836.GB13795@redhat.com>
References: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com> <20121205184456.3750.35005.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31216 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029Ab2LETJS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 5 Dec 2012 14:09:18 -0500
Content-Disposition: inline
In-Reply-To: <20121205184456.3750.35005.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/06, Srivatsa S. Bhat wrote:
>
> @@ -418,7 +418,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen)
>  	}
>  	smpboot_park_threads(cpu);
>
> -	err = __stop_machine(take_cpu_down, &tcd_param, cpumask_of(cpu));
> +	err = stop_cpus(cpumask_of(cpu), take_cpu_down, &tcd_param);

stop_one_cpu(cpu) ?

Oleg.

