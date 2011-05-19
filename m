From: Jian Peng <jipeng2005@gmail.com>
Subject: Re: [PATCH v2.6.38-rc7] Revert "libata:
 ahci_start_engine compliant to AHCI spec"
Date: Thu, 19 May 2011 09:42:38 -0700
Message-ID: <BANLkTin6+2obBm=+5Kd5Za1Lq-n4UQ-STw@mail.gmail.com>
References: <201105120025.34531.rjw@sisk.pl>
	<BANLkTimZ9pe-FhkJYHTG1Jx8MUPrMHSFbA@mail.gmail.com>
	<BANLkTim9_1Xt8oE4awbCO1iKUW96YUOv_A@mail.gmail.com>
	<201105191219.27743.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0157077279530722888=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105191219.27743.rjw@sisk.pl>
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

--===============0157077279530722888==
Content-Type: multipart/alternative; boundary=20cf3071ca626b1b6704a3a3b1d6

--20cf3071ca626b1b6704a3a3b1d6
Content-Type: text/plain; charset=ISO-8859-1

Hi, Rafael,

Yes. I tested without reverting the patch that caused failure on E6410 (with
same AHCI controller), The system is Ubuntu 11.04 with default 2.6.39-rc6
kernel (guess this should be same kernel as yours before reverting the
patch).

My system worked well with AC power cable plugging in and out at boot time,
at runtime, and during "dd if=/dev/sda5 of=/dev/null ..".

The config file I mentioned is those under /etc/ or other directories that
is used to control the power management.

Did you test my patch? What it the result?

Thanks,
Jian


2011/5/19 Rafael J. Wysocki <rjw@sisk.pl>

> On Thursday, May 19, 2011, Jian Peng wrote:
> > Hi, Rafael,
>
> Hi,
>
> > I am using Dell E6410 with same AHCI host controller as your system, but
> > could not reproduce the bug you found out (using Ubuntu 11.04 and
> 2.6.39-rc6
> > kernel).
>
> OK, do I think correctly you tested without the patch you sent previously?
>
> > Do you know which config file I need change to perform this testing?
>
> I'm not sure what you mean.  The kernel .config?
>
> Rafael
>

--20cf3071ca626b1b6704a3a3b1d6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi, Rafael,</div>
<div>=A0</div>
<div>Yes. I tested without reverting the patch that caused failure on E6410=
 (with same AHCI controller), The system is Ubuntu 11.04 with default 2.6.3=
9-rc6 kernel (guess this should be same kernel as yours before reverting th=
e patch).</div>

<div>=A0</div>
<div>My system worked well with AC power cable plugging in and out at boot =
time, at runtime, and during &quot;dd if=3D/dev/sda5 of=3D/dev/null ..&quot=
;.</div>
<div>=A0</div>
<div>The config file I mentioned is those under /etc/ or other directories =
that is used to control the power management.</div>
<div>=A0</div>
<div>Did you test my patch? What it the result?</div>
<div>=A0</div>
<div>Thanks,</div>
<div>Jian</div>
<div><br>=A0</div>
<div class=3D"gmail_quote">2011/5/19 Rafael J. Wysocki <span dir=3D"ltr">&l=
t;<a href=3D"mailto:rjw@sisk.pl">rjw@sisk.pl</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Thursday, May 19, 2011, Jian =
Peng wrote:<br>&gt; Hi, Rafael,<br><br>Hi,<br>
<div class=3D"im"><br>&gt; I am using Dell E6410 with same AHCI host contro=
ller as your system, but<br>&gt; could not reproduce the bug you found out =
(using Ubuntu 11.04 and 2.6.39-rc6<br>&gt; kernel).<br><br></div>OK, do I t=
hink correctly you tested without the patch you sent previously?<br>

<div class=3D"im"><br>&gt; Do you know which config file I need change to p=
erform this testing?<br><br></div>I&#39;m not sure what you mean. =A0The ke=
rnel .config?<br><font color=3D"#888888"><br>Rafael<br></font></blockquote>=
</div>
<br>

--20cf3071ca626b1b6704a3a3b1d6--

--===============0157077279530722888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0157077279530722888==--
