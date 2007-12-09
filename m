From: Ingo Molnar <mingo@elte.hu>
Subject: Re: broken suspend (sched related) [Was: 2.6.24-rc4-mm1]
Date: Sun, 9 Dec 2007 08:46:47 +0100
Message-ID: <20071209074647.GE22981__13786.838859278$1197186544$gmane$org@elte.hu>
References: <20071204211701.994dfce6.akpm@linux-foundation.org>
	<47595A0A.5000502@gmail.com> <20071207151150.GB24254@elte.hu>
	<20071207175134.GA18916@elte.hu> <475A5188.6070809@gmail.com>
	<20071208083939.GD30997@elte.hu> <475A629C.7010408@gmail.com>
	<20071208152447.GA30270@elte.hu> <475B24F4.3090904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <475B24F4.3090904@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>, Gautham R Shenoy <ego@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Jiri Slaby <jirislaby@gmail.com> wrote:

> On 12/08/2007 04:24 PM, Ingo Molnar wrote:
> > i'm wondering why it had no effect now
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index e0d3a4f..a46c252 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -47,15 +47,21 @@ void __init cpu_hotplug_init(void)
>  }
> 
>  #ifdef CONFIG_HOTPLUG_CPU
> -
> +#include <asm/io.h>
>  void get_online_cpus(void)
>  {
> +       outb(0x20, 0x80);
>         might_sleep();
> +       outb(0x21, 0x80);

ah. If you comment out get_online_cpus()/put_online_cpus() from 
kernel/softlockup.c, does it start working?

Gautham, any ideas?

	Ingo
