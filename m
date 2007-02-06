From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 07/10] powermac: support G5 CPU hotplug
Date: Tue, 6 Feb 2007 13:42:12 +0100
Message-ID: <20070206124212.GD8662@elf.ucw.cz>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185837.640324000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070205185837.640324000@sipsolutions.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> This patch allows "hotplugging" of CPUs on G5 machines. CPUs that are
> disabled are put into an idle loop with interrupts hard-disabled, to wake
> them up again we kick them just like when bringing them up.
> =

> Maybe there's some way to actually turn off those CPUs even more?
> =

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> --- mb-wireless.orig/arch/powerpc/kernel/smp.c	2007-02-05 16:07:09.274524=
763 +0100
> +++ mb-wireless/arch/powerpc/kernel/smp.c	2007-02-05 18:15:51.114524763 +=
0100
> @@ -558,6 +558,11 @@ int __devinit start_secondary(void *unus
>  =

>  	local_irq_enable();
>  =

> +	/* it seems to be possible that we died from within
> +	 * an interrupt ... reset the in-irq counts */
> +	task_thread_info(paca[cpu].__current)->preempt_count &=3D
> +		~(SOFTIRQ_MASK|HARDIRQ_MASK);
> +
>  	cpu_idle();
>  	return 0;

This is quite a nasty hack. Are you sure?

I've seen similar weirdness on pc, and it was caused by
swsusp-copying-code using FPU and incrementing preempt_count...

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
