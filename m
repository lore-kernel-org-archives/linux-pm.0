From: "Satendra..." <satendra.pratap@gmail.com>
Subject: Re: Regarding Devfreq
Date: Tue, 17 Apr 2012 14:58:47 +0530
Message-ID: <CAChS5kP5n_UvZmJx2-Xatzr0WkH4qF0vc7XNh3v=CPfU184V8Q@mail.gmail.com>
References: <0M18009PVCPE8JM0@mailout1.samsung.com>
	<CAChS5kPtG3kk9dH9twMp68XKs6eLgQSiN49_ehsHAEddCHsJDg@mail.gmail.com>
	<CAJ0PZbRWgS_Vcx9mXqT=mO+oCXxgJwL1JOnDb_9uyU=p3a9tbA@mail.gmail.com>
	<CAChS5kNA8CyQuHPJ+HjJ21NMVB5vddBjJvSXQF+KcLbN4v8mXg@mail.gmail.com>
	<CAJ0PZbRfHz1BqMrJHi2FD+d51nx86hyr79M96pJ-ZCKoUYEFTQ@mail.gmail.com>
	<CAJ0PZbQPHMNAw459PwSF5fVc0kRN2J_cp7mbtAGwOBt-_-3JWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1557220123798490846=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJ0PZbQPHMNAw459PwSF5fVc0kRN2J_cp7mbtAGwOBt-_-3JWQ@mail.gmail.com>
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

--===============1557220123798490846==
Content-Type: multipart/alternative; boundary=e89a8ff1c90edad84d04bddc907f

--e89a8ff1c90edad84d04bddc907f
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: quoted-printable

Hi Ham,

On 16 April 2012 17:40, MyungJoo Ham <myungjoo.ham@gmail.com> wrote:

> On Mon, Apr 16, 2012 at 7:19 PM, MyungJoo Ham <myungjoo.ham@gmail.com>
> wrote:
> > On Mon, Apr 16, 2012 at 4:02 PM, Satendra... <satendra.pratap@gmail.com=
>
> wrote:
> >> Hi Ham,
> >>
> >> I have used jiffies to calculate the busy time and total time for a
> module
> >> (made of 'n' functions say).
> >> I have added a bew structure:
> >
> > Hi.
> >
> > In my ARM SoC systems, one jiffy is 5ms. I don't think other systems
> > won't vary too much (should be around several hundred us to several
> > ms). Are you sure that jiffy has enough granularity for your system?
> > If you are counting the length spent in a function call, shouldn't
> > nsecs be usec? (ktime?). And for saving such values, the
> > "private_data" is intended for individual devfreq drivers
> > communicating with governors specific to the drivers. Devfreq->data is
> > intended for individual devfreq governors. Thus, yes, platform-data is
> > the right place for devfreq driver internal.
> >
> > Cheers!
> > MyungJoo.
> >
>
> Ah.. and one missing point:
>
> Please consider the concurrency. You may have multiple instance of
> function calls in your device driver. And please do not block them by
> simply adding locks there if this performance counting is the only
> reason to make them mutually exclusive. This is another reason to
> count nsecs (ktime) locally in the function and add the end-start
> (local variable) into the aggregation variable (lock here only or use
> atomic operators).
>
> Cheers!
> MyungJoo.
>
>
Yes thats true that we will have multiple instances of function calls but
every instance of driver
will have its own copy of counters which can be accessed through platform
data.
So AFAICS we need not to worry about concurrency issue because no instance
will touch the
counters of another instance. Please correct if i am wrong.

Below is the code using ktime API:

typedef struct devfreq_perf_counters {
#ifdef DEVFREQ_USE_KTIME
        ktime_t fentry_time; /* jiffies at the enrty of a func */
        ktime_t start_time; /* starting jiffies for every busy/total \
                             load cal in the last x seconds*/
        ktime_t prev_count; /* last jiffies count */
        s64 busy_time; /* total execution jiffies count in the last \
                              x seconds */
#else
        unsigned long fentry_time; /* jiffies at the enrty of a func */
        unsigned long start_time; /* starting jiffies for every busy/total =
\
                                             load cal in the last x
seconds*/
        unsigned long prev_count; /* last jiffies count */
        unsigned long busy_time; /* total execution jiffies count in the
last \
                                      x seconds */
#endif
}devfreq_counters;

#ifdef DEVFREQ_USE_KTIME
/* using ktime */
        #define devfreq_func_start(dc) do {\
                (dc)->fentry_time =3D ktime_get();\
        }while(0)

        #define devfreq_func_end(dc) do {\
                (dc)->prev_count =3D ktime_get();\
                (dc)->busy_time +=3D ktime_to_ns(ktime_sub((dc)->prev_count=
, \
                                        (dc)->fentry_time));\
        }while(0)

        #define module_busy_time(dc)    ((dc)->busy_time)

        #define module_busy_plus_not_busy_time(dc) \
                ktime_to_ns(ktime_sub(ktime_get(), (dc)->start_time))

        #define devfreq_reset_counters(dc) do { \
                (dc)->start_time =3D ktime_get();\
        }while(0)
