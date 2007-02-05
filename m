From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH revision 2] windfarm: dont die on suspend
	thread signal
Date: Tue, 06 Feb 2007 10:04:01 +1100
Message-ID: <1170716641.2620.145.camel@localhost.localdomain>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185835.700233000@sipsolutions.net>
	<20070205224325.GA8453@lst.de>
	<1170716074.30959.13.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1170716074.30959.13.camel@johannes.berg>
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
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Christoph Hellwig <hch@lst.de>, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-02-05 at 23:54 +0100, Johannes Berg wrote:
> When the windfarm thread gets a suspend signal it will die instead of
> freezing. This fixes it.

Don't we still need to call try_to_freeze() ?

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> =

> ---
> Adresses Christoph's comment: This keeps the original try_to_freeze() in
> place and just remove the code that kills the thread on a signal.
> =

> --- mb-wireless.orig/drivers/macintosh/windfarm_core.c	2007-02-05 16:07:1=
0.524524763 +0100
> +++ mb-wireless/drivers/macintosh/windfarm_core.c	2007-02-05 23:49:46.004=
524763 +0100
> @@ -117,12 +117,6 @@ static int wf_thread_func(void *data)
>  		delay =3D next - jiffies;
>  		if (delay <=3D HZ)
>  			schedule_timeout_interruptible(delay);
> -
> -		/* there should be no signal, but oh well */
> -		if (signal_pending(current)) {
> -			printk(KERN_WARNING "windfarm: thread got sigl !\n");
> -			break;
> -		}
>  	}
>  =

>  	DBG("wf: thread stopped\n");
> =

> =

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
