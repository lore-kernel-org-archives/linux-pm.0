From: "Alexey Starikovskiy" <aystarik@gmail.com>
Subject: Re: [RFT][PATCH] swsusp: Change code ordering related to
	ACPI
Date: Fri, 4 May 2007 22:36:41 +0400
Message-ID: <8f8ff01d0705041136r18315079w13f95dc3c627a53b__19861.5137291656$1178303848$gmane$org@mail.gmail.com>
References: <200705041143.02451.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705041143.02451.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Marcus Better <marcus@better.se>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Tobias Diedrich <ranma+kernel@tdiedrich.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Doing _WAK (from pm_finish) before device_resume will brake almost all
ACPI devices.

Regards,
Alex.

On 5/4/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> The change of the hibernation/suspend code ordering made before 2.6.21 has
> caused some systems to have problems related to ACPI.  In particular, the
> 'platform' hibernation mode doesn't work any more on some systems.
>
> It has been confirmed that the appended patch fixes the problem, but it's not
> certain if this changes don't break some other systems.  For this reason, all
> users of hibernation (swsusp, uswsusp) are gently requested to verify if this
> patch doesn't break their systems.
>
> Greetings,
> Rafael
>
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> The current code ordering in the hibernation code paths causes some systems to
> have problems.  It has been confirmed by testers that these problems do not
> appear if the acpi_pm_finish() function (called via platform_finish()) is
> executed after device_suspend().
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/disk.c |    4 ++--
>  kernel/power/user.c |    8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> Index: linux-2.6.21/kernel/power/disk.c
> ===================================================================
> --- linux-2.6.21.orig/kernel/power/disk.c       2007-05-04 10:31:51.000000000 +0200
> +++ linux-2.6.21/kernel/power/disk.c    2007-05-04 10:32:12.000000000 +0200
> @@ -195,9 +195,9 @@ int hibernate(void)
>
>         if (in_suspend) {
>                 enable_nonboot_cpus();
> -               platform_finish();
>                 device_resume();
>                 resume_console();
> +               platform_finish();
>                 pr_debug("PM: writing image.\n");
>                 error = swsusp_write();
>                 if (!error)
> @@ -214,9 +214,9 @@ int hibernate(void)
>   Enable_cpus:
>         enable_nonboot_cpus();
>   Resume_devices:
> -       platform_finish();
>         device_resume();
>         resume_console();
> +       platform_finish();
>   Thaw:
>         mutex_unlock(&pm_mutex);
>         unprepare_processes();
> Index: linux-2.6.21/kernel/power/user.c
> ===================================================================
> --- linux-2.6.21.orig/kernel/power/user.c       2007-05-04 10:31:51.000000000 +0200
> +++ linux-2.6.21/kernel/power/user.c    2007-05-04 10:32:12.000000000 +0200
> @@ -169,11 +169,11 @@ static inline int snapshot_suspend(int p
>         }
>         enable_nonboot_cpus();
>   Resume_devices:
> +       device_resume();
> +       resume_console();
>         if (platform_suspend)
>                 platform_finish();
>
> -       device_resume();
> -       resume_console();
>   Finish:
>         mutex_unlock(&pm_mutex);
>         return error;
> @@ -201,11 +201,11 @@ static inline int snapshot_restore(int p
>
>         enable_nonboot_cpus();
>   Resume_devices:
> +       device_resume();
> +       resume_console();
>         if (platform_suspend)
>                 platform_finish();
>
> -       device_resume();
> -       resume_console();
>   Finish:
>         pm_restore_console();
>         mutex_unlock(&pm_mutex);
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
