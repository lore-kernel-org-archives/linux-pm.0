From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 1/3 v3] ARM: EXYNOS4: Support for generic I/O
 power domains on EXYNOS4210/4212
Date: Tue, 8 Nov 2011 22:19:59 +0900
Message-ID: <CAGTfZH0xOh=EDRhb3gxOZhV-KQZNY_-o=miBOEne_S5-YsQ_Vg@mail.gmail.com>
References: <4EA690EF.4000703@samsung.com>
	<013301cc99cd$8d5a6a00$a80f3e00$%kim@samsung.com>
	<4EB26BE2.2060508@samsung.com>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8235363546724667571=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4EB26BE2.2060508@samsung.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sylwester Nawrocki <snjw23@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

--===============8235363546724667571==
Content-Type: multipart/alternative; boundary=f46d041555f0398aea04b1390783

--f46d041555f0398aea04b1390783
Content-Type: text/plain; charset=ISO-8859-1

Hi Kukjin Kim,

Please reply about Sylwester Nawrocki and me.

2011/11/3 Sylwester Nawrocki <s.nawrocki@samsung.com>

> Hi Kgene,
>
> On 11/03/2011 03:09 AM, Kukjin Kim wrote:
> > As I said, I don't think we should control/gate the clocks with
> regarding power domain.
>
> As far as I know there is a plan to let the drivers override
> start/stop_device callbacks,
> moreover the clock control can be disabled globally by not implementing
> start/stop_device
> callbacks or per device by not adding clkdev entities to the device clock
> list at runtime
> PM core. So IMHO, there is/going to be enough flexibility.
>
> > It should be controlled by each regarding device driver and in addition,
> as I know,
> > to handle block of clock is not recommended on EXYNOS4 now.
>
> What do you mean by this ? I couldn't find such information in any
> documentation.
> Shouldn't "clock gate block" registers be touched by boot loader and the
> kernel?
> Our boot loaders disable all clocks, and if the global clock gate is not
> enabled
> by the kernel there is no chance any multimedia device will work.
>
> Should the global clock block gate be always enabled then ? I'm afraid it
> is not
> optimal form power management POV.
>
>
To Kukjin Kim,

> It should be controlled by each regarding device driver and in addition,
as I know,
> to handle block of clock is not recommended on EXYNOS4 now.

As you said, should we separately control power and clock of power domain?
or Have to turn on the clock of power domain always?
I think that it is to happen unnecessary power consumption.
If we have to maintain on state of power domain clock, please let me know
guide about this.

Also,
For example, fimg2d and framebuffer use LCD0 power domain as parent device.I
If fimg2d and framebuffer is disabled state due to not using their,
I think that we should turn off the clock of LCD0 power domain to reduce
power leakage.
Which each regarding device driver control the clock of power domain?

I will expect for your reply.

Best regards,
Chanwoo Choi

--f46d041555f0398aea04b1390783
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Kukjin Kim,<div><br></div><div>Please reply about=A0Sylwester Nawrocki a=
nd me.<br><br><div class=3D"gmail_quote">2011/11/3 Sylwester Nawrocki <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:s.nawrocki@samsung.com">s.nawrocki@samsu=
ng.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">Hi Kgene,<br>
<div class=3D"im"><br>
On 11/03/2011 03:09 AM, Kukjin Kim wrote:<br>
&gt; As I said, I don&#39;t think we should control/gate the clocks with re=
garding power domain.<br>
<br>
</div>As far as I know there is a plan to let the drivers override start/st=
op_device callbacks,<br>
moreover the clock control can be disabled globally by not implementing sta=
rt/stop_device<br>
callbacks or per device by not adding clkdev entities to the device clock l=
ist at runtime<br>
PM core. So IMHO, there is/going to be enough flexibility.<br>
<div class=3D"im"><br>
&gt; It should be controlled by each regarding device driver and in additio=
n, as I know,<br>
&gt; to handle block of clock is not recommended on EXYNOS4 now.<br>
<br>
</div>What do you mean by this ? I couldn&#39;t find such information in an=
y documentation.<br>
Shouldn&#39;t &quot;clock gate block&quot; registers be touched by boot loa=
der and the kernel?<br>
Our boot loaders disable all clocks, and if the global clock gate is not en=
abled<br>
by the kernel there is no chance any multimedia device will work.<br>
<br>
Should the global clock block gate be always enabled then ? I&#39;m afraid =
it is not<br>
optimal form power management POV.<br>
<font color=3D"#888888"><br></font></blockquote><div><br></div><div>To Kukj=
in Kim,</div><div><br></div>&gt; It should be controlled by each regarding =
device driver and in addition, as I know,<br><div>&gt; to handle block of c=
lock is not recommended on EXYNOS4 now.</div>
<div><br></div><div>As you said, should we separately control power and clo=
ck of power domain?</div><div>or Have to turn on the clock of power domain =
always?</div><div>I think that it is to happen unnecessary power consumptio=
n.</div>
<div>If we have to maintain=A0on state of power domain clock, please let me=
 know guide about this.</div><div><br></div><div>Also,=A0</div><div>For exa=
mple, fimg2d and framebuffer use LCD0 power domain as parent device.I</div>
<div>If fimg2d and framebuffer is disabled state due to not using their,</d=
iv><div>I think that we should turn off the clock of LCD0 power domain to r=
educe power leakage.</div><div>Which each regarding device driver control t=
he clock of power domain?</div>
<div><br></div><div>I will expect for your reply.</div><div><br></div><div>=
Best regards,</div><div>Chanwoo Choi</div><div><br></div><div>=A0</div></di=
v></div>

--f46d041555f0398aea04b1390783--

--===============8235363546724667571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8235363546724667571==--
