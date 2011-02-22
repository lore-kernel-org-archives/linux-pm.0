From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH 2/3] xen: use freeze/restore/thaw
 PM events for suspend/resume/chkpt
Date: Tue, 22 Feb 2011 15:43:20 -0500
Message-ID: <20110222204320.GB4605__16364.8376743824$1298476504$gmane$org@dumpdata.com>
References: <1298157158-5421-1-git-send-email-rshriram@cs.ubc.ca>
	<1298157158-5421-3-git-send-email-rshriram@cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1298157158-5421-3-git-send-email-rshriram@cs.ubc.ca>
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
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com, Iam Campbell <ian.campbell@citrix.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 19, 2011 at 03:12:37PM -0800, Shriram Rajagopalan wrote:
> Use PM_FREEZE, PM_THAW and PM_RESTORE power events for
> suspend/resume/checkpoint functionality, instead of PM_SUSPEND
> and PM_RESUME. Use of these pm events fixes the Xen Guest hangup
> when taking checkpoints. When a suspend event is cancelled
> (while taking checkpoints once/continuously), we use PM_THAW
> instead of PM_RESUME. PM_RESTORE is used when suspend is not
> cancelled. See Documentation/power/devices.txt and linux/pm.h
> for more info about freeze, thaw and restore. The sequence of
> pm events in a suspend-resume scenario is shown below.
> 
>         dpm_suspend_start(PMSG_FREEZE);
> 
>                 dpm_suspend_noirq(PMSG_FREEZE);
> 
>                        sysdev_suspend(PMSG_FREEZE);
>                        cancelled = suspend_hypercall()
>                        sysdev_resume();
> 
>                dpm_resume_noirq(cancelled ? PMSG_THAW : PMSG_RESTORE);
> 
>        dpm_resume_end(cancelled ? PMSG_THAW : PMSG_RESTORE);
> 
> Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
> ---
>  drivers/base/power/main.c                  |    8 ++++----
>  drivers/xen/manage.c                       |   16 ++++++++--------
>  drivers/xen/xenbus/xenbus_probe_frontend.c |    8 +++++---
>  3 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 8340497..aab4f60 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -233,7 +233,7 @@ static int pm_op(struct device *dev,
>  		}
>  		break;
>  #endif /* CONFIG_SUSPEND */
> -#ifdef CONFIG_HIBERNATION
> +#if defined(CONFIG_HIBERNATION) || defined(CONFIG_XEN_SAVE_RESTORE)

Could we just make CONFIG_XEN_SAVE_RESTORE depend on CONFIG_HIBERANTION?
Like this:


diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
index 5b54892..838e20c 100644
--- a/arch/x86/xen/Kconfig
+++ b/arch/x86/xen/Kconfig
@@ -38,7 +38,7 @@ config XEN_MAX_DOMAIN_MEMORY
 
 config XEN_SAVE_RESTORE
        bool
-       depends on XEN && PM
+       depends on XEN && PM && HIBERNATION
        default y
 
 config XEN_DEBUG_FS
