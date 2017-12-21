From: =?UTF-8?Q?Ognjen_Gali=C4=87?= <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3 v8] thinkpad_acpi: Add support for
 battery thresholds
Date: Thu, 21 Dec 2017 16:24:06 +0100
Message-ID: <CALgTWSvnyBysDJqGFwCxB43wgzMAAUqYZ2M5r8-L9ZdJ9J4XxQ@mail.gmail.com>
References: <20171221100051.GA30647@thinkpad>
 <CAHp75Vc2MYDLanvZmqaPkmFVfNbyBQoPwbRDDFmKDtSPAmfj9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4670975370945848674=="
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAHp75Vc2MYDLanvZmqaPkmFVfNbyBQoPwbRDDFmKDtSPAmfj9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Henrique de Moraes Holschuh <ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph-KeW1gJXA36yNJhrcwGid2A@public.gmane.org>, Kevin Locke <kevin-yFOG++GfaLUI8/NkjqMgMw@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Shevchenko <andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============4670975370945848674==
Content-Type: multipart/alternative; boundary="94eb2c1ce1bc83e8760560db4ab2"

--94eb2c1ce1bc83e8760560db4ab2
Content-Type: text/plain; charset="UTF-8"

On 21 Dec 2017 2:53 pm, "Andy Shevchenko" <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

On Thu, Dec 21, 2017 at 12:00 PM, Ognjen Galic <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> thinkpad_acpi registers two new attributes for each battery:
>
> 1) Charge start threshold
> /sys/class/power_supply/BATN/charge_start_threshold
>
> Valid values are [0, 99]. A value of 0 turns off the
> start threshold wear control.
>
> 2) Charge stop threshold
> /sys/class/power_supply/BATN/charge_stop_threshold
>
> Valid values are [1, 100]. A value of 100 turns off
> the stop threshold wear control. This must be
> configured first.
>
> This patch depends on the following patches:
>
> "battery: Add the battery hooking API"

Sorry, didn't notice earlier some things commented below.

>  #include <acpi/video.h>
>
> +
>  /* ThinkPad CMOS commands */

Redundant change.

> +enum {
> +       /* Error condition bit */
> +       METHOD_ERR = (1 << 31),

bitops.h but no BIT() use?

BIT(31) ?

> +};

> +static int tpacpi_battery_set(int what, int battery, int value)
> +{

> +

Redundant.

> +       int param = 0x0, ret = 0xFFFFFFFF;

Useless assignment for param, not sure abour ret.

> +
> +       /* The first 8 bits are the value of the threshold */
> +       param = value;
> +       /* The battery ID is in bits 8-9, 2 bits */
> +       param |= battery << 8;
> +
> +       switch (what) {
> +
> +       case THRESHOLD_START:
> +
> +               if (tpacpi_battery_acpi_eval(SET_START, &ret, param)) {
> +                       pr_err("failed to set charge threshold on battery
%d",
> +                                       battery);
> +                       return -ENODEV;
> +               }
> +
> +               return 0;
> +
> +       case THRESHOLD_STOP:
> +
> +               if (tpacpi_battery_acpi_eval(SET_STOP, &ret, param)) {
> +                       pr_err("failed to set charge stop threshold: %d",
battery);
> +                       return -ENODEV;
> +               }
> +
> +               return 0;
> +
> +       default:
> +               pr_crit("wrong parameter: %d", what);
> +               return -EINVAL;
> +       }

> +

Redundant.

> +}

> +
> +static int tpacpi_battery_probe(int battery)
> +{
> +       int ret = 0;
> +

> +       /* Reset the struct */

Useless.

> +       memset(&battery_info, 0, sizeof(struct
tpacpi_battery_driver_data));

> +}

