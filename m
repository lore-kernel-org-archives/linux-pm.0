From: "Satendra..." <satendra.pratap@gmail.com>
Subject: Re: Regarding Devfreq
Date: Mon, 16 Apr 2012 12:32:20 +0530
Message-ID: <CAChS5kNA8CyQuHPJ+HjJ21NMVB5vddBjJvSXQF+KcLbN4v8mXg@mail.gmail.com>
References: <0M18009PVCPE8JM0@mailout1.samsung.com>
	<CAChS5kPtG3kk9dH9twMp68XKs6eLgQSiN49_ehsHAEddCHsJDg@mail.gmail.com>
	<CAJ0PZbRWgS_Vcx9mXqT=mO+oCXxgJwL1JOnDb_9uyU=p3a9tbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3050859028022772088=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJ0PZbRWgS_Vcx9mXqT=mO+oCXxgJwL1JOnDb_9uyU=p3a9tbA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============3050859028022772088==
Content-Type: multipart/alternative; boundary=047d7b10c8994ef2e704bdc667be

--047d7b10c8994ef2e704bdc667be
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ham,

I have used jiffies to calculate the busy time and total time for a module
(made of 'n' functions say).
I have added a bew structure:

typedef struct devfreq_perf_counters {
        unsigned long func_entry_jiffies; /* jiffies at the enrty of a func
*/
        unsigned long start_jiffies; /* starting jiffies for every
busy/total \
                                             load cal in the last x
seconds*/
        unsigned long local_jiffies; /* last jiffies count */
        unsigned long busy_jiffies; /* total execution jiffies count in the
last \
                                      x seconds */
}devfreq_counters;

This structure's instance can be included in the platform_data(or private
data) of the
driver which has to register itself with devfreq. This way while doing
set_drv_data, access
to these counters could be available all the time.

Now there is one initialization function :

void devfreq_counters_init(void *data)
{
        devfreq_counters **dc =3D &data->dpc;

        *dc =3D kzalloc(sizeof (devfreq_counters), GFP_KERNEL);

        (*dc)->func_entry_jiffies =3D 0UL;
        (*dc)->local_jiffies =3D 0UL;
        (*dc)->busy_jiffies =3D 0UL;
        (*dc)->start_jiffies =3D jiffies;

        return;
}

This function initializes the counters and is called at the end of driver
initialiation function.

Now there is a list of APIs as shown below:

#define devfreq_jiffies_start(dc) \
        dc->func_entry_jiffies =3D jiffies

#define devfreq_jiffies_end(dc) do { \
        dc->local_jiffies =3D (jiffies)-(dc->func_entry_jiffies);\
        dc->busy_jiffies +=3D dc->local_jiffies;\
}while(0)

#define busy_jiffies_in_usec(dc) \
        jiffies_to_usecs((dc)->busy_jiffies)

#define busy_plus_not_busy_jiffies_in_usec(dc) \
        jiffies_to_usecs(((jiffies) - (dc)->start_jiffies))

#define devfreq_reset_counters(dc) do { \
        dc->func_entry_jiffies =3D 0UL; \
        dc->local_jiffies =3D 0UL; \
        dc->busy_jiffies =3D 0UL; \
        dc->start_jiffies =3D jiffies;\
}while(0)

Description:
- devfreq_jiffies_start(dc): Will be called in the start of the function
(this is one of the functions
which we want to consider in measuring the busy time of the driver)
- devfreq_jiffies_end(dc): Will be called at the end of that function
- busy_jiffies_in_usec(dc): Will return jiffies for which all considered
(for busy time) driver's
functions were busy
- busy_plus_not_busy_jiffies_in_usec(dc): Total jiffies i.e. busy time +
not busy time of driver
- devfreq_reset_counters(dc): obvious

I wanted the simple solution to busy and load and i thought about this.
This solution hasn't been verified
yet.

Ham, can you please provide your views on it.

Thanks,
Satendra


