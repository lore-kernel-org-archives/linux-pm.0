From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/1] Add /sys/power/last_state support
Date: Mon, 7 Dec 2009 22:41:27 +0100
Message-ID: <200912072241.28017.rjw@sisk.pl>
References: <3c192bd846cc4337d9999c6cd66b649232d9561c.1260074113.git.victor.lowther@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <3c192bd846cc4337d9999c6cd66b649232d9561c.1260074113.git.victor.lowther@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Victor Lowther <victor.lowther@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 06 December 2009, you wrote:
> Hi, I have a completly unsolicited patch that I figured I should run past you
> before proceeding to embarrass myself on lkml, as there does not seem to be 
> a linux kernel related mailing list more dedicated to power management.

There is a pm list, <linux-pm@lists.linux-foundation.org>.  Please post patches
to this list in the future rather than to me directly, because I have rather
limited patch-reviewing capacity.

> This patch just adds /sys/power/last_state, which will make my job making
> pm-utils more robust in the face of suspend or hibernate failure a little
> easier. 
>
> last_state will contain the last suspend state the kernel successfully
> resumed from.  This sysfs interface was added so that userspace tools
> (such as pm-utils) can determine whether the last requested power management
> operation succeeded or failed without having to listen to uevents (a tricky
> proposition when you are written in shell script), or parse the kernel event
> log (annoying when most of the time things will succeed anyways).

What exactly do you need the previous state for?

Can't you just use the error code returned by "echo mem > /sys/power/state"?

Rafael


> Signed-off-by:  Victor Lowther <victor.lowther@gmail.com>
> ---
>  Documentation/power/interface.txt |    7 +++++++
>  kernel/power/hibernate.c          |    2 ++
>  kernel/power/main.c               |   32 ++++++++++++++++++++++++++++++++
>  kernel/power/power.h              |    1 +
>  kernel/power/suspend.c            |    1 +
>  5 files changed, 43 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/power/interface.txt b/Documentation/power/interface.txt
> index e67211f..5903de0 100644
> --- a/Documentation/power/interface.txt
> +++ b/Documentation/power/interface.txt
> @@ -16,6 +16,13 @@ transition into that state. Please see the file
>  Documentation/power/states.txt for a description of each of those
>  states.
>  
> +/sys/power/last_state reports the last state the system sucessfully
> +transitioned from.  It holds the same values that /sys/power/state takes.
> +If you have never transitioned from a power state, or the last transition
> +failed for some reason, it will contain the string "none".
> +
> +Writing this file will reset it to the default value of "none"
> +
>  
>  /sys/power/disk controls the operating mode of the suspend-to-disk
>  mechanism. Suspend-to-disk can be handled in several ways. We have a
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 04a9e90..168be07 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -324,6 +324,8 @@ int hibernation_snapshot(int platform_mode)
>  	resume_console();
>   Close:
>  	platform_end(platform_mode);
> +	if (!in_suspend)
> +	        snprintf(last_suspend_state,8,"disk");
>  	return error;
>  
>   Recover_platform:
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 347d2cc..200948a 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -19,6 +19,7 @@ DEFINE_MUTEX(pm_mutex);
>  
>  unsigned int pm_flags;
>  EXPORT_SYMBOL(pm_flags);
> +char last_suspend_state[8];
>  
>  #ifdef CONFIG_PM_SLEEP
>  
> @@ -111,6 +112,33 @@ power_attr(pm_test);
>  
>  struct kobject *power_kobj;
>  
> +/**     last_state - retrieve the last power state
> + *      show() returns the most recent state the system sucessfully entered.
> + *      Its value is whatever was last accepted by state_store()
> + *
> + *      store() discards its arguments and sets the last power state back to
> + *      'none'
> + */
> +
> +static ssize_t last_state_show(struct kobject *kobj,
> +			       struct kobj_attribute *attr,
> +			       char *buf)
> +{
> +        snprintf(buf, 9, "%s\n",last_suspend_state);
> +	return (strlen(last_suspend_state) + 1);
> +}
> +
> +static ssize_t last_state_store(struct kobject *kobj,
> +				struct kobj_attribute *attr,
> +				const char *buf,
> +				size_t n)
> +{
> +        snprintf(last_suspend_state, 8, "%s","none");
> +        return n;
> +}
> +
> +power_attr(last_state);
> +
>  /**
>   *	state - control system power state.
>   *
> @@ -173,6 +201,8 @@ static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
>  #endif
>  
>   Exit:
> +	if (error)
> +	        snprintf(last_suspend_state,8,"none");
>  	return error ? error : n;
>  }
>  
> @@ -211,6 +241,7 @@ static struct attribute * g[] = {
>  #if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PM_DEBUG)
>  	&pm_test_attr.attr,
>  #endif
> +	&last_state_attr.attr,
>  	NULL,
>  };
>  
> @@ -234,6 +265,7 @@ static inline int pm_start_workqueue(void) { return 0; }
>  static int __init pm_init(void)
>  {
>  	int error = pm_start_workqueue();
> +	snprintf(last_suspend_state,8,"none");
>  	if (error)
>  		return error;
>  	power_kobj = kobject_create_and_add("power", NULL);
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 46c5a26..db267a3 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -68,6 +68,7 @@ extern unsigned long image_size;
>  extern int in_suspend;
>  extern dev_t swsusp_resume_device;
>  extern sector_t swsusp_resume_block;
> +extern char last_suspend_state[8];
>  
>  extern asmlinkage int swsusp_arch_suspend(void);
>  extern asmlinkage int swsusp_arch_resume(void);
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 6f10dfc..cebdf6f 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -210,6 +210,7 @@ int suspend_devices_and_enter(suspend_state_t state)
>  		goto Recover_platform;
>  
>  	suspend_enter(state);
> +	snprintf(last_suspend_state,8,pm_states[state]);
>  
>   Resume_devices:
>  	suspend_test_start();
> 
