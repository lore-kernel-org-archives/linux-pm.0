From: Jian Peng <jipeng2005@gmail.com>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
 ahci_start_engine compliant to AHCI spec"
Date: Thu, 19 May 2011 14:57:07 -0700
Message-ID: <BANLkTikR2E2vb=9_ftLS4pcq0ysje7Rqyg@mail.gmail.com>
References: <201105120025.34531.rjw@sisk.pl> <201105191219.27743.rjw@sisk.pl>
	<BANLkTin6+2obBm=+5Kd5Za1Lq-n4UQ-STw@mail.gmail.com>
	<201105192332.16493.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4705024762546897354=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105192332.16493.rjw@sisk.pl>
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
Cc: Valdis.Kletnieks@vt.edu, Michael Leun <lkml20100708@newton.leun.net>, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-pm@vger.kernel.org

--===============4705024762546897354==
Content-Type: multipart/alternative; boundary=20cf3071c8de13bde504a3a816c3

--20cf3071c8de13bde504a3a816c3
Content-Type: text/plain; charset=ISO-8859-1

Hi, Rafael,

I am using internal WDC laptop HDD. I will give SDD a try even though I only
have non-Intel SDD now.

Is your SDD the boot disk (by swapping the built-in HDD out) or the extra
one installed using device bay on Dell laptop?

Thanks,
Jian


2011/5/19 Rafael J. Wysocki <rjw@sisk.pl>

> On Thursday, May 19, 2011, Jian Peng wrote:
> > Hi, Rafael,
> >
> > Yes. I tested without reverting the patch that caused failure on E6410
> (with
> > same AHCI controller), The system is Ubuntu 11.04 with default 2.6.39-rc6
> > kernel (guess this should be same kernel as yours before reverting the
> > patch).
> >
> > My system worked well with AC power cable plugging in and out at boot
> time,
> > at runtime, and during "dd if=/dev/sda5 of=/dev/null ..".
>
> What kind of disk did you use?  Mine is an Intel SSD.
>
> > The config file I mentioned is those under /etc/ or other directories
> that
> > is used to control the power management.
>
> They aren't relevant to this issue.
>
> > Did you test my patch? What it the result?
>
> No, I didn't.  Unfortunately, I won't be able to do any tests on the
> affected
> machine in the near future (most probably for the next two weeks or so).
>
> Thanks,
> Rafael
>

--20cf3071c8de13bde504a3a816c3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi, Rafael,</div>
<div>=A0</div>
<div>I am using internal=A0WDC laptop HDD. I will give SDD a try even thoug=
h I=A0only have non-Intel SDD now.</div>
<div>=A0</div>
<div>Is your SDD the boot disk (by swapping the built-in HDD out) or the ex=
tra one installed using device bay on Dell laptop?</div>
<div>=A0</div>
<div>Thanks,</div>
<div>Jian=A0</div>
<div><br>=A0</div>
<div class=3D"gmail_quote">2011/5/19 Rafael J. Wysocki <span dir=3D"ltr">&l=
t;<a href=3D"mailto:rjw@sisk.pl">rjw@sisk.pl</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">On Thursday, May 19, 2011, Jian Peng wrote:<br>&gt; Hi, R=
afael,<br>&gt;<br></div>
<div class=3D"im">&gt; Yes. I tested without reverting the patch that cause=
d failure on E6410 (with<br>&gt; same AHCI controller), The system is Ubunt=
u 11.04 with default 2.6.39-rc6<br>&gt; kernel (guess this should be same k=
ernel as yours before reverting the<br>
&gt; patch).<br>&gt;<br>&gt; My system worked well with AC power cable plug=
ging in and out at boot time,<br>&gt; at runtime, and during &quot;dd if=3D=
/dev/sda5 of=3D/dev/null ..&quot;.<br><br></div>What kind of disk did you u=
se? =A0Mine is an Intel SSD.<br>

<div class=3D"im"><br>&gt; The config file I mentioned is those under /etc/=
 or other directories that<br>&gt; is used to control the power management.=
<br><br></div>They aren&#39;t relevant to this issue.<br>
<div class=3D"im"><br>&gt; Did you test my patch? What it the result?<br><b=
r></div>No, I didn&#39;t. =A0Unfortunately, I won&#39;t be able to do any t=
ests on the affected<br>machine in the near future (most probably for the n=
ext two weeks or so).<br>
<br>Thanks,<br><font color=3D"#888888">Rafael<br></font></blockquote></div>=
<br>

--20cf3071c8de13bde504a3a816c3--

--===============4705024762546897354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4705024762546897354==--