On 29 March 2012 07:44, MyungJoo Ham <myungjoo.ham@gmail.com> wrote:

> 2012/3/28 Satendra... <satendra.pratap@gmail.com>
> >
> > Hi Ham,
> >
> > In the below struct :
> > struct devfreq_dev_status {
> >         /* both since the last measure */
> >         unsigned long total_time;
> >         unsigned long busy_time;
> >         unsigned long current_frequency;
> >         void *private_data;
> > };
> >
> > How to calculate total_time/busy_time? Does it require hardware support
> > (may be some performance counters)?
> >
> > Thanks,
> > Satendra
>
> It is decided by each devfreq device driver, which is why
> get_dev_status() is to be provided by the devfreq device driver.
>
> If the device has performance counters, then, it's great, but
> performance counters are not mandatory.
>
> Here goes a list of mechanisms to fetch busy/total time:
> - Performance counters
> - Measure the time between "operation start" and "operation end" and
> accumulate the time (getting busy time. probably by ktime?)
> - Measure the idle time (CPUIDLE/CPUFREQ does this)
> - Count the number of operation and calculate the operational time
> based on the number.
> - and so on.
>
> As you can see in the list, you don't need a hardware support such as
> performance counters.
>
>
>
> Cheers!
> MyungJoo.
>
> >
> >
> > On 21 March 2012 15:49, =ED=95=A8=EB=AA=85=EC=A3=BC <myungjoo.ham@samsu=
ng.com> wrote:
> >>
> >> Hi Stendra,
> >>
> >>
> >>
> >> - Bascially, you can determine the voltage based on frequency; thus, w=
e
> >> do not need to determint voltages at DVFS framework. It is correspondi=
ng
> >> device driver's responsibility even when we have AVS features. Thus,
> yes,
> >> the target callback needs to control both frequency and voltage (and
> >> anything else required to change the frequency/voltage)
> >>
> >>
> >>
> >> - I recommend to use regulator framework to control regulators unless
> you
> >> really really need to ignore regulator framework. Don't reinvent the
> wheel.
> >>
> >>
> >>
> >> - The three steps you've mentioned are correct.
> >>
> >>
> >>
> >> - The mailing list is opened to all. You are welcomed to use it (CC'ed
> >> linux-pm) and just CC needed people.
> >>
> >>
> >>
> >>
> >>
> >> Cheers!
> >>
> >> MyungJoo.
> >>
> >>
> >>
> >> ------- Original Message -------
> >>
> >> Sender : Satendra...<satendra.pratap@gmail.com>
> >>
> >> Date : 2012-03-21 19:03 (GMT+09:00)
> >>
> >> Title : Re: Re: Regarding Devfreq
> >>
> >>
> >>
> >> Hi Ham,
> >>
> >> Thank you very much for your reply. I will try not to disturb you much=
.
> >> In Devfreq I dont see any API related to voltage scaling. Is it the
> >> "->target" function's (in  struct devfreq_dev_profile)
> >> responsibility to change the voltage as well with frequency?
> >> Do we really need to register our regulators using regulator framework
> of
> >> linux for voltage scaling?
> >>
> >> For a clear understanding I need to do following to use devfreq (I am
> >> sorry as I may be verifying it again):
> >> - define an instance of "struct devfreq_dev_profile" and provide
> >> implementations of target, get_dev_status and exit callbacks
> >> - Implement our choice of governer or use any one from already
> >> implemented ones.
> >> - call "devfreq_add_device" function from our driver's probe function.
> >>
> >> is that it? or do we need to do something else also?
> >>
> >> Thanks,
> >> Satendra
> >>
> >>
> >> On 21 March 2012 15:14, =ED=95=A8=EB=AA=85=EC=A3=BC <myungjoo.ham@sams=
ung.com> wrote:
> >>>
> >>> Hello Satendra,
> >>>
> >>>
> >>>
> >>> - For Devfreq, OPP is optional though recommended for easier
> >>> implementation. You can still implement all the needed things without
> OPP.
> >>> OPP is just a simple data structure to store pairs of voltage and
> frequency.
> >>>
> >>>
> >>>
> >>> - Yes, you need to call devfreq_add_device() and supply the required
> >>> data. You can implement your own governor or use one of predefined
> >>> governors. Runtime replacement of governors like CPUfreq is "TODO" fo=
r
> now.
> >>>
> >>>
> >>>
> >>> - For example, you can see /drivers/devfreq/exynos4_bus.c. GPU, Displ=
ay
> >>> devfreq drivers are under development in other companies (ARM).
> >>>
> >>>
> >>>
> >>> Cheers!
> >>>
> >>> MyungJoo.
> >>>
> >>>
> >>>
> >>>
> >>>
> >>> ------- Original Message -------
> >>>
> >>> Sender : Satendra...<satendra.pratap@gmail.com>
> >>>
> >>> Date : 2012-03-21 17:31 (GMT+09:00)
> >>>
> >>> Title : Re: Regarding Devfreq
> >>>
> >>>
> >>>
> >>> Hi Ham,
> >>>
> >>> I have studied DVFS and what I feel is that we need to use OPP and
> >>> Voltage regulator interfaces also to
> >>> maintain Optimum Performance Points and to provide APIs to change the
> >>> voltage.
> >>> What I feel is that to use DVFS every driver has to
> >>> call devfreq_add_device function to register that device to
> >>> the devfreq framework. And in order to do that we have to
> >>> implement devfreq_dev_profile and our choice of governer.
> >>>
> >>> I appreciate your help.
> >>>
> >>> Thanks,
> >>> Satendra
> >>>
> >>> On 20 March 2012 12:16, Satendra... <satendra.pratap@gmail.com> wrote=
:
> >>>>
> >>>> Hi Ham,
> >>>>
> >>>> We are working on a new SoC for our new product and would want to us=
e
> >>>> your Devfreq
> >>>> framework for our devices. Would you please let me know any other
> >>>> implementation which
> >>>> uses devfreq ? so that we could take that as a reference.
> >>>> Or we would be the first one to start?
> >>>>
> >>>> Thanks,
> >>>> Satendra
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>> --
> >>>
> >>> MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), PHD
> >>>
> >>> System S/W Lab, S/W Platform Team, Software Center
> >>> Samsung Electronics
> >>> Cell: +82-10-6714-2858
> >>>
> >>>
> >>
> >>
> >>
> >>
> >>
> >>
> >> --
> >>
> >> MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), PHD
> >>
> >> System S/W Lab, S/W Platform Team, Software Center
> >> Samsung Electronics
> >> Cell: +82-10-6714-2858
> >>
> >>
> >
> >
> >
> > _______________________________________________
> > linux-pm mailing list
> > linux-pm@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
>
>
>
>
> --
> MyungJoo Ham, Ph.D.
> System S/W Lab, S/W Center, Samsung Electronics
>