#else
        #define devfreq_func_start(dc) \
                (dc)->fentry_time =3D jiffies

        #define devfreq_fun_end(dc) do { \
                (dc)->prev_count =3D (jiffies)-((dc)->fentry_time);\
                (dc)->busy_time +=3D (dc)->prev_count;\
        }while(0)

        #define module_busy_time(dc) \
                jiffies_to_usecs((dc)->busy_time)

        #define module_busy_plus_not_busy_time(dc) \
                jiffies_to_usecs(((jiffies) - (dc)->start_time))

        #define devfreq_reset_counters(dc) do { \
                (dc)->fentry_time =3D 0UL; \
                (dc)->prev_count =3D 0UL; \
                (dc)->busy_time =3D 0UL; \
                (dc)->start_time =3D jiffies;\
        }while(0)
#endif

Thanks,
Satendra


> >>
> >> typedef struct devfreq_perf_counters {
> >>         unsigned long func_entry_jiffies; /* jiffies at the enrty of a
> func
> >> */
> >>         unsigned long start_jiffies; /* starting jiffies for every
> >> busy/total \
> >>                                              load cal in the last x
> >> seconds*/
> >>         unsigned long local_jiffies; /* last jiffies count */
> >>         unsigned long busy_jiffies; /* total execution jiffies count i=
n
> the
> >> last \
> >>                                       x seconds */
> >> }devfreq_counters;
> >>
> >> This structure's instance can be included in the platform_data(or
> private
> >> data) of the
> >> driver which has to register itself with devfreq. This way while doing
> >> set_drv_data, access
> >> to these counters could be available all the time.
> >>
> >> Now there is one initialization function :
> >>
> >> void devfreq_counters_init(void *data)
> >> {
> >>         devfreq_counters **dc =3D &data->dpc;
> >>
> >>         *dc =3D kzalloc(sizeof (devfreq_counters), GFP_KERNEL);
> >>
> >>         (*dc)->func_entry_jiffies =3D 0UL;
> >>         (*dc)->local_jiffies =3D 0UL;
> >>         (*dc)->busy_jiffies =3D 0UL;
> >>         (*dc)->start_jiffies =3D jiffies;
> >>
> >>         return;
> >> }
> >>
> >> This function initializes the counters and is called at the end of
> driver
> >> initialiation function.
> >>
> >> Now there is a list of APIs as shown below:
> >>
> >> #define devfreq_jiffies_start(dc) \
> >>         dc->func_entry_jiffies =3D jiffies
> >>
> >> #define devfreq_jiffies_end(dc) do { \
> >>         dc->local_jiffies =3D (jiffies)-(dc->func_entry_jiffies);\
> >>         dc->busy_jiffies +=3D dc->local_jiffies;\
> >> }while(0)
> >>
> >> #define busy_jiffies_in_usec(dc) \
> >>         jiffies_to_usecs((dc)->busy_jiffies)
> >>
> >> #define busy_plus_not_busy_jiffies_in_usec(dc) \
> >>         jiffies_to_usecs(((jiffies) - (dc)->start_jiffies))
> >>
> >> #define devfreq_reset_counters(dc) do { \
> >>         dc->func_entry_jiffies =3D 0UL; \
> >>         dc->local_jiffies =3D 0UL; \
> >>         dc->busy_jiffies =3D 0UL; \
> >>         dc->start_jiffies =3D jiffies;\
> >> }while(0)
> >>
> >> Description:
> >> - devfreq_jiffies_start(dc): Will be called in the start of the functi=
on
> >> (this is one of the functions
> >> which we want to consider in measuring the busy time of the driver)
> >> - devfreq_jiffies_end(dc): Will be called at the end of that function
> >> - busy_jiffies_in_usec(dc): Will return jiffies for which all consider=
ed
> >> (for busy time) driver's
> >> functions were busy
> >> - busy_plus_not_busy_jiffies_in_usec(dc): Total jiffies i.e. busy time
> + not
> >> busy time of driver
> >> - devfreq_reset_counters(dc): obvious
> >>
> >> I wanted the simple solution to busy and load and i thought about this=
.
> This
> >> solution hasn't been verified
> >> yet.
> >>
> >> Ham, can you please provide your views on it.
> >>
> >> Thanks,
> >> Satendra
> >>
> >>
> >> On 29 March 2012 07:44, MyungJoo Ham <myungjoo.ham@gmail.com> wrote:
> >>>
> >>> 2012/3/28 Satendra... <satendra.pratap@gmail.com>
> >>> >
> >>> > Hi Ham,
> >>> >
> >>> > In the below struct :
> >>> > struct devfreq_dev_status {
> >>> >         /* both since the last measure */
> >>> >         unsigned long total_time;
> >>> >         unsigned long busy_time;
> >>> >         unsigned long current_frequency;
> >>> >         void *private_data;
> >>> > };
> >>> >
> >>> > How to calculate total_time/busy_time? Does it require hardware
> support
> >>> > (may be some performance counters)?
> >>> >
> >>> > Thanks,
> >>> > Satendra
> >>>
> >>> It is decided by each devfreq device driver, which is why
> >>> get_dev_status() is to be provided by the devfreq device driver.
> >>>
> >>> If the device has performance counters, then, it's great, but
> >>> performance counters are not mandatory.
> >>>
> >>> Here goes a list of mechanisms to fetch busy/total time:
> >>> - Performance counters
> >>> - Measure the time between "operation start" and "operation end" and
> >>> accumulate the time (getting busy time. probably by ktime?)
> >>> - Measure the idle time (CPUIDLE/CPUFREQ does this)
> >>> - Count the number of operation and calculate the operational time
> >>> based on the number.
> >>> - and so on.
> >>>
> >>> As you can see in the list, you don't need a hardware support such as
> >>> performance counters.
> >>>
> >>>
> >>>
> >>> Cheers!
> >>> MyungJoo.
> >>>
> >>> >
> >>> >
> >>> > On 21 March 2012 15:49, =C7=D4=B8=ED=C1=D6 <myungjoo.ham@samsung.co=
m> wrote:
> >>> >>
> >>> >> Hi Stendra,
> >>> >>
> >>> >>
> >>> >>
> >>> >> - Bascially, you can determine the voltage based on frequency;
> thus, we
> >>> >> do not need to determint voltages at DVFS framework. It is
> >>> >> corresponding
> >>> >> device driver's responsibility even when we have AVS features. Thu=
s,
> >>> >> yes,
> >>> >> the target callback needs to control both frequency and voltage (a=
nd
> >>> >> anything else required to change the frequency/voltage)
> >>> >>
> >>> >>
> >>> >>
> >>> >> - I recommend to use regulator framework to control regulators
> unless
> >>> >> you
> >>> >> really really need to ignore regulator framework. Don't reinvent t=
he
> >>> >> wheel.
> >>> >>
> >>> >>
> >>> >>
> >>> >> - The three steps you've mentioned are correct.
> >>> >>
> >>> >>
> >>> >>
> >>> >> - The mailing list is opened to all. You are welcomed to use it
> (CC'ed
> >>> >> linux-pm) and just CC needed people.
> >>> >>
> >>> >>
> >>> >>
> >>> >>
> >>> >>
> >>> >> Cheers!
> >>> >>
> >>> >> MyungJoo.
> >>> >>
> >>> >>
> >>> >>
> >>> >> ------- Original Message -------
> >>> >>
> >>> >> Sender : Satendra...<satendra.pratap@gmail.com>
> >>> >>
> >>> >> Date : 2012-03-21 19:03 (GMT+09:00)
> >>> >>
> >>> >> Title : Re: Re: Regarding Devfreq
> >>> >>
> >>> >>
> >>> >>
> >>> >> Hi Ham,
> >>> >>
> >>> >> Thank you very much for your reply. I will try not to disturb you
> much.
> >>> >> In Devfreq I dont see any API related to voltage scaling. Is it th=
e
> >>> >> "->target" function's (in  struct devfreq_dev_profile)
> >>> >> responsibility to change the voltage as well with frequency?
> >>> >> Do we really need to register our regulators using regulator
> framework
> >>> >> of
> >>> >> linux for voltage scaling?
> >>> >>
> >>> >> For a clear understanding I need to do following to use devfreq (I
> am
> >>> >> sorry as I may be verifying it again):
> >>> >> - define an instance of "struct devfreq_dev_profile" and provide
> >>> >> implementations of target, get_dev_status and exit callbacks
> >>> >> - Implement our choice of governer or use any one from already
> >>> >> implemented ones.
> >>> >> - call "devfreq_add_device" function from our driver's probe
> function.
> >>> >>
> >>> >> is that it? or do we need to do something else also?
> >>> >>
> >>> >> Thanks,
> >>> >> Satendra
> >>> >>
> >>> >>
> >>> >> On 21 March 2012 15:14, =C7=D4=B8=ED=C1=D6 <myungjoo.ham@samsung.c=
om> wrote:
> >>> >>>
> >>> >>> Hello Satendra,
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>> - For Devfreq, OPP is optional though recommended for easier
> >>> >>> implementation. You can still implement all the needed things
> without
> >>> >>> OPP.
> >>> >>> OPP is just a simple data structure to store pairs of voltage and
> >>> >>> frequency.
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>> - Yes, you need to call devfreq_add_device() and supply the
> required
> >>> >>> data. You can implement your own governor or use one of predefine=
d
> >>> >>> governors. Runtime replacement of governors like CPUfreq is "TODO=
"
> for
> >>> >>> now.
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>> - For example, you can see /drivers/devfreq/exynos4_bus.c. GPU,
> >>> >>> Display
> >>> >>> devfreq drivers are under development in other companies (ARM).
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>> Cheers!
> >>> >>>
> >>> >>> MyungJoo.
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>> ------- Original Message -------
> >>> >>>
> >>> >>> Sender : Satendra...<satendra.pratap@gmail.com>
> >>> >>>
> >>> >>> Date : 2012-03-21 17:31 (GMT+09:00)
> >>> >>>
> >>> >>> Title : Re: Regarding Devfreq
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>> Hi Ham,
> >>> >>>
> >>> >>> I have studied DVFS and what I feel is that we need to use OPP an=
d
> >>> >>> Voltage regulator interfaces also to
> >>> >>> maintain Optimum Performance Points and to provide APIs to change
> the
> >>> >>> voltage.
> >>> >>> What I feel is that to use DVFS every driver has to
> >>> >>> call devfreq_add_device function to register that device to
> >>> >>> the devfreq framework. And in order to do that we have to
> >>> >>> implement devfreq_dev_profile and our choice of governer.
> >>> >>>
> >>> >>> I appreciate your help.
> >>> >>>
> >>> >>> Thanks,
> >>> >>> Satendra
> >>> >>>
> >>> >>> On 20 March 2012 12:16, Satendra... <satendra.pratap@gmail.com>
> wrote:
> >>> >>>>
> >>> >>>> Hi Ham,
> >>> >>>>
> >>> >>>> We are working on a new SoC for our new product and would want t=
o
> use
> >>> >>>> your Devfreq
> >>> >>>> framework for our devices. Would you please let me know any othe=
r
> >>> >>>> implementation which
> >>> >>>> uses devfreq ? so that we could take that as a reference.
> >>> >>>> Or we would be the first one to start?
> >>> >>>>
> >>> >>>> Thanks,
> >>> >>>> Satendra
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>>
> >>> >>> --
> >>> >>>
> >>> >>> MyungJoo Ham (=C7=D4=B8=ED=C1=D6), PHD
> >>> >>>
> >>> >>> System S/W Lab, S/W Platform Team, Software Center
> >>> >>> Samsung Electronics
> >>> >>> Cell: +82-10-6714-2858
> >>> >>>
> >>> >>>
> >>> >>
> >>> >>
> >>> >>
> >>> >>
> >>> >>
> >>> >>
> >>> >> --
> >>> >>
> >>> >> MyungJoo Ham (=C7=D4=B8=ED=C1=D6), PHD
> >>> >>
> >>> >> System S/W Lab, S/W Platform Team, Software Center
> >>> >> Samsung Electronics
> >>> >> Cell: +82-10-6714-2858
> >>> >>
> >>> >>
> >>> >
> >>> >
> >>> >
> >>> > _______________________________________________
> >>> > linux-pm mailing list
> >>> > linux-pm@lists.linux-foundation.org
> >>> > https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
> >>>
> >>>
> >>>
> >>>
> >>> --
> >>> MyungJoo Ham, Ph.D.
> >>> System S/W Lab, S/W Center, Samsung Electronics
> >>
> >>
> >
> >
> >
> > --
> > MyungJoo Ham, Ph.D.
> > System S/W Lab, S/W Center, Samsung Electronics
>
>
>
> --
> MyungJoo Ham, Ph.D.
> System S/W Lab, S/W Center, Samsung Electronics
>

