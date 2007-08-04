From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] PM: Fix dependencies of CONFIG_SUSPEND and
	CONFIG_HIBERNATION
Date: Fri, 3 Aug 2007 23:45:31 -0400
Message-ID: <200708032345.32262.lenb@kernel.org>
References: <200708032359.37677.rjw@sisk.pl>
	<alpine.LFD.0.999.0708031459090.8184@woody.linux-foundation.org>
	<200708040047.35180.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708040047.35180.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 03 August 2007 18:47, Rafael J. Wysocki wrote:
> On Saturday, 4 August 2007 00:01, Linus Torvalds wrote:
> > 
> > On Fri, 3 Aug 2007, Rafael J. Wysocki wrote:
> > >  	depends on PM
> > > -	depends on !SMP || SUSPEND_SMP_POSSIBLE
> > > +	depends on SUSPEND_SMP_POSSIBLE || ((BLACKFIN || MIPS || SUPERH || FRV \
> > > +		    || (PPC32 && PPC_MPC52xx)) && !SMP)
> > 
> > Please, do that as SUSPEND_UP_POSSIBLE, and make it look like
> > 
> > 	config SUSPEND_UP_POSSIBLE
> > 		depends on BLACKFIN || MIPS || SUPERH || FRV || ((PPC32 && PPC_MPC52xx)
> > 		depends on !SMP
> > 		default y
> 
> OK
> 
> > and now you can write the above thing as
> > 
> > 	depends on SUSPEND_SMP_POSSIBLE || SUSPEND_UP_POSSIBLE
> > 
> > and it's all much nicer.
> > 
> > I would say that doing a similar setup for HIBERNATE would be nice too,
> > but the SUSPEND case is more noticeable because the SMP case is so nice 
> > already.
> 
> I did it symmetrically for suspend and hibernation and renamed SUSPEND_SMP to
> PM_SLEEP_SMP.  Patch follows.
> 
> Greetings,
> Rafael
> 
> 
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Dependencies of CONFIG_SUSPEND and CONFIG_HIBERNATION introduced by commit
> 296699de6bdc717189a331ab6bbe90e05c94db06 "Introduce CONFIG_SUSPEND for
> suspend-to-Ram and standby" are incorrect, as they don't cover the facts that
> (1) not all architectures support suspend and (2) SMP hibernation is only
> possible on X86 and PPC64 (if PPC64_SWSUSP is set).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  kernel/power/Kconfig |   40 ++++++++++++++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 10 deletions(-)
> 
> Index: linux-2.6/kernel/power/Kconfig
> ===================================================================
> --- linux-2.6.orig/kernel/power/Kconfig	2007-07-30 07:58:48.000000000 +0200
> +++ linux-2.6/kernel/power/Kconfig	2007-08-04 00:39:21.000000000 +0200
> @@ -72,15 +72,10 @@ config PM_TRACE
>  	CAUTION: this option will cause your machine's real-time clock to be
>  	set to an invalid time after a resume.
>  
> -config SUSPEND_SMP_POSSIBLE
> -	bool
> -	depends on (X86 && !X86_VOYAGER) || (PPC64 && (PPC_PSERIES || PPC_PMAC))
> -	depends on SMP
> -	default y
> -
> -config SUSPEND_SMP
> +config PM_SLEEP_SMP
>  	bool
> -	depends on SUSPEND_SMP_POSSIBLE && PM_SLEEP
> +	depends on SUSPEND_SMP_POSSIBLE || HIBERNATION_SMP_POSSIBLE
> +	depends on PM_SLEEP
>  	select HOTPLUG_CPU
>  	default y
>  
> @@ -89,20 +84,45 @@ config PM_SLEEP
>  	depends on SUSPEND || HIBERNATION
>  	default y
>  
> +config SUSPEND_UP_POSSIBLE
> +	bool
> +	depends on BLACKFIN || MIPS || SUPERH || FRV || (PPC32 && PPC_MPC52xx)

please include (X86 && !X86_VOYAGER) here -- else you'll disable
SUSPEND from all X86 when built UP.

thanks,
-Len