--047d7b10c8994ef2e704bdc667be
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ham,<div><br></div><div><div>I have used jiffies to calculate the busy t=
ime and total time for=C2=A0a module (made of &#39;n&#39; functions say).</=
div><div>I have added a bew structure:</div><div><br></div><div>typedef str=
uct devfreq_perf_counters {</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long func_entry_jiffies; /* jiffi=
es at the enrty of a func */</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned=
 long start_jiffies; /* starting jiffies for every busy/total \</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0load cal in the last x seconds*/</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long local_jiffies; /* last jiffi=
es count */</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long busy_jiffie=
s; /* total execution jiffies count in the last \</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x seconds */</div>
<div>}devfreq_counters;</div><div><br></div><div>This structure&#39;s insta=
nce can be included in the platform_data(or private data) of the</div><div>=
driver which has to register itself with devfreq. This way while doing set_=
drv_data, access</div>
<div>to these counters could be available all the time.</div><div><br></div=
><div>Now there is one initialization function :</div><div><br></div><div>v=
oid devfreq_counters_init(void *data)</div><div>{</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 devfreq_counters **dc =3D &amp;data-&gt;dpc;</div>
<div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 *dc =3D kzalloc(sizeof (dev=
freq_counters), GFP_KERNEL);</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 (*dc)-&gt;func_entry_jiffies =3D 0UL;</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (*dc)-&gt;local_jiffies =3D 0UL;</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (*dc)-&gt;busy_jiffies =3D 0UL;</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 (*dc)-&gt;start_jiffies =3D jiffies;</div>=
<div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;</div><div>}</div><d=
iv><br></div><div>This function initializes the counters and is called at t=
he end of driver initialiation function.</div>
<div><br></div><div>Now there is a list of APIs as shown below:</div><div><=
br></div><div>#define devfreq_jiffies_start(dc) \</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 dc-&gt;func_entry_jiffies =3D jiffies</div><div><br></div><di=
v>#define devfreq_jiffies_end(dc) do { \</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 dc-&gt;local_jiffies =3D (jiffies)-(dc-&gt=
;func_entry_jiffies);\</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 dc-&gt;busy_ji=
ffies +=3D dc-&gt;local_jiffies;\</div><div>}while(0)</div><div><br></div><=
div>#define busy_jiffies_in_usec(dc) \</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 jiffies_to_usecs((dc)-&gt;busy_jiffies)</d=
iv><div><br></div><div>#define busy_plus_not_busy_jiffies_in_usec(dc) \</di=
v><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 jiffies_to_usecs(((jiffies) - (dc)-&gt;s=
tart_jiffies))</div><div><br></div><div>
#define devfreq_reset_counters(dc) do { \</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dc-&gt;func_entry_jiffies =3D 0UL; \</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dc-&gt;local_jiffies =3D 0UL; \</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dc-&gt;busy_jiffies =3D 0UL; \</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 dc=
-&gt;start_jiffies =3D jiffies;\</div>
<div>}while(0)</div><div><br></div><div>Description:</div><div><span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>- devfreq_jiffies_sta=
rt(dc): Will be called in the start of the function (this is one of the fun=
ctions</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>which=
 we want to consider in measuring the busy time of the driver)</div><div><s=
