From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [PATCH 4/6] Container Freezer: Skip frozen cgroups
	during	power management resume
Date: Fri, 01 Aug 2008 20:24:40 +1000
Message-ID: <1217586280.27551.18.camel__49760.2311465473$1217591904$gmane$org@nigel-laptop>
References: <20080801050659.924495279@us.ibm.com>
	<20080801050701.070484831@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080801050701.070484831@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>, Li Zefan <lizf@cn.fujitsu.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, linux-pm@lists.linux-foundation.org, "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Paul Menage <menage@google.com>
List-Id: linux-pm@vger.kernel.org

Hi.

On Thu, 2008-07-31 at 22:07 -0700, Matt Helsley wrote:
> When a system is resumed after a suspend, it will also unfreeze
> frozen cgroups.
> 
> This patchs modifies the resume sequence to skip the tasks which
> are part of a frozen control group.
> 
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> Acked-by: Serge E. Hallyn <serue@us.ibm.com>
> Tested-by: Matt Helsley <matthltc@us.ibm.com>

I understand the freezer pretty well, so maybe I can help a little.

Acked-by: Nigel Cunningham <nigel@tuxonice.net>

> ---
>  kernel/power/process.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 444cea8..ce9e280 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/syscalls.h>
>  #include <linux/freezer.h>
> +#include <linux/cgroup_freezer.h>
>  
>  /* 
>   * Timeout for stopping processes
> @@ -135,6 +136,9 @@ static void thaw_tasks(bool nosig_only)
>  		if (nosig_only && should_send_signal(p))
>  			continue;
>  
> +		if (cgroup_frozen(p))
> +			continue;
> +
>  		thaw_process(p);
>  	} while_each_thread(g, p);
>  	read_unlock(&tasklist_lock);
> -- 
> 1.5.3.7
> 
