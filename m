From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH 1/2] cpufreq: Improve debug prints
Date: Thu, 25 Oct 2012 00:00:03 +0200
Message-ID: <1952796.OHncReY41t@vostro.rjw.lan>
References: <3b38cb8ab136e5af3a70fceb7d77ad9fc889eb3f.1350451100.git.viresh.kumar@linaro.org>
	<1350455212.3072.27.camel@joe-AO722>
	<CAKohpo=fgz98F+1SBG9TgO0EsPd_XLznJ0Z__0ehsgm14EZK7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAKohpo=fgz98F+1SBG9TgO0EsPd_XLznJ0Z__0ehsgm14EZK7A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pdsw-power-team-5wv7dgnIgG8@public.gmane.org, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 17 of October 2012 12:03:31 Viresh Kumar wrote:
> On 17 October 2012 11:56, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org> wrote:
> > Oh good, but please use a space between KBUILD_MODNAME
> > and the quoted ": ".
> 
> Anything technical behind it or just for code formatting? As output is
> same in both cases :)
> 
> ------------------------8<----------------------8<-------------------
> 
> From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Date: Wed, 17 Oct 2012 10:38:31 +0530
> Subject: [PATCH] cpufreq: Improve debug prints
> 
> With debug options on, it is difficult to locate cpufreq core's debug prints.
> Fix this by prefixing debug prints with KBUILD_MODNAME.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>


Applied to linux-pm.git/linux-next as v3.8 material.

Thanks,
Rafael


> ---
>  drivers/cpufreq/cpufreq.c             | 2 ++
>  drivers/cpufreq/cpufreq_performance.c | 2 ++
>  drivers/cpufreq/cpufreq_powersave.c   | 2 ++
>  drivers/cpufreq/cpufreq_userspace.c   | 2 ++
>  drivers/cpufreq/freq_table.c          | 2 ++
>  5 files changed, 10 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index db6e337..85df538 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -15,6 +15,8 @@
>   *
>   */
> 
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> diff --git a/drivers/cpufreq/cpufreq_performance.c
> b/drivers/cpufreq/cpufreq_performance.c
> index f13a8a9..ceee068 100644
> --- a/drivers/cpufreq/cpufreq_performance.c
> +++ b/drivers/cpufreq/cpufreq_performance.c
> @@ -10,6 +10,8 @@
>   *
>   */
> 
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/cpufreq.h>
> diff --git a/drivers/cpufreq/cpufreq_powersave.c
> b/drivers/cpufreq/cpufreq_powersave.c
> index 4c2eb51..2d948a1 100644
> --- a/drivers/cpufreq/cpufreq_powersave.c
> +++ b/drivers/cpufreq/cpufreq_powersave.c
> @@ -10,6 +10,8 @@
>   *
>   */
> 
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/cpufreq.h>
> diff --git a/drivers/cpufreq/cpufreq_userspace.c
> b/drivers/cpufreq/cpufreq_userspace.c
> index bedac1a..c8c3d29 100644
> --- a/drivers/cpufreq/cpufreq_userspace.c
> +++ b/drivers/cpufreq/cpufreq_userspace.c
> @@ -11,6 +11,8 @@
>   *
>   */
> 
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/smp.h>
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 90431cb..49cda25 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -9,6 +9,8 @@
>   *
>   */
> 
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
