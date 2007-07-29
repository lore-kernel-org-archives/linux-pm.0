From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6 patch] make kernel/power/main.c:suspend_enter()
	static
Date: Sun, 29 Jul 2007 18:35:19 +0200
Message-ID: <200707291835.20105.rjw__40158.4318293773$1185726463$gmane$org@sisk.pl>
References: <20070729145742.GP16817@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070729145742.GP16817@stusta.de>
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
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 29 July 2007 16:57, Adrian Bunk wrote:
> suspend_enter() can now become static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

>  kernel/power/main.c  |    2 +-
>  kernel/power/power.h |    1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> --- linux-2.6.23-rc1-mm1/kernel/power/power.h.old	2007-07-26 14:49:29.000000000 +0200
> +++ linux-2.6.23-rc1-mm1/kernel/power/power.h	2007-07-26 14:49:36.000000000 +0200
> @@ -177,7 +177,6 @@
>  				unsigned int, char *);
>  
>  /* kernel/power/main.c */
> -extern int suspend_enter(suspend_state_t state);
>  extern int suspend_devices_and_enter(suspend_state_t state);
>  extern struct blocking_notifier_head pm_chain_head;
>  
> --- linux-2.6.23-rc1-mm1/kernel/power/main.c.old	2007-07-26 14:49:44.000000000 +0200
> +++ linux-2.6.23-rc1-mm1/kernel/power/main.c	2007-07-26 14:50:05.000000000 +0200
> @@ -120,7 +120,7 @@
>   *
>   *	This function should be called after devices have been suspended.
>   */
> -int suspend_enter(suspend_state_t state)
> +static int suspend_enter(suspend_state_t state)
>  {
>  	int error = 0;
>  
> 
> 
> 

-- 
"Premature optimization is the root of all evil." - Donald Knuth
