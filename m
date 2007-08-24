From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -mm 2/2] Hibernation: Arbitrary boot kernel
 support on x86_64
Date: Fri, 24 Aug 2007 16:23:46 -0700
Message-ID: <20070824162346.ec57f508.akpm@linux-foundation.org>
References: <200708241206.57178.rjw@sisk.pl> <200708241211.55319.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708241211.55319.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel@smtp2.linux-foundation.org, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 24 Aug 2007 12:11:54 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Index: linux-2.6.23-rc3/include/asm-x86_64/suspend.h
> ===================================================================
> --- linux-2.6.23-rc3.orig/include/asm-x86_64/suspend.h	2007-08-21 20:36:49.000000000 +0200
> +++ linux-2.6.23-rc3/include/asm-x86_64/suspend.h	2007-08-21 20:37:47.000000000 +0200
> @@ -43,4 +43,10 @@ extern void fix_processor_context(void);
>  /* routines for saving/restoring kernel state */
>  extern int acpi_save_state_mem(void);
>  
> +#define ARCH_HAS_HIBERNATION_HEADER

The preferred way of doing this is via Kconfig, please.  ie: add a
CONFIG_HIBERNATION_HEADER to arch/x86_64/Kconfig.

> +
> +/* arch/x86_64/kernel/suspend.c */
> +extern int arch_hibernation_header_save(void *addr, unsigned int max_size);
> +extern int arch_hibernation_header_restore(void *addr);

Given that these are called from non-arch-specific code, they must have the
same signature across all architectures.  So there's no point in putting
the prototypes into an arch-specific header file.

It would be better to do something like this in (say) suspend.h:

#ifdef CONFIG_HIBERNATION_HEADER
extern int arch_hibernation_header_save(void *addr, unsigned int max_size);
extern int arch_hibernation_header_restore(void *addr);
#else
static inline int arch_hibernation_header_save(void *addr,
						unsigned int max_size)
{
	return 0;
}

static inline int arch_hibernation_header_restore(void *addr)
{
	return 0;
}
#endif

then go nuke some ifdefs from the .c files.
