From: Peter Teoh <htmldeveloper@gmail.com>
Subject: Re: suspend/resume PM criterion for application
Date: Tue, 16 Sep 2014 23:16:52 -0400
Message-ID: <CAHnt0GUbX3iyb5SGqX2zfB1zB8V3q3KZ0ta0yOUHPbzBbOeXbA@mail.gmail.com>
References: <CAJ2oMh+xmgC9mfT5QqEmMMek7SOqYE2QLVV6sPvK0CF5+56hDg@mail.gmail.com>
	<17893.1410371984@turing-police.cc.vt.edu>
	<CAJ2oMhJpTQjgDgEgOqvLVJg7LQjtHg2by71=98uH=vq59zTmDg@mail.gmail.com>
	<20227.1410374378@turing-police.cc.vt.edu>
	<CAJ2oMhLnP7TpP3caycqVS0xHRE3tf=+2vREE6H1NradsmFmH4A@mail.gmail.com>
	<23104.1410377100@turing-police.cc.vt.edu>
	<CAGAs2Anafp-S+L5B7meg9ET-ckb=MDFupUQk5DnKTTJ9mWWJXA@mail.gmail.com>
	<CAJ2oMhJdAr0akNJoVXafvW95zzK+MKWbf=b79+EuKm60L3CKdg@mail.gmail.com>
	<CAJ2oMhL1+RBw5ifB_CcuTK2nKRhCfKLXZZd4k6GzT9q6p8RTAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4113408845614584725=="
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
In-Reply-To: <CAJ2oMhL1+RBw5ifB_CcuTK2nKRhCfKLXZZd4k6GzT9q6p8RTAA@mail.gmail.com>
List-Unsubscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces@kernelnewbies.org
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, linux-pm@vger.kernel.org, AYAN KUMAR HALDER <ayankumarh@gmail.com>, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-pm@vger.kernel.org

--===============4113408845614584725==
Content-Type: multipart/alternative; boundary=bcaec548a399a7e6a305033a4c6a

--bcaec548a399a7e6a305033a4c6a
Content-Type: text/plain; charset=UTF-8

On Sun, Sep 14, 2014 at 2:11 AM, Ran Shalit <ranshalit@gmail.com> wrote:

