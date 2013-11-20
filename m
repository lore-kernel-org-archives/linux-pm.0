From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 7/7] preempt: Take away preempt_enable_no_resched() from
 modules
Date: Wed, 20 Nov 2013 10:54:57 -0800
Message-ID: <20131120105457.04f6e51e@ultegra>
References: <20131120160450.072555619@infradead.org>
	<20131120162736.760865926@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131120162736.760865926@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, lenb@kernel.org, rjw@rjwysocki.net, Eliezer Tamir <eliezer.tamir@linux.intel.com>, Chris Leech <christopher.leech@intel.com>, David Miller <davem@davemloft.net>, rui.zhang@intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
List-Id: linux-pm@vger.kernel.org

On Wed, 20 Nov 2013 17:04:57 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Discourage drivers/modules to be creative with preemption.
>=20
> Sadly all is implemented in macros and inline so if they want to do
> evil they still can, but at least try and discourage some.
>=20
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: lenb@kernel.org
> Cc: rjw@rjwysocki.net
> Cc: Eliezer Tamir <eliezer.tamir@linux.intel.com>
> Cc: Chris Leech <christopher.leech@intel.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: rui.zhang@intel.com
> Cc: jacob.jun.pan@linux.intel.com
> Cc: Mike Galbraith <bitbucket@online.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: hpa@zytor.com
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> ---
>  include/linux/preempt.h |   16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -64,7 +64,11 @@ do { \
>  } while (0)
> =20
>  #else
> -#define preempt_enable() preempt_enable_no_resched()
> +#define preempt_enable() \
> +do { \
> +	barrier(); \
> +	preempt_count_dec(); \
> +} while (0)
>  #define preempt_check_resched() do { } while (0)
>  #endif
> =20
> @@ -126,6 +130,16 @@ do { \
>  #define preempt_fold_need_resched() do { } while (0)
>  #endif
> =20
> +#ifdef MODULE
> +/*
> + * Modules have no business playing preemption tricks.
> + */
> +#undef sched_preempt_enable_no_resched
> +#undef preempt_enable_no_resched
> +#undef preempt_enable_no_resched_notrace
> +#undef preempt_check_resched
> +#endif
> +
>  #ifdef CONFIG_PREEMPT_NOTIFIERS
> =20
>  struct preempt_notifier;
>=20
>=20

run into a couple of compile issues.

1)
include/linux/rcupdate.h: In function =E2=80=98rcu_read_unlock_sched_no=
trace=E2=80=99:
include/linux/rcupdate.h:889:2: error: implicit declaration of function
=E2=80=98preempt_enable_no_resched_notrace=E2=80=99 [-Werror=3Dimplicit=
-function-declaration]

2)
In file included from drivers/cpufreq/acpi-cpufreq.c:41:0:
include/linux/uaccess.h: In function =E2=80=98pagefault_enable=E2=80=99=
:
include/linux/uaccess.h:34:2: error: implicit declaration of function
=E2=80=98preempt_check_resched=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]

1) happens when CONFIG_PREEMPT is not set, perhaps add a dummy function=
?
2) I am not sure if we should take pagefault_enable away from modules