pan class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>- devfreq_ji=
ffies_end(dc): Will be called at the end of that function</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>- bus=
y_jiffies_in_usec(dc): Will return jiffies for which all considered (for bu=
sy time) driver&#39;s</div><div><span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>functions were busy</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>- bus=
y_plus_not_busy_jiffies_in_usec(dc): Total jiffies i.e. busy time + not bus=
y time of driver</div><div><span class=3D"Apple-tab-span" style=3D"white-sp=
ace:pre">	</span>- devfreq_reset_counters(dc): obvious</div>
<div><br></div><div>I wanted the simple solution to busy and load and i tho=
ught about this. This solution hasn&#39;t been verified</div><div>yet.=C2=
=A0</div></div><div><br></div><div><div>Ham, can you please provide your vi=
ews on it.</div>
<div><br></div><div>Thanks,</div><div>Satendra</div><div><br></div><br><div=
 class=3D"gmail_quote">On 29 March 2012 07:44, MyungJoo Ham <span dir=3D"lt=
r">&lt;<a href=3D"mailto:myungjoo.ham@gmail.com">myungjoo.ham@gmail.com</a>=
&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">2012/3/28 Satendra... &lt;<a href=3D"mailto:=
satendra.pratap@gmail.com">satendra.pratap@gmail.com</a>&gt;<br>
<div class=3D"im">&gt;<br>
&gt; Hi Ham,<br>
&gt;<br>
&gt; In the below struct :<br>
&gt; struct devfreq_dev_status {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* both since the last measure */<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long total_time;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long busy_time;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long current_frequency;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *private_data;<br>
&gt; };<br>
&gt;<br>
&gt; How to calculate total_time/busy_time? Does it require hardware suppor=
t<br>
&gt; (may be some performance counters)?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Satendra<br>
<br>
</div>It is decided by each devfreq device driver, which is why<br>
get_dev_status() is to be provided by the devfreq device driver.<br>
<br>
If the device has performance counters, then, it&#39;s great, but<br>
performance counters are not mandatory.<br>
<br>
Here goes a list of mechanisms to fetch busy/total time:<br>
- Performance counters<br>
- Measure the time between &quot;operation start&quot; and &quot;operation =
end&quot; and<br>
accumulate the time (getting busy time. probably by ktime?)<br>
- Measure the idle time (CPUIDLE/CPUFREQ does this)<br>
- Count the number of operation and calculate the operational time<br>
based on the number.<br>
- and so on.<br>
<br>
As you can see in the list, you don&#39;t need a hardware support such as<b=
r>
performance counters.<br>
<br>
<br>
<br>
Cheers!<br>
MyungJoo.<br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt;<br>
&gt; On 21 March 2012 15:49, =ED=95=A8=EB=AA=85=EC=A3=BC &lt;<a href=3D"mai=
lto:myungjoo.ham@samsung.com">myungjoo.ham@samsung.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Hi Stendra,<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; - Bascially, you can determine the voltage based on frequency; thu=
s, we<br>
&gt;&gt; do not need to determint voltages at DVFS framework. It is corresp=
onding<br>
&gt;&gt; device driver&#39;s responsibility even when we have AVS features.=
 Thus, yes,<br>
