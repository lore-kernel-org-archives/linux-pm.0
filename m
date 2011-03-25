From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v3 4/5] PM: Add visible HIBERNATION_INTERFACE
	and hide HIBERNATION
Date: Fri, 25 Mar 2011 23:35:42 +0100
Message-ID: <201103252335.43131.rjw__5201.11688315428$1301092734$gmane$org@sisk.pl>
References: <1299906471-31011-1-git-send-email-rshriram@cs.ubc.ca>
	<AANLkTikEKiQdVA8025xbAdpDsNWmoDwaq2WUuxuLSeLU@mail.gmail.com>
	<AANLkTi=_iPbpgFZ7BeKBgeO_++hWZaDLO005+VEQh-OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=_iPbpgFZ7BeKBgeO_++hWZaDLO005+VEQh-OQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rshriram@cs.ubc.ca
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com
List-Id: linux-pm@vger.kernel.org

On Friday, March 25, 2011, Shriram Rajagopalan wrote:
> On Sat, Mar 19, 2011 at 6:25 PM, Shriram Rajagopalan <rshriram@cs.ubc.ca>wrote:
> 
> > On Fri, Mar 18, 2011 at 2:36 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> >> On Wednesday, March 16, 2011, Rafael J. Wysocki wrote:
> >> > On Tuesday, March 15, 2011, Shriram Rajagopalan wrote:
> >> > > 2011/3/15 Rafael J. Wysocki <rjw@sisk.pl>:
> >> ...
> >> >
> >> > Basically, I can do the patch for you, but that'll take some time.
> >> > Stay tuned. :-)
> >>
> >> The patch below appears to work for me, please check if it works
> >> for you when you put the Xen patch selecting HIBERNATION on top
> >> of it.
> >>
> >> Thanks,
> >> Rafael
> >>
> >> ---
> >>  arch/x86/power/Makefile |    3 ++-
> >>  include/linux/suspend.h |   15 +++++----------
> >>  kernel/power/Kconfig    |    4 ++++
> >>  kernel/power/Makefile   |    4 ++--
> >>  kernel/power/main.c     |    2 +-
> >>  kernel/power/power.h    |    6 +++---
> >>  6 files changed, 17 insertions(+), 17 deletions(-)
> >>
> >> Index: linux-2.6/kernel/power/Kconfig
> >> ===================================================================
> >> --- linux-2.6.orig/kernel/power/Kconfig
> >> +++ linux-2.6/kernel/power/Kconfig
> >> @@ -19,8 +19,12 @@ config SUSPEND_FREEZER
> >>           Turning OFF this setting is NOT recommended! If in doubt, say Y.
> >>
> >>  config HIBERNATION
> >> +       bool
> >> +
> >> +config HIBERNATE_INTERFACE
> >>         bool "Hibernation (aka 'suspend to disk')"
> >>         depends on SWAP && ARCH_HIBERNATION_POSSIBLE
> >> +       select HIBERNATION
> >>         select LZO_COMPRESS
> >>        select LZO_DECOMPRESS
> >>         ---help---
> >> Index: linux-2.6/kernel/power/Makefile
> >> ===================================================================
> >> --- linux-2.6.orig/kernel/power/Makefile
> >> +++ linux-2.6/kernel/power/Makefile
> >> @@ -5,7 +5,7 @@ obj-$(CONFIG_PM_SLEEP)          += console.o
> >>  obj-$(CONFIG_FREEZER)          += process.o
> >>  obj-$(CONFIG_SUSPEND)          += suspend.o
> >>  obj-$(CONFIG_PM_TEST_SUSPEND)  += suspend_test.o
> >> -obj-$(CONFIG_HIBERNATION)      += hibernate.o snapshot.o swap.o user.o \
> >> -                                  block_io.o
> >> +obj-$(CONFIG_HIBERNATE_INTERFACE)      += hibernate.o snapshot.o swap.o \
> >> +                                               user.o block_io.o
> >>
> >>  obj-$(CONFIG_MAGIC_SYSRQ)      += poweroff.o
> >> Index: linux-2.6/include/linux/suspend.h
> >> ===================================================================
> >> --- linux-2.6.orig/include/linux/suspend.h
> >> +++ linux-2.6/include/linux/suspend.h
> >> @@ -229,7 +229,7 @@ struct platform_hibernation_ops {
> >>        void (*recover)(void);
> >>  };
> >>
> >> -#ifdef CONFIG_HIBERNATION
> >> +#ifdef CONFIG_HIBERNATE_INTERFACE
> >>  /* kernel/power/snapshot.c */
> >>  extern void __register_nosave_region(unsigned long b, unsigned long e,
> >> int km);
> >>  static inline void __init register_nosave_region(unsigned long b,
> >> unsigned long e)
> >> @@ -248,7 +248,9 @@ extern unsigned long get_safe_page(gfp_t
> >>  extern void hibernation_set_ops(const struct platform_hibernation_ops
> >> *ops);
> >>  extern int hibernate(void);
> >>  extern bool system_entering_hibernation(void);
> >> -#else /* CONFIG_HIBERNATION */
> >> +#else /* !CONFIG_HIBERNATE_INTERFACE */
> >> +static inline void register_nosave_region(unsigned long b, unsigned long
> >> e) {}
> >> +static inline void register_nosave_region_late(unsigned long b, unsigned
> >> long e) {}
> >>  static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
> >>  static inline void swsusp_set_page_free(struct page *p) {}
> >>  static inline void swsusp_unset_page_free(struct page *p) {}
> >> @@ -256,7 +258,7 @@ static inline void swsusp_unset_page_fre
> >>  static inline void hibernation_set_ops(const struct
> >> platform_hibernation_ops *ops) {}
> >>  static inline int hibernate(void) { return -ENOSYS; }
> >>  static inline bool system_entering_hibernation(void) { return false; }
> >> -#endif /* CONFIG_HIBERNATION */
> >> +#endif /* !CONFIG_HIBERNATE_INTERFACE */
> >>
> >>  #ifdef CONFIG_PM_SLEEP
> >>  void save_processor_state(void);
> >> @@ -298,13 +300,6 @@ static inline bool pm_wakeup_pending(voi
> >>  extern struct mutex pm_mutex;
> >>
> >>  #ifndef CONFIG_HIBERNATION
> >> -static inline void register_nosave_region(unsigned long b, unsigned long
> >> e)
> >> -{
> >> -}
> >> -static inline void register_nosave_region_late(unsigned long b, unsigned
> >> long e)
> >> -{
> >> -}
> >> -
> >>  static inline void lock_system_sleep(void) {}
> >>  static inline void unlock_system_sleep(void) {}
> >>
> >> Index: linux-2.6/arch/x86/power/Makefile
> >> ===================================================================
> >> --- linux-2.6.orig/arch/x86/power/Makefile
> >> +++ linux-2.6/arch/x86/power/Makefile
> >> @@ -4,4 +4,5 @@ nostackp := $(call cc-option, -fno-stack
> >>  CFLAGS_cpu.o   := $(nostackp)
> >>
> >>  obj-$(CONFIG_PM_SLEEP)         += cpu.o
> >> -obj-$(CONFIG_HIBERNATION)      += hibernate_$(BITS).o
> >> hibernate_asm_$(BITS).o
> >> +obj-$(CONFIG_HIBERNATE_INTERFACE)      += hibernate_$(BITS).o \
> >> +                                               hibernate_asm_$(BITS).o
> >> Index: linux-2.6/kernel/power/main.c
> >> ===================================================================
> >> --- linux-2.6.orig/kernel/power/main.c
> >> +++ linux-2.6/kernel/power/main.c
> >> @@ -156,7 +156,7 @@ static ssize_t state_show(struct kobject
> >>                         s += sprintf(s,"%s ", pm_states[i]);
> >>        }
> >>  #endif
> >> -#ifdef CONFIG_HIBERNATION
> >> +#ifdef CONFIG_HIBERNATE_INTERFACE
> >>         s += sprintf(s, "%s\n", "disk");
> >>  #else
> >>        if (s != buf)
> >> Index: linux-2.6/kernel/power/power.h
> >> ===================================================================
> >> --- linux-2.6.orig/kernel/power/power.h
> >> +++ linux-2.6/kernel/power/power.h
> >> @@ -13,7 +13,7 @@ struct swsusp_info {
> >>        unsigned long           size;
> >>  } __attribute__((aligned(PAGE_SIZE)));
> >>
> >> -#ifdef CONFIG_HIBERNATION
> >> +#ifdef CONFIG_HIBERNATE_INTERFACE
> >>  /* kernel/power/snapshot.c */
> >>  extern void __init hibernate_image_size_init(void);
> >>
> >> @@ -53,10 +53,10 @@ extern int hibernation_snapshot(int plat
> >>  extern int hibernation_restore(int platform_mode);
> >>  extern int hibernation_platform_enter(void);
> >>
> >> -#else /* !CONFIG_HIBERNATION */
> >> +#else /* !CONFIG_HIBERNATE_INTERFACE */
> >>
> >>  static inline void hibernate_image_size_init(void) {}
> >> -#endif /* !CONFIG_HIBERNATION */
> >> +#endif /* !CONFIG_HIBERNATE_INTERFACE */
> >>
> >>  extern int pfn_is_nosave(unsigned long);
> >>
> >>
> >> The code compiles perfectly. However, I am not able to test it
> > in my installation (cant seem to boot a PV kernel - nothing to do
> > with your patch).
> > Will respond once I get the boot issue sorted.
> >
> > shriram
> >
> Hi,
> sorry for the delay. I finally managed to get my system back in
> one piece.
> 
> So the patch you sent works perfectly. I tested xen save/restore with
> both HIBERNATE_INTERFACE enabled and disabled. When disabled,
> I dont see sys/power/disk.. (as expected).

Cool. :-)

> so how do you want to go about these two patches? I am ok with you
> pushing "4/5 Add visible HIBERNATE_INTERFACE..." under your own
> authorship (as you did the refactoring anyway :) ). That way, you would
> just have to take "5/5 fix XEN_SAVE_RESTORE Kconfig dependencies".

I will push my patch to Linus, but quite likely after -rc1, since I've just
prepared a pull request I'm going to send later today.

I'll add your Tested-by to the patch if you don't mind.

Thanks,
Rafael
