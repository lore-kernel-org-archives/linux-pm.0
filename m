From: "Satendra..." <satendra.pratap@gmail.com>
Subject: Re: Devfreq Simple On Demand Governor
Date: Tue, 17 Apr 2012 15:49:32 +0530
Message-ID: <CAChS5kO96UeZEeisRqdX7Ene_cQBjdB2+pduBMtoBWvXr4szTw@mail.gmail.com>
References: <CAChS5kNS6DUq9W-R0XkQ8ksojUAbsLy5opz1eKb5iaa0D895cw@mail.gmail.com>
	<CAJ0PZbQB3USyV65KNERn01yF-KFgi9o7yRJquoOc0iBWotv6PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0800063515720809313=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJ0PZbQB3USyV65KNERn01yF-KFgi9o7yRJquoOc0iBWotv6PA@mail.gmail.com>
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

--===============0800063515720809313==
Content-Type: multipart/alternative; boundary=047d7b10cbcb5ad3cc04bddd460b

--047d7b10cbcb5ad3cc04bddd460b
Content-Type: text/plain; charset=ISO-8859-1

Hi Ham,

Thanks for your replies. Below are my thoughts.

On 16 April 2012 19:46, MyungJoo Ham <myungjoo.ham@gmail.com> wrote:

> On Mon, Apr 16, 2012 at 7:07 PM, Satendra... <satendra.pratap@gmail.com>
> wrote:
> > Hi Ham,
> >
> > I was looking at the simple on demand governor's code and have got few
> > queries:
> > - In the code below to check for overflow, why 24 and 7  has been taken?
> >         /* Prevent overflow */
> >         if (stat.busy_time >= (1 << 24) || stat.total_time >= (1 << 24))
> {
> >                 stat.busy_time >>= 7;
> >                 stat.total_time >>= 7;
> >         }
>
> It is because 1<<7 >= 100 and 1<<6 < 100. (To get percentage, we are
> multiplying 100).
>
> ok. but what about 24? Is it assumed that no one will be allowed to
execute more than 2^(24-7) units (nsec, msecs etc)?
Is 2^(24-7) = 128 * 1024 units (nsecs, msecs etc) the default time slice of
kernel to any code?


> >
> > - Also for maximum frequency UINT_MAX is returned which may not be suited
> > for some devices.
>
> The frequency given to devfreq driver is "recommended frequency", not
> the "exact frequency required".
>
> Thus, the driver is required to choose
> 1. frequency that is at least (but closest) or same with the
> "recommended frequency"
> and if that's impossible,
> 2. frequency that is closest to the "recommended frequency".
>
> Thus, if it's "UINT_MAX", then it should choose the maximum frequency.
>
>
You mean we have to check for UINT_MAX in our code and if its so then set
device at its maximum frequency.


> >
> > - One more query, whats the unit (usecs, nsecs etc) used for busy and
> load
> > time. Has it got nothing to do with units
> > and its mere the percentage of busy time?
>
> The unit is up to the device driver. It only needs to provide
> "reasonable" values in u32 to the infrastructure. It could be usec,
> nsec, #ops, or anything else.
> I've mentioned it only because jiffy does not seem to be "reasonable";
> jiffy is too rough. You may even get 0 jiffies for 100 operations
> while you may get 1 jiffy for 1 operation in the same system.
>
> In the governors, maybe busy / total ratio can be used as in
> simple_ondemand. And you should give values that can support some fair
> granularity there, which jiffy cannot.
>
> >
> > - If we want to use simple on demand governor then do we need to modify
> > yours to suit our needs? I mean you have
> > just provided a framework?
>
> If you want to use THE simple_ondemand for your device, you only need
> to create a devfreq driver. You don't need to modify the governor or
> the framework/.
>
> >
> > Thanks,
> > Satendra
>
>
> Cheers!
> MyungJoo.
>
> --
> MyungJoo Ham, Ph.D.
> System S/W Lab, S/W Center, Samsung Electronics
>

Thanks,
Satendra

