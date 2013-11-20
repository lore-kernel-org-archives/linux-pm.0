From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 7/7] preempt: Take away preempt_enable_no_resched() from
 modules
Date: Wed, 20 Nov 2013 20:00:11 +0100
Message-ID: <20131120190011.GX16796@laptop.programming.kicks-ass.net>
References: <20131120160450.072555619@infradead.org>
 <20131120162736.760865926@infradead.org>
 <20131120105457.04f6e51e@ultegra>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131120105457.04f6e51e@ultegra>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, lenb@kernel.org, rjw@rjwysocki.net, Eliezer Tamir <eliezer.tamir@linux.intel.com>, Chris Leech <christopher.leech@intel.com>, David Miller <davem@davemloft.net>, rui.zhang@intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 20, 2013 at 10:54:57AM -0800, Jacob Pan wrote:
> run into a couple of compile issues.
>=20
> 1)
> include/linux/rcupdate.h: In function =E2=80=98rcu_read_unlock_sched_=
notrace=E2=80=99:
> include/linux/rcupdate.h:889:2: error: implicit declaration of functi=
on
> =E2=80=98preempt_enable_no_resched_notrace=E2=80=99 [-Werror=3Dimplic=
it-function-declaration]
>=20
> 2)
> In file included from drivers/cpufreq/acpi-cpufreq.c:41:0:
> include/linux/uaccess.h: In function =E2=80=98pagefault_enable=E2=80=99=
:
> include/linux/uaccess.h:34:2: error: implicit declaration of function
> =E2=80=98preempt_check_resched=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
>=20
> 1) happens when CONFIG_PREEMPT is not set, perhaps add a dummy functi=
on?

Ah, indeed, will fix.

> 2) I am not sure if we should take pagefault_enable away from modules

We can't I think, I'll have to fix that up. Easiest would be to make
preempt_check_resched() available again. That function actually adds
preemption points so its not bad.
