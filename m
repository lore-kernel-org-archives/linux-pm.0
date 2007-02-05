From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/10] powerpc: fix comment in kernel/irq.c
Date: Tue, 06 Feb 2007 09:59:36 +1100
Message-ID: <1170716376.2620.141.camel@localhost.localdomain>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185836.099816000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070205185836.099816000@sipsolutions.net>
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
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-02-05 at 19:30 +0100, Johannes Berg wrote:
> plain text document attachment (irq-comment.patch)
> kernel/irq.c contains a comment that speaks of -1 and -2 as interrupt
> numbers. Replace by NO_IRQ and NO_IRQ_IGNORE.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Andrew Morton <akpm@osdl.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> --- mb-wireless.orig/arch/powerpc/kernel/irq.c	2007-02-05 14:24:06.694526=
864 +0100
> +++ mb-wireless/arch/powerpc/kernel/irq.c	2007-02-05 14:24:37.084526864 +=
0100
> @@ -281,10 +281,10 @@ void do_IRQ(struct pt_regs *regs)
>  =

>  	/*
>  	 * Every platform is required to implement ppc_md.get_irq.
> -	 * This function will either return an irq number or -1 to
> +	 * This function will either return an irq number or NO_IRQ to
>  	 * indicate there are no more pending.
> -	 * The value -2 is for buggy hardware and means that this IRQ
> -	 * has already been handled. -- Tom
> +	 * The value NO_IRQ_IGNORE is for buggy hardware and means that this
> +	 * IRQ has already been handled. -- Tom
>  	 */
>  	irq =3D ppc_md.get_irq();
>  =

> =

> --
> =

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
