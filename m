From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM_SLEEP_SMP: fix kconfig warning
Date: Sun, 12 Sep 2010 19:26:08 +0200
Message-ID: <201009121926.08633.rjw__47086.2617287368$1284312492$gmane$org@sisk.pl>
References: <20100911155720.c4fe6b4b.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100911155720.c4fe6b4b.randy.dunlap@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-pm@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, September 12, 2010, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix kconfig unmet dependency warning:
> 
> warning: (PM_SLEEP_SMP && SMP && (ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE) && PM_SLEEP) selects HOTPLUG_CPU which has unmet direct dependencies (SMP && HOTPLUG)
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  kernel/power/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20100908.orig/kernel/power/Kconfig
> +++ linux-next-20100908/kernel/power/Kconfig
> @@ -83,7 +83,7 @@ config PM_TRACE_RTC
>  
>  config PM_SLEEP_SMP
>  	bool
> -	depends on SMP
> +	depends on SMP && HOTPLUG
>  	depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
>  	depends on PM_SLEEP
>  	select HOTPLUG_CPU

I'm afraid that may cause some people to find that suspend is not compiled in
to their surprise.

Would it be possible to select both HOTPLUG and HOTPLUG_CPU instead (ie. would
that work)?

Rafael