--e89a8ff1c90edad84d04bddc907f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ham,<br><br><div class=3D"gmail_quote">On 16 April 2012 17:40, MyungJoo =
Ham <span dir=3D"ltr">&lt;<a href=3D"mailto:myungjoo.ham@gmail.com">myungjo=
o.ham@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On Mon, Apr 16, 2012 at 7:19 PM, MyungJoo Ham &lt;<a href=
=3D"mailto:myungjoo.ham@gmail.com">myungjoo.ham@gmail.com</a>&gt; wrote:<br=
>
&gt; On Mon, Apr 16, 2012 at 4:02 PM, Satendra... &lt;<a href=3D"mailto:sat=
endra.pratap@gmail.com">satendra.pratap@gmail.com</a>&gt; wrote:<br>
&gt;&gt; Hi Ham,<br>
&gt;&gt;<br>
&gt;&gt; I have used jiffies to calculate the busy time and total time for=
=C2=A0a module<br>
&gt;&gt; (made of &#39;n&#39; functions say).<br>
&gt;&gt; I have added a bew structure:<br>
&gt;<br>
&gt; Hi.<br>
&gt;<br>
&gt; In my ARM SoC systems, one jiffy is 5ms. I don&#39;t think other syste=
ms<br>
&gt; won&#39;t vary too much (should be around several hundred us to severa=
l<br>
&gt; ms). Are you sure that jiffy has enough granularity for your system?<b=
r>
&gt; If you are counting the length spent in a function call, shouldn&#39;t=
<br>
&gt; nsecs be usec? (ktime?). And for saving such values, the<br>
&gt; &quot;private_data&quot; is intended for individual devfreq drivers<br=
>
&gt; communicating with governors specific to the drivers. Devfreq-&gt;data=
 is<br>
