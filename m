From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/5] Container Freezer: Make refrigerator
	always available
Date: Tue, 12 Aug 2008 22:49:26 +0200
Message-ID: <200808122249.27553.rjw__48988.1850932308$1218576111$gmane$org@sisk.pl>
References: <20080811235323.872291138@us.ibm.com>
	<20080811235324.661871296@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080811235324.661871296@us.ibm.com>
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>, Li Zefan <lizf@cn.fujitsu.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, linux-pm@lists.linux-foundation.org, "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Paul Menage <menage@google.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 12 of August 2008, Matt Helsley wrote:
> Now that the TIF_FREEZE flag is available in all architectures,
> extract the refrigerator() and freeze_task() from kernel/power/process.c
> and make it available to all.
> 
> The refrigerator() can now be used in a control group subsystem
> implementing a control group freezer.
> 
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
> Acked-by: Serge E. Hallyn <serue@us.ibm.com>
> Tested-by: Matt Helsley <matthltc@us.ibm.com>

Your Signed-off-by implies your Tested-by (at least it should ;-)).

> ---
[--snip--]
> Index: linux-2.6.27-rc1-mm1/kernel/power/Kconfig
> ===================================================================
> --- linux-2.6.27-rc1-mm1.orig/kernel/power/Kconfig
> +++ linux-2.6.27-rc1-mm1/kernel/power/Kconfig
> @@ -85,6 +85,9 @@ config PM_SLEEP
>  	depends on SUSPEND || HIBERNATION || XEN_SAVE_RESTORE
>  	default y
>  
> +config FREEZER
> +	def_bool PM_SLEEP
> +

I'd still prefer this to go into a Kconfig in the parent directory (ie. where
freezer.c and the Makefile building it are located).  Otherwise it's guaranteed
to confuse someone.

>  config SUSPEND
>  	bool "Suspend to RAM and standby"
>  	depends on PM && ARCH_SUSPEND_POSSIBLE
> 
