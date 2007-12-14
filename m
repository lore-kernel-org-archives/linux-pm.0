From: Len Brown <lenb@kernel.org>
Subject: Re: + git-acpi-build-fix.patch added to -mm tree
Date: Thu, 13 Dec 2007 20:27:31 -0500
Message-ID: <200712132027.31477.lenb__2872.45790609649$1197595753$gmane$org@kernel.org>
References: <200712130343.lBD3hAmY011894@imap1.linux-foundation.org>
	<200712140107.13630.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712140107.13630.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, akpm@linux-foundation.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 13 December 2007 19:07, Rafael J. Wysocki wrote:
> On Thursday, 13 of December 2007, akpm@linux-foundation.org wrote:
> > 
> > The patch titled
> >      git-acpi build fix
> > has been added to the -mm tree.  Its filename is
> >      git-acpi-build-fix.patch
> > 
> > *** Remember to use Documentation/SubmitChecklist when testing your code ***
> > 
> > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> > out what to do about this
> > 
> > ------------------------------------------------------
> > Subject: git-acpi build fix
> > From: Andrew Morton <akpm@linux-foundation.org>
> > 
> > ia64 allmodconfig:

ah, good to know that ia64 allmodconfig is supposed to build.
A while back it looked so hopeless that I deleted it from
my test builds and it never got back onto my list.

I guess I should kick off an ia64 allyesconfig and see how that does too...

> > kernel/power/main.c:493: error: `pm_test_attr' undeclared here (not in a function)
> > 
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> > 
> >  kernel/power/main.c |    3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff -puN kernel/power/main.c~git-acpi-build-fix kernel/power/main.c
> > --- a/kernel/power/main.c~git-acpi-build-fix
> > +++ a/kernel/power/main.c
> > @@ -489,9 +489,6 @@ static struct attribute * g[] = {
> >  #ifdef CONFIG_PM_TRACE
> >  	&pm_trace_attr.attr,
> >  #endif
> > -#ifdef CONFIG_PM_DEBUG
> > -	&pm_test_attr.attr,
> > -#endif
> 
> Doesn't it kill pm_test_attr on all architectures?
> 
> The proper (hopefully) fix is appended (Len, please add it to the suspend
> branch).
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Fix compilation problems related to the /sys/power/pm_test attribute.
> Namely, this attribute should also be available when
> CONFIG_HIBERNATION is set and CONFIG_SUSPEND is unset and it should
> not break compilation when neither of them is set.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/main.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Index: linux-2.6/kernel/power/main.c
> ===================================================================
> --- linux-2.6.orig/kernel/power/main.c
> +++ linux-2.6/kernel/power/main.c
> @@ -50,10 +50,6 @@ int pm_notifier_call_chain(unsigned long
>  			== NOTIFY_BAD) ? -EINVAL : 0;
>  }
>  
> -#endif /* CONFIG_PM_SLEEP */
> -
> -#ifdef CONFIG_SUSPEND
> -
>  #ifdef CONFIG_PM_DEBUG
>  int pm_test_level = TEST_NONE;
>  
> @@ -127,6 +123,10 @@ power_attr(pm_test);
>  static inline int suspend_test(int level) { return 0; }
>  #endif /* !CONFIG_PM_DEBUG */
>  
> +#endif /* CONFIG_PM_SLEEP */
> +
> +#ifdef CONFIG_SUSPEND
> +
>  /* This is just an arbitrary number */
>  #define FREE_PAGE_NUMBER (100)
>  
> @@ -484,7 +484,7 @@ static struct attribute * g[] = {
>  #ifdef CONFIG_PM_TRACE
>  	&pm_trace_attr.attr,
>  #endif
> -#ifdef CONFIG_PM_DEBUG
> +#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_PM_DEBUG)
>  	&pm_test_attr.attr,
>  #endif
>  	NULL,
> 

Applied.
thanks,
-Len
