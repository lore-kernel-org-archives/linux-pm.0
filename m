From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: Re: [PATCH v3 4/5] PM: Add visible HIBERNATION_INTERFACE
 and hide HIBERNATION
Date: Fri, 25 Mar 2011 15:41:09 -0700
Message-ID: <AANLkTinVNXHiVD9_MBHCJ2sSHPQV_UKpAH=2WeeOzmHX__4632.88209070942$1301092982$gmane$org@mail.gmail.com>
References: <1299906471-31011-1-git-send-email-rshriram@cs.ubc.ca>
	<AANLkTikEKiQdVA8025xbAdpDsNWmoDwaq2WUuxuLSeLU@mail.gmail.com>
	<AANLkTi=_iPbpgFZ7BeKBgeO_++hWZaDLO005+VEQh-OQ@mail.gmail.com>
	<201103252335.43131.rjw@sisk.pl>
Reply-To: rshriram@cs.ubc.ca
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5835513009598858103=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103252335.43131.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com
List-Id: linux-pm@vger.kernel.org

--===============5835513009598858103==
Content-Type: multipart/alternative; boundary=0016e6470e64ab1535049f564ca2

--0016e6470e64ab1535049f564ca2
Content-Type: text/plain; charset=ISO-8859-1

2011/3/25 Rafael J. Wysocki <rjw@sisk.pl>

