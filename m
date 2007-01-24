From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 2/3] windfarm: dont die on suspend thread signal
Date: Wed, 24 Jan 2007 17:32:04 +1100
Message-ID: <1169620324.18754.62.camel@localhost.localdomain>
References: <20061211230208.526233000@sipsolutions.net> >
	<20061211230754.679589000@sipsolutions.net>>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061211230754.679589000@sipsolutions.net>>
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
Cc: linuxppc-dev@ozlabs.org, Michael Hanselmann <linux-kernel@hansmi.ch>, linux-pm@lists.osdl.org, Michael Buesch <mb@bu3sch.de>, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2006-12-12 at 00:02 +0100, Johannes Berg wrote:
> plain text document attachment (windfarm-dont-die-on-signals.patch)
> When the windfarm thread gets a suspend signal it will die instead of
> freezing. This fixes it.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> --- linux-2.6-git.orig/drivers/macintosh/windfarm_core.c	2006-12-11 23:34=
:47.082716759 +0100
> +++ linux-2.6-git/drivers/macintosh/windfarm_core.c	2006-12-11 23:37:58.1=
81716759 +0100
> @@ -93,8 +93,6 @@ static int wf_thread_func(void *data)
>  	DBG("wf: thread started\n");
>  =

>  	while(!kthread_should_stop()) {
> -		try_to_freeze();
> -
>  		if (time_after_eq(jiffies, next)) {
>  			wf_notify(WF_EVENT_TICK, NULL);
>  			if (wf_overtemp) {
> @@ -117,8 +115,8 @@ static int wf_thread_func(void *data)
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
