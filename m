From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: INFO: possible circular locking dependency at
	cleanup_workqueue_thread
Date: Sun, 24 May 2009 10:30:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905241016410.7718-100000__7261.12859924815$1243175504$gmane$org@netrider.rowland.org>
References: <200905240120.30336.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905240120.30336.rjw@sisk.pl>
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
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sun, 24 May 2009, Rafael J. Wysocki wrote:

> The patch is appended for reference (Alan, please have a look; I can't recall
> why exactly we have called device_pm_lock() from the core suspend/hibernation
> code instead of acquiring the lock locally in drivers/base/power/main.c) and
> I'll attach it to the bug entry too.

I can't remember the reason either.  Probably there wasn't any.  The 
patch looks fine, and it has the nice added benefit that now the only 
user of device_pm_lock() will be device_move().

> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Do not hold dpm_list_mtx while disabling/enabling nonboot CPUs
> 
> We shouldn't hold dpm_list_mtx while executing
> [disable|enable]_nonboot_cpus(), because theoretically this may lead
> to a deadlock as shown by the following example (provided by Johannes
> Berg):
> 
> CPU 3       CPU 2                     CPU 1
>                                       suspend/hibernate
>             something:
>             rtnl_lock()               device_pm_lock()
>                                        -> mutex_lock(&dpm_list_mtx)
> 
>             mutex_lock(&dpm_list_mtx)
> 
> linkwatch_work
>  -> rtnl_lock()
>                                       disable_nonboot_cpus()
>                                        -> flush CPU 3 workqueue
> 
> Fortunately, device drivers are supposed to stop any activities that
> might lead to the registration of new device objects and/or to the
> removal of the existing ones way before disable_nonboot_cpus() is

Strictly speaking, drivers are still allowed to unregister existing 
devices.  They are forbidden only to register new ones.  This shouldn't 
hurt anything, though.

> called, so it shouldn't be necessary to hold dpm_list_mtx over the
> entire late part of device suspend and early part of device resume.
> 
> Thus, during the late suspend and the early resume of devices acquire
> dpm_list_mtx only when dpm_list is going to be traversed and release
> it right after that.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
