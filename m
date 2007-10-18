From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm] Freezer: Do not allow freezing
	processes to clear TIF_SIGPENDING
Date: Fri, 19 Oct 2007 08:09:02 +1000
Message-ID: <200710190809.03042.nigel__39912.0854134255$1192745600$gmane$org@nigel.suspend2.net>
References: <200710190022.36145.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710190022.36145.rjw@sisk.pl>
Content-Disposition: inline
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi.

On Friday 19 October 2007 08:22:35 Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Do not allow processes to clear their TIF_SIGPENDING if TIF_FREEZE is set,
> to prevent them from racing with the freezer (like mysqld does, for 
example).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Nigel Cunningham <nigel@suspend2.net>

> ---
>  kernel/signal.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.23-mm1/kernel/signal.c
> ===================================================================
> --- linux-2.6.23-mm1.orig/kernel/signal.c
> +++ linux-2.6.23-mm1/kernel/signal.c
> @@ -124,7 +124,7 @@ void recalc_sigpending_and_wake(struct t
>  
>  void recalc_sigpending(void)
>  {
> -	if (!recalc_sigpending_tsk(current))
> +	if (!recalc_sigpending_tsk(current) && !freezing(current))
>  		clear_thread_flag(TIF_SIGPENDING);
>  
>  }
> 



-- 
Nigel, Michelle, Alisdair and ____________ Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia
