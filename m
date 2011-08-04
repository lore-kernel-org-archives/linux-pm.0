From: "Liu, ShuoX" <shuox.liu@intel.com>
Subject: [PATCH] PM: add statistics sysfs file for suspend to ram
Date: Thu, 4 Aug 2011 13:09:51 +0800
Message-ID: <6E3BC7F7C9A4BF4286DD4C043110F30B5B790E573B@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0307965158589121749=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-US
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
To: "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "rjw@sisk.pl" <rjw@sisk.pl>, "gregkh@suse.de" <gregkh@suse.de>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============0307965158589121749==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_6E3BC7F7C9A4BF4286DD4C043110F30B5B790E573Bshsmsx502ccrc_"

--_000_6E3BC7F7C9A4BF4286DD4C043110F30B5B790E573Bshsmsx502ccrc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From a906b0b5b4ff3414ceb9fc7a69a3d7c9d66e46b1 Mon Sep 17 00:00:00 2001
From: ShuoX Liu <shuox.liu@intel.com>
Date: Thu, 28 Jul 2011 10:54:22 +0800
Subject: [PATCH] PM: add statistics sysfs file for suspend to ram.

Record S3 failure time about each reason and the latest two failed
devices' name in S3 progress.
We can check it through /sys/power/suspend_stats.

Change-Id: Ieed7fd74e27d3b482675a20cb0bb26b9054a1624
Signed-off-by: ShuoX Liu <shuox.liu@intel.com>
---
 drivers/base/power/main.c |   31 +++++++++++++++++++++++++--
 include/linux/suspend.h   |   16 ++++++++++++++
 kernel/power/main.c       |   49 +++++++++++++++++++++++++++++++++++++++++=
++++
 kernel/power/suspend.c    |   13 ++++++++++-
 4 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index a854591..da1c561 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -46,6 +46,7 @@ LIST_HEAD(dpm_prepared_list);
 LIST_HEAD(dpm_suspended_list);
 LIST_HEAD(dpm_noirq_list);

+struct suspend_stats suspend_stats;
 static DEFINE_MUTEX(dpm_list_mtx);
 static pm_message_t pm_transition;

@@ -180,6 +181,15 @@ static void initcall_debug_report(struct device *dev, =
ktime_t calltime,
    }
 }

+static void dpm_save_dev_name(const char *name)
+{
+   strlcpy(suspend_stats.failed_devs[suspend_stats.last_failed],
+       name,
+       sizeof(suspend_stats.failed_devs[0]));
+   suspend_stats.last_failed++;
+   suspend_stats.last_failed %=3D REC_FAILED_DEV_NUM;
+}
+
 /**
  * dpm_wait - Wait for a PM operation to complete.
  * @dev: Device to wait for.
@@ -464,8 +474,11 @@ void dpm_resume_noirq(pm_message_t state)
        mutex_unlock(&dpm_list_mtx);

        error =3D device_resume_noirq(dev, state);
-       if (error)
+       if (error) {
+           suspend_stats.failed_resume_noirq++;
+           dpm_save_dev_name(dev_name(dev));
            pm_dev_err(dev, state, " early", error);
+       }

        mutex_lock(&dpm_list_mtx);
        put_device(dev);
@@ -626,8 +639,11 @@ void dpm_resume(pm_message_t state)
            mutex_unlock(&dpm_list_mtx);

            error =3D device_resume(dev, state, false);
-           if (error)
+           if (error) {
+               suspend_stats.failed_resume++;
+               dpm_save_dev_name(dev_name(dev));
                pm_dev_err(dev, state, "", error);
+           }

            mutex_lock(&dpm_list_mtx);
        }
@@ -802,6 +818,8 @@ int dpm_suspend_noirq(pm_message_t state)
        mutex_lock(&dpm_list_mtx);
        if (error) {
            pm_dev_err(dev, state, " late", error);
+           suspend_stats.failed_suspend_noirq++;
+           dpm_save_dev_name(dev_name(dev));
            put_device(dev);
            break;
        }
@@ -923,8 +941,10 @@ static void async_suspend(void *data, async_cookie_t c=
ookie)
    int error;

    error =3D __device_suspend(dev, pm_transition, true);
-   if (error)
+   if (error) {
+       dpm_save_dev_name(dev_name(dev));
        pm_dev_err(dev, pm_transition, " async", error);
+   }

    put_device(dev);
 }
@@ -967,6 +987,7 @@ int dpm_suspend(pm_message_t state)
        mutex_lock(&dpm_list_mtx);
        if (error) {
            pm_dev_err(dev, state, "", error);
+           dpm_save_dev_name(dev_name(dev));
            put_device(dev);
            break;
        }
@@ -982,6 +1003,8 @@ int dpm_suspend(pm_message_t state)
        error =3D async_error;
    if (!error)
        dpm_show_time(starttime, state, NULL);
+   else
+       suspend_stats.failed_suspend++;
    return error;
 }

@@ -1090,6 +1113,8 @@ int dpm_suspend_start(pm_message_t state)
    error =3D dpm_prepare(state);
    if (!error)
        error =3D dpm_suspend(state);
+   else
+       suspend_stats.failed_prepare++;
    return error;
 }
 EXPORT_SYMBOL_GPL(dpm_suspend_start);
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 6bbcef2..6a8ff23 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -34,6 +34,22 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_MEM     ((__force suspend_state_t) 3)
 #define PM_SUSPEND_MAX     ((__force suspend_state_t) 4)

+struct suspend_stats {
+   int success;
+   int fail;
+   int failed_freeze;
+   int failed_prepare;
+   int failed_suspend;
+   int failed_suspend_noirq;
+   int failed_resume;
+   int failed_resume_noirq;
+#define    REC_FAILED_DEV_NUM  2
+   char    failed_devs[REC_FAILED_DEV_NUM][40];
+   int last_failed;
+};
+
+extern struct suspend_stats suspend_stats;
+
 /**
  * struct platform_suspend_ops - Callbacks for managing platform dependent
  * system sleep states.
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6c601f8..32eb67b 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -133,6 +133,50 @@ power_attr(pm_test);

 #endif /* CONFIG_PM_SLEEP */