&gt;&gt; the target callback needs to control both frequency and voltage (a=
nd<br>
&gt;&gt; anything else required to change the frequency/voltage)<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; - I recommend to use regulator framework to control regulators unl=
ess you<br>
&gt;&gt; really really need to ignore regulator framework. Don&#39;t reinve=
nt the wheel.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; - The three steps you&#39;ve mentioned are correct.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; - The mailing list is opened to all. You are welcomed to use it (C=
C&#39;ed<br>
&gt;&gt; linux-pm) and just CC needed people.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Cheers!<br>
&gt;&gt;<br>
&gt;&gt; MyungJoo.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; ------- Original Message -------<br>
&gt;&gt;<br>
&gt;&gt; Sender : Satendra...&lt;<a href=3D"mailto:satendra.pratap@gmail.co=
m">satendra.pratap@gmail.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Date : 2012-03-21 19:03 (GMT+09:00)<br>
&gt;&gt;<br>
&gt;&gt; Title : Re: Re: Regarding Devfreq<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hi Ham,<br>
&gt;&gt;<br>
&gt;&gt; Thank you very much for your reply. I will try not to disturb you =
much.<br>
&gt;&gt; In Devfreq I dont see any API related to voltage scaling. Is it th=
e<br>
&gt;&gt; &quot;-&gt;target&quot; function&#39;s (in =C2=A0struct devfreq_de=
v_profile)<br>
&gt;&gt; responsibility to change the voltage as well with frequency?<br>
&gt;&gt; Do we really need to register our regulators using regulator frame=
work of<br>
&gt;&gt; linux for voltage scaling?<br>
&gt;&gt;<br>
&gt;&gt; For a clear understanding I need to do following to use devfreq (I=
 am<br>
&gt;&gt; sorry as I may be verifying it again):<br>
&gt;&gt; - define an instance of &quot;struct devfreq_dev_profile&quot; and=
 provide<br>
