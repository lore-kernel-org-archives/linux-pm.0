From: "Jiejing.Zhang " <kzjeef@gmail.com>
Subject: Re: [RESEND PATCH] PM: add a config that give warnning
 if driver take too long on suspend/resume.
Date: Tue, 12 Apr 2011 01:37:22 +0800
Message-ID: <BANLkTincwnm_2DBKibNP-JC5fqKJf5MWXQ@mail.gmail.com>
References: <BANLkTi=Q8N-=gjiS6M1b-krjqceVHfk8GQ@mail.gmail.com>
	<Pine.LNX.4.44L0.1104111306310.1975-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3718408530758806418=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1104111306310.1975-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-pm@vger.kernel.org

--===============3718408530758806418==
Content-Type: multipart/alternative; boundary=000e0cd16e545db61504a0a80808

--000e0cd16e545db61504a0a80808
Content-Type: text/plain; charset=ISO-8859-1

Hi Alan,

2011/4/12 Alan Stern <stern@rowland.harvard.edu>

> On Tue, 12 Apr 2011, Jiejing.Zhang  wrote:
>
> > Hi,
> >
> > Does anyone have comments on this driver?
> >
> > Best regards,
> > Zhang Jiejing
> >
> >
> > 2011/4/7 Jiejing Zhang <kzjeef@gmail.com>
> >
> > > From: Zhang Jiejing <jiejing.zhang@freescale.com>
> > >
> > > This patch add function to check each device's suspend time
> > > consumption. If any driver takes more time that the threshold (default
> > > 0.5 ms), it will print a warnning message including the device and bus
> > > name on the console.  You can change the threshold on-the-fly by
> > > modify file '/sys/power/device_suspend_time_threshold' to adjust this
> > > value,the unit is in microsecond.
>
> Bear in mind that rotating disk drives typically take several hundred
> milliseconds to spin down.  The warning would always trigger.  That
> doesn't seem particularly useful.
>

I think it's better change the default value 0 to disable it, enable it only
some one write a threshold.

First of all, it's a debug function (depends on PM_DEBUG), It's useful
in embedded area, like mobile phone or e-book, they are suspend/resume very
frequently and required resume as quick as possible. This debug function
can used to figure out which driver(s) is/are slow on suspend/resume.

I fact that embedded engineer meets a lot is, after some development the
total time of suspend/resume is become slow, since there was a lot driver
may affect the total time, it's function can help them to figure out which
driver is slow, and it's make life easier.

Thanks.

Jiejing Zhang


> Alan Stern
>
>

--000e0cd16e545db61504a0a80808
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Alan,<div><br><div class=3D"gmail_quote">2011/4/12 Alan Stern <span dir=
=3D"ltr">&lt;<a href=3D"mailto:stern@rowland.harvard.edu">stern@rowland.har=
vard.edu</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div class=3D"im">On Tue, 12 Apr 2011, Jiejing.Zhang =A0wrote:<br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt; Does anyone have comments on this driver?<br>
&gt;<br>
&gt; Best regards,<br>
&gt; Zhang Jiejing<br>
&gt;<br>
&gt;<br>
&gt; 2011/4/7 Jiejing Zhang &lt;<a href=3D"mailto:kzjeef@gmail.com">kzjeef@=
gmail.com</a>&gt;<br>
&gt;<br>
&gt; &gt; From: Zhang Jiejing &lt;<a href=3D"mailto:jiejing.zhang@freescale=
.com">jiejing.zhang@freescale.com</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; This patch add function to check each device&#39;s suspend time<b=
r>
&gt; &gt; consumption. If any driver takes more time that the threshold (de=
fault<br>
&gt; &gt; 0.5 ms), it will print a warnning message including the device an=
d bus<br>
&gt; &gt; name on the console. =A0You can change the threshold on-the-fly b=
y<br>
&gt; &gt; modify file &#39;/sys/power/device_suspend_time_threshold&#39; to=
 adjust this<br>
&gt; &gt; value,the unit is in microsecond.<br>
<br>
</div>Bear in mind that rotating disk drives typically take several hundred=
<br>
milliseconds to spin down. =A0The warning would always trigger. =A0That<br>
doesn&#39;t seem particularly useful.<br></blockquote><div><br></div><div>I=
 think it&#39;s better change the default value 0 to disable it, enable it =
only some one write a threshold.</div><div><br></div><div>First of all, it&=
#39;s a debug function (depends on PM_DEBUG), It&#39;s useful in=A0embedded=
=A0area, like mobile phone or e-book, they are suspend/resume very frequent=
ly and required resume as quick as possible. This debug function can=A0used=
 to figure out which driver(s) is/are slow on suspend/resume.</div>

<div><br></div><div>I fact that=A0embedded=A0engineer meets a lot is, after=
 some development the total time of suspend/resume is become slow, since th=
ere was a lot driver may affect the total time, it&#39;s function can help =
them to figure out which driver is slow, and it&#39;s make life easier.</di=
v>

<div><br></div><div>Thanks.</div><div><br></div><div>Jiejing Zhang</div><di=
v><br></div><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex;">


<font color=3D"#888888"><br>
Alan Stern<br>
<br>
</font></blockquote></div><br></div>

--000e0cd16e545db61504a0a80808--

--===============3718408530758806418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3718408530758806418==--