&gt; intended for individual devfreq governors. Thus, yes, platform-data is=
<br>
&gt; the right place for devfreq driver internal.<br>
&gt;<br>
&gt; Cheers!<br>
&gt; MyungJoo.<br>
&gt;<br>
<br>
</div>Ah.. and one missing point:<br>
<br>
Please consider the concurrency. You may have multiple instance of<br>
function calls in your device driver. And please do not block them by<br>
simply adding locks there if this performance counting is the only<br>
reason to make them mutually exclusive. This is another reason to<br>
count nsecs (ktime) locally in the function and add the end-start<br>
(local variable) into the aggregation variable (lock here only or use<br>
atomic operators).<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
Cheers!<br>
MyungJoo.<br>
<br></div></div></blockquote><div><br></div><div>Yes thats true that we wil=
l have multiple instances of function calls but every instance of driver</d=
iv><div>will have its own copy of counters which can be accessed through pl=
atform data.</div>
<div>So AFAICS we need not to worry about concurrency issue because no inst=
ance will touch the</div><div>counters of another instance. Please correct =
if i am wrong.</div><div><br></div><div>Below is the code using ktime API:<=
/div>
<div><br></div><div><div>typedef struct devfreq_perf_counters {</div><div>#=
ifdef DEVFREQ_USE_KTIME</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ktime_t fentr=
y_time; /* jiffies at the enrty of a func */</div><div>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ktime_t start_time; /* starting jiffies for every busy/total \</div=
>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0load cal in the last x seconds*/</div><di=
v>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ktime_t prev_count; /* last jiffies count */<=
/div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 s64 busy_time; /* total execution jif=
fies count in the last \</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x second=
s */</div>
<div>#else</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long fentry_time;=
 /* jiffies at the enrty of a func */</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 unsigned long start_time; /* starting jiffies for every busy/total \</div>=
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0load cal in the last x seconds*/</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long prev_count; /* last jiffies =
count */</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long busy_time; /* =
total execution jiffies count in the last \</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x seconds */</div><div>
#endif</div><div>}devfreq_counters;</div></div><div><br></div><div><div>#if=
def DEVFREQ_USE_KTIME</div><div>/* using ktime */</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 #define devfreq_func_start(dc) do {\</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dc)-&gt;fentry_time =3D ktime_ge=
t();\</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }while(0)</div><div><br></div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 #define devfreq_func_end(dc) do {\</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dc)-&gt;prev_count =3D kt=
ime_get();\</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (dc)-&gt;busy_time +=3D ktime_to_ns(ktime_sub((dc)-&gt;prev_count, \</d=
iv>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dc)-=
&gt;fentry_time));\</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }while(0)</div><d=
iv><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 #define module_busy_time(dc) =
=C2=A0 =C2=A0((dc)-&gt;busy_time)</div><div><br></div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 #define module_busy_plus_not_busy_time(dc) \</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ktime_to_ns(kt=
ime_sub(ktime_get(), (dc)-&gt;start_time))</div><div><br></div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 #define devfreq_reset_counters(dc) do { \</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dc)-&gt;start_time=
 =3D ktime_get();\</div><div>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }while(0)</div><div>#else</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 #define devfreq_func_start(dc) \</div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dc)-&gt;fentry_time =3D jiffies<=