> On Thu, Sep 11, 2014 at 12:24 PM, Ran Shalit <ranshalit@gmail.com> wrote:
> > On Thu, Sep 11, 2014 at 8:32 AM, AYAN KUMAR HALDER <ayankumarh@gmail.com>
> wrote:
> >> On Thu, Sep 11, 2014 at 12:55 AM,  <Valdis.Kletnieks@vt.edu> wrote:
> >>> On Wed, 10 Sep 2014 21:58:48 +0300, Ran Shalit said:
> >>>
> >>>> 1. How can I make a process to notice this inactivity ? Do you think
> >>>> it can be implemented by some periodic process who check if there is
> >>>> activity ? It returns to the original question I raised, that I will
> >>>> use some periodic process who checks maybe cpu load or something like
> >>>> that. What do you think ?
> >>>
> >>> That's going to depend on your system and what processes are running.
> >>>
> >>> You may have an MP3 player going that doesn't take much CPU at all -
> but
> >>> shutting down because the user hasn't hit a button in 47 minutes will
> probably
> >>> irritate the user no end.  Or there may be a screensaver running that
> takes
> >>> twice as much CPU as the MP3 player, but is totally OK on the system
> >>> suspending whenever the rest of the system wants it.
> >>>
> >>> You're going to have to look at your system design, and decide for
> yourself
> >>> what the criteria are.
> >>
> >> Please correct me if my understanding is wrong:-
> >>
> >> I believe that autosuspend feature (for system suspend) is not present
> >> in kernel. I believe that there is no feature in kernel which checks
> >> for system ( cpu, devices) inactivity and suspends the entire system.
> >> System suspend is caused when :-
> >> 1. the user issues a command
> >> 2. The system receives some interrupt or event (lid closing event)
> >> 3. There is an external process which monitors system inactivity and
> >> suspends the system.
> >>
> >> For runtime suspend of a device, I believe it is the driver who has
> >> the complete responsibility to decide when to suspend the device or
> >> resume it.  The driver can take this decision on user intervention (eg
> >> when user writes to   /sys/devices/<my-device>/power/* ) or when the
> >> driver has completed servicing an interrupt and feels it has nothing
> >> more to do, etc
> >
> > Thanks Vlaid, Ayan,
> >
> > I am a bit yet struggling for couple of days on this PM issue, and I
> > would appreciate your continous advise.
> > The system requirement I have is as following:
> > 1. make everything as automatic as possible , so that there won't be
> > any need to add any userspace application for the matter.
> > 2. wakeup from all relevant wakeup sources
> > 3. should not use sysfs (it should be disabled from kernel)
> > 4. platform is OMAP3530.
>

a.   look into /arch/arm/mach-omap2 of kernel source and grep for "sleep"
and "wakeup" functionality:   power management is just managing with the
different frequencies of the the CPU.   as far as I can tell, once sleep,
only uart pin can be used for waking up....not sure.

b.   read this:

http://e2e.ti.com/support/dsp/omap_applications_processors/f/447/t/30005.aspx

http://www.ti.com/lit/an/slva310b/slva310b.pdf   (read page 2, which
describe the different powerup-sequence of the CPU, "Powering-Up Sequence".


c.   the technology brand name for omap3530 is "DVFS"....search for this
inside the arch/arm kernel source.....you can find lots of sample codes
there.

(don't confuse with another omap CPU brand name "DeepSleep" but is PM for
another type of omap cpu.)

d.   http://www.ti.com/product/omap3530 --> on the right is a DVSDK +
Android source code for 3530....grep the codes for the above keywords...

hopefully it helps?



> >
> > Now, As I understand thus far, I have the following options (
> > requirement 3 above I will ignore, don't know how to handle it yet,
> > and assume for meanwhile that I have sysfs) :
> > 1. use suspend scheme (no runtime PM)
> >     1.a. create some kernel thread who check cpu load and will decide
> > to disable system only if its below some minimum threshold (which
> > should indicate no activity)
> >     1.b. initialize all HW interrupts (gpio, uart, etc) as wakeup sources
> >     with this scheme only this thread is responsible for the suspend,
> > and there is no use of the runtime PM, right ?
> >
> > 2. use runtime PM scheme :
> >     With this scheme I don't understand how some device will wake the
> > system , or doesn't it need to  ? If a driver wakes up maybe it need
> > to deliver some info to system    ?
> >
> > I think option 1 is also easier to support, what do you think about both
> ?
> >
> > Thanks!!
> > Ran
>
> Does Anyone have any suggestions and feedback on the above requirements ?
>
> Thank you,
> Ran
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
>



-- 
Regards,
Peter Teoh

--bcaec548a399a7e6a305033a4c6a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sun, Sep 14, 2014 at 2:11 AM, Ran Shalit <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:ranshalit@gmail.com" target=3D"_blank">ranshalit@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bor=
der-left-style:solid;padding-left:1ex"><div class=3D""><div class=3D"h5">On=
 Thu, Sep 11, 2014 at 12:24 PM, Ran Shalit &lt;<a href=3D"mailto:ranshalit@=
gmail.com">ranshalit@gmail.com</a>&gt; wrote:<br>
&gt; On Thu, Sep 11, 2014 at 8:32 AM, AYAN KUMAR HALDER &lt;<a href=3D"mail=
to:ayankumarh@gmail.com">ayankumarh@gmail.com</a>&gt; wrote:<br>
&gt;&gt; On Thu, Sep 11, 2014 at 12:55 AM,=C2=A0 &lt;<a href=3D"mailto:Vald=
is.Kletnieks@vt.edu">Valdis.Kletnieks@vt.edu</a>&gt; wrote:<br>
&gt;&gt;&gt; On Wed, 10 Sep 2014 21:58:48 +0300, Ran Shalit said:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; 1. How can I make a process to notice this inactivity ? Do=
 you think<br>
&gt;&gt;&gt;&gt; it can be implemented by some periodic process who check i=
f there is<br>
&gt;&gt;&gt;&gt; activity ? It returns to the original question I raised, t=
hat I will<br>
&gt;&gt;&gt;&gt; use some periodic process who checks maybe cpu load or som=
ething like<br>
&gt;&gt;&gt;&gt; that. What do you think ?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; That&#39;s going to depend on your system and what processes a=
re running.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; You may have an MP3 player going that doesn&#39;t take much CP=
U at all - but<br>
&gt;&gt;&gt; shutting down because the user hasn&#39;t hit a button in 47 m=
inutes will probably<br>
&gt;&gt;&gt; irritate the user no end.=C2=A0 Or there may be a screensaver =
running that takes<br>
&gt;&gt;&gt; twice as much CPU as the MP3 player, but is totally OK on the =
system<br>
&gt;&gt;&gt; suspending whenever the rest of the system wants it.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; You&#39;re going to have to look at your system design, and de=
cide for yourself<br>
&gt;&gt;&gt; what the criteria are.<br>
&gt;&gt;<br>
&gt;&gt; Please correct me if my understanding is wrong:-<br>
&gt;&gt;<br>
&gt;&gt; I believe that autosuspend feature (for system suspend) is not pre=
sent<br>
&gt;&gt; in kernel. I believe that there is no feature in kernel which chec=
ks<br>
&gt;&gt; for system ( cpu, devices) inactivity and suspends the entire syst=
em.<br>
&gt;&gt; System suspend is caused when :-<br>
&gt;&gt; 1. the user issues a command<br>
&gt;&gt; 2. The system receives some interrupt or event (lid closing event)=
<br>
&gt;&gt; 3. There is an external process which monitors system inactivity a=
nd<br>
&gt;&gt; suspends the system.<br>
&gt;&gt;<br>
&gt;&gt; For runtime suspend of a device, I believe it is the driver who ha=
s<br>
&gt;&gt; the complete responsibility to decide when to suspend the device o=
r<br>
&gt;&gt; resume it.=C2=A0 The driver can take this decision on user interve=
ntion (eg<br>
&gt;&gt; when user writes to=C2=A0 =C2=A0/sys/devices/&lt;my-device&gt;/pow=
er/* ) or when the<br>
&gt;&gt; driver has completed servicing an interrupt and feels it has nothi=
ng<br>
&gt;&gt; more to do, etc<br>
&gt;<br>
&gt; Thanks Vlaid, Ayan,<br>
&gt;<br>
&gt; I am a bit yet struggling for couple of days on this PM issue, and I<b=
r>
&gt; would appreciate your continous advise.<br>
&gt; The system requirement I have is as following:<br>
&gt; 1. make everything as automatic as possible , so that there won&#39;t =
be<br>
&gt; any need to add any userspace application for the matter.<br>
&gt; 2. wakeup from all relevant wakeup sources<br>
&gt; 3. should not use sysfs (it should be disabled from kernel)<br>
&gt; 4. platform is OMAP3530.<br></div></div></blockquote><div><br>a. =C2=
=A0 look into=C2=A0/arch/arm/mach-omap2 of kernel source and grep for &quot=
;sleep&quot; and &quot;wakeup&quot; functionality: =C2=A0 power management =
is just managing with the different frequencies of the the CPU. =C2=A0 as f=
ar as I can tell, once sleep, only uart pin can be used for waking up....no=
t sure.</div><div><br></div><div>b. =C2=A0 read this:</div><div><br></div><=
div><a href=3D"http://e2e.ti.com/support/dsp/omap_applications_processors/f=
/447/t/30005.aspx">http://e2e.ti.com/support/dsp/omap_applications_processo=
rs/f/447/t/30005.aspx</a></div><div><br></div><div><a href=3D"http://www.ti=
.com/lit/an/slva310b/slva310b.pdf">http://www.ti.com/lit/an/slva310b/slva31=
0b.pdf</a> =C2=A0 (read page 2, which describe the different powerup-sequen=
ce of the CPU, &quot;Powering-Up Sequence&quot;. =C2=A0=C2=A0<br></div><div=
><br></div><div>c. =C2=A0 the technology brand name for omap3530 is &quot;D=
VFS&quot;....search for this inside the arch/arm kernel source.....you can =
find lots of sample codes there.</div><div><br></div><div>(don&#39;t confus=
e with another omap CPU brand name &quot;DeepSleep&quot; but is PM for anot=
her type of omap cpu.)</div><div><br></div><div>d. =C2=A0 <a href=3D"http:/=
/www.ti.com/product/omap3530">http://www.ti.com/product/omap3530</a> --&gt;=
 on the right is a DVSDK + Android source code for 3530....grep the codes f=
or the above keywords...<br></div><div><br></div><div>hopefully it helps?</=
div><div><br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rg=
b(204,204,204);border-left-style:solid;padding-left:1ex"><div class=3D""><d=
iv class=3D"h5">
&gt;<br>
&gt; Now, As I understand thus far, I have the following options (<br>
&gt; requirement 3 above I will ignore, don&#39;t know how to handle it yet=
,<br>
&gt; and assume for meanwhile that I have sysfs) :<br>
&gt; 1. use suspend scheme (no runtime PM)<br>
&gt;=C2=A0 =C2=A0 =C2=A01.a. create some kernel thread who check cpu load a=
nd will decide<br>
&gt; to disable system only if its below some minimum threshold (which<br>
&gt; should indicate no activity)<br>
&gt;=C2=A0 =C2=A0 =C2=A01.b. initialize all HW interrupts (gpio, uart, etc)=
 as wakeup sources<br>
&gt;=C2=A0 =C2=A0 =C2=A0with this scheme only this thread is responsible fo=
r the suspend,<br>
&gt; and there is no use of the runtime PM, right ?<br>
&gt;<br>
&gt; 2. use runtime PM scheme :<br>
&gt;=C2=A0 =C2=A0 =C2=A0With this scheme I don&#39;t understand how some de=
vice will wake the<br>
&gt; system , or doesn&#39;t it need to=C2=A0 ? If a driver wakes up maybe =
it need<br>
&gt; to deliver some info to system=C2=A0 =C2=A0 ?<br>
&gt;<br>
&gt; I think option 1 is also easier to support, what do you think about bo=
th ?<br>
&gt;<br>
&gt; Thanks!!<br>
&gt; Ran<br>
<br>
</div></div>Does Anyone have any suggestions and feedback on the above requ=
irements ?<br>
<br>
Thank you,<br>
<div class=3D""><div class=3D"h5">Ran<br>
<br>
_______________________________________________<br>
Kernelnewbies mailing list<br>
<a href=3D"mailto:Kernelnewbies@kernelnewbies.org">Kernelnewbies@kernelnewb=
ies.org</a><br>
<a href=3D"http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies" t=
arget=3D"_blank">http://lists.kernelnewbies.org/mailman/listinfo/kernelnewb=
ies</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
Regards,<br>Peter Teoh
</div></div>

--bcaec548a399a7e6a305033a4c6a--


--===============4113408845614584725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============4113408845614584725==--
