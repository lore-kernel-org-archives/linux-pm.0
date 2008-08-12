From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/5] Container Freezer: Skip frozen cgroups
	during power management resume
Date: Tue, 12 Aug 2008 22:50:08 +0200
Message-ID: <200808122250.08699.rjw__19392.0742291541$1218576478$gmane$org@sisk.pl>
References: <20080811235323.872291138@us.ibm.com>
	<20080811235325.485466148@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080811235325.485466148@us.ibm.com>
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

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  kernel/power/process.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-2.6.27-rc1-mm1/kernel/power/process.c
> ===================================================================
> --- linux-2.6.27-rc1-mm1.orig/kernel/power/process.c
> +++ linux-2.6.27-rc1-mm1/kernel/power/process.c
> @@ -135,6 +135,9 @@ static void thaw_tasks(bool nosig_only)
>  		if (nosig_only && should_send_signal(p))
>  			continue;
>  
> +		if (cgroup_frozen(p))
> +			continue;
> +
>  		thaw_process(p);
>  	} while_each_thread(g, p);
>  	read_unlock(&tasklist_lock);
> 
