From: "abrar momin" <abrar.momin@gmail.com>
Subject: Re: :How do I move the system to idle mode
Date: Thu, 15 Mar 2007 13:45:25 +0530
Message-ID: <91a2c5d50703150115o57d0695fm305496a77daa25e5@mail.gmail.com>
References: <200703101154.CGX93234@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1416861605=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703101154.CGX93234@tataelxsi.co.in>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Sridhar Rao V <sridharraov@tataelxsi.co.in>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format...

--===============1416861605==
Content-Type: multipart/alternative;
    boundary="----------=_1173946529-11203-680"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1173946529-11203-680
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 3/10/07, Sridhar Rao V <sridharraov@tataelxsi.co.in> wrote:
>
>  HI,
>
>
>
> I am working on optimizing the power consumption on the system.
>
>
>
> I need to detect when the system is idle and move it to standby state.
>

 u define the system states and cause a transition acordingly

i do not know ur board details

do
cat /sys/power/state
to know the current supported states
and an
echo standby > /sys/power/state
to trigger a transition

And when there is an interrupt, it needs to be brought back to run state.
>

 for that u need to configure the required  gpio's  to be able to cause a
wakeup
before u go to idle or sleep

I have an application which is waiting on a message. When it gets idle
> message, it needs to move the system to idle state.
>
>
>
> I have two questions:
>
> 1. How do we detect the idle mode.
>
> 2. Can I call the acpi_suspend() function from my driver to move the
> system to different states. If not what is the preferred way.
>
>
>
> Sridhar.
>
>
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>
>


-- 
abrarahmed

------------=_1173946529-11203-680
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 3/10/07, <b class="gmail_sendername">Sridhar Rao V</b> &lt;<a href="mailto:sridharraov@tataelxsi.co.in">sridharraov@tataelxsi.co.in</a>&gt; wrote:</span><blockquote class="gmail_quote" DEFANGED_style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><span class="q" id="q_1113bb4d39c11db0_0">










<div DEFANGED_link="blue" DEFANGED_vlink="purple" lang="EN-US">

<div>

<p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">HI,</span></font></p>

<p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">&nbsp;</span></font></p>

<p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">I am working on optimizing the power consumption on the
system.</span></font></p>

<p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">&nbsp;</span></font></p>

<p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">I need to detect when the system is idle and move it to
standby state.</span></font></p></div></div></span></div></blockquote><div><br>&nbsp;u define the system states and cause a transition acordingly<br>
<br>
i do not know ur board details<br>
<br>
do<br>
cat /sys/power/state <br>
to know the current supported states<br>
and an <br>
echo standby &gt; /sys/power/state <br>
to trigger a transition</div><br><blockquote class="gmail_quote" DEFANGED_style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><span class="q" id="q_1113bb4d39c11db0_0"><div DEFANGED_link="blue" DEFANGED_vlink="purple" lang="EN-US">
<div><p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">And when there is an interrupt, it needs to be brought
back to run state.</span></font></p></div></div></span></div></blockquote><div><br>&nbsp;for that u need to configure the required&nbsp; gpio&#39;s&nbsp; to be able to cause a wakeup<br>before u go to idle or sleep</div><br><blockquote class="gmail_quote" DEFANGED_style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><span class="q" id="q_1113bb4d39c11db0_0"><div DEFANGED_link="blue" DEFANGED_vlink="purple" lang="EN-US"><div><p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">I have an application which is waiting on a message. When
it gets idle message, it needs to move the system to idle state.</span></font></p>

<p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">&nbsp;</span></font></p>

<p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">I have two questions:</span></font></p>

<p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">1. How do we detect the idle mode.</span></font></p>

<p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">2. Can I call the acpi_suspend() function from my driver
to move the system to different states. If not what is the preferred way.</span></font></p>

<p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">&nbsp;</span></font></p>

<p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">Sridhar.</span></font></p>

<p><font face="Garamond" size="3"><span DEFANGED_style="font-size: 12pt; font-family: Garamond;">&nbsp;</span></font></p>

</div>

</div>


</span></div><br>_______________________________________________<br>linux-pm mailing list<br><a DEFANGED_onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:linux-pm@lists.osdl.org">linux-pm@lists.osdl.org</a><br>
<a DEFANGED_onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.osdl.org/mailman/listinfo/linux-pm" target="_blank">https://lists.osdl.org/mailman/listinfo/linux-pm</a><br><br></blockquote></div><br><br clear="all">
<br>-- <br>abrarahmed

------------=_1173946529-11203-680--

--===============1416861605==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1416861605==--