&gt;&gt; implementations of target, get_dev_status and exit callbacks<br>
&gt;&gt; - Implement our choice of governer or use any one from already<br>
&gt;&gt; implemented ones.<br>
&gt;&gt; - call &quot;devfreq_add_device&quot; function from our driver&#39=
;s probe function.<br>
&gt;&gt;<br>
&gt;&gt; is that it? or do we need to do something else also?<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; Satendra<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On 21 March 2012 15:14, =ED=95=A8=EB=AA=85=EC=A3=BC &lt;<a href=3D=
"mailto:myungjoo.ham@samsung.com">myungjoo.ham@samsung.com</a>&gt; wrote:<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hello Satendra,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; - For Devfreq, OPP is optional though recommended for easier<b=
r>
&gt;&gt;&gt; implementation. You can still implement all the needed things =
without OPP.<br>
&gt;&gt;&gt; OPP is just a simple data structure to store pairs of voltage =
and frequency.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; - Yes, you need to call devfreq_add_device() and supply the re=
quired<br>
&gt;&gt;&gt; data. You can implement your own governor or use one of predef=
ined<br>
&gt;&gt;&gt; governors. Runtime replacement of governors like CPUfreq is &q=
uot;TODO&quot; for now.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; - For example, you can see /drivers/devfreq/exynos4_bus.c. GPU=
, Display<br>
&gt;&gt;&gt; devfreq drivers are under development in other companies (ARM)=
.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Cheers!<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; MyungJoo.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; ------- Original Message -------<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Sender : Satendra...&lt;<a href=3D"mailto:satendra.pratap@gmai=
l.com">satendra.pratap@gmail.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Date : 2012-03-21 17:31 (GMT+09:00)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Title : Re: Regarding Devfreq<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hi Ham,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I have studied DVFS and what I feel is that we need to use OPP=
 and<br>
&gt;&gt;&gt; Voltage regulator interfaces also to<br>
&gt;&gt;&gt; maintain Optimum Performance Points and to provide APIs to cha=
nge the<br>
&gt;&gt;&gt; voltage.<br>
&gt;&gt;&gt; What I feel is that to use DVFS every driver has to<br>
&gt;&gt;&gt; call devfreq_add_device function to register that device to<br=
>
&gt;&gt;&gt; the devfreq framework. And in order to do that we have to<br>
&gt;&gt;&gt; implement devfreq_dev_profile and our choice of governer.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I appreciate your help.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; Satendra<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 20 March 2012 12:16, Satendra... &lt;<a href=3D"mailto:sate=
ndra.pratap@gmail.com">satendra.pratap@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Hi Ham,<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; We are working on a new SoC for our new product and would =
want to use<br>
&gt;&gt;&gt;&gt; your Devfreq<br>
&gt;&gt;&gt;&gt; framework for our devices. Would you please let me know an=
y other<br>
&gt;&gt;&gt;&gt; implementation which<br>
&gt;&gt;&gt;&gt; uses devfreq ? so that we could take that as a reference.<=
br>
&gt;&gt;&gt;&gt; Or we would be the first one to start?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;&gt; Satendra<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), PHD<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; System S/W Lab, S/W Platform Team, Software Center<br>
&gt;&gt;&gt; Samsung Electronics<br>
&gt;&gt;&gt; Cell: +82-10-6714-2858<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt;<br>
&gt;&gt; MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), PHD<br>
&gt;&gt;<br>
&gt;&gt; System S/W Lab, S/W Platform Team, Software Center<br>
&gt;&gt; Samsung Electronics<br>
&gt;&gt; Cell: +82-10-6714-2858<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; linux-pm mailing list<br>
&gt; <a href=3D"mailto:linux-pm@lists.linux-foundation.org">linux-pm@lists.=
linux-foundation.org</a><br>
&gt; <a href=3D"https://lists.linuxfoundation.org/mailman/listinfo/linux-pm=
" target=3D"_blank">https://lists.linuxfoundation.org/mailman/listinfo/linu=
x-pm</a><br>
<br>
<br>
<br>
<br>
--<br>
MyungJoo Ham, Ph.D.<br>
System S/W Lab, S/W Center, Samsung Electronics<br>
</blockquote></div><br></div>

--047d7b10c8994ef2e704bdc667be--

--===============3050859028022772088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3050859028022772088==--
