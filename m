From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: Re: [Xen-devel] [PATCH] PM / Hibernate: Introduce
	CONFIG_HIBERNATE_INTERFACE
Date: Tue, 29 Mar 2011 09:45:08 -0700
Message-ID: <AANLkTinAHtrm4VX1JzJtc=nGYc5=E+fvOzRB2jE55b6b__42623.6238367439$1301417204$gmane$org@mail.gmail.com>
References: <201103261229.44770.rjw@sisk.pl>
	<1301414013.18413.29.camel@zakaz.uk.xensource.com>
Reply-To: rshriram@cs.ubc.ca
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4152370757629893671=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1301414013.18413.29.camel@zakaz.uk.xensource.com>
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
To: Ian Campbell <Ian.Campbell@citrix.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============4152370757629893671==
Content-Type: multipart/alternative; boundary=0022152d7e1bd3752c049fa1ca66

--0022152d7e1bd3752c049fa1ca66
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Mar 29, 2011 at 8:53 AM, Ian Campbell <Ian.Campbell@citrix.com>wrote:

> Hi Rafael,
>
> On Sat, 2011-03-26 at 11:29 +0000, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Xen save/restore is going to use hibernate device callbacks for
> > quiescing devices and putting them back to normal operations and it
> > would need to select CONFIG_HIBERNATION for this purpose.  However,
> > that also would cause the hibernate interfaces for user space to be
> > enabled, which might confuse user space, because the Xen kernels
> > don't support hibernation.  Moreover, it would be wasteful, as it
> > would make the Xen kernels include a substantial amount of code that
> > they would never use.
> >
> > To address this issue introduce new power management Kconfig option
> > CONFIG_HIBERNATE_INTERFACE, such that the hibernate interfaces for
> > user space and the image-handling code will depend on it and it will
> > select CONFIG_HIBERNATION.  Then, Xen save/restore will be able to
> > select CONFIG_HIBERNATION without dragging the entire hibernate code
> > along with it.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>
> Were you planning to put this forward for 2.6.39 or are you waiting for
> 2.6.40?
>
> > Tested-by: Shriram Rajagopalan <rshriram@cs.ubc.ca>
>
> Shriram,
>
> Is the additional Xen side patch still the same as in
> <1299906483-31053-1-git-send-email-rshriram@cs.ubc.ca> ? Is there
> anything else which isn't already in upstream?
>
> Ah. I knew I was missing something.
Yes. That patch remains the same.

thanks
shriram