+static ssize_t suspend_stats_show(struct kobject *kobj,
+               struct kobj_attribute *attr, char *buf)
+{
+   int i, index, last_index;
+   char *s =3D buf;
+
+   last_index =3D suspend_stats.last_failed + REC_FAILED_DEV_NUM - 1;
+   last_index %=3D REC_FAILED_DEV_NUM;
+   s +=3D sprintf(s, "%s: %d\n%s: %d\n%s: %d\n%s: %d\n"
+           "%s: %d\n%s: %d\n%s: %d\n%s: %d\n",
+           "success", suspend_stats.success,
+           "fail", suspend_stats.fail,
+           "failed_freeze", suspend_stats.failed_freeze,
+           "failed_prepare", suspend_stats.failed_prepare,
+           "failed_suspend", suspend_stats.failed_suspend,
+           "failed_suspend_noirq",
+               suspend_stats.failed_suspend_noirq,
+           "failed_resume", suspend_stats.failed_resume,
+           "failed_resume_noirq",
+               suspend_stats.failed_resume_noirq);
+   s +=3D sprintf(s, "failed_devs:\n  last_failed:\t%s\n",
+           suspend_stats.failed_devs[last_index]);
+   for (i =3D 1; i < REC_FAILED_DEV_NUM; i++) {
+       index =3D last_index + REC_FAILED_DEV_NUM - i;
+       index %=3D REC_FAILED_DEV_NUM;
+       s +=3D sprintf(s, "\t\t%s\n",
+           suspend_stats.failed_devs[index]);
+   }
+
+   if (s !=3D buf)
+       /* convert the last space to a newline */
+       *(s-1) =3D '\n';
+
+   return s - buf;
+}
+
+static ssize_t suspend_stats_store(struct kobject *kobj,
+       struct kobj_attribute *attr, const char *buf, size_t n)
+{
+   return n;
+}
+
+power_attr(suspend_stats);
+
 struct kobject *power_kobj;

 /**
@@ -194,6 +238,10 @@ static ssize_t state_store(struct kobject *kobj, struc=
t kobj_attribute *attr,
    }
    if (state < PM_SUSPEND_MAX && *s)
        error =3D enter_state(state);
+       if (error)
+           suspend_stats.fail++;
+       else
+           suspend_stats.success++;
 #endif

  Exit:
@@ -310,6 +358,7 @@ static struct attribute * g[] =3D {
 #ifdef CONFIG_PM_DEBUG
    &pm_test_attr.attr,
 #endif
+   &suspend_stats_attr.attr,
 #endif
    NULL,
 };
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index b6b71ad..9bb4281 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -106,6 +106,8 @@ static int suspend_prepare(void)
    error =3D suspend_freeze_processes();
    if (!error)
        return 0;
+   else
+       suspend_stats.failed_freeze++;

    suspend_thaw_processes();
    usermodehelper_enable();
@@ -315,8 +317,15 @@ int enter_state(suspend_state_t state)
  */
 int pm_suspend(suspend_state_t state)
 {
-   if (state > PM_SUSPEND_ON && state <=3D PM_SUSPEND_MAX)
-       return enter_state(state);
+   int ret;
+   if (state > PM_SUSPEND_ON && state <=3D PM_SUSPEND_MAX) {
+       ret =3D enter_state(state);
+       if (ret)
+           suspend_stats.fail++;
+       else
+           suspend_stats.success++;
+       return ret;
+   }
    return -EINVAL;
 }
 EXPORT_SYMBOL(pm_suspend);