/div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 #define devfreq_fun_en=
d(dc) do { \</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (dc)-&gt;prev_count =3D (jiffies)-((dc)-&gt;fentry_time);\</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dc)-&gt;busy_=
time +=3D (dc)-&gt;prev_count;\</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }whil=
e(0)</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 #define module_bu=
sy_time(dc) \</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 jiffies_to_usecs((dc)-&gt;busy_time)</div>
<div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 #define module_busy_plus_no=
t_busy_time(dc) \</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 jiffies_to_usecs(((jiffies) - (dc)-&gt;start_time))</div><div><b=
r></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 #define devfreq_reset_counters(dc)=
 do { \</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dc)-&gt;fentr=
y_time =3D 0UL; \</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (dc)-&gt;prev_count =3D 0UL; \</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dc)-&gt;busy_time =3D 0UL; \</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (dc)-&gt;start_time=
 =3D jiffies;\</div>
<div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }while(0)</div><div>#endif</div></div><div=
><br></div><div>Thanks,</div><div>Satendra</div><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><div class=3D"HOEnZb">
<div class=3D"h5">
&gt;&gt;<br>
&gt;&gt; typedef struct devfreq_perf_counters {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long func_entry_jiffies; /* j=
iffies at the enrty of a func<br>
&gt;&gt; */<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long start_jiffies; /* starti=
ng jiffies for every<br>
&gt;&gt; busy/total \<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0load cal in the last x<br>
&gt;&gt; seconds*/<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long local_jiffies; /* last j=
iffies count */<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long busy_jiffies; /* total e=
xecution jiffies count in the<br>
&gt;&gt; last \<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x second=
s */<br>
&gt;&gt; }devfreq_counters;<br>
&gt;&gt;<br>
&gt;&gt; This structure&#39;s instance can be included in the platform_data=
(or private<br>
&gt;&gt; data) of the<br>
&gt;&gt; driver which has to register itself with devfreq. This way while d=
oing<br>
&gt;&gt; set_drv_data, access<br>
&gt;&gt; to these counters could be available all the time.<br>
&gt;&gt;<br>
&gt;&gt; Now there is one initialization function :<br>
&gt;&gt;<br>
&gt;&gt; void devfreq_counters_init(void *data)<br>
&gt;&gt; {<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 devfreq_counters **dc =3D &amp;data-&g=
t;dpc;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 *dc =3D kzalloc(sizeof (devfreq_counte=
rs), GFP_KERNEL);<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*dc)-&gt;func_entry_jiffies =3D 0UL;<=
br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*dc)-&gt;local_jiffies =3D 0UL;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*dc)-&gt;busy_jiffies =3D 0UL;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 (*dc)-&gt;start_jiffies =3D jiffies;<b=
r>
&gt;&gt;<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt; }<br>
&gt;&gt;<br>
&gt;&gt; This function initializes the counters and is called at the end of=
 driver<br>
