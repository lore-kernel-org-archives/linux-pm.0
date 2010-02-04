From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Net / pktgen: Fix freezing problem
Date: Thu, 4 Feb 2010 14:12:39 -0800
Message-ID: <20100204141239.aa94e75c.akpm__34139.8836965256$1265321802$gmane$org@linux-foundation.org>
References: <201002042250.58944.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002042250.58944.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: NetDev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ciprian Dorin Craciun <ciprian.craciun@gmail.com>, list <linux-pm@lists.linux-foundation.org>, David Miller <davem@davemloft.net>, pm@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 4 Feb 2010 22:50:58 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: Net / pktgen: Fix freezing problem
> 
> Add missing try_to_freeze() to one of the pktgen_thread_worker() code
> paths so that it doesn't block suspend/hibernation.
> 
> Fixes http://bugzilla.kernel.org/show_bug.cgi?id=15006
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Reported-and-tested-by: Ciprian Dorin Craciun <ciprian.craciun@gmail.com>
> ---
>  net/core/pktgen.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: linux-2.6/net/core/pktgen.c
> ===================================================================
> --- linux-2.6.orig/net/core/pktgen.c
> +++ linux-2.6/net/core/pktgen.c
> @@ -3524,6 +3524,7 @@ static int pktgen_thread_worker(void *ar
>  			wait_event_interruptible_timeout(t->queue,
>  							 t->control != 0,
>  							 HZ/10);
> +			try_to_freeze();
>  			continue;
>  		}
>  

Also needed in -stable, IMO.