> +static ssize_t tpacpi_battery_store(struct device *dev,
> +                                  struct device_attribute *devattr,
> +                                  const char *buf, size_t count)
> +{
> +       int attr, battery;
> +       unsigned long value;
> +       struct power_supply *supply = to_power_supply(dev);

Can you use reverse xmas tree, esp. put assignments first.

> +       if (!supply) {

How this could be possible?!

> +               pr_err("Can't upcast to power_supply!");
> +               return -ENODEV;
> +       }

> +       if (kstrtoul(buf, 10, &value))
> +               return -EINVAL;

Don't shadow an error code from kstrtoul().

> +static ssize_t tpacpi_battery_show(struct device *dev,
> +                                 struct device_attribute *devattr,
> +                                 char *buf)
> +{
> +       int ret = 0x0, attr, battery;
> +       struct power_supply *supply = to_power_supply(dev);

> +       if (!supply) {

How this could be possible?!

> +               pr_crit("Can't upcast to power_supply!");
> +               return -ENODEV;
> +       }

> +       return sprintf(buf, "%d\n", ret);
> +}
> +
> +DEVICE_ATTR(charge_start_threshold, 0644,
> +               tpacpi_battery_show, tpacpi_battery_store);
> +DEVICE_ATTR(charge_stop_threshold, 0644,
> +       tpacpi_battery_show, tpacpi_battery_store);

DEVICE_ATTR_RW().


I did not use DEVICE_ATTR_RW() because I can't use a common store and show
function for both attributes to minimize the code I need. If I used
DEVICE_ATTR_RW() I would need to define 4 more functions that do the same.
That seems redundant.


> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -371,6 +371,8 @@ devm_power_supply_register_no_ws(struct device
*parent,
>  extern void power_supply_unregister(struct power_supply *psy);
>  extern int power_supply_powers(struct power_supply *psy, struct device
*dev);
>
> +#define to_power_supply(device) container_of(device, struct
power_supply, dev)
> +
>  extern void *power_supply_get_drvdata(struct power_supply *psy);
>  /* For APM emulation, think legacy userspace. */
>  extern struct class *power_supply_class;

This one sounds to me as a separate change.

At the same time you may convert the current user of it to make sense
of the change.
drivers/power/supply/power_supply_core.c:671:

I think I pointed to this out once.


I wanted to minimize the changes in pm to avoid going through all the
review process hassle for a few simple changes, because I'm modifying a
third subsystem. But I will do it later tonight.

This is my first patchset and I did not expect for the review process to be
this agonizingly slow, so I wanted to speed it up by not touching pm.

Thanks for the comments!

Ognjen


--
With Best Regards,
Andy Shevchenko

--94eb2c1ce1bc83e8760560db4ab2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><div class=3D"gmail_q=
uote">On 21 Dec 2017 2:53 pm, &quot;Andy Shevchenko&quot; &lt;<a href=3D"ma=
ilto:andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br=
 type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"quoted-text">O=
n Thu, Dec 21, 2017 at 12:00 PM, Ognjen Galic &lt;<a href=3D"mailto:smclt30=
p@gmail.com">smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; thinkpad_acpi registers two new attributes for each battery:<br>
&gt;<br>
&gt; 1) Charge start threshold<br>
&gt; /sys/class/power_supply/BATN/<wbr>charge_start_threshold<br>
&gt;<br>
&gt; Valid values are [0, 99]. A value of 0 turns off the<br>
&gt; start threshold wear control.<br>
&gt;<br>
&gt; 2) Charge stop threshold<br>
&gt; /sys/class/power_supply/BATN/<wbr>charge_stop_threshold<br>
&gt;<br>
&gt; Valid values are [1, 100]. A value of 100 turns off<br>
&gt; the stop threshold wear control. This must be<br>
&gt; configured first.<br>
&gt;<br>
&gt; This patch depends on the following patches:<br>
&gt;<br>
&gt; &quot;battery: Add the battery hooking API&quot;<br>
<br>
</div>Sorry, didn&#39;t notice earlier some things commented below.<br>
<div class=3D"quoted-text"><br>
&gt;=C2=A0 #include &lt;acpi/video.h&gt;<br>
&gt;<br>
&gt; +<br>
&gt;=C2=A0 /* ThinkPad CMOS commands */<br>
<br>
</div>Redundant change.<br>
<div class=3D"quoted-text"><br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Error condition bit */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0METHOD_ERR =3D (1 &lt;&lt; 31),<br>
<br>
</div>bitops.h but no BIT() use?<br>
<br>
BIT(31) ?<br>
<div class=3D"quoted-text"><br>
&gt; +};<br>
<br>
&gt; +static int tpacpi_battery_set(int what, int battery, int value)<br>
&gt; +{<br>
<br>
&gt; +<br>
<br>
</div>Redundant.<br>
<div class=3D"quoted-text"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int param =3D 0x0, ret =3D 0xFFFFFFFF;<br>
<br>
</div>Useless assignment for param, not sure abour ret.<br>
<div class=3D"elided-text"><br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* The first 8 bits are the value of the t=
hreshold */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0param =3D value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* The battery ID is in bits 8-9, 2 bits *=
/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0param |=3D battery &lt;&lt; 8;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (what) {<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case THRESHOLD_START:<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tpacpi_bat=
tery_acpi_eval(SET_<wbr>START, &amp;ret, param)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pr_err(&quot;failed to set charge threshold on battery %d&quo=
t;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0batte=
ry);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -ENODEV;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case THRESHOLD_STOP:<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tpacpi_bat=
tery_acpi_eval(SET_<wbr>STOP, &amp;ret, param)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0pr_err(&quot;failed to set charge stop threshold: %d&quot;, b=
attery);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return -ENODEV;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_crit(&quot;=
wrong parameter: %d&quot;, what);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
&gt; +<br>
<br>
</div>Redundant.<br>
<div class=3D"quoted-text"><br>
&gt; +}<br>
<br>
&gt; +<br>
&gt; +static int tpacpi_battery_probe(int battery)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt; +<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Reset the struct */<br>
<br>
</div>Useless.<br>
<div class=3D"quoted-text"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;battery_info, 0, sizeof(struct=
 tpacpi_battery_driver_data));<br>