&gt;&gt; initialiation function.<br>
&gt;&gt;<br>
&gt;&gt; Now there is a list of APIs as shown below:<br>
&gt;&gt;<br>
&gt;&gt; #define devfreq_jiffies_start(dc) \<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 dc-&gt;func_entry_jiffies =3D jiffies<=
br>
&gt;&gt;<br>
&gt;&gt; #define devfreq_jiffies_end(dc) do { \<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 dc-&gt;local_jiffies =3D (jiffies)-(dc=
-&gt;func_entry_jiffies);\<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 dc-&gt;busy_jiffies +=3D dc-&gt;local_=
jiffies;\<br>
&gt;&gt; }while(0)<br>
&gt;&gt;<br>
&gt;&gt; #define busy_jiffies_in_usec(dc) \<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 jiffies_to_usecs((dc)-&gt;busy_jiffies=
)<br>
&gt;&gt;<br>
&gt;&gt; #define busy_plus_not_busy_jiffies_in_usec(dc) \<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 jiffies_to_usecs(((jiffies) - (dc)-&gt=
;start_jiffies))<br>
&gt;&gt;<br>
&gt;&gt; #define devfreq_reset_counters(dc) do { \<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 dc-&gt;func_entry_jiffies =3D 0UL; \<b=
r>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 dc-&gt;local_jiffies =3D 0UL; \<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 dc-&gt;busy_jiffies =3D 0UL; \<br>
&gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 dc-&gt;start_jiffies =3D jiffies;\<br>
&gt;&gt; }while(0)<br>
&gt;&gt;<br>
&gt;&gt; Description:<br>
&gt;&gt; - devfreq_jiffies_start(dc): Will be called in the start of the fu=
nction<br>
&gt;&gt; (this is one of the functions<br>
&gt;&gt; which we want to consider in measuring the busy time of the driver=
)<br>
&gt;&gt; - devfreq_jiffies_end(dc): Will be called at the end of that funct=
ion<br>
&gt;&gt; - busy_jiffies_in_usec(dc): Will return jiffies for which all cons=
idered<br>
&gt;&gt; (for busy time) driver&#39;s<br>
&gt;&gt; functions were busy<br>
&gt;&gt; - busy_plus_not_busy_jiffies_in_usec(dc): Total jiffies i.e. busy =
time + not<br>
&gt;&gt; busy time of driver<br>
&gt;&gt; - devfreq_reset_counters(dc): obvious<br>
&gt;&gt;<br>
&gt;&gt; I wanted the simple solution to busy and load and i thought about =
this. This<br>
&gt;&gt; solution hasn&#39;t been verified<br>
&gt;&gt; yet.<br>
&gt;&gt;<br>
&gt;&gt; Ham, can you please provide your views on it.<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; Satendra<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On 29 March 2012 07:44, MyungJoo Ham &lt;<a href=3D"mailto:myungjo=
o.ham@gmail.com">myungjoo.ham@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 2012/3/28 Satendra... &lt;<a href=3D"mailto:satendra.pratap@gm=
ail.com">satendra.pratap@gmail.com</a>&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Hi Ham,<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; In the below struct :<br>
&gt;&gt;&gt; &gt; struct devfreq_dev_status {<br>
&gt;&gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* both since the last measur=
e */<br>
&gt;&gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long total_time;<br>
&gt;&gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long busy_time;<br>
&gt;&gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long current_frequen=
cy;<br>
&gt;&gt;&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *private_data;<br>
&gt;&gt;&gt; &gt; };<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; How to calculate total_time/busy_time? Does it require ha=
rdware support<br>
&gt;&gt;&gt; &gt; (may be some performance counters)?<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; Thanks,<br>
&gt;&gt;&gt; &gt; Satendra<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; It is decided by each devfreq device driver, which is why<br>
&gt;&gt;&gt; get_dev_status() is to be provided by the devfreq device drive=
r.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; If the device has performance counters, then, it&#39;s great, =
but<br>
&gt;&gt;&gt; performance counters are not mandatory.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Here goes a list of mechanisms to fetch busy/total time:<br>
&gt;&gt;&gt; - Performance counters<br>
&gt;&gt;&gt; - Measure the time between &quot;operation start&quot; and &qu=
ot;operation end&quot; and<br>
&gt;&gt;&gt; accumulate the time (getting busy time. probably by ktime?)<br=
>
&gt;&gt;&gt; - Measure the idle time (CPUIDLE/CPUFREQ does this)<br>
&gt;&gt;&gt; - Count the number of operation and calculate the operational =
time<br>
&gt;&gt;&gt; based on the number.<br>
&gt;&gt;&gt; - and so on.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; As you can see in the list, you don&#39;t need a hardware supp=
ort such as<br>
&gt;&gt;&gt; performance counters.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Cheers!<br>
&gt;&gt;&gt; MyungJoo.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; On 21 March 2012 15:49, =ED=95=A8=EB=AA=85=EC=A3=BC &lt;<=
a href=3D"mailto:myungjoo.ham@samsung.com">myungjoo.ham@samsung.com</a>&gt;=
 wrote:<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; Hi Stendra,<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; - Bascially, you can determine the voltage based on f=
