From: Peter Teoh <htmldeveloper@gmail.com>
Subject: Re: suspend/resume PM criterion for application
Date: Wed, 17 Sep 2014 11:32:13 +0800
Message-ID: <CAHnt0GUQ1_4F5ceA53MK9or8YPZusY9WpzWZBUxV2OszfeqHhg@mail.gmail.com>
References: <CAJ2oMh+xmgC9mfT5QqEmMMek7SOqYE2QLVV6sPvK0CF5+56hDg@mail.gmail.com>
	<17893.1410371984@turing-police.cc.vt.edu>
	<CAJ2oMhJpTQjgDgEgOqvLVJg7LQjtHg2by71=98uH=vq59zTmDg@mail.gmail.com>
	<20227.1410374378@turing-police.cc.vt.edu>
	<CAJ2oMhLnP7TpP3caycqVS0xHRE3tf=+2vREE6H1NradsmFmH4A@mail.gmail.com>
	<23104.1410377100@turing-police.cc.vt.edu>
	<CAGAs2Anafp-S+L5B7meg9ET-ckb=MDFupUQk5DnKTTJ9mWWJXA@mail.gmail.com>
	<CAJ2oMhJdAr0akNJoVXafvW95zzK+MKWbf=b79+EuKm60L3CKdg@mail.gmail.com>
	<CAJ2oMhL1+RBw5ifB_CcuTK2nKRhCfKLXZZd4k6GzT9q6p8RTAA@mail.gmail.com>
	<CAHnt0GUbX3iyb5SGqX2zfB1zB8V3q3KZ0ta0yOUHPbzBbOeXbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4222450202515839681=="
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
In-Reply-To: <CAHnt0GUbX3iyb5SGqX2zfB1zB8V3q3KZ0ta0yOUHPbzBbOeXbA@mail.gmail.com>
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

--===============4222450202515839681==
Content-Type: multipart/alternative; boundary=bcaec548a3998b16d005033a83d1

--bcaec548a3998b16d005033a83d1
Content-Type: text/plain; charset=UTF-8

On Wed, Sep 17, 2014 at 11:16 AM, Peter Teoh <htmldeveloper@gmail.com>
wrote:

>
>
> On Sun, Sep 14, 2014 at 2:11 AM, Ran Shalit <ranshalit@gmail.com> wrote:
>
>> On Thu, Sep 11, 2014 at 12:24 PM, Ran Shalit <ranshalit@gmail.com> wrote:
>> > On Thu, Sep 11, 2014 at 8:32 AM, AYAN KUMAR HALDER <
>> ayankumarh@gmail.com> wrote:
>> >> On Thu, Sep 11, 2014 at 12:55 AM,  <Valdis.Kletnieks@vt.edu> wrote:
>> >>> On Wed, 10 Sep 2014 21:58:48 +0300, Ran Shalit said:
>> >>>
>> >>>> 1. How can I make a process to notice this inactivity ? Do you think
>> >>>> it can be implemented by some periodic process who check if there is
>> >>>> activity ? It returns to the original question I raised, that I will
>> >>>> use some periodic process who checks maybe cpu load or something like
>> >>>> that. What do you think ?
>> >>>
>> >>> That's going to depend on your system and what processes are running.
>> >>>
>> >>> You may have an MP3 player going that doesn't take much CPU at all -
>> but
>> >>> shutting down because the user hasn't hit a button in 47 minutes will
>> probably
>> >>> irritate the user no end.  Or there may be a screensaver running that
>> takes
>> >>> twice as much CPU as the MP3 player, but is totally OK on the system
>> >>> suspending whenever the rest of the system wants it.
>> >>>
>> >>> You're going to have to look at your system design, and decide for
>> yourself
>> >>> what the criteria are.
>> >>
>> >> Please correct me if my understanding is wrong:-
>> >>
>> >> I believe that autosuspend feature (for system suspend) is not present
>> >> in kernel. I believe that there is no feature in kernel which checks
>> >> for system ( cpu, devices) inactivity and suspends the entire system.
>> >> System suspend is caused when :-
>> >> 1. the user issues a command
>> >> 2. The system receives some interrupt or event (lid closing event)
>> >> 3. There is an external process which monitors system inactivity and
>> >> suspends the system.
>> >>
>> >> For runtime suspend of a device, I believe it is the driver who has
>> >> the complete responsibility to decide when to suspend the device or
>> >> resume it.  The driver can take this decision on user intervention (eg
>> >> when user writes to   /sys/devices/<my-device>/power/* ) or when the
>> >> driver has completed servicing an interrupt and feels it has nothing
>> >> more to do, etc
>> >
>> > Thanks Vlaid, Ayan,
>> >
>> > I am a bit yet struggling for couple of days on this PM issue, and I
>> > would appreciate your continous advise.
>> > The system requirement I have is as following:
>> > 1. make everything as automatic as possible , so that there won't be
>> > any need to add any userspace application for the matter.
>> > 2. wakeup from all relevant wakeup sources
>> > 3. should not use sysfs (it should be disabled from kernel)
>> > 4. platform is OMAP3530.
>>
>
> a.   look into /arch/arm/mach-omap2 of kernel source and grep for "sleep"
> and "wakeup" functionality:   power management is just managing with the
> different frequencies of the the CPU.   as far as I can tell, once sleep,
> only uart pin can be used for waking up....not sure.
>
> b.   read this:
>
>
> http://e2e.ti.com/support/dsp/omap_applications_processors/f/447/t/30005.aspx
>
> http://www.ti.com/lit/an/slva310b/slva310b.pdf   (read page 2, which
> describe the different powerup-sequence of the CPU, "Powering-Up Sequence".
>
>
> c.   the technology brand name for omap3530 is "DVFS"....search for this
> inside the arch/arm kernel source.....you can find lots of sample codes
> there.
>
> (don't confuse with another omap CPU brand name "DeepSleep" but is PM for
> another type of omap cpu.)
>
> d.   http://www.ti.com/product/omap3530 --> on the right is a DVSDK +
> Android source code for 3530....grep the codes for the above keywords...
>
> hopefully it helps?
>
>
at the risk of missing out other files:

how about this two files:

inside arch/arm/mach-omap2:

omap-pm.h
omap-pm-noop.c

which I think provide a lot of hint for you.

--bcaec548a3998b16d005033a83d1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Sep 17, 2014 at 11:16 AM, Peter Teoh <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:htmldeveloper@gmail.com" target=3D"_blank">htmldeveloper@gmai=
l.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote"><div><div class=3D"h5">On Sun, Sep 14, 2014 at 2:11 AM, Ran Shali=
t <span dir=3D"ltr">&lt;<a href=3D"mailto:ranshalit@gmail.com" target=3D"_b=
lank">ranshalit@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div><div>On Thu, Sep 11, 2014 at 12:24 PM, Ran S=
halit &lt;<a href=3D"mailto:ranshalit@gmail.com" target=3D"_blank">ranshali=
t@gmail.com</a>&gt; wrote:<br>
&gt; On Thu, Sep 11, 2014 at 8:32 AM, AYAN KUMAR HALDER &lt;<a href=3D"mail=
to:ayankumarh@gmail.com" target=3D"_blank">ayankumarh@gmail.com</a>&gt; wro=
te:<br>
&gt;&gt; On Thu, Sep 11, 2014 at 12:55 AM,=C2=A0 &lt;<a href=3D"mailto:Vald=
is.Kletnieks@vt.edu" target=3D"_blank">Valdis.Kletnieks@vt.edu</a>&gt; wrot=
e:<br>
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
&gt; 4. platform is OMAP3530.<br></div></div></blockquote></div></div><div>=
<br>a. =C2=A0 look into=C2=A0/arch/arm/mach-omap2 of kernel source and grep=
 for &quot;sleep&quot; and &quot;wakeup&quot; functionality: =C2=A0 power m=
anagement is just managing with the different frequencies of the the CPU. =
=C2=A0 as far as I can tell, once sleep, only uart pin can be used for waki=
ng up....not sure.</div><div><br></div><div>b. =C2=A0 read this:</div><div>=
<br></div><div><a href=3D"http://e2e.ti.com/support/dsp/omap_applications_p=
rocessors/f/447/t/30005.aspx" target=3D"_blank">http://e2e.ti.com/support/d=
sp/omap_applications_processors/f/447/t/30005.aspx</a></div><div><br></div>=
<div><a href=3D"http://www.ti.com/lit/an/slva310b/slva310b.pdf" target=3D"_=
blank">http://www.ti.com/lit/an/slva310b/slva310b.pdf</a> =C2=A0 (read page=
 2, which describe the different powerup-sequence of the CPU, &quot;Powerin=
g-Up Sequence&quot;. =C2=A0=C2=A0<br></div><div><br></div><div>c. =C2=A0 th=
e technology brand name for omap3530 is &quot;DVFS&quot;....search for this=
 inside the arch/arm kernel source.....you can find lots of sample codes th=
ere.</div><div><br></div><div>(don&#39;t confuse with another omap CPU bran=
d name &quot;DeepSleep&quot; but is PM for another type of omap cpu.)</div>=
<div><br></div><div>d. =C2=A0 <a href=3D"http://www.ti.com/product/omap3530=
" target=3D"_blank">http://www.ti.com/product/omap3530</a> --&gt; on the ri=
ght is a DVSDK + Android source code for 3530....grep the codes for the abo=
ve keywords...<br></div><div><br></div><div>hopefully it helps?</div><span =
class=3D""><div><br></div></span></div></div></div></blockquote><div><br></=
div><div>at the risk of missing out other files:<br><br></div><div>how abou=
t this two files:<br><br>inside arch/arm/mach-omap2:<br><br>omap-pm.h=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <br>omap-pm-noop.c=C2=A0 <br><br></div><div>=
which I think provide a lot of hint for you.<br></div></div></div></div>

--bcaec548a3998b16d005033a83d1--


--===============4222450202515839681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============4222450202515839681==--
