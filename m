From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] power management: no valid states w/o pm_ops
 + docs
Date: Tue, 13 Feb 2007 09:23:56 -0800
Message-ID: <20070213092357.7ea02880.randy.dunlap@oracle.com>
References: <1171383980.10344.39.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1171383980.10344.39.camel@johannes.berg>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm <linux-pm@lists.osdl.org>, Machek <pavel@ucw.cz>, Pavel@smtp.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tue, 13 Feb 2007 17:26:20 +0100 Johannes Berg wrote:

> This patch changes /sys/power/state to not advertise any valid states
> (except for disk if SOFTWARE_SUSPEND is enabled) when no pm_ops have been
> set so userspace can easily discover what states should be available.
> =

> Also, because the pm ops in powermac are obviously not using them as
> intended, I added documentation for it in kernel-doc format.

Thanks... but it's not quite in kernel-doc format.
Did you test it?
See Documentation/kernel-doc-nano-HOWTO.txt for details.

> Reordering the fields in struct pm_ops not only makes the output of
> kernel-doc make more sense but also removes a hole from the structure on
> 64-bit platforms.
> =

> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Acked-by: Pavel Macheck <pavel@ucw.cz>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: linux-pm@lists.osdl.org
> =

> ---
>  include/linux/pm.h  |   36 ++++++++++++++++++++++++++++++++++--
>  kernel/power/main.c |    5 ++++-
>  2 files changed, 38 insertions(+), 3 deletions(-)
> =

> --- linux-2.6-git.orig/include/linux/pm.h	2007-02-08 19:23:44.219643144 +=
0100
> +++ linux-2.6-git/include/linux/pm.h	2007-02-08 19:23:54.204643144 +0100
> @@ -120,15 +120,47 @@ typedef int __bitwise suspend_disk_metho
>  #define	PM_DISK_TESTPROC	((__force suspend_disk_method_t) 6)
>  #define	PM_DISK_MAX		((__force suspend_disk_method_t) 7)
>  =

> +/**
> + * struct pm_ops
> + *
> + * Callbacks for managing platform dependent suspend states.
> + *

 * struct pm_ops - callbacks for managing platform-dependent suspend states

> + * @valid: Callback to determine whether the given state can be entered.
> + *         If %CONFIG_SOFTWARE_SUSPEND is set then %PM_SUSPEND_DISK is
> + *         always valid and never passed to this call.
> + *         If not assigned, all suspend states are advertised as valid
> + *         in /sys/power/state (but can still be rejected by prepare or =
enter.)
> + * @prepare: Prepare the platform for the given suspend state. Can retur=
n a
> + *           negative error code if necessary.
> + * @enter: Enter the given suspend state, must be assigned. Can return a
> + *         negative error code if necessary.
> + * @finish: Called when the system has left the given state and all devi=
ces
> + *          are resumed. The return value is ignored.
> + * @pm_disk_mode: Set to the disk method that the user should be able to
> + *                configure for suspend-to-disk. Since %PM_DISK_SHUTDOWN,
> + *                %PM_DISK_REBOOT, %PM_DISK_TEST and %PM_DISK_TESTPROC
> + *                are always allowed, currently only %PM_DISK_PLATFORM
> + *                makes sense. If the user then choses %PM_DISK_PLATFORM,
> + *                the @prepare call will be called before suspending to =
disk
> + *                (if present), the @enter call should be present and wi=
ll
> + *                be called after all state has been saved and the machi=
ne
> + *                is ready to be shut down/suspended/..., and the @finish
> + *                callback is called after state has been restored. All
> + *                these calls are called with %PM_SUSPEND_DISK as the st=
ate.

We usually just indent the following lines the same for all function
parameters or struct members.

> + */
>  struct pm_ops {
> -	suspend_disk_method_t pm_disk_mode;
>  	int (*valid)(suspend_state_t state);
>  	int (*prepare)(suspend_state_t state);
>  	int (*enter)(suspend_state_t state);
>  	int (*finish)(suspend_state_t state);
> +	suspend_disk_method_t pm_disk_mode;
>  };


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