--
1.7.1



--_000_6E3BC7F7C9A4BF4286DD4C043110F30B5B790E573Bshsmsx502ccrc_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 12 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"Arial Unicode MS";
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@Arial Unicode MS";
	panose-1:2 11 6 4 2 2 2 2 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:SimSun;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Arial Unicode MS","sans-serif";
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:SimSun;}
.MsoChpDefault
	{mso-style-type:export-only;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DZH-CN link=3Dblue vli=
nk=3Dpurple style=3D'text-justify-trim:punctuation'><div class=3DWordSectio=
n1><p class=3DMsoPlainText><span lang=3DEN-US>From a906b0b5b4ff3414ceb9fc7a=
69a3d7c9d66e46b1 Mon Sep 17 00:00:00 2001<br>
From: ShuoX Liu &lt;shuox.liu@intel.com&gt;<br>
Date: Thu, 28 Jul 2011 10:54:22 +0800<br>
Subject: [PATCH] PM: add statistics sysfs file for suspend to ram.<br>
<br>
Record S3 failure time about each reason and the latest two failed<br>
devices' name in S3 progress.<br>
We can check it through /sys/power/suspend_stats.<br>
<br>
Change-Id: Ieed7fd74e27d3b482675a20cb0bb26b9054a1624<br>
Signed-off-by: ShuoX Liu &lt;shuox.liu@intel.com&gt;<br>
---<br>
&nbsp;drivers/base/power/main.c |&nbsp;&nbsp; 31 +++++++++++++++++++++++++-=
-<br>
&nbsp;include/linux/suspend.h&nbsp;&nbsp; |&nbsp;&nbsp; 16 ++++++++++++++<b=
r>
&nbsp;kernel/power/main.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;=
 49 +++++++++++++++++++++++++++++++++++++++++++++<br>
&nbsp;kernel/power/suspend.c&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 13 ++++++++++-=
<br>
&nbsp;4 files changed, 104 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c<br>
index a854591..da1c561 100644<br>
--- a/drivers/base/power/main.c<br>
+++ b/drivers/base/power/main.c<br>
@@ -46,6 +46,7 @@ LIST_HEAD(dpm_prepared_list);<br>
&nbsp;LIST_HEAD(dpm_suspended_list);<br>
&nbsp;LIST_HEAD(dpm_noirq_list);<br>
&nbsp;<br>
+struct suspend_stats suspend_stats;<br>
&nbsp;static DEFINE_MUTEX(dpm_list_mtx);<br>
&nbsp;static pm_message_t pm_transition;<br>
&nbsp;<br>
@@ -180,6 +181,15 @@ static void initcall_debug_report(struct device *dev, =
ktime_t calltime,<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
+static void dpm_save_dev_name(const char *name)<br>
+{<br>
+&nbsp;&nbsp; strlcpy(suspend_stats.failed_devs[suspend_stats.last_failed],=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(suspend_stats.failed_devs[0]))=
;<br>
+&nbsp;&nbsp; suspend_stats.last_failed++;<br>
+&nbsp;&nbsp; suspend_stats.last_failed %=3D REC_FAILED_DEV_NUM;<br>
+}<br>
+<br>
&nbsp;/**<br>
&nbsp; * dpm_wait - Wait for a PM operation to complete.<br>
&nbsp; * @dev: Device to wait for.<br>
@@ -464,8 +474,11 @@ void dpm_resume_noirq(pm_message_t state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;dpm_list_mtx);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error =3D device_resume_noirq(de=
v, state);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (error)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (error) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend_stats=
.failed_resume_noirq++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_save_dev_=
name(dev_name(dev));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_dev_e=
rr(dev, state, &quot; early&quot;, error);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;dpm_list_mtx);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; put_device(dev);<br>
@@ -626,8 +639,11 @@ void dpm_resume(pm_message_t state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_un=
lock(&amp;dpm_list_mtx);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error =
=3D device_resume(dev, state, false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (error)<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (error) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; suspend_stats.failed_resume++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dpm_save_dev_name(dev_name(dev));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pm_dev_err(dev, state, &quot;&quot;, error);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lo=
ck(&amp;dpm_list_mtx);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -802,6 +818,8 @@ int dpm_suspend_noirq(pm_message_t state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;dpm_list_mtx);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (error) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_dev_e=
rr(dev, state, &quot; late&quot;, error);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend_stats=
.failed_suspend_noirq++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_save_dev_=
name(dev_name(dev));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; put_devi=
ce(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -923,8 +941,10 @@ static void async_suspend(void *data, async_cookie_t c=
ookie)<br>
&nbsp;&nbsp;&nbsp; int error;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp; error =3D __device_suspend(dev, pm_transition, true);<br=
>
-&nbsp;&nbsp; if (error)<br>
+&nbsp;&nbsp; if (error) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_save_dev_name(dev_name(dev));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_dev_err(dev, pm_transition, &=
quot; async&quot;, error);<br>
+&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp; put_device(dev);<br>
&nbsp;}<br>
@@ -967,6 +987,7 @@ int dpm_suspend(pm_message_t state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;dpm_list_mtx);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (error) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_dev_e=
rr(dev, state, &quot;&quot;, error);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_save_dev_=
name(dev_name(dev));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; put_devi=
ce(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -982,6 +1003,8 @@ int dpm_suspend(pm_message_t state)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error =3D async_error;<br>
&nbsp;&nbsp;&nbsp; if (!error)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_show_time(starttime, state, =
NULL);<br>
+&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend_stats.failed_suspend++;<br>
&nbsp;&nbsp;&nbsp; return error;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -1090,6 +1113,8 @@ int dpm_suspend_start(pm_message_t state)<br>
&nbsp;&nbsp;&nbsp; error =3D dpm_prepare(state);<br>
&nbsp;&nbsp;&nbsp; if (!error)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error =3D dpm_suspend(state);<br=
>
+&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend_stats.failed_prepare++;<br>
&nbsp;&nbsp;&nbsp; return error;<br>
&nbsp;}<br>
&nbsp;EXPORT_SYMBOL_GPL(dpm_suspend_start);<br>
diff --git a/include/linux/suspend.h b/include/linux/suspend.h<br>
index 6bbcef2..6a8ff23 100644<br>
--- a/include/linux/suspend.h<br>
+++ b/include/linux/suspend.h<br>
@@ -34,6 +34,22 @@ typedef int __bitwise suspend_state_t;<br>
&nbsp;#define PM_SUSPEND_MEM&nbsp;&nbsp;&nbsp;&nbsp; ((__force suspend_stat=
e_t) 3)<br>
&nbsp;#define PM_SUSPEND_MAX&nbsp;&nbsp;&nbsp;&nbsp; ((__force suspend_stat=
e_t) 4)<br>
&nbsp;<br>
+struct suspend_stats {<br>
+&nbsp;&nbsp; int success;<br>
+&nbsp;&nbsp; int fail;<br>
+&nbsp;&nbsp; int failed_freeze;<br>
+&nbsp;&nbsp; int failed_prepare;<br>
+&nbsp;&nbsp; int failed_suspend;<br>
+&nbsp;&nbsp; int failed_suspend_noirq;<br>
+&nbsp;&nbsp; int failed_resume;<br>
+&nbsp;&nbsp; int failed_resume_noirq;<br>
+#define&nbsp;&nbsp;&nbsp; REC_FAILED_DEV_NUM&nbsp; 2<br>
+&nbsp;&nbsp; char&nbsp;&nbsp;&nbsp; failed_devs[REC_FAILED_DEV_NUM][40];<b=
r>
+&nbsp;&nbsp; int last_failed;<br>
+};<br>
+<br>
+extern struct suspend_stats suspend_stats;<br>
+<br>
&nbsp;/**<br>
&nbsp; * struct platform_suspend_ops - Callbacks for managing platform depe=
ndent<br>
&nbsp; * system sleep states.<br>
diff --git a/kernel/power/main.c b/kernel/power/main.c<br>
index 6c601f8..32eb67b 100644<br>
--- a/kernel/power/main.c<br>
+++ b/kernel/power/main.c<br>
@@ -133,6 +133,50 @@ power_attr(pm_test);<br>
&nbsp;<br>
&nbsp;#endif /* CONFIG_PM_SLEEP */<br>
&nbsp;<br>
+static ssize_t suspend_stats_show(struct kobject *kobj,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct kobj_attribute *attr, char *buf)<br>
+{<br>
+&nbsp;&nbsp; int i, index, last_index;<br>
+&nbsp;&nbsp; char *s =3D buf;<br>
+<br>
+&nbsp;&nbsp; last_index =3D suspend_stats.last_failed + REC_FAILED_DEV_NUM=
 - 1;<br>
+&nbsp;&nbsp; last_index %=3D REC_FAILED_DEV_NUM;<br>
+&nbsp;&nbsp; s +=3D sprintf(s, &quot;%s: %d\n%s: %d\n%s: %d\n%s: %d\n&quot=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;%s: %d\=
n%s: %d\n%s: %d\n%s: %d\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;success=
&quot;, suspend_stats.success,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;fail&qu=
ot;, suspend_stats.fail,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;failed_=
freeze&quot;, suspend_stats.failed_freeze,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;failed_=
prepare&quot;, suspend_stats.failed_prepare,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;failed_=
suspend&quot;, suspend_stats.failed_suspend,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;failed_=
suspend_noirq&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; suspend_stats.failed_suspend_noirq,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;failed_=
resume&quot;, suspend_stats.failed_resume,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;failed_=
resume_noirq&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; suspend_stats.failed_resume_noirq);<br>
+&nbsp;&nbsp; s +=3D sprintf(s, &quot;failed_devs:\n&nbsp; last_failed:\t%s=
\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend_stats=
.failed_devs[last_index]);<br>
+&nbsp;&nbsp; for (i =3D 1; i &lt; REC_FAILED_DEV_NUM; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index =3D last_index + REC_FAILED_DEV=
_NUM - i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index %=3D REC_FAILED_DEV_NUM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s +=3D sprintf(s, &quot;\t\t%s\n&quot=
;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend_stats=
.failed_devs[index]);<br>
+&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp; if (s !=3D buf)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* convert the last space to a newlin=
e */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(s-1) =3D '\n';<br>
+<br>
+&nbsp;&nbsp; return s - buf;<br>
+}<br>
+<br>
+static ssize_t suspend_stats_store(struct kobject *kobj,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobj_attribute *attr, const ch=
ar *buf, size_t n)<br>
+{<br>
+&nbsp;&nbsp; return n;<br>
+}<br>
+<br>
+power_attr(suspend_stats);<br>
+<br>
&nbsp;struct kobject *power_kobj;<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -194,6 +238,10 @@ static ssize_t state_store(struct kobject *kobj, struc=
t kobj_attribute *attr,<br>
&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; if (state &lt; PM_SUSPEND_MAX &amp;&amp; *s)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error =3D enter_state(state);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (error)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend_stats=
.fail++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend_stats=
.success++;<br>
&nbsp;#endif<br>
&nbsp;<br>
&nbsp; Exit:<br>
@@ -310,6 +358,7 @@ static struct attribute * g[] =3D {<br>
&nbsp;#ifdef CONFIG_PM_DEBUG<br>
&nbsp;&nbsp;&nbsp; &amp;pm_test_attr.attr,<br>
&nbsp;#endif<br>
+&nbsp;&nbsp; &amp;suspend_stats_attr.attr,<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp; NULL,<br>
&nbsp;};<br>
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c<br>
index b6b71ad..9bb4281 100644<br>
--- a/kernel/power/suspend.c<br>
+++ b/kernel/power/suspend.c<br>
@@ -106,6 +106,8 @@ static int suspend_prepare(void)<br>
&nbsp;&nbsp;&nbsp; error =3D suspend_freeze_processes();<br>
&nbsp;&nbsp;&nbsp; if (!error)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend_stats.failed_freeze++;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp; suspend_thaw_processes();<br>
&nbsp;&nbsp;&nbsp; usermodehelper_enable();<br>
@@ -315,8 +317,15 @@ int enter_state(suspend_state_t state)<br>
&nbsp; */<br>
&nbsp;int pm_suspend(suspend_state_t state)<br>
&nbsp;{<br>
-&nbsp;&nbsp; if (state &gt; PM_SUSPEND_ON &amp;&amp; state &lt;=3D PM_SUSP=
END_MAX)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return enter_state(state);<br>
+&nbsp;&nbsp; int ret;<br>
+&nbsp;&nbsp; if (state &gt; PM_SUSPEND_ON &amp;&amp; state &lt;=3D PM_SUSP=
END_MAX) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D enter_state(state);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend_stats=
.fail++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suspend_stats=
.success++;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;}<br>
&nbsp;EXPORT_SYMBOL(pm_suspend);<br>
-- <br>
1.7.1<br>
<br>
</span><span lang=3DEN-US style=3D'font-size:9.0pt;font-family:"Arial Unico=
de MS","sans-serif"'><o:p>&nbsp;</o:p></span></p></div></body></html>=

--_000_6E3BC7F7C9A4BF4286DD4C043110F30B5B790E573Bshsmsx502ccrc_--

--===============0307965158589121749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0307965158589121749==--