requency; thus, we<br>
&gt;&gt;&gt; &gt;&gt; do not need to determint voltages at DVFS framework. =
It is<br>
&gt;&gt;&gt; &gt;&gt; corresponding<br>
&gt;&gt;&gt; &gt;&gt; device driver&#39;s responsibility even when we have =
AVS features. Thus,<br>
&gt;&gt;&gt; &gt;&gt; yes,<br>
&gt;&gt;&gt; &gt;&gt; the target callback needs to control both frequency a=
nd voltage (and<br>
&gt;&gt;&gt; &gt;&gt; anything else required to change the frequency/voltag=
e)<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; - I recommend to use regulator framework to control r=
egulators unless<br>
&gt;&gt;&gt; &gt;&gt; you<br>
&gt;&gt;&gt; &gt;&gt; really really need to ignore regulator framework. Don=
&#39;t reinvent the<br>
&gt;&gt;&gt; &gt;&gt; wheel.<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; - The three steps you&#39;ve mentioned are correct.<b=
r>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; - The mailing list is opened to all. You are welcomed=
 to use it (CC&#39;ed<br>
&gt;&gt;&gt; &gt;&gt; linux-pm) and just CC needed people.<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; Cheers!<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; MyungJoo.<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; ------- Original Message -------<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; Sender : Satendra...&lt;<a href=3D"mailto:satendra.pr=
atap@gmail.com">satendra.pratap@gmail.com</a>&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; Date : 2012-03-21 19:03 (GMT+09:00)<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; Title : Re: Re: Regarding Devfreq<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; Hi Ham,<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; Thank you very much for your reply. I will try not to=
 disturb you much.<br>
&gt;&gt;&gt; &gt;&gt; In Devfreq I dont see any API related to voltage scal=
ing. Is it the<br>
&gt;&gt;&gt; &gt;&gt; &quot;-&gt;target&quot; function&#39;s (in =C2=A0stru=
ct devfreq_dev_profile)<br>
&gt;&gt;&gt; &gt;&gt; responsibility to change the voltage as well with fre=
quency?<br>
&gt;&gt;&gt; &gt;&gt; Do we really need to register our regulators using re=
gulator framework<br>
&gt;&gt;&gt; &gt;&gt; of<br>
&gt;&gt;&gt; &gt;&gt; linux for voltage scaling?<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; For a clear understanding I need to do following to u=
se devfreq (I am<br>
&gt;&gt;&gt; &gt;&gt; sorry as I may be verifying it again):<br>
&gt;&gt;&gt; &gt;&gt; - define an instance of &quot;struct devfreq_dev_prof=
ile&quot; and provide<br>
&gt;&gt;&gt; &gt;&gt; implementations of target, get_dev_status and exit ca=
llbacks<br>
&gt;&gt;&gt; &gt;&gt; - Implement our choice of governer or use any one fro=
m already<br>
&gt;&gt;&gt; &gt;&gt; implemented ones.<br>
&gt;&gt;&gt; &gt;&gt; - call &quot;devfreq_add_device&quot; function from o=
ur driver&#39;s probe function.<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; is that it? or do we need to do something else also?<=
br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; Thanks,<br>
&gt;&gt;&gt; &gt;&gt; Satendra<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; On 21 March 2012 15:14, =ED=95=A8=EB=AA=85=EC=A3=BC &=
lt;<a href=3D"mailto:myungjoo.ham@samsung.com">myungjoo.ham@samsung.com</a>=
&gt; wrote:<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; Hello Satendra,<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; - For Devfreq, OPP is optional though recommended=
 for easier<br>
