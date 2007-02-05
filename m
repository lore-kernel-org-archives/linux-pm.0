From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 02/10] windfarm: dont die on suspend thread
	signal
Date: Tue, 06 Feb 2007 09:58:36 +1100
Message-ID: <1170716316.2620.139.camel@localhost.localdomain>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185835.700233000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070205185835.700233000@sipsolutions.net>
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
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, Torrance <torrance123@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-02-05 at 19:30 +0100, Johannes Berg wrote:
> plain text document attachment (windfarm-dont-die-on-signals.patch)
> When the windfarm thread gets a suspend signal it will die instead of
> freezing. This fixes it.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Andrew Morton <akpm@osdl.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> =

> ---
> Please apply to -mm.
> =

> --- mb-wireless.orig/drivers/macintosh/windfarm_core.c	2007-02-05 14:24:0=
6.344526864 +0100
> +++ mb-wireless/drivers/macintosh/windfarm_core.c	2007-02-05 14:24:38.264=
526864 +0100
> @@ -94,8 +94,6 @@ static int wf_thread_func(void *data)
>  	DBG("wf: thread started\n");
>  =

>  	while(!kthread_should_stop()) {
> -		try_to_freeze();
> -
>  		if (time_after_eq(jiffies, next)) {
>  			wf_notify(WF_EVENT_TICK, NULL);
>  			if (wf_overtemp) {
> @@ -118,8 +116,8 @@ static int wf_thread_func(void *data)
>  		if (delay <=3D HZ)
>  			schedule_timeout_interruptible(delay);
>  =

> -		/* there should be no signal, but oh well */
> -		if (signal_pending(current)) {
> +		/* there should be no non-suspend signal, but oh well */
> +		if (signal_pending(current) && !try_to_freeze()) {
>  			printk(KERN_WARNING "windfarm: thread got sigl !\n");
>  			break;
>  		}
> =

> --
