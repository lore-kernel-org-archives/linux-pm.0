From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: Re: [PATCH v3 4/5] PM: Add visible HIBERNATION_INTERFACE
 and hide HIBERNATION
Date: Fri, 25 Mar 2011 00:23:34 -0700
Message-ID: <AANLkTi=_iPbpgFZ7BeKBgeO_++hWZaDLO005+VEQh-OQ__31257.2963689037$1301037923$gmane$org@mail.gmail.com>
References: <1299906471-31011-1-git-send-email-rshriram@cs.ubc.ca>
	<AANLkTimyDVG7YjNmQGjo7pnKyZE1cXSZyVNx_rekNgNC@mail.gmail.com>
	<201103160153.32080.rjw@sisk.pl> <201103182236.26624.rjw@sisk.pl>
	<AANLkTikEKiQdVA8025xbAdpDsNWmoDwaq2WUuxuLSeLU@mail.gmail.com>
Reply-To: rshriram@cs.ubc.ca
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7444139627228364355=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikEKiQdVA8025xbAdpDsNWmoDwaq2WUuxuLSeLU@mail.gmail.com>
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

--===============7444139627228364355==
Content-Type: multipart/alternative; boundary=bcaec529952521b159049f497b69

--bcaec529952521b159049f497b69
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Mar 19, 2011 at 6:25 PM, Shriram Rajagopalan <rshriram@cs.ubc.ca>wrote:

> On Fri, Mar 18, 2011 at 2:36 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
>> On Wednesday, March 16, 2011, Rafael J. Wysocki wrote:
>> > On Tuesday, March 15, 2011, Shriram Rajagopalan wrote:
>> > > 2011/3/15 Rafael J. Wysocki <rjw@sisk.pl>:
>> ...
>> >
>> > Basically, I can do the patch for you, but that'll take some time.
>> > Stay tuned. :-)
>>
>> The patch below appears to work for me, please check if it works
>> for you when you put the Xen patch selecting HIBERNATION on top
>> of it.
>>
>> Thanks,
>> Rafael
>>
>> ---
>>  arch/x86/power/Makefile |    3 ++-
>>  include/linux/suspend.h |   15 +++++----------
>>  kernel/power/Kconfig    |    4 ++++
>>  kernel/power/Makefile   |    4 ++--
>>  kernel/power/main.c     |    2 +-
>>  kernel/power/power.h    |    6 +++---
>>  6 files changed, 17 insertions(+), 17 deletions(-)
>>
>> Index: linux-2.6/kernel/power/Kconfig
>> ===================================================================
>> --- linux-2.6.orig/kernel/power/Kconfig
>> +++ linux-2.6/kernel/power/Kconfig
>> @@ -19,8 +19,12 @@ config SUSPEND_FREEZER
>>           Turning OFF this setting is NOT recommended! If in doubt, say Y.
>>
>>  config HIBERNATION
>> +       bool
>> +
>> +config HIBERNATE_INTERFACE
>>         bool "Hibernation (aka 'suspend to disk')"
>>         depends on SWAP && ARCH_HIBERNATION_POSSIBLE
>> +       select HIBERNATION
>>         select LZO_COMPRESS
>>        select LZO_DECOMPRESS
>>         ---help---
>> Index: linux-2.6/kernel/power/Makefile
>> ===================================================================
>> --- linux-2.6.orig/kernel/power/Makefile
>> +++ linux-2.6/kernel/power/Makefile
>> @@ -5,7 +5,7 @@ obj-$(CONFIG_PM_SLEEP)          += console.o
>>  obj-$(CONFIG_FREEZER)          += process.o
>>  obj-$(CONFIG_SUSPEND)          += suspend.o
>>  obj-$(CONFIG_PM_TEST_SUSPEND)  += suspend_test.o
>> -obj-$(CONFIG_HIBERNATION)      += hibernate.o snapshot.o swap.o user.o \
>> -                                  block_io.o
>> +obj-$(CONFIG_HIBERNATE_INTERFACE)      += hibernate.o snapshot.o swap.o \
>> +                                               user.o block_io.o
>>
>>  obj-$(CONFIG_MAGIC_SYSRQ)      += poweroff.o
>> Index: linux-2.6/include/linux/suspend.h
>> ===================================================================
>> --- linux-2.6.orig/include/linux/suspend.h
>> +++ linux-2.6/include/linux/suspend.h
>> @@ -229,7 +229,7 @@ struct platform_hibernation_ops {
>>        void (*recover)(void);
>>  };
>>
>> -#ifdef CONFIG_HIBERNATION
>> +#ifdef CONFIG_HIBERNATE_INTERFACE
>>  /* kernel/power/snapshot.c */
>>  extern void __register_nosave_region(unsigned long b, unsigned long e,
>> int km);
>>  static inline void __init register_nosave_region(unsigned long b,
>> unsigned long e)
>> @@ -248,7 +248,9 @@ extern unsigned long get_safe_page(gfp_t
>>  extern void hibernation_set_ops(const struct platform_hibernation_ops
>> *ops);
>>  extern int hibernate(void);
>>  extern bool system_entering_hibernation(void);
>> -#else /* CONFIG_HIBERNATION */
>> +#else /* !CONFIG_HIBERNATE_INTERFACE */
>> +static inline void register_nosave_region(unsigned long b, unsigned long
>> e) {}
>> +static inline void register_nosave_region_late(unsigned long b, unsigned
>> long e) {}
>>  static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
>>  static inline void swsusp_set_page_free(struct page *p) {}
>>  static inline void swsusp_unset_page_free(struct page *p) {}
>> @@ -256,7 +258,7 @@ static inline void swsusp_unset_page_fre
>>  static inline void hibernation_set_ops(const struct
>> platform_hibernation_ops *ops) {}
>>  static inline int hibernate(void) { return -ENOSYS; }
>>  static inline bool system_entering_hibernation(void) { return false; }
>> -#endif /* CONFIG_HIBERNATION */
>> +#endif /* !CONFIG_HIBERNATE_INTERFACE */
>>
>>  #ifdef CONFIG_PM_SLEEP
>>  void save_processor_state(void);
>> @@ -298,13 +300,6 @@ static inline bool pm_wakeup_pending(voi
>>  extern struct mutex pm_mutex;
>>
>>  #ifndef CONFIG_HIBERNATION
>> -static inline void register_nosave_region(unsigned long b, unsigned long
>> e)
>> -{
>> -}
>> -static inline void register_nosave_region_late(unsigned long b, unsigned
>> long e)
>> -{
>> -}
>> -
>>  static inline void lock_system_sleep(void) {}
>>  static inline void unlock_system_sleep(void) {}
>>
>> Index: linux-2.6/arch/x86/power/Makefile
>> ===================================================================
>> --- linux-2.6.orig/arch/x86/power/Makefile
>> +++ linux-2.6/arch/x86/power/Makefile
>> @@ -4,4 +4,5 @@ nostackp := $(call cc-option, -fno-stack
>>  CFLAGS_cpu.o   := $(nostackp)
>>
>>  obj-$(CONFIG_PM_SLEEP)         += cpu.o
>> -obj-$(CONFIG_HIBERNATION)      += hibernate_$(BITS).o
>> hibernate_asm_$(BITS).o
>> +obj-$(CONFIG_HIBERNATE_INTERFACE)      += hibernate_$(BITS).o \
>> +                                               hibernate_asm_$(BITS).o
>> Index: linux-2.6/kernel/power/main.c
>> ===================================================================
>> --- linux-2.6.orig/kernel/power/main.c
>> +++ linux-2.6/kernel/power/main.c
>> @@ -156,7 +156,7 @@ static ssize_t state_show(struct kobject
>>                         s += sprintf(s,"%s ", pm_states[i]);
>>        }
>>  #endif
>> -#ifdef CONFIG_HIBERNATION
>> +#ifdef CONFIG_HIBERNATE_INTERFACE
>>         s += sprintf(s, "%s\n", "disk");
>>  #else
>>        if (s != buf)
>> Index: linux-2.6/kernel/power/power.h
>> ===================================================================
>> --- linux-2.6.orig/kernel/power/power.h
>> +++ linux-2.6/kernel/power/power.h
>> @@ -13,7 +13,7 @@ struct swsusp_info {
>>        unsigned long           size;
>>  } __attribute__((aligned(PAGE_SIZE)));
>>
>> -#ifdef CONFIG_HIBERNATION
>> +#ifdef CONFIG_HIBERNATE_INTERFACE
>>  /* kernel/power/snapshot.c */
>>  extern void __init hibernate_image_size_init(void);
>>
>> @@ -53,10 +53,10 @@ extern int hibernation_snapshot(int plat
>>  extern int hibernation_restore(int platform_mode);
>>  extern int hibernation_platform_enter(void);
>>
>> -#else /* !CONFIG_HIBERNATION */
>> +#else /* !CONFIG_HIBERNATE_INTERFACE */
>>
>>  static inline void hibernate_image_size_init(void) {}
>> -#endif /* !CONFIG_HIBERNATION */
>> +#endif /* !CONFIG_HIBERNATE_INTERFACE */
>>
>>  extern int pfn_is_nosave(unsigned long);
>>
>>
>> The code compiles perfectly. However, I am not able to test it
> in my installation (cant seem to boot a PV kernel - nothing to do
> with your patch).
> Will respond once I get the boot issue sorted.
>
> shriram
>
Hi,
sorry for the delay. I finally managed to get my system back in
one piece.

So the patch you sent works perfectly. I tested xen save/restore with
both HIBERNATE_INTERFACE enabled and disabled. When disabled,
I dont see sys/power/disk.. (as expected).

so how do you want to go about these two patches? I am ok with you
pushing "4/5 Add visible HIBERNATE_INTERFACE..." under your own
authorship (as you did the refactoring anyway :) ). That way, you would
just have to take "5/5 fix XEN_SAVE_RESTORE Kconfig dependencies".

shriram

--bcaec529952521b159049f497b69
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sat, Mar 19, 2011 at 6:25 PM, Shriram Rajagop=
alan <span dir=3D"ltr">&lt;<a href=3D"mailto:rshriram@cs.ubc.ca">rshriram@c=
s.ubc.ca</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); p=
adding-left: 1ex;">

<div><div></div><div class=3D"h5"><div class=3D"gmail_quote">On Fri, Mar 18=
, 2011 at 2:36 PM, Rafael J. Wysocki <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:rjw@sisk.pl" target=3D"_blank">rjw@sisk.pl</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


<div>On Wednesday, March 16, 2011, Rafael J. Wysocki wrote:<br>
&gt; On Tuesday, March 15, 2011, Shriram Rajagopalan wrote:<br>
&gt; &gt; 2011/3/15 Rafael J. Wysocki &lt;<a href=3D"mailto:rjw@sisk.pl" ta=
rget=3D"_blank">rjw@sisk.pl</a>&gt;:<br>
</div>...<br>
<div>&gt;<br>
&gt; Basically, I can do the patch for you, but that&#39;ll take some time.=
<br>
&gt; Stay tuned. :-)<br>
<br>
</div>The patch below appears to work for me, please check if it works<br>
for you when you put the Xen patch selecting HIBERNATION on top<br>
of it.<br>
<br>
Thanks,<br>
Rafael<br>
<br>
---<br>
=A0arch/x86/power/Makefile | =A0 =A03 ++-<br>
=A0include/linux/suspend.h | =A0 15 +++++----------<br>
=A0kernel/power/Kconfig =A0 =A0| =A0 =A04 ++++<br>
=A0kernel/power/Makefile =A0 | =A0 =A04 ++--<br>
<div>=A0kernel/power/main.c =A0 =A0 | =A0 =A02 +-<br>
</div>=A0kernel/power/power.h =A0 =A0| =A0 =A06 +++---<br>
=A06 files changed, 17 insertions(+), 17 deletions(-)<br>
<br>
Index: linux-2.6/kernel/power/Kconfig<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- linux-2.6.orig/kernel/power/Kconfig<br>
+++ linux-2.6/kernel/power/Kconfig<br>
@@ -19,8 +19,12 @@ config SUSPEND_FREEZER<br>
<div> =A0 =A0 =A0 =A0 =A0Turning OFF this setting is NOT recommended! If in=
 doubt, say Y.<br>
<br>
=A0config HIBERNATION<br>
+ =A0 =A0 =A0 bool<br>
</div>+<br>
+config HIBERNATE_INTERFACE<br>
<div> =A0 =A0 =A0 =A0bool &quot;Hibernation (aka &#39;suspend to disk&#39;)=
&quot;<br>
</div> =A0 =A0 =A0 =A0depends on SWAP &amp;&amp; ARCH_HIBERNATION_POSSIBLE<=
br>
+ =A0 =A0 =A0 select HIBERNATION<br>
<div> =A0 =A0 =A0 =A0select LZO_COMPRESS<br>
 =A0 =A0 =A0 =A0select LZO_DECOMPRESS<br>
</div> =A0 =A0 =A0 =A0---help---<br>
Index: linux-2.6/kernel/power/Makefile<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- linux-2.6.orig/kernel/power/Makefile<br>
+++ linux-2.6/kernel/power/Makefile<br>
@@ -5,7 +5,7 @@ obj-$(CONFIG_PM_SLEEP) =A0 =A0 =A0 =A0 =A0+=3D console.o<br=
>
=A0obj-$(CONFIG_FREEZER) =A0 =A0 =A0 =A0 =A0+=3D process.o<br>
=A0obj-$(CONFIG_SUSPEND) =A0 =A0 =A0 =A0 =A0+=3D suspend.o<br>
=A0obj-$(CONFIG_PM_TEST_SUSPEND) =A0+=3D suspend_test.o<br>
-obj-$(CONFIG_HIBERNATION) =A0 =A0 =A0+=3D hibernate.o snapshot.o swap.o us=
er.o \<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0block_=
io.o<br>
+obj-$(CONFIG_HIBERNATE_INTERFACE) =A0 =A0 =A0+=3D hibernate.o snapshot.o s=
wap.o \<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 user.o block_io.o<br>
<br>
=A0obj-$(CONFIG_MAGIC_SYSRQ) =A0 =A0 =A0+=3D poweroff.o<br>
Index: linux-2.6/include/linux/suspend.h<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- linux-2.6.orig/include/linux/suspend.h<br>
+++ linux-2.6/include/linux/suspend.h<br>
@@ -229,7 +229,7 @@ struct platform_hibernation_ops {<br>
 =A0 =A0 =A0 =A0void (*recover)(void);<br>
=A0};<br>
<br>
-#ifdef CONFIG_HIBERNATION<br>
+#ifdef CONFIG_HIBERNATE_INTERFACE<br>
=A0/* kernel/power/snapshot.c */<br>
=A0extern void __register_nosave_region(unsigned long b, unsigned long e, i=
nt km);<br>
=A0static inline void __init register_nosave_region(unsigned long b, unsign=
ed long e)<br>
@@ -248,7 +248,9 @@ extern unsigned long get_safe_page(gfp_t<br>
=A0extern void hibernation_set_ops(const struct platform_hibernation_ops *o=
ps);<br>
=A0extern int hibernate(void);<br>
=A0extern bool system_entering_hibernation(void);<br>
-#else /* CONFIG_HIBERNATION */<br>
+#else /* !CONFIG_HIBERNATE_INTERFACE */<br>
+static inline void register_nosave_region(unsigned long b, unsigned long e=
) {}<br>
+static inline void register_nosave_region_late(unsigned long b, unsigned l=
ong e) {}<br>
=A0static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }=
<br>
=A0static inline void swsusp_set_page_free(struct page *p) {}<br>
=A0static inline void swsusp_unset_page_free(struct page *p) {}<br>
@@ -256,7 +258,7 @@ static inline void swsusp_unset_page_fre<br>
=A0static inline void hibernation_set_ops(const struct platform_hibernation=
_ops *ops) {}<br>
=A0static inline int hibernate(void) { return -ENOSYS; }<br>
=A0static inline bool system_entering_hibernation(void) { return false; }<b=
r>
-#endif /* CONFIG_HIBERNATION */<br>
+#endif /* !CONFIG_HIBERNATE_INTERFACE */<br>
<br>
=A0#ifdef CONFIG_PM_SLEEP<br>
=A0void save_processor_state(void);<br>
@@ -298,13 +300,6 @@ static inline bool pm_wakeup_pending(voi<br>
=A0extern struct mutex pm_mutex;<br>
<br>
=A0#ifndef CONFIG_HIBERNATION<br>
-static inline void register_nosave_region(unsigned long b, unsigned long e=
)<br>
-{<br>
-}<br>
-static inline void register_nosave_region_late(unsigned long b, unsigned l=
ong e)<br>
-{<br>
-}<br>
-<br>
=A0static inline void lock_system_sleep(void) {}<br>
=A0static inline void unlock_system_sleep(void) {}<br>
<br>
Index: linux-2.6/arch/x86/power/Makefile<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- linux-2.6.orig/arch/x86/power/Makefile<br>
+++ linux-2.6/arch/x86/power/Makefile<br>
@@ -4,4 +4,5 @@ nostackp :=3D $(call cc-option, -fno-stack<br>
=A0CFLAGS_cpu.o =A0 :=3D $(nostackp)<br>
<br>
=A0obj-$(CONFIG_PM_SLEEP) =A0 =A0 =A0 =A0 +=3D cpu.o<br>
-obj-$(CONFIG_HIBERNATION) =A0 =A0 =A0+=3D hibernate_$(BITS).o hibernate_as=
m_$(BITS).o<br>
+obj-$(CONFIG_HIBERNATE_INTERFACE) =A0 =A0 =A0+=3D hibernate_$(BITS).o \<br=
>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 hibernate_asm_$(BITS).o<br>
Index: linux-2.6/kernel/power/main.c<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- linux-2.6.orig/kernel/power/main.c<br>
+++ linux-2.6/kernel/power/main.c<br>
<div>@@ -156,7 +156,7 @@ static ssize_t state_show(struct kobject<br>
</div><div> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s +=3D sprintf(s=
,&quot;%s &quot;, pm_states[i]);<br>
 =A0 =A0 =A0 =A0}<br>
=A0#endif<br>
-#ifdef CONFIG_HIBERNATION<br>
</div>+#ifdef CONFIG_HIBERNATE_INTERFACE<br>
<div> =A0 =A0 =A0 =A0s +=3D sprintf(s, &quot;%s\n&quot;, &quot;disk&quot;);=
<br>
=A0#else<br>
 =A0 =A0 =A0 =A0if (s !=3D buf)<br>
</div>Index: linux-2.6/kernel/power/power.h<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
--- linux-2.6.orig/kernel/power/power.h<br>
+++ linux-2.6/kernel/power/power.h<br>
@@ -13,7 +13,7 @@ struct swsusp_info {<br>
 =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 size;<br>
=A0} __attribute__((aligned(PAGE_SIZE)));<br>
<br>
-#ifdef CONFIG_HIBERNATION<br>
+#ifdef CONFIG_HIBERNATE_INTERFACE<br>
=A0/* kernel/power/snapshot.c */<br>
=A0extern void __init hibernate_image_size_init(void);<br>
<br>
@@ -53,10 +53,10 @@ extern int hibernation_snapshot(int plat<br>
=A0extern int hibernation_restore(int platform_mode);<br>
=A0extern int hibernation_platform_enter(void);<br>
<br>
-#else /* !CONFIG_HIBERNATION */<br>
+#else /* !CONFIG_HIBERNATE_INTERFACE */<br>
<br>
=A0static inline void hibernate_image_size_init(void) {}<br>
-#endif /* !CONFIG_HIBERNATION */<br>
+#endif /* !CONFIG_HIBERNATE_INTERFACE */<br>
<br>
=A0extern int pfn_is_nosave(unsigned long);<br>
<br>
<br>
</blockquote></div></div></div>The code compiles perfectly. However, I am n=
ot able to test it<br>in my installation (cant seem to boot a PV kernel - n=
othing to do <br>with your patch).<br>Will respond once I get the boot issu=
e sorted.<br>

<font color=3D"#888888">
<br>shriram<br>
</font></blockquote></div>Hi,<br>sorry for the delay. I finally managed to =
get my system back in <br>one piece.<br><br>So the patch you sent works per=
fectly. I tested xen save/restore with <br>both HIBERNATE_INTERFACE enabled=
 and disabled. When disabled,<br>

I dont see sys/power/disk.. (as expected).<br><br>so how do you want to go =
about these two patches? I am ok with you<br>pushing &quot;4/5 Add visible =
HIBERNATE_INTERFACE...&quot; under your own <br>authorship (as you did the =
refactoring anyway :) ). That way, you would<br>

just have to take &quot;5/5 fix XEN_SAVE_RESTORE Kconfig dependencies&quot;=
.<br><br>shriram<br>

--bcaec529952521b159049f497b69--

--===============7444139627228364355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7444139627228364355==--
