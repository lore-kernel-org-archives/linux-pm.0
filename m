From: Xiaoguang Chen <chenxg.marvell@gmail.com>
Subject: Re: [PATCH 1/2] PM: devfreq: add freq table and
	available_freqs
Date: Wed, 13 Jun 2012 13:28:45 +0800
Message-ID: <CAFgnuDfMVfimmYTQdB-vxCJPdB_x_nbwmd-2su45en4SpJeiow@mail.gmail.com>
References: <16928680.915361339563225913.JavaMail.weblogic@epml04>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2517963997285259765=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <16928680.915361339563225913.JavaMail.weblogic@epml04>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: myungjoo.ham@samsung.com
Cc: =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, Xiaoguang Chen <chenxg@marvell.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============2517963997285259765==
Content-Type: multipart/alternative; boundary=e89a8ff1c76265d3dd04c253db6e

--e89a8ff1c76265d3dd04c253db6e
Content-Type: text/plain; charset=ISO-8859-1

I think Devfreq should not be combined with OPP,
OPP framework does contain one frequency table, but the frequency is
combined with voltage. some platforms may don't want to use this but
handling voltage seperately in their clock driver.

and some platforms don't use OPP, and they want a frequency list.
then this is necessary. also devfreq should contain a frequency list even
without any other frameworks, don't you think so ?

Thanks
Xiaoguang

2012/6/13 MyungJoo Ham <myungjoo.ham@samsung.com>

