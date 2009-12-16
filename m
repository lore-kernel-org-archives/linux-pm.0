From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -next] power: fix printk formats
Date: Wed, 16 Dec 2009 23:35:31 +0100
Message-ID: <200912162335.31395.rjw__8613.56438040293$1261003088$gmane$org@sisk.pl>
References: <20091216183212.118c5e14.sfr@canb.auug.org.au>
	<20091216142606.1a9f3817.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091216142606.1a9f3817.randy.dunlap@oracle.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-pm@lists.linux-foundation.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 16 December 2009, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix printk format warnings:
> 
> drivers/base/power/main.c:398:warning: format '%Lu' expects type 'long long unsigned int', but argument 5 has type 'long int'
> drivers/base/power/main.c:398:warning: format '%03Lu' expects type 'long long unsigned int', but argument 6 has type 'long int'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Already fixed in my tree.

Rafael


> ---
>  drivers/base/power/main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20091216.orig/drivers/base/power/main.c
> +++ linux-next-20091216/drivers/base/power/main.c
> @@ -395,7 +395,7 @@ static void dpm_show_time(ktime_t startt
>  	usecs = usecs64;
>  	if (usecs == 0)
>  		usecs = 1;
> -	pr_info("PM: %s%s%s of devices complete after %Lu.%03Lu msecs\n",
> +	pr_info("PM: %s%s%s of devices complete after %lu.%03lu msecs\n",
>  		info ?: "", info ? " " : "", pm_verb(state.event),
>  		usecs / USEC_PER_MSEC, usecs % USEC_PER_MSEC);
>  }
> 
> 
