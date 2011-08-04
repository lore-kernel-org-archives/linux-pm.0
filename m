From: Trinabh Gupta <g.trinabh@gmail.com>
Subject: Re: [PATCH 5/5] cpuidle: stop depending on pm_idle
Date: Thu, 4 Aug 2011 10:21:17 -0700
Message-ID: <CAAXLqgrnRi25WM2HpHxe-R4ePrgdbVROky4+=3Jr489M7zbgUA@mail.gmail.com>
References: <8e24ed2af46a5d008d85bfeb128d25efc394a3fd.1312400543.git.len.brown@intel.com>
	<1312400648-17636-1-git-send-email-lenb@kernel.org>
	<619b3f9e65307529dd4bbc98efe9d2f3b632646c.1312400543.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5231035709509622490=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <619b3f9e65307529dd4bbc98efe9d2f3b632646c.1312400543.git.len.brown@intel.com>
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
To: Len Brown <lenb@kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============5231035709509622490==
Content-Type: multipart/alternative; boundary=0016e657af566d93b104a9b135dd

--0016e657af566d93b104a9b135dd
Content-Type: text/plain; charset=UTF-8

On Wed, Aug 3, 2011 at 12:44 PM, Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
>
> cpuidle users should call cpuidle_call_idle() directly
> rather than via (pm_idle)() function pointer.
>
> Architecture may choose to continue using (pm_idle)(),
> but cpuidle need not depend on it:
>
>  my_arch_cpu_idle()
>        ...
>        if(cpuidle_call_idle())
>                pm_idle();
>
> cc: x86@kernel.org
> cc: Kevin Hilman <khilman@deeprootsystems.com>
> cc: Paul Mundt <lethal@linux-sh.org>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/arm/kernel/process.c    |    4 +++-
>  arch/sh/kernel/idle.c        |    6 ++++--
>  arch/x86/kernel/process_32.c |    4 +++-
>  arch/x86/kernel/process_64.c |    4 +++-
>  drivers/cpuidle/cpuidle.c    |   38 ++++++++++++++++++--------------------
>  include/linux/cpuidle.h      |    2 ++
>  6 files changed, 33 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 5e1e541..d7ee0d4 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -30,6 +30,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/random.h>
>  #include <linux/hw_breakpoint.h>
> +#include <linux/cpuidle.h>
>
>  #include <asm/cacheflush.h>
>  #include <asm/leds.h>
> @@ -196,7 +197,8 @@ void cpu_idle(void)
>                                cpu_relax();
>                        } else {
>                                stop_critical_timings();
> -                               pm_idle();
> +                               if (cpuidle_call_idle())
>

Hi Len,

This should be cpuidle_idle_call()


> +                                       pm_idle();
>                                start_critical_timings();
>                                /*
>                                 * This will eventually be removed - pm_idle
> diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
> index 425d604..9c7099e 100644
> --- a/arch/sh/kernel/idle.c
> +++ b/arch/sh/kernel/idle.c
> @@ -16,12 +16,13 @@
>  #include <linux/thread_info.h>
>  #include <linux/irqflags.h>
>  #include <linux/smp.h>
> +#include <linux/cpuidle.h>
>  #include <asm/pgalloc.h>
>  #include <asm/system.h>
>  #include <asm/atomic.h>
>  #include <asm/smp.h>
>
> -void (*pm_idle)(void) = NULL;
> +static void (*pm_idle)(void);
>
>  static int hlt_counter;
>
> @@ -100,7 +101,8 @@ void cpu_idle(void)
>                        local_irq_disable();
>                        /* Don't trace irqs off for idle */
>                        stop_critical_timings();
> -                       pm_idle();
> +                       if (cpuidle_call_idle())
>

Again this should be cpuidle_idle_call()

+                               pm_idle();
>                        /*
>                         * Sanity check to ensure that pm_idle() returns
>                         * with IRQs enabled
> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index a3d0dc5..7a3b651 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -38,6 +38,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/io.h>
>  #include <linux/kdebug.h>
> +#include <linux/cpuidle.h>
>
>  #include <asm/pgtable.h>
>  #include <asm/system.h>
> @@ -109,7 +110,8 @@ void cpu_idle(void)
>                        local_irq_disable();
>                        /* Don't trace irqs off for idle */
>                        stop_critical_timings();
> -                       pm_idle();
> +                       if (cpuidle_idle_call())
> +                               pm_idle();
>                        start_critical_timings();
>                }
>                tick_nohz_restart_sched_tick();
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index ca6f7ab..f693e44 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -37,6 +37,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/io.h>
>  #include <linux/ftrace.h>
> +#include <linux/cpuidle.h>
>
>  #include <asm/pgtable.h>
>  #include <asm/system.h>
> @@ -136,7 +137,8 @@ void cpu_idle(void)
>                        enter_idle();
>                        /* Don't trace irqs off for idle */
>                        stop_critical_timings();
> -                       pm_idle();
> +                       if (cpuidle_idle_call())
> +                               pm_idle();
>                        start_critical_timings();
>
>                        /* In many cases the interrupt that ended idle
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 041df0b..d4c5423 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -25,10 +25,10 @@ DEFINE_PER_CPU(struct cpuidle_device *,
> cpuidle_devices);
>
>  DEFINE_MUTEX(cpuidle_lock);
>  LIST_HEAD(cpuidle_detected_devices);
> -static void (*pm_idle_old)(void);
>
>  static int enabled_devices;
>  static int off __read_mostly;
> +static int initialized __read_mostly;
>
>  int cpuidle_disabled(void)
>  {
> @@ -56,25 +56,23 @@ static int __cpuidle_register_device(struct
> cpuidle_device *dev);
>  * cpuidle_idle_call - the main idle loop
>  *
>  * NOTE: no locks or semaphores should be used here
> + * return non-zero on failure
>  */
> -static void cpuidle_idle_call(void)
> +int cpuidle_idle_call(void)
>  {
>        struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
>        struct cpuidle_state *target_state;
>        int next_state;
>
> +       if (off)
> +               return -ENODEV;
> +
> +       if (!initialized)
> +               return -ENODEV;
> +
>        /* check if the device is ready */
> -       if (!dev || !dev->enabled) {
> -               if (pm_idle_old)
> -                       pm_idle_old();
> -               else
> -#if defined(CONFIG_ARCH_HAS_DEFAULT_IDLE)
> -                       default_idle();
> -#else
> -                       local_irq_enable();
> -#endif
> -               return;
> -       }
> +       if (!dev || !dev->enabled)
> +               return -EBUSY;
>
>  #if 0
>        /* shows regressions, re-enable for 2.6.29 */
> @@ -99,7 +97,7 @@ static void cpuidle_idle_call(void)
>        next_state = cpuidle_curr_governor->select(dev);
>        if (need_resched()) {
>                local_irq_enable();
> -               return;
> +               return 0;
>        }
>
>        target_state = &dev->states[next_state];
> @@ -124,6 +122,8 @@ static void cpuidle_idle_call(void)
>        /* give the governor an opportunity to reflect on the outcome */
>        if (cpuidle_curr_governor->reflect)
>                cpuidle_curr_governor->reflect(dev);
> +
> +       return 0;
>  }
>
>  /**
> @@ -131,10 +131,10 @@ static void cpuidle_idle_call(void)
>  */
>  void cpuidle_install_idle_handler(void)
>  {
> -       if (enabled_devices && (pm_idle != cpuidle_idle_call)) {
> +       if (enabled_devices) {
>                /* Make sure all changes finished before we switch to new
> idle */
>                smp_wmb();
> -               pm_idle = cpuidle_idle_call;
> +               initialized = 1;
>        }
>  }
>
> @@ -143,8 +143,8 @@ void cpuidle_install_idle_handler(void)
>  */
>  void cpuidle_uninstall_idle_handler(void)
>  {
> -       if (enabled_devices && pm_idle_old && (pm_idle != pm_idle_old)) {
> -               pm_idle = pm_idle_old;
> +       if (enabled_devices) {
> +               initialized = 0;
>                cpuidle_kick_cpus();
>        }
>  }
> @@ -440,8 +440,6 @@ static int __init cpuidle_init(void)
>        if (cpuidle_disabled())
>                return -ENODEV;
>
> -       pm_idle_old = pm_idle;
> -
>        ret = cpuidle_add_class_sysfs(&cpu_sysdev_class);
>        if (ret)
>                return ret;
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index b89f67d..b51629e 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -123,6 +123,7 @@ struct cpuidle_driver {
>
>  #ifdef CONFIG_CPU_IDLE
>  extern void disable_cpuidle(void);
> +extern int cpuidle_idle_call(void);
>
>  extern int cpuidle_register_driver(struct cpuidle_driver *drv);
>  struct cpuidle_driver *cpuidle_get_driver(void);
> @@ -137,6 +138,7 @@ extern void cpuidle_disable_device(struct
> cpuidle_device *dev);
>
>  #else
>  static inline void disable_cpuidle(void) { }
> +static inline int cpuidle_idle_call(void) { return -ENODEV; }
>
>  static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
>  {return -ENODEV; }
> --
> 1.7.6.396.ge0613
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>

--0016e657af566d93b104a9b135dd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Aug 3, 2011 at 12:44 PM, Len Bro=
wn <span dir=3D"ltr">&lt;<a href=3D"mailto:lenb@kernel.org">lenb@kernel.org=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
From: Len Brown &lt;<a href=3D"mailto:len.brown@intel.com">len.brown@intel.=
com</a>&gt;<br>
<br>
cpuidle users should call cpuidle_call_idle() directly<br>
rather than via (pm_idle)() function pointer.<br>
<br>
Architecture may choose to continue using (pm_idle)(),<br>
but cpuidle need not depend on it:<br>
<br>
 =C2=A0my_arch_cpu_idle()<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if(cpuidle_call_idle())<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_idle();<br>
<br>
cc: <a href=3D"mailto:x86@kernel.org">x86@kernel.org</a><br>
cc: Kevin Hilman &lt;<a href=3D"mailto:khilman@deeprootsystems.com">khilman=
@deeprootsystems.com</a>&gt;<br>
cc: Paul Mundt &lt;<a href=3D"mailto:lethal@linux-sh.org">lethal@linux-sh.o=
rg</a>&gt;<br>
Signed-off-by: Len Brown &lt;<a href=3D"mailto:len.brown@intel.com">len.bro=
wn@intel.com</a>&gt;<br>
---<br>
=C2=A0arch/arm/kernel/process.c =C2=A0 =C2=A0| =C2=A0 =C2=A04 +++-<br>
=C2=A0arch/sh/kernel/idle.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A06 +++=
+--<br>
=C2=A0arch/x86/kernel/process_32.c | =C2=A0 =C2=A04 +++-<br>
=C2=A0arch/x86/kernel/process_64.c | =C2=A0 =C2=A04 +++-<br>
=C2=A0drivers/cpuidle/cpuidle.c =C2=A0 =C2=A0| =C2=A0 38 ++++++++++++++++++=
--------------------<br>
=C2=A0include/linux/cpuidle.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 ++<br>
=C2=A06 files changed, 33 insertions(+), 25 deletions(-)<br>
<br>
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c<br>
index 5e1e541..d7ee0d4 100644<br>
--- a/arch/arm/kernel/process.c<br>
+++ b/arch/arm/kernel/process.c<br>
@@ -30,6 +30,7 @@<br>
=C2=A0#include &lt;linux/uaccess.h&gt;<br>
=C2=A0#include &lt;linux/random.h&gt;<br>
=C2=A0#include &lt;linux/hw_breakpoint.h&gt;<br>
+#include &lt;linux/cpuidle.h&gt;<br>
<br>
=C2=A0#include &lt;asm/cacheflush.h&gt;<br>
=C2=A0#include &lt;asm/leds.h&gt;<br>
@@ -196,7 +197,8 @@ void cpu_idle(void)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_relax();<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0} else {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stop_critical_timings();<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_idle();<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpuidle_call_idle())<br></blockquote><d=
iv><br></div><div>Hi Len,</div><div><br></div><div>This should be cpuidle_i=
dle_call()</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_idle();<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start_critical_timings();<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * This will eventually be removed - =
pm_idle<br>
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c<br>
index 425d604..9c7099e 100644<br>
--- a/arch/sh/kernel/idle.c<br>
+++ b/arch/sh/kernel/idle.c<br>
@@ -16,12 +16,13 @@<br>
=C2=A0#include &lt;linux/thread_info.h&gt;<br>
=C2=A0#include &lt;linux/irqflags.h&gt;<br>
=C2=A0#include &lt;linux/smp.h&gt;<br>
+#include &lt;linux/cpuidle.h&gt;<br>
=C2=A0#include &lt;asm/pgalloc.h&gt;<br>
=C2=A0#include &lt;asm/system.h&gt;<br>
=C2=A0#include &lt;asm/atomic.h&gt;<br>
=C2=A0#include &lt;asm/smp.h&gt;<br>
<br>
-void (*pm_idle)(void) =3D NULL;<br>
+static void (*pm_idle)(void);<br>
<br>
=C2=A0static int hlt_counter;<br>
<br>
@@ -100,7 +101,8 @@ void cpu_idle(void)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0local_irq_disable();<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Don&#39;t trace irqs off for idle */<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0stop_critical_timings();<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pm_idle();<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (cpuidle_call_idle())<br></blockquote><div>=C2=A0</div><div>Again th=
is should be cpuidle_idle_call()=C2=A0</div><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex;">

+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_idle();<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/*<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * Sanity check to ensure that pm_idle() returns<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * with IRQs enabled<br>
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c<br=
>
index a3d0dc5..7a3b651 100644<br>
--- a/arch/x86/kernel/process_32.c<br>
+++ b/arch/x86/kernel/process_32.c<br>
@@ -38,6 +38,7 @@<br>
=C2=A0#include &lt;linux/uaccess.h&gt;<br>
=C2=A0#include &lt;linux/io.h&gt;<br>
=C2=A0#include &lt;linux/kdebug.h&gt;<br>
+#include &lt;linux/cpuidle.h&gt;<br>
<br>
=C2=A0#include &lt;asm/pgtable.h&gt;<br>
=C2=A0#include &lt;asm/system.h&gt;<br>
@@ -109,7 +110,8 @@ void cpu_idle(void)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0local_irq_disable();<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Don&#39;t trace irqs off for idle */<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0stop_critical_timings();<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pm_idle();<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (cpuidle_idle_call())<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_idle();<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0start_critical_timings();<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tick_nohz_restart_s=
ched_tick();<br>
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c<br=
>
index ca6f7ab..f693e44 100644<br>
--- a/arch/x86/kernel/process_64.c<br>
+++ b/arch/x86/kernel/process_64.c<br>
@@ -37,6 +37,7 @@<br>
=C2=A0#include &lt;linux/uaccess.h&gt;<br>
=C2=A0#include &lt;linux/io.h&gt;<br>
=C2=A0#include &lt;linux/ftrace.h&gt;<br>
+#include &lt;linux/cpuidle.h&gt;<br>
<br>
=C2=A0#include &lt;asm/pgtable.h&gt;<br>
=C2=A0#include &lt;asm/system.h&gt;<br>
@@ -136,7 +137,8 @@ void cpu_idle(void)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0enter_idle();<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Don&#39;t trace irqs off for idle */<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0stop_critical_timings();<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pm_idle();<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (cpuidle_idle_call())<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_idle();<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0start_critical_timings();<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* In many cases the interrupt that ended idle<br>
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c<br>
index 041df0b..d4c5423 100644<br>
--- a/drivers/cpuidle/cpuidle.c<br>
+++ b/drivers/cpuidle/cpuidle.c<br>
@@ -25,10 +25,10 @@ DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices=
);<br>
<br>
=C2=A0DEFINE_MUTEX(cpuidle_lock);<br>
=C2=A0LIST_HEAD(cpuidle_detected_devices);<br>
-static void (*pm_idle_old)(void);<br>
<br>
=C2=A0static int enabled_devices;<br>
=C2=A0static int off __read_mostly;<br>
+static int initialized __read_mostly;<br>
<br>
=C2=A0int cpuidle_disabled(void)<br>
=C2=A0{<br>
@@ -56,25 +56,23 @@ static int __cpuidle_register_device(struct cpuidle_dev=
ice *dev);<br>
 =C2=A0* cpuidle_idle_call - the main idle loop<br>
 =C2=A0*<br>
 =C2=A0* NOTE: no locks or semaphores should be used here<br>
+ * return non-zero on failure<br>
 =C2=A0*/<br>
-static void cpuidle_idle_call(void)<br>
+int cpuidle_idle_call(void)<br>
=C2=A0{<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cpuidle_device *dev =3D __this_cpu_read(=
cpuidle_devices);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cpuidle_state *target_state;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int next_state;<br>
<br>
+ =C2=A0 =C2=A0 =C2=A0 if (off)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
+<br>
+ =C2=A0 =C2=A0 =C2=A0 if (!initialized)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;<br>
+<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* check if the device is ready */<br>
- =C2=A0 =C2=A0 =C2=A0 if (!dev || !dev-&gt;enabled) {<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pm_idle_old)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pm_idle_old();<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-#if defined(CONFIG_ARCH_HAS_DEFAULT_IDLE)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 default_idle();<br>
-#else<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 local_irq_enable();<br>
-#endif<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
- =C2=A0 =C2=A0 =C2=A0 }<br>
+ =C2=A0 =C2=A0 =C2=A0 if (!dev || !dev-&gt;enabled)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBUSY;<br>
<br>
=C2=A0#if 0<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* shows regressions, re-enable for 2.6.29 */<b=
r>
@@ -99,7 +97,7 @@ static void cpuidle_idle_call(void)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0next_state =3D cpuidle_curr_governor-&gt;select=
(dev);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (need_resched()) {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_enable();=
<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_state =3D &amp;dev-&gt;states[next_state=
];<br>
@@ -124,6 +122,8 @@ static void cpuidle_idle_call(void)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* give the governor an opportunity to reflect =
on the outcome */<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpuidle_curr_governor-&gt;reflect)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpuidle_curr_govern=
or-&gt;reflect(dev);<br>
+<br>
+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
@@ -131,10 +131,10 @@ static void cpuidle_idle_call(void)<br>
 =C2=A0*/<br>
=C2=A0void cpuidle_install_idle_handler(void)<br>
=C2=A0{<br>
- =C2=A0 =C2=A0 =C2=A0 if (enabled_devices &amp;&amp; (pm_idle !=3D cpuidle=
_idle_call)) {<br>
+ =C2=A0 =C2=A0 =C2=A0 if (enabled_devices) {<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Make sure all ch=
anges finished before we switch to new idle */<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0smp_wmb();<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_idle =3D cpuidle_idle=
_call;<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initialized =3D 1;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -143,8 +143,8 @@ void cpuidle_install_idle_handler(void)<br>
 =C2=A0*/<br>
=C2=A0void cpuidle_uninstall_idle_handler(void)<br>
=C2=A0{<br>
- =C2=A0 =C2=A0 =C2=A0 if (enabled_devices &amp;&amp; pm_idle_old &amp;&amp=
; (pm_idle !=3D pm_idle_old)) {<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_idle =3D pm_idle_old;=
<br>
+ =C2=A0 =C2=A0 =C2=A0 if (enabled_devices) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initialized =3D 0;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpuidle_kick_cpus()=
;<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
@@ -440,8 +440,6 @@ static int __init cpuidle_init(void)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cpuidle_disabled())<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV;<br>
<br>
- =C2=A0 =C2=A0 =C2=A0 pm_idle_old =3D pm_idle;<br>
-<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D cpuidle_add_class_sysfs(&amp;cpu_sysdev=
_class);<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h<br>
index b89f67d..b51629e 100644<br>
--- a/include/linux/cpuidle.h<br>
+++ b/include/linux/cpuidle.h<br>
@@ -123,6 +123,7 @@ struct cpuidle_driver {<br>
<br>
=C2=A0#ifdef CONFIG_CPU_IDLE<br>
=C2=A0extern void disable_cpuidle(void);<br>
+extern int cpuidle_idle_call(void);<br>
<br>
=C2=A0extern int cpuidle_register_driver(struct cpuidle_driver *drv);<br>
=C2=A0struct cpuidle_driver *cpuidle_get_driver(void);<br>
@@ -137,6 +138,7 @@ extern void cpuidle_disable_device(struct cpuidle_devic=
e *dev);<br>
<br>
=C2=A0#else<br>
=C2=A0static inline void disable_cpuidle(void) { }<br>
+static inline int cpuidle_idle_call(void) { return -ENODEV; }<br>
<br>
=C2=A0static inline int cpuidle_register_driver(struct cpuidle_driver *drv)=
<br>
=C2=A0{return -ENODEV; }<br>
<font color=3D"#888888">--<br>
1.7.6.396.ge0613<br>
<br>
_______________________________________________<br>
linux-pm mailing list<br>
<a href=3D"mailto:linux-pm@lists.linux-foundation.org">linux-pm@lists.linux=
-foundation.org</a><br>
<a href=3D"https://lists.linux-foundation.org/mailman/listinfo/linux-pm" ta=
rget=3D"_blank">https://lists.linux-foundation.org/mailman/listinfo/linux-p=
m</a><br>
</font></blockquote></div><br>

--0016e657af566d93b104a9b135dd--

--===============5231035709509622490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5231035709509622490==--