> > Devfreq framework don't have a frequency table, add it
> > for easy use.
> >
> > Signed-off-by: Xiaoguang Chen <chenxg@marvell.com>
>
> If you need a predefined data structure to support frequency table,
> you can simply use OPP, which has helper functions implemented in
> devfreq subsystem. Is there any reason not to use OPP and to implement
> another data structure to store a frequency table attached to a device?
>
>
> Cheers!
> MyungJoo.
>
> > ---
> >  drivers/devfreq/devfreq.c |   26 ++++++++++++++++++++++++++
> >  include/linux/devfreq.h   |   12 ++++++++++++
> >  2 files changed, 38 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 70c31d4..2144200 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -460,6 +460,17 @@ int devfreq_remove_device(struct devfreq *devfreq)
> >       return 0;
> >  }
> >
> > +/*
> > + * devfreq_set_freq_table()- Set frequency table for devfreq
> > + * @devfreq  The devfreq instance
> > + * @table    The frequency table that device supports
> > + */
> > +void devfreq_set_freq_table(struct devfreq *devfreq,
> > +                         struct devfreq_frequency_table *table)
> > +{
> > +     devfreq->freq_table = table;
> > +}
> > +
> >  static ssize_t show_governor(struct device *dev,
> >                            struct device_attribute *attr, char *buf)
> >  {
> > @@ -472,6 +483,20 @@ static ssize_t show_freq(struct device *dev,
> >       return sprintf(buf, "%lu\n", to_devfreq(dev)->previous_freq);
> >  }
> >
> > +static ssize_t show_avail_freq(struct device *dev,
> > +                            struct device_attribute *attr, char *buf)
> > +{
> > +     int len = 0, i;
> > +     struct devfreq *devfreq = to_devfreq(dev);
> > +     if (devfreq->freq_table)
> > +             for (i = 0; devfreq->freq_table[i].frequency !=
> DEVFREQ_TABLE_END; i++)
> > +                     len += sprintf(buf + len, "%lu\n",
> > +                                    devfreq->freq_table[i].frequency);
> > +     if (len == 0)
> > +             len += sprintf(buf + len, "No frequency table is
> provided\n");
> > +     return len;
> > +}
> > +
> >  static ssize_t show_polling_interval(struct device *dev,
> >                                    struct device_attribute *attr, char
> *buf)
> >  {
> > @@ -595,6 +620,7 @@ static struct device_attribute devfreq_attrs[] = {
> >              store_polling_interval),
> >       __ATTR(min_freq, S_IRUGO | S_IWUSR, show_min_freq, store_min_freq),
> >       __ATTR(max_freq, S_IRUGO | S_IWUSR, show_max_freq, store_max_freq),
> > +     __ATTR(available_freqs, S_IRUGO, show_avail_freq, NULL),
> >       { },
> >  };
> >
> > diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> > index 281c72a..e5e4036 100644
> > --- a/include/linux/devfreq.h
> > +++ b/include/linux/devfreq.h
> > @@ -52,6 +52,14 @@ struct devfreq_dev_status {
> >   */
> >  #define DEVFREQ_FLAG_LEAST_UPPER_BOUND               0x1
> >
> > +#define DEVFREQ_ENTRY_INVALID (~0)
> > +#define DEVFREQ_TABLE_END     (~1)
> > +
> > +struct devfreq_frequency_table {
> > +     unsigned int index;
> > +     unsigned long frequency;
> > +};
> > +
> >  /**
> >   * struct devfreq_dev_profile - Devfreq's user device profile
> >   * @initial_freq     The operating frequency when devfreq_add_device()
> is
> > @@ -130,6 +138,7 @@ struct devfreq_governor {
> >   *                   "devfreq_monitor" executions to reevaluate
> >   *                   frequency/voltage of the device. Set by
> >   *                   profile's polling_ms interval.
> > + * @freq_table       The frequency table that device supports
> >   * @data     Private data of the governor. The devfreq framework does
> not
> >   *           touch this.
> >   * @being_removed    a flag to mark that this object is being removed in
> > @@ -157,6 +166,7 @@ struct devfreq {
> >       unsigned long polling_jiffies;
> >       unsigned long previous_freq;
> >       unsigned int next_polling;
> > +     struct devfreq_frequency_table *freq_table;
> >
> >       void *data; /* private data for governors */
> >
> > @@ -180,6 +190,8 @@ extern int devfreq_register_opp_notifier(struct
> device *dev,
> >                                        struct devfreq *devfreq);
> >  extern int devfreq_unregister_opp_notifier(struct device *dev,
> >                                          struct devfreq *devfreq);
> > +extern void devfreq_set_freq_table(struct devfreq *devfreq,
> > +                                struct devfreq_frequency_table *table);
> >
> >  #ifdef CONFIG_DEVFREQ_GOV_POWERSAVE
> >  extern const struct devfreq_governor devfreq_powersave;
> > --
> > 1.7.0.4
> >
>

--e89a8ff1c76265d3dd04c253db6e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I think Devfreq should not be combined with OPP,=A0<div>OPP framework does =
contain one frequency table, but the frequency is combined with voltage. so=
me platforms may don&#39;t want to use this but handling voltage seperately=
 in their clock driver.</div>
<div><br></div><div>and some platforms don&#39;t use OPP, and they want a f=
requency list.<div>then this is necessary. also devfreq should contain a fr=
equency list even without any other frameworks, don&#39;t you think so ?</d=
iv>
<div><br></div><div>Thanks</div><div>Xiaoguang<br><br><div class=3D"gmail_q=
uote">2012/6/13 MyungJoo Ham <span dir=3D"ltr">&lt;<a href=3D"mailto:myungj=
oo.ham@samsung.com" target=3D"_blank">myungjoo.ham@samsung.com</a>&gt;</spa=
n><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<div>&gt; Devfreq framework don&#39;t have a frequency table, add it<br>
&gt; for easy use.<br>
&gt;<br>
&gt; Signed-off-by: Xiaoguang Chen &lt;<a href=3D"mailto:chenxg@marvell.com=
" target=3D"_blank">chenxg@marvell.com</a>&gt;<br>
<br>
</div>If you need a predefined data structure to support frequency table,<b=
r>
you can simply use OPP, which has helper functions implemented in<br>
devfreq subsystem. Is there any reason not to use OPP and to implement<br>
another data structure to store a frequency table attached to a device?<br>
<br>
<br>
Cheers!<br>
<span><font color=3D"#888888">MyungJoo.<br>
</font></span><div><div><br>
&gt; ---<br>
&gt; =A0drivers/devfreq/devfreq.c | =A0 26 ++++++++++++++++++++++++++<br>
&gt; =A0include/linux/devfreq.h =A0 | =A0 12 ++++++++++++<br>
&gt; =A02 files changed, 38 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c<br>
&gt; index 70c31d4..2144200 100644<br>
&gt; --- a/drivers/devfreq/devfreq.c<br>
&gt; +++ b/drivers/devfreq/devfreq.c<br>
&gt; @@ -460,6 +460,17 @@ int devfreq_remove_device(struct devfreq *devfreq=
)<br>
&gt; =A0 =A0 =A0 return 0;<br>
&gt; =A0}<br>
&gt;<br>
&gt; +/*<br>
&gt; + * devfreq_set_freq_table()- Set frequency table for devfreq<br>
&gt; + * @devfreq =A0The devfreq instance<br>
&gt; + * @table =A0 =A0The frequency table that device supports<br>
&gt; + */<br>
&gt; +void devfreq_set_freq_table(struct devfreq *devfreq,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devfreq_frequ=
ency_table *table)<br>
&gt; +{<br>
&gt; + =A0 =A0 devfreq-&gt;freq_table =3D table;<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0static ssize_t show_governor(struct device *dev,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_a=
ttribute *attr, char *buf)<br>
&gt; =A0{<br>
&gt; @@ -472,6 +483,20 @@ static ssize_t show_freq(struct device *dev,<br>
&gt; =A0 =A0 =A0 return sprintf(buf, &quot;%lu\n&quot;, to_devfreq(dev)-&gt=
;previous_freq);<br>
&gt; =A0}<br>
&gt;<br>
&gt; +static ssize_t show_avail_freq(struct device *dev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device=
_attribute *attr, char *buf)<br>
&gt; +{<br>
&gt; + =A0 =A0 int len =3D 0, i;<br>
&gt; + =A0 =A0 struct devfreq *devfreq =3D to_devfreq(dev);<br>
&gt; + =A0 =A0 if (devfreq-&gt;freq_table)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; devfreq-&gt;freq_table[i].freq=
uency !=3D DEVFREQ_TABLE_END; i++)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len +=3D sprintf(buf + len, =
&quot;%lu\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0devfreq-&gt;freq_table[i].frequency);<br>
&gt; + =A0 =A0 if (len =3D=3D 0)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 len +=3D sprintf(buf + len, &quot;No frequen=
cy table is provided\n&quot;);<br>
&gt; + =A0 =A0 return len;<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0static ssize_t show_polling_interval(struct device *dev,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0struct device_attribute *attr, char *buf)<br>
&gt; =A0{<br>
&gt; @@ -595,6 +620,7 @@ static struct device_attribute devfreq_attrs[] =3D=
 {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0store_polling_interval),<br>
&gt; =A0 =A0 =A0 __ATTR(min_freq, S_IRUGO | S_IWUSR, show_min_freq, store_m=
in_freq),<br>
&gt; =A0 =A0 =A0 __ATTR(max_freq, S_IRUGO | S_IWUSR, show_max_freq, store_m=
ax_freq),<br>
&gt; + =A0 =A0 __ATTR(available_freqs, S_IRUGO, show_avail_freq, NULL),<br>
&gt; =A0 =A0 =A0 { },<br>
&gt; =A0};<br>
&gt;<br>
&gt; diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h<br>
&gt; index 281c72a..e5e4036 100644<br>
&gt; --- a/include/linux/devfreq.h<br>
&gt; +++ b/include/linux/devfreq.h<br>
&gt; @@ -52,6 +52,14 @@ struct devfreq_dev_status {<br>
&gt; =A0 */<br>
&gt; =A0#define DEVFREQ_FLAG_LEAST_UPPER_BOUND =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
0x1<br>
&gt;<br>
&gt; +#define DEVFREQ_ENTRY_INVALID (~0)<br>
&gt; +#define DEVFREQ_TABLE_END =A0 =A0 (~1)<br>
&gt; +<br>
&gt; +struct devfreq_frequency_table {<br>
&gt; + =A0 =A0 unsigned int index;<br>
&gt; + =A0 =A0 unsigned long frequency;<br>
&gt; +};<br>
&gt; +<br>
&gt; =A0/**<br>
&gt; =A0 * struct devfreq_dev_profile - Devfreq&#39;s user device profile<b=
r>
&gt; =A0 * @initial_freq =A0 =A0 The operating frequency when devfreq_add_d=
evice() is<br>
&gt; @@ -130,6 +138,7 @@ struct devfreq_governor {<br>
&gt; =A0 * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;devfreq_monitor&quot; =
executions to reevaluate<br>
&gt; =A0 * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 frequency/voltage of the dev=
ice. Set by<br>
&gt; =A0 * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 profile&#39;s polling_ms int=
erval.<br>
&gt; + * @freq_table =A0 =A0 =A0 The frequency table that device supports<b=
r>
&gt; =A0 * @data =A0 =A0 Private data of the governor. The devfreq framewor=
k does not<br>
&gt; =A0 * =A0 =A0 =A0 =A0 =A0 touch this.<br>
&gt; =A0 * @being_removed =A0 =A0a flag to mark that this object is being r=
emoved in<br>
&gt; @@ -157,6 +166,7 @@ struct devfreq {<br>
&gt; =A0 =A0 =A0 unsigned long polling_jiffies;<br>
&gt; =A0 =A0 =A0 unsigned long previous_freq;<br>
&gt; =A0 =A0 =A0 unsigned int next_polling;<br>
&gt; + =A0 =A0 struct devfreq_frequency_table *freq_table;<br>
&gt;<br>
&gt; =A0 =A0 =A0 void *data; /* private data for governors */<br>
&gt;<br>
&gt; @@ -180,6 +190,8 @@ extern int devfreq_register_opp_notifier(struct de=
vice *dev,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0struct devfreq *devfreq);<br>
&gt; =A0extern int devfreq_unregister_opp_notifier(struct device *dev,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0struct devfreq *devfreq);<br>
&gt; +extern void devfreq_set_freq_table(struct devfreq *devfreq,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struc=
t devfreq_frequency_table *table);<br>
&gt;<br>
&gt; =A0#ifdef CONFIG_DEVFREQ_GOV_POWERSAVE<br>
&gt; =A0extern const struct devfreq_governor devfreq_powersave;<br>
&gt; --<br>
&gt; 1.7.0.4<br>
&gt;<br>
</div></div></blockquote></div><br>
</div></div>

--e89a8ff1c76265d3dd04c253db6e--

--===============2517963997285259765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2517963997285259765==--
