From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [RESEND PATCH] PM: add a config that give warnning
 if driver take too long on suspend/resume.
Date: Tue, 12 Apr 2011 00:48:25 +0800
Message-ID: <BANLkTi=Q8N-=gjiS6M1b-krjqceVHfk8GQ@mail.gmail.com>
References: <1302180894-16468-1-git-send-email-kzjeef@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2959757781992624014=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1302180894-16468-1-git-send-email-kzjeef@gmail.com>
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
To: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg Kroah-Hartman <gregkh@suse.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============2959757781992624014==
Content-Type: multipart/alternative; boundary=001636e0a66f4f1b9204a0a75976

--001636e0a66f4f1b9204a0a75976
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Does anyone have comments on this driver?

Best regards,
Zhang Jiejing


2011/4/7 Jiejing Zhang <kzjeef@gmail.com>

> From: Zhang Jiejing <jiejing.zhang@freescale.com>
>
> This patch add function to check each device's suspend time
> consumption. If any driver takes more time that the threshold (default
> 0.5 ms), it will print a warnning message including the device and bus
> name on the console.  You can change the threshold on-the-fly by
> modify file '/sys/power/device_suspend_time_threshold' to adjust this
> value,the unit is in microsecond.
>
> The output is like:
> PM: device (bus)   :(device name) suspend/resume too slow, takes (time)
> msencs.
> PM: device platform:soc-audio.2 suspend too slow, takes          606.696
> msecs
> PM: device platform:mxc_sdc_fb.1 suspend too slow, takes         7.708
> msecs
>
> Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
> ---
>  drivers/base/power/main.c  |   40 +++++++++++++++++++++++++++++++++++++++-
>  drivers/base/power/power.h |    3 +++
>  kernel/power/Kconfig       |   15 +++++++++++++++
>  kernel/power/main.c        |   32 ++++++++++++++++++++++++++++++++
>  4 files changed, 89 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 052dc53..000243c 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -178,6 +178,40 @@ static void initcall_debug_report(struct device *dev,
> ktime_t calltime,
>        }
>  }
>
> +#ifdef CONFIG_SUSPEND_DEVICE_TIME_DEBUG
> +static void suspend_time_debug_start(ktime_t *start)
> +{
> +       *start = ktime_get();
> +}
> +
> +static void suspend_time_debug_report(const char *name, struct device
> *dev,
> +                                     ktime_t starttime)
> +{
> +       ktime_t rettime;
> +       s64 usecs64;
> +       int usecs;
> +
> +       if (!dev->driver)
> +               return;
> +
> +       rettime = ktime_get();
> +       usecs64 = ktime_to_us(ktime_sub(rettime, starttime));
> +       usecs = usecs64;
> +       if (usecs == 0)
> +               usecs = 1;
> +
> +       if (device_suspend_time_threshold
> +           && usecs > device_suspend_time_threshold)
> +               pr_info("PM: device %s:%s %s too slow, it takes \t
> %ld.%03ld mses\n",
> +                       dev->bus->name, dev_name(dev), name,
> +                       usecs / USEC_PER_MSEC, usecs % USEC_PER_MSEC);
> +}
> +#else
> +static void suspend_time_debug_start(ktime_t *start) {}
> +static void suspend_time_debug_report(const char *name, struct device
> *dev,
> +                                     ktime_t starttime) {}
> +#endif /* CONFIG_SUSPEND_DEVICE_TIME_DEBUG */
> +
>  /**
>  * dpm_wait - Wait for a PM operation to complete.
>  * @dev: Device to wait for.
> @@ -214,7 +248,7 @@ static int pm_op(struct device *dev,
>                 pm_message_t state)
>  {
>        int error = 0;
> -       ktime_t calltime;
> +       ktime_t calltime, starttime;
>
>        calltime = initcall_debug_start(dev);
>
> @@ -222,13 +256,17 @@ static int pm_op(struct device *dev,
>  #ifdef CONFIG_SUSPEND
>        case PM_EVENT_SUSPEND:
>                if (ops->suspend) {
> +                       suspend_time_debug_start(&starttime);
>                        error = ops->suspend(dev);
> +                       suspend_time_debug_report("suspend", dev,
> starttime);
>                        suspend_report_result(ops->suspend, error);
>                }
>                break;
>        case PM_EVENT_RESUME:
>                if (ops->resume) {
> +                       suspend_time_debug_start(&starttime);
>                        error = ops->resume(dev);
> +                       suspend_time_debug_report("resume", dev,
> starttime);
>                        suspend_report_result(ops->resume, error);
>                }
>                break;
> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index f2a25f1..72d5963 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -18,6 +18,9 @@ extern int pm_async_enabled;
>  /* drivers/base/power/main.c */
>  extern struct list_head dpm_list;      /* The active device list */
>
> +/* driver/base/power/main.c */
> +extern int device_suspend_time_threshold;
> +
>  static inline struct device *to_device(struct list_head *entry)
>  {
>        return container_of(entry, struct device, power.entry);
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 4603f08..9b82c4b 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -87,6 +87,21 @@ config PM_SLEEP
>        def_bool y
>        depends on SUSPEND || HIBERNATION || XEN_SAVE_RESTORE
>
> +config SUSPEND_DEVICE_TIME_DEBUG
> +        bool "Warnning device suspend/resume takes too much time"
> +       depends on SUSPEND && PM_DEBUG
> +       default n
> +       ---help---
> +
> +       This option will enable a timing function to check each device
> +        suspend time consumption, If the device takes more time that
> +        the threshold (default 0.5 ms), it will print the device and
> +        bus name on the console.  You can change the threshold
> +        on-the-fly by modify "/sys/power/device_suspend_time_threshold"
> +        the unit is in microsecond.
> +
> +       This options only for debug proprose, If in doubt, say N.
> +
>  config PM_SLEEP_SMP
>        def_bool y
>        depends on SMP
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 8eaba5f..d2e734f 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -297,12 +297,44 @@ power_attr(pm_trace_dev_match);
>
>  #endif /* CONFIG_PM_TRACE */
>
> +#ifdef CONFIG_SUSPEND_DEVICE_TIME_DEBUG
> +/*
> + * threshold of device suspend time consumption in microsecond(0.5ms), the
> + * driver suspend/resume time longer than this threshold will be
> + * print to console, 0 to disable */
> +int device_suspend_time_threshold = 500;
> +
> +static ssize_t
> +device_suspend_time_threshold_show(struct kobject *kobj,
> +                                  struct kobj_attribute *attr, char *buf)
> +{
> +       return sprintf(buf, "%d\n", device_suspend_time_threshold);
> +}
> +
> +static ssize_t
> +device_suspend_time_threshold_store(struct kobject *kobj,
> +                                   struct kobj_attribute *attr,
> +                                   const char *buf, size_t n)
> +{
> +       int val;
> +       if (sscanf(buf, "%d", &val) > 0) {
> +               device_suspend_time_threshold = val;
> +               return n;
> +       }
> +       return -EINVAL;
> +}
> +power_attr(device_suspend_time_threshold);
> +#endif
> +
>  static struct attribute * g[] = {
>        &state_attr.attr,
>  #ifdef CONFIG_PM_TRACE
>        &pm_trace_attr.attr,
>        &pm_trace_dev_match_attr.attr,
>  #endif
> +#ifdef CONFIG_SUSPEND_DEVICE_TIME_DEBUG
> +       &device_suspend_time_threshold_attr.attr,
> +#endif
>  #ifdef CONFIG_PM_SLEEP
>        &pm_async_attr.attr,
>        &wakeup_count_attr.attr,
> --
> 1.7.1
>
>

--001636e0a66f4f1b9204a0a75976
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>Does anyone have comments on this driver?<br clear=
=3D"all"><div><br></div>Best regards,<br>Zhang Jiejing<br>
<br><br><div class=3D"gmail_quote">2011/4/7 Jiejing Zhang <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:kzjeef@gmail.com">kzjeef@gmail.com</a>&gt;</span><br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex;">

From: Zhang Jiejing &lt;<a href=3D"mailto:jiejing.zhang@freescale.com">jiej=
ing.zhang@freescale.com</a>&gt;<br>
<br>
This patch add function to check each device&#39;s suspend time<br>
consumption. If any driver takes more time that the threshold (default<br>
0.5 ms), it will print a warnning message including the device and bus<br>
name on the console. =A0You can change the threshold on-the-fly by<br>
modify file &#39;/sys/power/device_suspend_time_threshold&#39; to adjust th=
is<br>
value,the unit is in microsecond.<br>
<br>
The output is like:<br>
PM: device (bus) =A0 :(device name) suspend/resume too slow, takes (time) m=
sencs.<br>
PM: device platform:soc-audio.2 suspend too slow, takes =A0 =A0 =A0 =A0 =A0=
606.696 msecs<br>
PM: device platform:mxc_sdc_fb.1 suspend too slow, takes =A0 =A0 =A0 =A0 7.=
708 msecs<br>
<br>
Signed-off-by: Zhang Jiejing &lt;<a href=3D"mailto:jiejing.zhang@freescale.=
com">jiejing.zhang@freescale.com</a>&gt;<br>
---<br>
=A0drivers/base/power/main.c =A0| =A0 40 ++++++++++++++++++++++++++++++++++=
+++++-<br>
=A0drivers/base/power/power.h | =A0 =A03 +++<br>
=A0kernel/power/Kconfig =A0 =A0 =A0 | =A0 15 +++++++++++++++<br>
=A0kernel/power/main.c =A0 =A0 =A0 =A0| =A0 32 ++++++++++++++++++++++++++++=
++++<br>
=A04 files changed, 89 insertions(+), 1 deletions(-)<br>
<br>
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c<br>
index 052dc53..000243c 100644<br>
--- a/drivers/base/power/main.c<br>
+++ b/drivers/base/power/main.c<br>
@@ -178,6 +178,40 @@ static void initcall_debug_report(struct device *dev, =
ktime_t calltime,<br>
 =A0 =A0 =A0 =A0}<br>
=A0}<br>
<br>
+#ifdef CONFIG_SUSPEND_DEVICE_TIME_DEBUG<br>
+static void suspend_time_debug_start(ktime_t *start)<br>
+{<br>
+ =A0 =A0 =A0 *start =3D ktime_get();<br>
+}<br>
+<br>
+static void suspend_time_debug_report(const char *name, struct device *dev=
,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 k=
time_t starttime)<br>
+{<br>
+ =A0 =A0 =A0 ktime_t rettime;<br>
+ =A0 =A0 =A0 s64 usecs64;<br>
+ =A0 =A0 =A0 int usecs;<br>
+<br>
+ =A0 =A0 =A0 if (!dev-&gt;driver)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
+<br>
+ =A0 =A0 =A0 rettime =3D ktime_get();<br>
+ =A0 =A0 =A0 usecs64 =3D ktime_to_us(ktime_sub(rettime, starttime));<br>
+ =A0 =A0 =A0 usecs =3D usecs64;<br>
+ =A0 =A0 =A0 if (usecs =3D=3D 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 usecs =3D 1;<br>
+<br>
+ =A0 =A0 =A0 if (device_suspend_time_threshold<br>
+ =A0 =A0 =A0 =A0 =A0 &amp;&amp; usecs &gt; device_suspend_time_threshold)<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info(&quot;PM: device %s:%s %s too slow, i=
t takes \t %ld.%03ld mses\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev-&gt;bus-&gt;name, dev_nam=
e(dev), name,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usecs / USEC_PER_MSEC, usecs =
% USEC_PER_MSEC);<br>
+}<br>
+#else<br>
+static void suspend_time_debug_start(ktime_t *start) {}<br>
+static void suspend_time_debug_report(const char *name, struct device *dev=
,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 k=
time_t starttime) {}<br>
+#endif /* CONFIG_SUSPEND_DEVICE_TIME_DEBUG */<br>
+<br>
=A0/**<br>
 =A0* dpm_wait - Wait for a PM operation to complete.<br>
 =A0* @dev: Device to wait for.<br>
@@ -214,7 +248,7 @@ static int pm_op(struct device *dev,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_message_t state)<br>
=A0{<br>
 =A0 =A0 =A0 =A0int error =3D 0;<br>
- =A0 =A0 =A0 ktime_t calltime;<br>
+ =A0 =A0 =A0 ktime_t calltime, starttime;<br>
<br>
 =A0 =A0 =A0 =A0calltime =3D initcall_debug_start(dev);<br>
<br>
@@ -222,13 +256,17 @@ static int pm_op(struct device *dev,<br>
=A0#ifdef CONFIG_SUSPEND<br>
 =A0 =A0 =A0 =A0case PM_EVENT_SUSPEND:<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ops-&gt;suspend) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_time_debug_start(&amp=
;starttime);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D ops-&gt;suspend(d=
ev);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_time_debug_report(&qu=
ot;suspend&quot;, dev, starttime);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0suspend_report_result(ops-&=
gt;suspend, error);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;<br>
 =A0 =A0 =A0 =A0case PM_EVENT_RESUME:<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ops-&gt;resume) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_time_debug_start(&amp=
;starttime);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error =3D ops-&gt;resume(de=
v);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_time_debug_report(&qu=
ot;resume&quot;, dev, starttime);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0suspend_report_result(ops-&=
gt;resume, error);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;<br>
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h<br>
index f2a25f1..72d5963 100644<br>
--- a/drivers/base/power/power.h<br>
+++ b/drivers/base/power/power.h<br>
@@ -18,6 +18,9 @@ extern int pm_async_enabled;<br>
=A0/* drivers/base/power/main.c */<br>
=A0extern struct list_head dpm_list; =A0 =A0 =A0/* The active device list *=
/<br>
<br>
+/* driver/base/power/main.c */<br>
+extern int device_suspend_time_threshold;<br>
+<br>
=A0static inline struct device *to_device(struct list_head *entry)<br>
=A0{<br>
 =A0 =A0 =A0 =A0return container_of(entry, struct device, power.entry);<br>
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig<br>
index 4603f08..9b82c4b 100644<br>
--- a/kernel/power/Kconfig<br>
+++ b/kernel/power/Kconfig<br>
@@ -87,6 +87,21 @@ config PM_SLEEP<br>
 =A0 =A0 =A0 =A0def_bool y<br>
 =A0 =A0 =A0 =A0depends on SUSPEND || HIBERNATION || XEN_SAVE_RESTORE<br>
<br>
+config SUSPEND_DEVICE_TIME_DEBUG<br>
+ =A0 =A0 =A0 =A0bool &quot;Warnning device suspend/resume takes too much t=
ime&quot;<br>
+ =A0 =A0 =A0 depends on SUSPEND &amp;&amp; PM_DEBUG<br>
+ =A0 =A0 =A0 default n<br>
+ =A0 =A0 =A0 ---help---<br>
+<br>
+ =A0 =A0 =A0 This option will enable a timing function to check each devic=
e<br>
+ =A0 =A0 =A0 =A0suspend time consumption, If the device takes more time th=
at<br>
+ =A0 =A0 =A0 =A0the threshold (default 0.5 ms), it will print the device a=
nd<br>
+ =A0 =A0 =A0 =A0bus name on the console. =A0You can change the threshold<b=
r>
+ =A0 =A0 =A0 =A0on-the-fly by modify &quot;/sys/power/device_suspend_time_=
threshold&quot;<br>
+ =A0 =A0 =A0 =A0the unit is in microsecond.<br>
+<br>
+ =A0 =A0 =A0 This options only for debug proprose, If in doubt, say N.<br>
+<br>
=A0config PM_SLEEP_SMP<br>
 =A0 =A0 =A0 =A0def_bool y<br>
 =A0 =A0 =A0 =A0depends on SMP<br>
diff --git a/kernel/power/main.c b/kernel/power/main.c<br>
index 8eaba5f..d2e734f 100644<br>
--- a/kernel/power/main.c<br>
+++ b/kernel/power/main.c<br>
@@ -297,12 +297,44 @@ power_attr(pm_trace_dev_match);<br>
<br>
=A0#endif /* CONFIG_PM_TRACE */<br>
<br>
+#ifdef CONFIG_SUSPEND_DEVICE_TIME_DEBUG<br>
+/*<br>
+ * threshold of device suspend time consumption in microsecond(0.5ms), the=
<br>
+ * driver suspend/resume time longer than this threshold will be<br>
+ * print to console, 0 to disable */<br>
+int device_suspend_time_threshold =3D 500;<br>
+<br>
+static ssize_t<br>
+device_suspend_time_threshold_show(struct kobject *kobj,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct=
 kobj_attribute *attr, char *buf)<br>
+{<br>
+ =A0 =A0 =A0 return sprintf(buf, &quot;%d\n&quot;, device_suspend_time_thr=
eshold);<br>
+}<br>
+<br>
+static ssize_t<br>
+device_suspend_time_threshold_store(struct kobject *kobj,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t kobj_attribute *attr,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const=
 char *buf, size_t n)<br>
+{<br>
+ =A0 =A0 =A0 int val;<br>
+ =A0 =A0 =A0 if (sscanf(buf, &quot;%d&quot;, &amp;val) &gt; 0) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_suspend_time_threshold =3D val;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return n;<br>
+ =A0 =A0 =A0 }<br>
+ =A0 =A0 =A0 return -EINVAL;<br>
+}<br>
+power_attr(device_suspend_time_threshold);<br>
+#endif<br>
+<br>
=A0static struct attribute * g[] =3D {<br>
 =A0 =A0 =A0 =A0&amp;state_attr.attr,<br>
=A0#ifdef CONFIG_PM_TRACE<br>
 =A0 =A0 =A0 =A0&amp;pm_trace_attr.attr,<br>
 =A0 =A0 =A0 =A0&amp;pm_trace_dev_match_attr.attr,<br>
=A0#endif<br>
+#ifdef CONFIG_SUSPEND_DEVICE_TIME_DEBUG<br>
+ =A0 =A0 =A0 &amp;device_suspend_time_threshold_attr.attr,<br>
+#endif<br>
=A0#ifdef CONFIG_PM_SLEEP<br>
 =A0 =A0 =A0 =A0&amp;pm_async_attr.attr,<br>
 =A0 =A0 =A0 =A0&amp;wakeup_count_attr.attr,<br>
<font color=3D"#888888">--<br>
1.7.1<br>
<br>
</font></blockquote></div><br></div>

--001636e0a66f4f1b9204a0a75976--

--===============2959757781992624014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2959757781992624014==--