--047d7b10cbcb5ad3cc04bddd460b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ham,=A0<div><br></div><div>Thanks for your replies. Below are my thought=
s.<br><br><div class=3D"gmail_quote">On 16 April 2012 19:46, MyungJoo Ham <=
span dir=3D"ltr">&lt;<a href=3D"mailto:myungjoo.ham@gmail.com">myungjoo.ham=
@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Mon, Apr 16, 2012 at 7:=
07 PM, Satendra... &lt;<a href=3D"mailto:satendra.pratap@gmail.com">satendr=
a.pratap@gmail.com</a>&gt; wrote:<br>

&gt; Hi Ham,<br>
&gt;<br>
&gt; I was looking at the simple on demand governor&#39;s code and have got=
 few<br>
&gt; queries:<br>
&gt; - In the code below to check for overflow, why 24 and 7 =A0has been ta=
ken?<br>
&gt; =A0 =A0 =A0 =A0 /* Prevent overflow */<br>
&gt; =A0 =A0 =A0 =A0 if (stat.busy_time &gt;=3D (1 &lt;&lt; 24) || stat.tot=
al_time &gt;=3D (1 &lt;&lt; 24)) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stat.busy_time &gt;&gt;=3D 7;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stat.total_time &gt;&gt;=3D 7;<br>
&gt; =A0 =A0 =A0 =A0 }<br>
<br>
</div>It is because 1&lt;&lt;7 &gt;=3D 100 and 1&lt;&lt;6 &lt; 100. (To get=
 percentage, we are<br>
multiplying 100).<br>
<div class=3D"im"><br></div></blockquote><div>ok. but what about 24? Is it =
assumed that no one will be allowed to execute more than 2^(24-7) units (ns=
ec, msecs etc)?</div><div>Is 2^(24-7) =3D 128 * 1024 units (nsecs, msecs et=
c) the default time slice of kernel to any code?</div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div class=3D"im">
&gt;<br>
&gt; - Also for maximum frequency UINT_MAX is returned which may not be sui=
ted<br>
&gt; for some devices.<br>
<br>
</div>The frequency given to devfreq driver is &quot;recommended frequency&=
quot;, not<br>
the &quot;exact frequency required&quot;.<br>
<br>
Thus, the driver is required to choose<br>
1. frequency that is at least (but closest) or same with the<br>
&quot;recommended frequency&quot;<br>
and if that&#39;s impossible,<br>
2. frequency that is closest to the &quot;recommended frequency&quot;.<br>
<br>
Thus, if it&#39;s &quot;UINT_MAX&quot;, then it should choose the maximum f=
requency.<br>
<div class=3D"im"><br></div></blockquote><div><br></div><div>You mean we ha=
ve to check for UINT_MAX in our code and if its so then set device at its m=
aximum frequency.</div><div>=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">
&gt;<br>
&gt; - One more query, whats the unit (usecs, nsecs etc) used for busy and =
load<br>
&gt; time. Has it got nothing to do with units<br>
&gt; and its mere the percentage of busy time?<br>
<br>
</div>The unit is up to the device driver. It only needs to provide<br>
&quot;reasonable&quot; values in u32 to the infrastructure. It could be use=
c,<br>
nsec, #ops, or anything else.<br>
I&#39;ve mentioned it only because jiffy does not seem to be &quot;reasonab=
le&quot;;<br>
jiffy is too rough. You may even get 0 jiffies for 100 operations<br>
while you may get 1 jiffy for 1 operation in the same system.<br>
<br>
In the governors, maybe busy / total ratio can be used as in<br>
simple_ondemand. And you should give values that can support some fair<br>
granularity there, which jiffy cannot.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; - If we want to use simple on demand governor then do we need to modif=
y<br>
&gt; yours to suit our needs? I mean you have<br>
&gt; just provided a framework?<br>
<br>
</div>If you want to use THE simple_ondemand for your device, you only need=
<br>
to create a devfreq driver. You don&#39;t need to modify the governor or<br=
>
the framework/.<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Satendra<br>
<br>
<br>
Cheers!<br>
<span class=3D"HOEnZb"><font color=3D"#888888">MyungJoo.<br>
<br>
--<br>
MyungJoo Ham, Ph.D.<br>
System S/W Lab, S/W Center, Samsung Electronics<br>
</font></span></blockquote></div><br><div>Thanks,</div><div>Satendra</div><=
/div>

--047d7b10cbcb5ad3cc04bddd460b--

--===============0800063515720809313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0800063515720809313==--