&gt;&gt;&gt; &gt;&gt;&gt; implementation. You can still implement all the n=
eeded things without<br>
&gt;&gt;&gt; &gt;&gt;&gt; OPP.<br>
&gt;&gt;&gt; &gt;&gt;&gt; OPP is just a simple data structure to store pair=
s of voltage and<br>
&gt;&gt;&gt; &gt;&gt;&gt; frequency.<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; - Yes, you need to call devfreq_add_device() and =
supply the required<br>
&gt;&gt;&gt; &gt;&gt;&gt; data. You can implement your own governor or use =
one of predefined<br>
&gt;&gt;&gt; &gt;&gt;&gt; governors. Runtime replacement of governors like =
CPUfreq is &quot;TODO&quot; for<br>
&gt;&gt;&gt; &gt;&gt;&gt; now.<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; - For example, you can see /drivers/devfreq/exyno=
s4_bus.c. GPU,<br>
&gt;&gt;&gt; &gt;&gt;&gt; Display<br>
&gt;&gt;&gt; &gt;&gt;&gt; devfreq drivers are under development in other co=
mpanies (ARM).<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; Cheers!<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; MyungJoo.<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; ------- Original Message -------<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; Sender : Satendra...&lt;<a href=3D"mailto:satendr=
a.pratap@gmail.com">satendra.pratap@gmail.com</a>&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; Date : 2012-03-21 17:31 (GMT+09:00)<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; Title : Re: Regarding Devfreq<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; Hi Ham,<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; I have studied DVFS and what I feel is that we ne=
ed to use OPP and<br>
&gt;&gt;&gt; &gt;&gt;&gt; Voltage regulator interfaces also to<br>
&gt;&gt;&gt; &gt;&gt;&gt; maintain Optimum Performance Points and to provid=
e APIs to change the<br>
&gt;&gt;&gt; &gt;&gt;&gt; voltage.<br>
&gt;&gt;&gt; &gt;&gt;&gt; What I feel is that to use DVFS every driver has =
to<br>
&gt;&gt;&gt; &gt;&gt;&gt; call devfreq_add_device function to register that=
 device to<br>
&gt;&gt;&gt; &gt;&gt;&gt; the devfreq framework. And in order to do that we=
 have to<br>
&gt;&gt;&gt; &gt;&gt;&gt; implement devfreq_dev_profile and our choice of g=
overner.<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; I appreciate your help.<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; &gt;&gt;&gt; Satendra<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; On 20 March 2012 12:16, Satendra... &lt;<a href=
=3D"mailto:satendra.pratap@gmail.com">satendra.pratap@gmail.com</a>&gt; wro=
te:<br>
&gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;&gt; Hi Ham,<br>
&gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;&gt; We are working on a new SoC for our new produ=
ct and would want to use<br>
&gt;&gt;&gt; &gt;&gt;&gt;&gt; your Devfreq<br>
&gt;&gt;&gt; &gt;&gt;&gt;&gt; framework for our devices. Would you please l=
et me know any other<br>
&gt;&gt;&gt; &gt;&gt;&gt;&gt; implementation which<br>
&gt;&gt;&gt; &gt;&gt;&gt;&gt; uses devfreq ? so that we could take that as =
a reference.<br>
&gt;&gt;&gt; &gt;&gt;&gt;&gt; Or we would be the first one to start?<br>
&gt;&gt;&gt; &gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; &gt;&gt;&gt;&gt; Satendra<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; --<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), PHD<b=
r>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; System S/W Lab, S/W Platform Team, Software Cente=
r<br>
&gt;&gt;&gt; &gt;&gt;&gt; Samsung Electronics<br>
&gt;&gt;&gt; &gt;&gt;&gt; Cell: +82-10-6714-2858<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; --<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; MyungJoo Ham (=ED=95=A8=EB=AA=85=EC=A3=BC), PHD<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; System S/W Lab, S/W Platform Team, Software Center<br=
>
&gt;&gt;&gt; &gt;&gt; Samsung Electronics<br>
&gt;&gt;&gt; &gt;&gt; Cell: +82-10-6714-2858<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt; _______________________________________________<br>
&gt;&gt;&gt; &gt; linux-pm mailing list<br>
&gt;&gt;&gt; &gt; <a href=3D"mailto:linux-pm@lists.linux-foundation.org">li=
nux-pm@lists.linux-foundation.org</a><br>
&gt;&gt;&gt; &gt; <a href=3D"https://lists.linuxfoundation.org/mailman/list=
info/linux-pm" target=3D"_blank">https://lists.linuxfoundation.org/mailman/=
listinfo/linux-pm</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; --<br>
&gt;&gt;&gt; MyungJoo Ham, Ph.D.<br>
&gt;&gt;&gt; System S/W Lab, S/W Center, Samsung Electronics<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; MyungJoo Ham, Ph.D.<br>
&gt; System S/W Lab, S/W Center, Samsung Electronics<br>
<br>
<br>
<br>
--<br>
MyungJoo Ham, Ph.D.<br>
System S/W Lab, S/W Center, Samsung Electronics<br>
</div></div></blockquote></div><br>

--e89a8ff1c90edad84d04bddc907f--

--===============1557220123798490846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1557220123798490846==--
