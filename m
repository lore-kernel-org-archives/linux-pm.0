From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
Date: Sun, 25 Mar 2018 14:48:10 +0100
Message-ID: <20180325134548.GA1344@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com>
 <20180320095215.GB23359@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180320095215.GB23359@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 20 Mar 2018 at 10:52:15 (+0100), Greg Kroah-Hartman wrote:
> On Tue, Mar 20, 2018 at 09:43:08AM +0000, Dietmar Eggemann wrote:
> > From: Quentin Perret <quentin.perret@arm.com>

[...]

> > +#ifdef CONFIG_PM_OPP
> 
> #ifdefs go in .h files, not .c files, right?
> 

So, after looking into this, my suggestion would be to: 1) remove the
#ifdef CONFIG_PM_OPP from energy.c entirely; 2) make sure
init_sched_energy() is stubbed properly for !CONFIG_SMP and
!CONFIG_PM_OPP in include/linux/sched/energy.h; 3) relocate the global
variables (energy_model, freq_domains, ...) to fair.c; and 4) modify
kernel/sched/Makefile with something like:

ifeq ($(CONFIG_PM_OPP),y)
obj-$(CONFIG_SMP) += energy.o
endif

That way, energy.c is not compiled if not needed by the arch, and the
ifdef are kept within header files and Makefiles.

Would that work ?

Thanks,
Quentin
