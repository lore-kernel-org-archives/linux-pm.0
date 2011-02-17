From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [Xen-devel] [PATCH] update comments in pm.h
 describing Xen Guest save/restore/checkpoint use case
Date: Thu, 17 Feb 2011 10:56:09 +0000
Message-ID: <1297940169.16356.1511.camel__47342.0926522978$1297961443$gmane$org@zakaz.uk.xensource.com>
References: <201102101801.20345.rjw@sisk.pl>
	<1297929363-27183-1-git-send-email-rshriram@cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1297929363-27183-1-git-send-email-rshriram@cs.ubc.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2011-02-17 at 07:56 +0000, Shriram Rajagopalan wrote:
> Add documentation to pm.h on how xen uses PM events (freeze,
> thaw, restore) to implement Guest VM save/checkpoint/restore
> functionality.

The change to freeze/thaw/restore instead of suspend/resume raises the
question of what the correct .config option for Xen to key off is.

Currently the Xen suspend functionality in drivers/xen/manage.c is keyed
off CONFIG_PM_SLEEP (which depends on SUSPEND || HIBERNATION ||
XEN_SAVE_RESTORE).

Since PMSG_{SUSPEND,RESUME} are covered by CONFIG_SUSPEND in pm_op()
this already seems incorrect before this change, since PM_SLEEP can be
enabled without SUSPEND, and is equally incorrect after changing to
PMSG_{FREEZE,THAW,RESUME}, which are covered by CONFIG_HIBERNATION.

Is the correct fix to update pm_op to include
	|| defined(CONFIG_XEN_SAVE_RESTORE)
where appropriate in pm_op()? 

Or should we be looking to adjust the Kconfig and/or code on the Xen
side? Having Xen depend on HIBERNATION ="Hibernation (aka 'suspend to
disk')" seems semantically incorrect.

Ian.

> 
> Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
> ---
>  include/linux/pm.h |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index dd9c7ab..2ddd9d3 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -516,6 +516,25 @@ extern void update_pm_runtime_accounting(struct device *dev);
>   * well as during system sleep states like PM_SUSPEND_STANDBY.  They may
>   * be able to use wakeup events to exit from runtime low-power states,
>   * or from system low-power states such as standby or suspend-to-RAM.
> + *
> + * Xen Guest Kernels use PM_FREEZE, PM_RESTORE and PM_THAW to implement
> + * VM save/restore/checkpoint functionality. Save and Restore are somewhat
> + * similar to hibernate functionality. The sequence of events is shown below:
> + *        dpm_suspend_start(PMSG_FREEZE);
> + *
> + *              dpm_suspend_noirq(PMSG_FREEZE);
> + *
> + *                     sysdev_suspend(PMSG_FREEZE);
> + *                     cancelled = suspend_hypercall()
> + *                     sysdev_resume();
> + *
> + *             dpm_resume_noirq(cancelled ? PMSG_THAW : PMSG_RESTORE);
> + *
> + *     dpm_resume_end(cancelled ? PMSG_THAW : PMSG_RESTORE);
> + *
> + * If the syspend_hypercall returns 1, it means that the VM was merely
> + * checkpointed (akin to THAW). If it returns 0, it means the system has been
> + * fully restored from its on-disk snapshot (akin to RESTORE).
>   */
>  
>  #ifdef CONFIG_PM_SLEEP
