From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] PM: Limit race conditions between
 runtime PM and system sleep
Date: Sat, 25 Jun 2011 22:57:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106252249450.10907-100000__41041.1894707524$1309057109$gmane$org@netrider.rowland.org>
References: <201106260056.32221.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106260056.32221.rjw@sisk.pl>
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
Cc: linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 26 Jun 2011, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> One of the roles of the PM core is to prevent different PM callbacks
> executed for the same device object from racing with each other.
> Unfortunately, after commit e8665002477f0278f84f898145b1f141ba26ee26
> (PM: Allow pm_runtime_suspend() to succeed during system suspend)
> runtime PM callbacks may be executed concurrently with system
> suspend/resume callbacks for the same device.

...

> Index: linux-2.6/Documentation/power/runtime_pm.txt
> ===================================================================
> --- linux-2.6.orig/Documentation/power/runtime_pm.txt
> +++ linux-2.6/Documentation/power/runtime_pm.txt

> +The PM core does its best to reduce the probability of race conditions between
> +the runtime PM and system suspend/resume (and hibernation) callbacks by carrying
> +out the following operations:
> +
> +  * During system suspend it acquires a runtime PM reference to every device
> +    and resume it if there's a runtime PM resume request pending right before
> +    executing the subsystem-level .suspend() callback for it.  In addition to
> +    that it disables the runtime PM framework for every device right after
> +    executing the subsystem-level .suspend() callback for it.
> +
> +  * During system resume it enables the runtime PM framework for all devices
> +    right before executing the subsystem-level .resume() callbacks for them.
> +    Additionally, it drops references to all devices right after executing the
> +    subsystem-level .resume() callbacks for them.

I think it would be better to be a little more specific here.  Instead 
of "acquires a runtime PM reference", say "calls 
pm_runtime_get_noresume()".  Or at least, say "increments the 
run-time usage counter".

Likewise, instead of "disables the runtime PM framework", say "calls 
pm_runtime_disable()" or at least "increments power.disable_depth".

Hmmm, come to think of it...  The documentation for pm_runtime_enable() 
and pm_runtime_disable() fails to mention power.disable_depth, which is 
a surprising omission.  In particular, the description of 
pm_runtime_enable() is wrong because it ignores the possibility of 
nested disables.

Alan Stern
