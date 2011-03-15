From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v3 4/5] PM: Add visible HIBERNATION_INTERFACE
	and hide HIBERNATION
Date: Tue, 15 Mar 2011 22:38:29 +0100
Message-ID: <201103152238.29405.rjw__4275.41977628625$1300225254$gmane$org@sisk.pl>
References: <1299906471-31011-1-git-send-email-rshriram@cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1299906471-31011-1-git-send-email-rshriram@cs.ubc.ca>
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
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com
List-Id: linux-pm@vger.kernel.org

Hi,

Sorry, I didn't have the time to review the patch in detail before.

On Saturday, March 12, 2011, Shriram Rajagopalan wrote:
> HIBERNATION covers the main hibernation control code and freeze-thaw
> pm events, that xen's save/restore also uses. Explicitly enabling
> an independant hibernation functionality to enable xen's save/restore
> is a bit ugly. Define a new user visible symbol HIBERNATION_INTERFACE
> that "selects" HIBERNATION and covers the main hibernation control code
> instead of HIBERNATION. This way, we can also make XEN_SAVE_RESTORE
> "select" HIBERNATION, enabling only the freeze-thaw code.
> 
> Signed-off-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
> ---
>  kernel/power/Kconfig     |    9 +++++++--
>  kernel/power/hibernate.c |    4 ++++
>  kernel/power/main.c      |    2 +-
>  kernel/power/user.c      |    2 ++
>  4 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 4603f08..493c678 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -19,10 +19,15 @@ config SUSPEND_FREEZER
>  	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
>  
>  config HIBERNATION
> -	bool "Hibernation (aka 'suspend to disk')"
> -	depends on SWAP && ARCH_HIBERNATION_POSSIBLE
> +	def_bool n

You don't need that.  Simply use "bool"

> +	depends on ARCH_HIBERNATION_POSSIBLE

That need not depend on it, HIBERNATION_INTERFACE should instead.

>  	select LZO_COMPRESS
>  	select LZO_DECOMPRESS

These two selects may be moved to HIBERNATION_INTERFACE too.

> +
> +config HIBERNATION_INTERFACE
> +	bool "Hibernation (aka 'suspend to disk')"
> +	depends on SWAP
> +	select HIBERNATION
>  	---help---
>  	  Enable the suspend to disk (STD) functionality, which is usually
>  	  called "hibernation" in user interfaces.  STD checkpoints the
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 1832bd2..13bcf69 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -592,6 +592,7 @@ static int prepare_processes(void)
>   *	hibernate - The granpappy of the built-in hibernation management
>   */
>  
> +#ifdef CONFIG_HIBERNATION_INTERFACE

Please don't do that.  Please make the whole hibernate.c depend on
CONFIG_HIBERNATION_INTERFACE.

>  int hibernate(void)
>  {
>  	int error;
> @@ -667,6 +668,8 @@ int hibernate(void)
>  	return error;
>  }
>  
> +#else /* !CONFIG_HIBERNATION_INTERFACE */
> +int hibernate(void) { return -ENOSYS; }

And move that to a header.

>  /**
>   *	software_resume - Resume from a saved image.
> @@ -1029,3 +1032,4 @@ __setup("noresume", noresume_setup);
>  __setup("resume_offset=", resume_offset_setup);
>  __setup("resume=", resume_setup);
>  __setup("hibernate=", hibernate_setup);
> +#endif /* !CONFIG_HIBERNATION_INTERFACE */
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 8eaba5f..686a130 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -156,7 +156,7 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			s += sprintf(s,"%s ", pm_states[i]);
>  	}
>  #endif
> -#ifdef CONFIG_HIBERNATION
> +#ifdef CONFIG_HIBERNATION_INTERFACE
>  	s += sprintf(s, "%s\n", "disk");
>  #else
>  	if (s != buf)
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index c36c3b9..5f36ee7 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -458,6 +458,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
>  	return error;
>  }
>  
> +#ifdef CONFIG_HIBERNATION_INTERFACE
>  static const struct file_operations snapshot_fops = {
>  	.open = snapshot_open,
>  	.release = snapshot_release,
> @@ -479,3 +480,4 @@ static int __init snapshot_device_init(void)
>  };
>  
>  device_initcall(snapshot_device_init);
> +#endif /* CONFIG_HIBERNATION_INTERFACE */
> 

Again, please make the entire user.c depend on CONFIG_HIBERNATION_INTERFACE
instead of adding #ifdefs to the file.

Thanks,
Rafael