<br>
&gt; +}<br>
<br>
</div><div class=3D"quoted-text">&gt; +static ssize_t tpacpi_battery_store(=
struct device *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *=
devattr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf, size_t c=
ount)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int attr, battery;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct power_supply *supply =3D to_power_s=
upply(dev);<br>
<br>
</div>Can you use reverse xmas tree, esp. put assignments first.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!supply) {<br>
<br>
How this could be possible?!<br>
<div class=3D"quoted-text"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_err(&quot;C=
an&#39;t upcast to power_supply!&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
</div>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (kstrtoul(buf, 10, &amp;value))<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;<br>
<br>
Don&#39;t shadow an error code from kstrtoul().<br>
<div class=3D"quoted-text"><br>
&gt; +static ssize_t tpacpi_battery_show(struct device *dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct device_attribute *d=
evattr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *buf)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0x0, attr, battery;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct power_supply *supply =3D to_power_s=
upply(dev);<br>
<br>
</div>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!supply) {<br>
<br>
How this could be possible?!<br>
<div class=3D"quoted-text"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_crit(&quot;=
Can&#39;t upcast to power_supply!&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
</div>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return sprintf(buf, &quot;%d\n&quot;=
, ret);<br>
<div class=3D"quoted-text">&gt; +}<br>
&gt; +<br>
&gt; +DEVICE_ATTR(charge_start_<wbr>threshold, 0644,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tpacpi_battery=
_show, tpacpi_battery_store);<br>
&gt; +DEVICE_ATTR(charge_stop_<wbr>threshold, 0644,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tpacpi_battery_show, tpacpi_battery_store)=
;<br>
<br>
</div>DEVICE_ATTR_RW().<br>
<div class=3D"quoted-text"></div></blockquote></div></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">I did not use DEVICE_ATTR_RW() because I=
 can&#39;t use a common store and show function for both attributes to mini=
mize the code I need. If I used DEVICE_ATTR_RW() I would need to define 4 m=
ore functions that do the same. That seems redundant.=C2=A0</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_extra"><div class=
=3D"gmail_quote"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><div class=3D"quoted-text"><br>
&gt; --- a/include/linux/power_supply.h<br>
&gt; +++ b/include/linux/power_supply.h<br>
&gt; @@ -371,6 +371,8 @@ devm_power_supply_register_no_<wbr>ws(struct devic=
e *parent,<br>
&gt;=C2=A0 extern void power_supply_unregister(struct power_supply *psy);<b=
r>
&gt;=C2=A0 extern int power_supply_powers(struct power_supply *psy, struct =
device *dev);<br>
&gt;<br>
&gt; +#define to_power_supply(device) container_of(device, struct power_sup=
ply, dev)<br>
&gt; +<br>
&gt;=C2=A0 extern void *power_supply_get_drvdata(<wbr>struct power_supply *=
psy);<br>
&gt;=C2=A0 /* For APM emulation, think legacy userspace. */<br>
&gt;=C2=A0 extern struct class *power_supply_class;<br>
<br>
</div>This one sounds to me as a separate change.<br>
<br>
At the same time you may convert the current user of it to make sense<br>
of the change.<br>
drivers/power/supply/power_<wbr>supply_core.c:671:<br>
<br>
I think I pointed to this out once.<br></blockquote></div></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">I wanted to minimize the changes i=
n pm to avoid going through all the review process hassle for a few simple =
changes, because I&#39;m modifying a third subsystem. But I will do it late=
r tonight.</div><div dir=3D"auto"><br></div><div dir=3D"auto">This is my fi=
rst patchset and I did not expect for the review process to be this agonizi=
ngly slow, so I wanted to speed it up by not touching pm.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Thanks for the comments!</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Ognjen</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><bl=
ockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<font color=3D"#888888"><br>
--<br>
With Best Regards,<br>
Andy Shevchenko<br>
</font></blockquote></div><br></div></div></div>

--94eb2c1ce1bc83e8760560db4ab2--


--===============4670975370945848674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--===============4670975370945848674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ibm-acpi-devel mailing list
ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel

--===============4670975370945848674==--