> On Friday, March 25, 2011, Shriram Rajagopalan wrote:
> > On Sat, Mar 19, 2011 at 6:25 PM, Shriram Rajagopalan <rshriram@cs.ubc.ca
> >wrote:
> >
> > > On Fri, Mar 18, 2011 at 2:36 PM, Rafael J. Wysocki <rjw@sisk.pl>
> wrote:
> > >
> > >> On Wednesday, March 16, 2011, Rafael J. Wysocki wrote:
> > >> > On Tuesday, March 15, 2011, Shriram Rajagopalan wrote:
> > >> > > 2011/3/15 Rafael J. Wysocki <rjw@sisk.pl>:
> > >> ...
> > >> >
> > >> > Basically, I can do the patch for you, but that'll take some time.
> > >> > Stay tuned. :-)
> > >>
> > >> The patch below appears to work for me, please check if it works
> > >> for you when you put the Xen patch selecting HIBERNATION on top
> > >> of it.
> > >>
> > >> Thanks,
> > >> Rafael
> > >>
> > >> ---
> > >>  arch/x86/power/Makefile |    3 ++-
> > >>  include/linux/suspend.h |   15 +++++----------
> > >>  kernel/power/Kconfig    |    4 ++++
> > >>  kernel/power/Makefile   |    4 ++--
> > >>  kernel/power/main.c     |    2 +-
> > >>  kernel/power/power.h    |    6 +++---
> > >>  6 files changed, 17 insertions(+), 17 deletions(-)
> > >>
> > >> Index: linux-2.6/kernel/power/Kconfig
> > >> ===================================================================
> > >> --- linux-2.6.orig/kernel/power/Kconfig
> > >> +++ linux-2.6/kernel/power/Kconfig
> > >> @@ -19,8 +19,12 @@ config SUSPEND_FREEZER
> > >>           Turning OFF this setting is NOT recommended! If in doubt,
> say Y.
> > >>
> > >>  config HIBERNATION
> > >> +       bool
> > >> +
> > >> +config HIBERNATE_INTERFACE
> > >>         bool "Hibernation (aka 'suspend to disk')"
> > >>         depends on SWAP && ARCH_HIBERNATION_POSSIBLE
> > >> +       select HIBERNATION
> > >>         select LZO_COMPRESS
> > >>        select LZO_DECOMPRESS
> > >>         ---help---
> > >> Index: linux-2.6/kernel/power/Makefile
> > >> ===================================================================
> > >> --- linux-2.6.orig/kernel/power/Makefile
> > >> +++ linux-2.6/kernel/power/Makefile
> > >> @@ -5,7 +5,7 @@ obj-$(CONFIG_PM_SLEEP)          += console.o
> > >>  obj-$(CONFIG_FREEZER)          += process.o
> > >>  obj-$(CONFIG_SUSPEND)          += suspend.o
> > >>  obj-$(CONFIG_PM_TEST_SUSPEND)  += suspend_test.o
> > >> -obj-$(CONFIG_HIBERNATION)      += hibernate.o snapshot.o swap.o
> user.o \
> > >> -                                  block_io.o
> > >> +obj-$(CONFIG_HIBERNATE_INTERFACE)      += hibernate.o snapshot.o
> swap.o \
> > >> +                                               user.o block_io.o
> > >>
> > >>  obj-$(CONFIG_MAGIC_SYSRQ)      += poweroff.o
> > >> Index: linux-2.6/include/linux/suspend.h
> > >> ===================================================================
> > >> --- linux-2.6.orig/include/linux/suspend.h
> > >> +++ linux-2.6/include/linux/suspend.h
> > >> @@ -229,7 +229,7 @@ struct platform_hibernation_ops {
> > >>        void (*recover)(void);
> > >>  };
> > >>
> > >> -#ifdef CONFIG_HIBERNATION
> > >> +#ifdef CONFIG_HIBERNATE_INTERFACE
> > >>  /* kernel/power/snapshot.c */
> > >>  extern void __register_nosave_region(unsigned long b, unsigned long
> e,
> > >> int km);
> > >>  static inline void __init register_nosave_region(unsigned long b,
> > >> unsigned long e)
> > >> @@ -248,7 +248,9 @@ extern unsigned long get_safe_page(gfp_t
> > >>  extern void hibernation_set_ops(const struct platform_hibernation_ops
> > >> *ops);
> > >>  extern int hibernate(void);
> > >>  extern bool system_entering_hibernation(void);
> > >> -#else /* CONFIG_HIBERNATION */
> > >> +#else /* !CONFIG_HIBERNATE_INTERFACE */
> > >> +static inline void register_nosave_region(unsigned long b, unsigned
> long
> > >> e) {}
> > >> +static inline void register_nosave_region_late(unsigned long b,
> unsigned
> > >> long e) {}
> > >>  static inline int swsusp_page_is_forbidden(struct page *p) { return
> 0; }
> > >>  static inline void swsusp_set_page_free(struct page *p) {}
> > >>  static inline void swsusp_unset_page_free(struct page *p) {}
> > >> @@ -256,7 +258,7 @@ static inline void swsusp_unset_page_fre
> > >>  static inline void hibernation_set_ops(const struct
> > >> platform_hibernation_ops *ops) {}
> > >>  static inline int hibernate(void) { return -ENOSYS; }
> > >>  static inline bool system_entering_hibernation(void) { return false;
> }
> > >> -#endif /* CONFIG_HIBERNATION */
> > >> +#endif /* !CONFIG_HIBERNATE_INTERFACE */
> > >>
> > >>  #ifdef CONFIG_PM_SLEEP
> > >>  void save_processor_state(void);
> > >> @@ -298,13 +300,6 @@ static inline bool pm_wakeup_pending(voi
> > >>  extern struct mutex pm_mutex;
> > >>
> > >>  #ifndef CONFIG_HIBERNATION
> > >> -static inline void register_nosave_region(unsigned long b, unsigned
> long
> > >> e)
> > >> -{
> > >> -}
> > >> -static inline void register_nosave_region_late(unsigned long b,
> unsigned
> > >> long e)
> > >> -{
> > >> -}
> > >> -
> > >>  static inline void lock_system_sleep(void) {}
> > >>  static inline void unlock_system_sleep(void) {}
> > >>
> > >> Index: linux-2.6/arch/x86/power/Makefile
> > >> ===================================================================
> > >> --- linux-2.6.orig/arch/x86/power/Makefile
> > >> +++ linux-2.6/arch/x86/power/Makefile
> > >> @@ -4,4 +4,5 @@ nostackp := $(call cc-option, -fno-stack
> > >>  CFLAGS_cpu.o   := $(nostackp)
> > >>
> > >>  obj-$(CONFIG_PM_SLEEP)         += cpu.o
> > >> -obj-$(CONFIG_HIBERNATION)      += hibernate_$(BITS).o
> > >> hibernate_asm_$(BITS).o
> > >> +obj-$(CONFIG_HIBERNATE_INTERFACE)      += hibernate_$(BITS).o \
> > >> +
> hibernate_asm_$(BITS).o
> > >> Index: linux-2.6/kernel/power/main.c
> > >> ===================================================================
> > >> --- linux-2.6.orig/kernel/power/main.c
> > >> +++ linux-2.6/kernel/power/main.c
> > >> @@ -156,7 +156,7 @@ static ssize_t state_show(struct kobject
> > >>                         s += sprintf(s,"%s ", pm_states[i]);
> > >>        }
> > >>  #endif
> > >> -#ifdef CONFIG_HIBERNATION
> > >> +#ifdef CONFIG_HIBERNATE_INTERFACE
> > >>         s += sprintf(s, "%s\n", "disk");
> > >>  #else
> > >>        if (s != buf)
> > >> Index: linux-2.6/kernel/power/power.h
> > >> ===================================================================
> > >> --- linux-2.6.orig/kernel/power/power.h
> > >> +++ linux-2.6/kernel/power/power.h
> > >> @@ -13,7 +13,7 @@ struct swsusp_info {
> > >>        unsigned long           size;
> > >>  } __attribute__((aligned(PAGE_SIZE)));
> > >>
> > >> -#ifdef CONFIG_HIBERNATION
> > >> +#ifdef CONFIG_HIBERNATE_INTERFACE
> > >>  /* kernel/power/snapshot.c */
> > >>  extern void __init hibernate_image_size_init(void);
> > >>
> > >> @@ -53,10 +53,10 @@ extern int hibernation_snapshot(int plat
> > >>  extern int hibernation_restore(int platform_mode);
> > >>  extern int hibernation_platform_enter(void);
> > >>
> > >> -#else /* !CONFIG_HIBERNATION */
> > >> +#else /* !CONFIG_HIBERNATE_INTERFACE */
> > >>
> > >>  static inline void hibernate_image_size_init(void) {}
> > >> -#endif /* !CONFIG_HIBERNATION */
> > >> +#endif /* !CONFIG_HIBERNATE_INTERFACE */
> > >>
> > >>  extern int pfn_is_nosave(unsigned long);
> > >>
> > >>
> > >> The code compiles perfectly. However, I am not able to test it
> > > in my installation (cant seem to boot a PV kernel - nothing to do
> > > with your patch).
> > > Will respond once I get the boot issue sorted.
> > >
> > > shriram
> > >
> > Hi,
> > sorry for the delay. I finally managed to get my system back in
> > one piece.
> >
> > So the patch you sent works perfectly. I tested xen save/restore with
> > both HIBERNATE_INTERFACE enabled and disabled. When disabled,
> > I dont see sys/power/disk.. (as expected).
>
> Cool. :-)
>
> > so how do you want to go about these two patches? I am ok with you
> > pushing "4/5 Add visible HIBERNATE_INTERFACE..." under your own
> > authorship (as you did the refactoring anyway :) ). That way, you would
> > just have to take "5/5 fix XEN_SAVE_RESTORE Kconfig dependencies".
>
> I will push my patch to Linus, but quite likely after -rc1, since I've just
> prepared a pull request I'm going to send later today.
>
> I'll add your Tested-by to the patch if you don't mind.
>
> Thanks,
> Rafael
>
> yep. sure

--0016e6470e64ab1535049f564ca2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2011/3/25 Rafael J. Wysocki <span dir=3D"ltr">&l=
t;<a href=3D"mailto:rjw@sisk.pl">rjw@sisk.pl</a>&gt;</span><br><blockquote =
class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px =
solid rgb(204, 204, 204); padding-left: 1ex;">

<div><div></div><div class=3D"h5">On Friday, March 25, 2011, Shriram Rajago=
palan wrote:<br>
&gt; On Sat, Mar 19, 2011 at 6:25 PM, Shriram Rajagopalan &lt;<a href=3D"ma=
ilto:rshriram@cs.ubc.ca">rshriram@cs.ubc.ca</a>&gt;wrote:<br>
&gt;<br>
&gt; &gt; On Fri, Mar 18, 2011 at 2:36 PM, Rafael J. Wysocki &lt;<a href=3D=
"mailto:rjw@sisk.pl">rjw@sisk.pl</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; On Wednesday, March 16, 2011, Rafael J. Wysocki wrote:<br>
&gt; &gt;&gt; &gt; On Tuesday, March 15, 2011, Shriram Rajagopalan wrote:<b=
r>
&gt; &gt;&gt; &gt; &gt; 2011/3/15 Rafael J. Wysocki &lt;<a href=3D"mailto:r=
jw@sisk.pl">rjw@sisk.pl</a>&gt;:<br>
&gt; &gt;&gt; ...<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Basically, I can do the patch for you, but that&#39;ll t=
ake some time.<br>
&gt; &gt;&gt; &gt; Stay tuned. :-)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The patch below appears to work for me, please check if it wo=
rks<br>
&gt; &gt;&gt; for you when you put the Xen patch selecting HIBERNATION on t=
op<br>
&gt; &gt;&gt; of it.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; Rafael<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt; =A0arch/x86/power/Makefile | =A0 =A03 ++-<br>
&gt; &gt;&gt; =A0include/linux/suspend.h | =A0 15 +++++----------<br>
&gt; &gt;&gt; =A0kernel/power/Kconfig =A0 =A0| =A0 =A04 ++++<br>
&gt; &gt;&gt; =A0kernel/power/Makefile =A0 | =A0 =A04 ++--<br>
&gt; &gt;&gt; =A0kernel/power/main.c =A0 =A0 | =A0 =A02 +-<br>
&gt; &gt;&gt; =A0kernel/power/power.h =A0 =A0| =A0 =A06 +++---<br>
&gt; &gt;&gt; =A06 files changed, 17 insertions(+), 17 deletions(-)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Index: linux-2.6/kernel/power/Kconfig<br>
&gt; &gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt;&gt; --- linux-2.6.orig/kernel/power/Kconfig<br>
&gt; &gt;&gt; +++ linux-2.6/kernel/power/Kconfig<br>
&gt; &gt;&gt; @@ -19,8 +19,12 @@ config SUSPEND_FREEZER<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 =A0 Turning OFF this setting is NOT recommend=
ed! If in doubt, say Y.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; =A0config HIBERNATION<br>
&gt; &gt;&gt; + =A0 =A0 =A0 bool<br>
&gt; &gt;&gt; +<br>
&gt; &gt;&gt; +config HIBERNATE_INTERFACE<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 bool &quot;Hibernation (aka &#39;suspend to d=
isk&#39;)&quot;<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 depends on SWAP &amp;&amp; ARCH_HIBERNATION_P=
OSSIBLE<br>
&gt; &gt;&gt; + =A0 =A0 =A0 select HIBERNATION<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 select LZO_COMPRESS<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0select LZO_DECOMPRESS<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 ---help---<br>
&gt; &gt;&gt; Index: linux-2.6/kernel/power/Makefile<br>
&gt; &gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt;&gt; --- linux-2.6.orig/kernel/power/Makefile<br>
&gt; &gt;&gt; +++ linux-2.6/kernel/power/Makefile<br>
&gt; &gt;&gt; @@ -5,7 +5,7 @@ obj-$(CONFIG_PM_SLEEP) =A0 =A0 =A0 =A0 =A0+=
=3D console.o<br>
&gt; &gt;&gt; =A0obj-$(CONFIG_FREEZER) =A0 =A0 =A0 =A0 =A0+=3D process.o<br=
>
&gt; &gt;&gt; =A0obj-$(CONFIG_SUSPEND) =A0 =A0 =A0 =A0 =A0+=3D suspend.o<br=
>
&gt; &gt;&gt; =A0obj-$(CONFIG_PM_TEST_SUSPEND) =A0+=3D suspend_test.o<br>
&gt; &gt;&gt; -obj-$(CONFIG_HIBERNATION) =A0 =A0 =A0+=3D hibernate.o snapsh=
ot.o swap.o user.o \<br>
&gt; &gt;&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0block_io.o<br>
&gt; &gt;&gt; +obj-$(CONFIG_HIBERNATE_INTERFACE) =A0 =A0 =A0+=3D hibernate.=
o snapshot.o swap.o \<br>
&gt; &gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user.o block_io.o<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; =A0obj-$(CONFIG_MAGIC_SYSRQ) =A0 =A0 =A0+=3D poweroff.o<br>
&gt; &gt;&gt; Index: linux-2.6/include/linux/suspend.h<br>
&gt; &gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt;&gt; --- linux-2.6.orig/include/linux/suspend.h<br>
&gt; &gt;&gt; +++ linux-2.6/include/linux/suspend.h<br>
&gt; &gt;&gt; @@ -229,7 +229,7 @@ struct platform_hibernation_ops {<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0void (*recover)(void);<br>
&gt; &gt;&gt; =A0};<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; -#ifdef CONFIG_HIBERNATION<br>
&gt; &gt;&gt; +#ifdef CONFIG_HIBERNATE_INTERFACE<br>
&gt; &gt;&gt; =A0/* kernel/power/snapshot.c */<br>
&gt; &gt;&gt; =A0extern void __register_nosave_region(unsigned long b, unsi=
gned long e,<br>
&gt; &gt;&gt; int km);<br>
&gt; &gt;&gt; =A0static inline void __init register_nosave_region(unsigned =
long b,<br>
&gt; &gt;&gt; unsigned long e)<br>
&gt; &gt;&gt; @@ -248,7 +248,9 @@ extern unsigned long get_safe_page(gfp_t<=
br>
&gt; &gt;&gt; =A0extern void hibernation_set_ops(const struct platform_hibe=
rnation_ops<br>
&gt; &gt;&gt; *ops);<br>
&gt; &gt;&gt; =A0extern int hibernate(void);<br>
&gt; &gt;&gt; =A0extern bool system_entering_hibernation(void);<br>
&gt; &gt;&gt; -#else /* CONFIG_HIBERNATION */<br>
&gt; &gt;&gt; +#else /* !CONFIG_HIBERNATE_INTERFACE */<br>
&gt; &gt;&gt; +static inline void register_nosave_region(unsigned long b, u=
nsigned long<br>
&gt; &gt;&gt; e) {}<br>
&gt; &gt;&gt; +static inline void register_nosave_region_late(unsigned long=
 b, unsigned<br>
&gt; &gt;&gt; long e) {}<br>
&gt; &gt;&gt; =A0static inline int swsusp_page_is_forbidden(struct page *p)=
 { return 0; }<br>
&gt; &gt;&gt; =A0static inline void swsusp_set_page_free(struct page *p) {}=
<br>
&gt; &gt;&gt; =A0static inline void swsusp_unset_page_free(struct page *p) =
{}<br>
&gt; &gt;&gt; @@ -256,7 +258,7 @@ static inline void swsusp_unset_page_fre<=
br>
&gt; &gt;&gt; =A0static inline void hibernation_set_ops(const struct<br>
&gt; &gt;&gt; platform_hibernation_ops *ops) {}<br>
&gt; &gt;&gt; =A0static inline int hibernate(void) { return -ENOSYS; }<br>
&gt; &gt;&gt; =A0static inline bool system_entering_hibernation(void) { ret=
urn false; }<br>
&gt; &gt;&gt; -#endif /* CONFIG_HIBERNATION */<br>
&gt; &gt;&gt; +#endif /* !CONFIG_HIBERNATE_INTERFACE */<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; =A0#ifdef CONFIG_PM_SLEEP<br>
&gt; &gt;&gt; =A0void save_processor_state(void);<br>
&gt; &gt;&gt; @@ -298,13 +300,6 @@ static inline bool pm_wakeup_pending(voi=
<br>
&gt; &gt;&gt; =A0extern struct mutex pm_mutex;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; =A0#ifndef CONFIG_HIBERNATION<br>
&gt; &gt;&gt; -static inline void register_nosave_region(unsigned long b, u=
nsigned long<br>
&gt; &gt;&gt; e)<br>
&gt; &gt;&gt; -{<br>
&gt; &gt;&gt; -}<br>
&gt; &gt;&gt; -static inline void register_nosave_region_late(unsigned long=
 b, unsigned<br>
&gt; &gt;&gt; long e)<br>
&gt; &gt;&gt; -{<br>
&gt; &gt;&gt; -}<br>
&gt; &gt;&gt; -<br>
&gt; &gt;&gt; =A0static inline void lock_system_sleep(void) {}<br>
&gt; &gt;&gt; =A0static inline void unlock_system_sleep(void) {}<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Index: linux-2.6/arch/x86/power/Makefile<br>
&gt; &gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt;&gt; --- linux-2.6.orig/arch/x86/power/Makefile<br>
&gt; &gt;&gt; +++ linux-2.6/arch/x86/power/Makefile<br>
&gt; &gt;&gt; @@ -4,4 +4,5 @@ nostackp :=3D $(call cc-option, -fno-stack<br=
>
&gt; &gt;&gt; =A0CFLAGS_cpu.o =A0 :=3D $(nostackp)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; =A0obj-$(CONFIG_PM_SLEEP) =A0 =A0 =A0 =A0 +=3D cpu.o<br>
&gt; &gt;&gt; -obj-$(CONFIG_HIBERNATION) =A0 =A0 =A0+=3D hibernate_$(BITS).=
o<br>
&gt; &gt;&gt; hibernate_asm_$(BITS).o<br>
&gt; &gt;&gt; +obj-$(CONFIG_HIBERNATE_INTERFACE) =A0 =A0 =A0+=3D hibernate_=
$(BITS).o \<br>
&gt; &gt;&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hibernate_asm_$(BITS).o<br>
&gt; &gt;&gt; Index: linux-2.6/kernel/power/main.c<br>
&gt; &gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt;&gt; --- linux-2.6.orig/kernel/power/main.c<br>
&gt; &gt;&gt; +++ linux-2.6/kernel/power/main.c<br>
&gt; &gt;&gt; @@ -156,7 +156,7 @@ static ssize_t state_show(struct kobject<=
br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s +=3D sprint=
f(s,&quot;%s &quot;, pm_states[i]);<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0}<br>
&gt; &gt;&gt; =A0#endif<br>
&gt; &gt;&gt; -#ifdef CONFIG_HIBERNATION<br>
&gt; &gt;&gt; +#ifdef CONFIG_HIBERNATE_INTERFACE<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0 s +=3D sprintf(s, &quot;%s\n&quot;, &quot;dis=
k&quot;);<br>
&gt; &gt;&gt; =A0#else<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0if (s !=3D buf)<br>
&gt; &gt;&gt; Index: linux-2.6/kernel/power/power.h<br>
&gt; &gt;&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; &gt;&gt; --- linux-2.6.orig/kernel/power/power.h<br>
&gt; &gt;&gt; +++ linux-2.6/kernel/power/power.h<br>
&gt; &gt;&gt; @@ -13,7 +13,7 @@ struct swsusp_info {<br>
&gt; &gt;&gt; =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 size;<br>
&gt; &gt;&gt; =A0} __attribute__((aligned(PAGE_SIZE)));<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; -#ifdef CONFIG_HIBERNATION<br>
&gt; &gt;&gt; +#ifdef CONFIG_HIBERNATE_INTERFACE<br>
&gt; &gt;&gt; =A0/* kernel/power/snapshot.c */<br>
&gt; &gt;&gt; =A0extern void __init hibernate_image_size_init(void);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; @@ -53,10 +53,10 @@ extern int hibernation_snapshot(int plat<=
br>
&gt; &gt;&gt; =A0extern int hibernation_restore(int platform_mode);<br>
&gt; &gt;&gt; =A0extern int hibernation_platform_enter(void);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; -#else /* !CONFIG_HIBERNATION */<br>
&gt; &gt;&gt; +#else /* !CONFIG_HIBERNATE_INTERFACE */<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; =A0static inline void hibernate_image_size_init(void) {}<br>
&gt; &gt;&gt; -#endif /* !CONFIG_HIBERNATION */<br>
&gt; &gt;&gt; +#endif /* !CONFIG_HIBERNATE_INTERFACE */<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; =A0extern int pfn_is_nosave(unsigned long);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The code compiles perfectly. However, I am not able to test i=
t<br>
&gt; &gt; in my installation (cant seem to boot a PV kernel - nothing to do=
<br>
&gt; &gt; with your patch).<br>
&gt; &gt; Will respond once I get the boot issue sorted.<br>
&gt; &gt;<br>
&gt; &gt; shriram<br>
&gt; &gt;<br>
&gt; Hi,<br>
&gt; sorry for the delay. I finally managed to get my system back in<br>
&gt; one piece.<br>
&gt;<br>
&gt; So the patch you sent works perfectly. I tested xen save/restore with<=
br>
&gt; both HIBERNATE_INTERFACE enabled and disabled. When disabled,<br>
&gt; I dont see sys/power/disk.. (as expected).<br>
<br>
</div></div>Cool. :-)<br>
<div class=3D"im"><br>
&gt; so how do you want to go about these two patches? I am ok with you<br>
&gt; pushing &quot;4/5 Add visible HIBERNATE_INTERFACE...&quot; under your =
own<br>
&gt; authorship (as you did the refactoring anyway :) ). That way, you woul=
d<br>
&gt; just have to take &quot;5/5 fix XEN_SAVE_RESTORE Kconfig dependencies&=
quot;.<br>
<br>
</div>I will push my patch to Linus, but quite likely after -rc1, since I&#=
39;ve just<br>
prepared a pull request I&#39;m going to send later today.<br>
<br>
I&#39;ll add your Tested-by to the patch if you don&#39;t mind.<br>
<br>
Thanks,<br>
<font color=3D"#888888">Rafael<br>
<br>
</font></blockquote></div>yep. sure<br>

--0016e6470e64ab1535049f564ca2--

--===============5835513009598858103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5835513009598858103==--
