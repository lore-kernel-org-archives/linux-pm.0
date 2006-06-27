From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fix windfarm core thread wrt. signal handling
Date: Wed, 28 Jun 2006 08:07:06 +1000
Message-ID: <1151446026.2350.76.camel@localhost.localdomain>
References: <1150847482.16662.13.camel@johannes>
	<1150956123.3633.23.camel@localhost.localdomain>
	<200606221303.19860.rjw@sisk.pl> <1150974836.16258.29.camel@johannes>
	<1150976092.16258.33.camel@johannes>
	<1151394268.2350.61.camel@localhost.localdomain>
	<1151432266.4289.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151432266.4289.6.camel@localhost>
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
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2006-06-27 at 20:17 +0200, Johannes Berg wrote:
> This patch removes the signal_pending() from the windfarm core thread
> loop as it isn't necessary and messes up when there actually *is* a
> signal pending because we should enter the freezer.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfa=
rm_core.c
> index ab3faa7..c05a838 100644
> --- a/drivers/macintosh/windfarm_core.c
> +++ b/drivers/macintosh/windfarm_core.c
> @@ -116,12 +116,6 @@ static int wf_thread_func(void *data)
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