> Ian.
>
> > ---
> >  arch/x86/power/Makefile |    3 ++-
> >  include/linux/suspend.h |   15 +++++----------
> >  kernel/power/Kconfig    |    4 ++++
> >  kernel/power/Makefile   |    4 ++--
> >  kernel/power/main.c     |    2 +-
> >  kernel/power/power.h    |    6 +++---
> >  6 files changed, 17 insertions(+), 17 deletions(-)
> >
> > Index: linux-2.6/kernel/power/Kconfig
> > ===================================================================
> > --- linux-2.6.orig/kernel/power/Kconfig
> > +++ linux-2.6/kernel/power/Kconfig
> > @@ -19,8 +19,12 @@ config SUSPEND_FREEZER
> >         Turning OFF this setting is NOT recommended! If in doubt, say Y.
> >
> >  config HIBERNATION
> > +     bool
> > +
> > +config HIBERNATE_INTERFACE
> >       bool "Hibernation (aka 'suspend to disk')"
> >       depends on SWAP && ARCH_HIBERNATION_POSSIBLE
> > +     select HIBERNATION
> >       select LZO_COMPRESS
> >       select LZO_DECOMPRESS
> >       ---help---
> > Index: linux-2.6/kernel/power/Makefile
> > ===================================================================
> > --- linux-2.6.orig/kernel/power/Makefile
> > +++ linux-2.6/kernel/power/Makefile
> > @@ -6,7 +6,7 @@ obj-$(CONFIG_PM_SLEEP)                += console.o
> >  obj-$(CONFIG_FREEZER)                += process.o
> >  obj-$(CONFIG_SUSPEND)                += suspend.o
> >  obj-$(CONFIG_PM_TEST_SUSPEND)        += suspend_test.o
> > -obj-$(CONFIG_HIBERNATION)    += hibernate.o snapshot.o swap.o user.o \
> > -                                block_io.o
> > +obj-$(CONFIG_HIBERNATE_INTERFACE)    += hibernate.o snapshot.o swap.o \
> > +                                             user.o block_io.o
> >
> >  obj-$(CONFIG_MAGIC_SYSRQ)    += poweroff.o
> > Index: linux-2.6/include/linux/suspend.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/suspend.h
> > +++ linux-2.6/include/linux/suspend.h
> > @@ -229,7 +229,7 @@ struct platform_hibernation_ops {
> >       void (*recover)(void);
> >  };
> >
> > -#ifdef CONFIG_HIBERNATION
> > +#ifdef CONFIG_HIBERNATE_INTERFACE
> >  /* kernel/power/snapshot.c */
> >  extern void __register_nosave_region(unsigned long b, unsigned long e,
> int km);
> >  static inline void __init register_nosave_region(unsigned long b,
> unsigned long e)
> > @@ -248,7 +248,9 @@ extern unsigned long get_safe_page(gfp_t
> >  extern void hibernation_set_ops(const struct platform_hibernation_ops
> *ops);
> >  extern int hibernate(void);
> >  extern bool system_entering_hibernation(void);
> > -#else /* CONFIG_HIBERNATION */
> > +#else /* !CONFIG_HIBERNATE_INTERFACE */
> > +static inline void register_nosave_region(unsigned long b, unsigned long
> e) {}
> > +static inline void register_nosave_region_late(unsigned long b, unsigned
> long e) {}
> >  static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
> >  static inline void swsusp_set_page_free(struct page *p) {}
> >  static inline void swsusp_unset_page_free(struct page *p) {}
> > @@ -256,7 +258,7 @@ static inline void swsusp_unset_page_fre
> >  static inline void hibernation_set_ops(const struct
> platform_hibernation_ops *ops) {}
> >  static inline int hibernate(void) { return -ENOSYS; }
> >  static inline bool system_entering_hibernation(void) { return false; }
> > -#endif /* CONFIG_HIBERNATION */
> > +#endif /* !CONFIG_HIBERNATE_INTERFACE */
> >
> >  #ifdef CONFIG_PM_SLEEP
> >  void save_processor_state(void);
> > @@ -298,13 +300,6 @@ static inline bool pm_wakeup_pending(voi
> >  extern struct mutex pm_mutex;
> >
> >  #ifndef CONFIG_HIBERNATION
> > -static inline void register_nosave_region(unsigned long b, unsigned long
> e)
> > -{
> > -}
> > -static inline void register_nosave_region_late(unsigned long b, unsigned
> long e)
> > -{
> > -}
> > -
> >  static inline void lock_system_sleep(void) {}
> >  static inline void unlock_system_sleep(void) {}
> >
> > Index: linux-2.6/arch/x86/power/Makefile
> > ===================================================================
> > --- linux-2.6.orig/arch/x86/power/Makefile
> > +++ linux-2.6/arch/x86/power/Makefile
> > @@ -4,4 +4,5 @@ nostackp := $(call cc-option, -fno-stack
> >  CFLAGS_cpu.o := $(nostackp)
> >
> >  obj-$(CONFIG_PM_SLEEP)               += cpu.o
> > -obj-$(CONFIG_HIBERNATION)    += hibernate_$(BITS).o
> hibernate_asm_$(BITS).o
> > +obj-$(CONFIG_HIBERNATE_INTERFACE)    += hibernate_$(BITS).o \
> > +                                             hibernate_asm_$(BITS).o
> > Index: linux-2.6/kernel/power/main.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/power/main.c
> > +++ linux-2.6/kernel/power/main.c
> > @@ -156,7 +156,7 @@ static ssize_t state_show(struct kobject
> >                       s += sprintf(s,"%s ", pm_states[i]);
> >       }
> >  #endif
> > -#ifdef CONFIG_HIBERNATION
> > +#ifdef CONFIG_HIBERNATE_INTERFACE
> >       s += sprintf(s, "%s\n", "disk");
> >  #else
> >       if (s != buf)
> > Index: linux-2.6/kernel/power/power.h
> > ===================================================================
> > --- linux-2.6.orig/kernel/power/power.h
> > +++ linux-2.6/kernel/power/power.h
> > @@ -13,7 +13,7 @@ struct swsusp_info {
> >       unsigned long           size;
> >  } __attribute__((aligned(PAGE_SIZE)));
> >
> > -#ifdef CONFIG_HIBERNATION
> > +#ifdef CONFIG_HIBERNATE_INTERFACE
> >  /* kernel/power/snapshot.c */
> >  extern void __init hibernate_image_size_init(void);
> >
> > @@ -53,10 +53,10 @@ extern int hibernation_snapshot(int plat
> >  extern int hibernation_restore(int platform_mode);
> >  extern int hibernation_platform_enter(void);
> >
> > -#else /* !CONFIG_HIBERNATION */
> > +#else /* !CONFIG_HIBERNATE_INTERFACE */
> >
> >  static inline void hibernate_image_size_init(void) {}
> > -#endif /* !CONFIG_HIBERNATION */
> > +#endif /* !CONFIG_HIBERNATE_INTERFACE */
> >
> >  extern int pfn_is_nosave(unsigned long);
> >
> >
> > _______________________________________________
> > Xen-devel mailing list
> > Xen-devel@lists.xensource.com
> > http://lists.xensource.com/xen-devel
>
>
>

--0022152d7e1bd3752c049fa1ca66
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Mar 29, 2011 at 8:53 AM, Ian Campbell <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:Ian.Campbell@citrix.com">Ian.Campbell=
@citrix.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); =
padding-left: 1ex;">

Hi Rafael,<br>
<div class=3D"im"><br>
On Sat, 2011-03-26 at 11:29 +0000, Rafael J. Wysocki wrote:<br>
&gt; From: Rafael J. Wysocki &lt;<a href=3D"mailto:rjw@sisk.pl">rjw@sisk.pl=
</a>&gt;<br>
&gt;<br>
&gt; Xen save/restore is going to use hibernate device callbacks for<br>
&gt; quiescing devices and putting them back to normal operations and it<br=
>
&gt; would need to select CONFIG_HIBERNATION for this purpose. =A0However,<=
br>
&gt; that also would cause the hibernate interfaces for user space to be<br=
>
&gt; enabled, which might confuse user space, because the Xen kernels<br>
&gt; don&#39;t support hibernation. =A0Moreover, it would be wasteful, as i=
t<br>
&gt; would make the Xen kernels include a substantial amount of code that<b=
r>
&gt; they would never use.<br>
&gt;<br>
&gt; To address this issue introduce new power management Kconfig option<br=
>
&gt; CONFIG_HIBERNATE_INTERFACE, such that the hibernate interfaces for<br>
&gt; user space and the image-handling code will depend on it and it will<b=
r>
&gt; select CONFIG_HIBERNATION. =A0Then, Xen save/restore will be able to<b=
r>
&gt; select CONFIG_HIBERNATION without dragging the entire hibernate code<b=
r>
&gt; along with it.<br>
&gt;<br>
&gt; Signed-off-by: Rafael J. Wysocki &lt;<a href=3D"mailto:rjw@sisk.pl">rj=
w@sisk.pl</a>&gt;<br>
<br>
</div>Were you planning to put this forward for 2.6.39 or are you waiting f=
or<br>
2.6.40?<br>
<div class=3D"im"><br>
&gt; Tested-by: Shriram Rajagopalan &lt;<a href=3D"mailto:rshriram@cs.ubc.c=
a">rshriram@cs.ubc.ca</a>&gt;<br>
<br>
</div>Shriram,<br>
<br>
Is the additional Xen side patch still the same as in<br>
&lt;<a href=3D"mailto:1299906483-31053-1-git-send-email-rshriram@cs.ubc.ca"=
>1299906483-31053-1-git-send-email-rshriram@cs.ubc.ca</a>&gt; ? Is there<br=
>
anything else which isn&#39;t already in upstream?<br>
<br></blockquote><div>Ah. I knew I was missing something.<br>Yes. That patc=
h remains the same. <br><br>thanks<br>shriram <br></div><blockquote class=
=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid=
 rgb(204, 204, 204); padding-left: 1ex;">


Ian.<br>
<div><div></div><div class=3D"h5"><br>
&gt; ---<br>
&gt; =A0arch/x86/power/Makefile | =A0 =A03 ++-<br>
&gt; =A0include/linux/suspend.h | =A0 15 +++++----------<br>
&gt; =A0kernel/power/Kconfig =A0 =A0| =A0 =A04 ++++<br>
&gt; =A0kernel/power/Makefile =A0 | =A0 =A04 ++--<br>
&gt; =A0kernel/power/main.c =A0 =A0 | =A0 =A02 +-<br>
&gt; =A0kernel/power/power.h =A0 =A0| =A0 =A06 +++---<br>
&gt; =A06 files changed, 17 insertions(+), 17 deletions(-)<br>
&gt;<br>
&gt; Index: linux-2.6/kernel/power/Kconfig<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; --- linux-2.6.orig/kernel/power/Kconfig<br>
&gt; +++ linux-2.6/kernel/power/Kconfig<br>
&gt; @@ -19,8 +19,12 @@ config SUSPEND_FREEZER<br>
&gt; =A0 =A0 =A0 =A0 Turning OFF this setting is NOT recommended! If in dou=
bt, say Y.<br>
&gt;<br>
&gt; =A0config HIBERNATION<br>
&gt; + =A0 =A0 bool<br>
&gt; +<br>
&gt; +config HIBERNATE_INTERFACE<br>
&gt; =A0 =A0 =A0 bool &quot;Hibernation (aka &#39;suspend to disk&#39;)&quo=
t;<br>
&gt; =A0 =A0 =A0 depends on SWAP &amp;&amp; ARCH_HIBERNATION_POSSIBLE<br>
&gt; + =A0 =A0 select HIBERNATION<br>
&gt; =A0 =A0 =A0 select LZO_COMPRESS<br>
&gt; =A0 =A0 =A0 select LZO_DECOMPRESS<br>
&gt; =A0 =A0 =A0 ---help---<br>
&gt; Index: linux-2.6/kernel/power/Makefile<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; --- linux-2.6.orig/kernel/power/Makefile<br>
&gt; +++ linux-2.6/kernel/power/Makefile<br>
&gt; @@ -6,7 +6,7 @@ obj-$(CONFIG_PM_SLEEP) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
+=3D console.o<br>
&gt; =A0obj-$(CONFIG_FREEZER) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D process.o=
<br>
&gt; =A0obj-$(CONFIG_SUSPEND) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D suspend.o=
<br>
&gt; =A0obj-$(CONFIG_PM_TEST_SUSPEND) =A0 =A0 =A0 =A0+=3D suspend_test.o<br=
>
&gt; -obj-$(CONFIG_HIBERNATION) =A0 =A0+=3D hibernate.o snapshot.o swap.o u=
ser.o \<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0block=
_io.o<br>
&gt; +obj-$(CONFIG_HIBERNATE_INTERFACE) =A0 =A0+=3D hibernate.o snapshot.o =
swap.o \<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 user.o block_io.o<br>
&gt;<br>
&gt; =A0obj-$(CONFIG_MAGIC_SYSRQ) =A0 =A0+=3D poweroff.o<br>
&gt; Index: linux-2.6/include/linux/suspend.h<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; --- linux-2.6.orig/include/linux/suspend.h<br>
&gt; +++ linux-2.6/include/linux/suspend.h<br>
&gt; @@ -229,7 +229,7 @@ struct platform_hibernation_ops {<br>
&gt; =A0 =A0 =A0 void (*recover)(void);<br>
&gt; =A0};<br>
&gt;<br>
&gt; -#ifdef CONFIG_HIBERNATION<br>
&gt; +#ifdef CONFIG_HIBERNATE_INTERFACE<br>
&gt; =A0/* kernel/power/snapshot.c */<br>
&gt; =A0extern void __register_nosave_region(unsigned long b, unsigned long=
 e, int km);<br>
&gt; =A0static inline void __init register_nosave_region(unsigned long b, u=
nsigned long e)<br>
&gt; @@ -248,7 +248,9 @@ extern unsigned long get_safe_page(gfp_t<br>
&gt; =A0extern void hibernation_set_ops(const struct platform_hibernation_o=
ps *ops);<br>
&gt; =A0extern int hibernate(void);<br>
&gt; =A0extern bool system_entering_hibernation(void);<br>
&gt; -#else /* CONFIG_HIBERNATION */<br>
&gt; +#else /* !CONFIG_HIBERNATE_INTERFACE */<br>
&gt; +static inline void register_nosave_region(unsigned long b, unsigned l=
ong e) {}<br>
&gt; +static inline void register_nosave_region_late(unsigned long b, unsig=
ned long e) {}<br>
&gt; =A0static inline int swsusp_page_is_forbidden(struct page *p) { return=
 0; }<br>
&gt; =A0static inline void swsusp_set_page_free(struct page *p) {}<br>
&gt; =A0static inline void swsusp_unset_page_free(struct page *p) {}<br>
&gt; @@ -256,7 +258,7 @@ static inline void swsusp_unset_page_fre<br>
&gt; =A0static inline void hibernation_set_ops(const struct platform_hibern=
ation_ops *ops) {}<br>
&gt; =A0static inline int hibernate(void) { return -ENOSYS; }<br>
&gt; =A0static inline bool system_entering_hibernation(void) { return false=
; }<br>
&gt; -#endif /* CONFIG_HIBERNATION */<br>
&gt; +#endif /* !CONFIG_HIBERNATE_INTERFACE */<br>
&gt;<br>
&gt; =A0#ifdef CONFIG_PM_SLEEP<br>
&gt; =A0void save_processor_state(void);<br>
&gt; @@ -298,13 +300,6 @@ static inline bool pm_wakeup_pending(voi<br>
&gt; =A0extern struct mutex pm_mutex;<br>
&gt;<br>
&gt; =A0#ifndef CONFIG_HIBERNATION<br>
&gt; -static inline void register_nosave_region(unsigned long b, unsigned l=
ong e)<br>
&gt; -{<br>
&gt; -}<br>
&gt; -static inline void register_nosave_region_late(unsigned long b, unsig=
ned long e)<br>
&gt; -{<br>
&gt; -}<br>
&gt; -<br>
&gt; =A0static inline void lock_system_sleep(void) {}<br>
&gt; =A0static inline void unlock_system_sleep(void) {}<br>
&gt;<br>
&gt; Index: linux-2.6/arch/x86/power/Makefile<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; --- linux-2.6.orig/arch/x86/power/Makefile<br>
&gt; +++ linux-2.6/arch/x86/power/Makefile<br>
&gt; @@ -4,4 +4,5 @@ nostackp :=3D $(call cc-option, -fno-stack<br>
&gt; =A0CFLAGS_cpu.o :=3D $(nostackp)<br>
&gt;<br>
&gt; =A0obj-$(CONFIG_PM_SLEEP) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D cpu.o<br>
&gt; -obj-$(CONFIG_HIBERNATION) =A0 =A0+=3D hibernate_$(BITS).o hibernate_a=
sm_$(BITS).o<br>
&gt; +obj-$(CONFIG_HIBERNATE_INTERFACE) =A0 =A0+=3D hibernate_$(BITS).o \<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 hibernate_asm_$(BITS).o<br>
&gt; Index: linux-2.6/kernel/power/main.c<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; --- linux-2.6.orig/kernel/power/main.c<br>
&gt; +++ linux-2.6/kernel/power/main.c<br>
&gt; @@ -156,7 +156,7 @@ static ssize_t state_show(struct kobject<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s +=3D sprintf(s,&quot;%s =
&quot;, pm_states[i]);<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0#endif<br>
&gt; -#ifdef CONFIG_HIBERNATION<br>
&gt; +#ifdef CONFIG_HIBERNATE_INTERFACE<br>
&gt; =A0 =A0 =A0 s +=3D sprintf(s, &quot;%s\n&quot;, &quot;disk&quot;);<br>
&gt; =A0#else<br>
&gt; =A0 =A0 =A0 if (s !=3D buf)<br>
&gt; Index: linux-2.6/kernel/power/power.h<br>
&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt; --- linux-2.6.orig/kernel/power/power.h<br>
&gt; +++ linux-2.6/kernel/power/power.h<br>
&gt; @@ -13,7 +13,7 @@ struct swsusp_info {<br>
&gt; =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 size;<br>
&gt; =A0} __attribute__((aligned(PAGE_SIZE)));<br>
&gt;<br>
&gt; -#ifdef CONFIG_HIBERNATION<br>
&gt; +#ifdef CONFIG_HIBERNATE_INTERFACE<br>
&gt; =A0/* kernel/power/snapshot.c */<br>
&gt; =A0extern void __init hibernate_image_size_init(void);<br>
&gt;<br>
&gt; @@ -53,10 +53,10 @@ extern int hibernation_snapshot(int plat<br>
&gt; =A0extern int hibernation_restore(int platform_mode);<br>
&gt; =A0extern int hibernation_platform_enter(void);<br>
&gt;<br>
&gt; -#else /* !CONFIG_HIBERNATION */<br>
&gt; +#else /* !CONFIG_HIBERNATE_INTERFACE */<br>
&gt;<br>
&gt; =A0static inline void hibernate_image_size_init(void) {}<br>
&gt; -#endif /* !CONFIG_HIBERNATION */<br>
&gt; +#endif /* !CONFIG_HIBERNATE_INTERFACE */<br>
&gt;<br>
&gt; =A0extern int pfn_is_nosave(unsigned long);<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; Xen-devel mailing list<br>
&gt; <a href=3D"mailto:Xen-devel@lists.xensource.com">Xen-devel@lists.xenso=
urce.com</a><br>
&gt; <a href=3D"http://lists.xensource.com/xen-devel" target=3D"_blank">htt=
p://lists.xensource.com/xen-devel</a><br>
<br>
<br>
</blockquote></div><br>

--0022152d7e1bd3752c049fa1ca66--

--===============4152370757629893671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4152370757629893671==--
