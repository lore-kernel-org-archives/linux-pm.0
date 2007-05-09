From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: [RFC][PATCH -mm 1/2] swsusp: Remove platform callbacks
	from restore code
Date: Wed, 9 May 2007 10:58:58 +0400
Message-ID: <8f8ff01d0705082358t74c08b5dja18e1c8b6c8e53e8__22066.6392161094$1178729826$gmane$org@mail.gmail.com>
References: <200705052227.14265.rjw@sisk.pl> <200705072257.13405.rjw@sisk.pl>
	<200705090019.20232.rjw@sisk.pl> <200705090027.05735.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705090027.05735.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, suspend-devel@lists.sourceforge.net, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

I expect http://bugzilla.kernel.org/show_bug.cgi?id=7887 this bug to
pop again with this patch.

Regards,
Alex.

On 5/9/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> The restore part of the hibernation code should not call any 'platform'
> functions, since it doesn't carry out any power transition of the system.
> Still, such functions are called from the restore code in kernel/power/user.c .
> Fix that.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/user.c |   17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>
> Index: linux-2.6.21/kernel/power/user.c
> ===================================================================
> --- linux-2.6.21.orig/kernel/power/user.c       2007-05-08 22:10:36.000000000 +0200
> +++ linux-2.6.21/kernel/power/user.c    2007-05-08 23:03:17.000000000 +0200
> @@ -179,34 +179,25 @@ static inline int snapshot_suspend(int p
>         return error;
>  }
>
> -static inline int snapshot_restore(int platform_suspend)
> +static inline int snapshot_restore(void)
>  {
>         int error;
>
>         mutex_lock(&pm_mutex);
>         pm_prepare_console();
> -       if (platform_suspend) {
> -               error = platform_prepare();
> -               if (error)
> -                       goto Finish;
> -       }
>         suspend_console();
>         error = device_suspend(PMSG_PRETHAW);
>         if (error)
> -               goto Resume_devices;
> +               goto Finish;
>
>         error = disable_nonboot_cpus();
>         if (!error)
>                 error = swsusp_resume();
>
>         enable_nonboot_cpus();
> - Resume_devices:
> -       if (platform_suspend)
> -               platform_finish();
> -
> + Finish:
>         device_resume();
>         resume_console();
> - Finish:
>         pm_restore_console();
>         mutex_unlock(&pm_mutex);
>         return error;
> @@ -272,7 +263,7 @@ static int snapshot_ioctl(struct inode *
>                         error = -EPERM;
>                         break;
>                 }
> -               error = snapshot_restore(data->platform_suspend);
> +               error = snapshot_restore();
>                 break;
>
>         case SNAPSHOT_FREE:
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
