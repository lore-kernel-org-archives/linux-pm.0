From: Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 10/12] sched/core: uclamp: use TG's clamps to restrict
 Task's clamps
Date: Thu, 26 Jul 2018 15:11:39 -0700
Message-ID: <CAJuCfpFhTYqbmAKFHXPAxh1qDnWWMrCuYso6gFn3AFVRK=tdDA@mail.gmail.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-11-patrick.bellasi@arm.com> <CAJuCfpFnj2g3+ZpR4fP4yqfxs0zd=c-Zehr2XM7m_C+WdL9jNA@mail.gmail.com>
 <20180723154025.GF2683@e110439-lin> <CAJuCfpHJ=O1QVFZZ2dpaDDQe+dX1aGkzWdcd76c9zZpxw2fNtA@mail.gmail.com>
 <20180724095550.GA3162@e110439-lin> <CAJuCfpEUsq=LPZgz20jn79CwymQGgfif8j8fzurUDmEJ3G9q5w@mail.gmail.com>
 <20180724154935.GB3275@e110439-lin>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="00000000000088a3b70571ee47ef"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724154935.GB3275@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

--00000000000088a3b70571ee47ef
Content-Type: text/plain; charset="UTF-8"

Sorry for the delay. Overlooked this comment...

On Tue, Jul 24, 2018 at 8:49 AM, Patrick Bellasi <patrick.bellasi@arm.com>
wrote:

> On 24-Jul 08:28, Suren Baghdasaryan wrote:
> > Hi Patrick. Thanks for the explanation and links. No more questions
> > from me on this one :)
>
> No problems at all!
>
> The important question is instead: does it makes sense for you too?
>

Well, it still feels unnatural to me due to the definition of the boost (at
least this much CPU bandwidth but higher should be fine).
Say I have a task which normally has specific boost and clamp requirements
(say TG.UCLAMP_MIN=20, TG.UCLAMP_MAX=80) which I want to temporarily boost
using a syscall to UCLAMP_MIN=60 (let's say a process should handle some
request and temporarily needs more CPU bandwidth). With this interface we
can clamp more than TG.UCLAMP_MAX value but we can't boost more than
TG.UCLAMP_MIN. For this usecase I would have to set TG.UCLAMP_MIN=80, then
use syscall to set SYSCALL.UCLAMP_MIN=20 to get effective UCLAMP_MIN=20 and
then set SYSCALL.UCLAMP_MIN=60 when I need that temporary boost.
To summarize, while this API does not stop me from achieving the desired
result it requires some hoop-jumping :)


>
> I think the important bits are that we are all on the same page about
> the end goals and features we like to have as well as the interface we use.
> This last has to fits best our goals and features while still being
> perfectly aligned with the frameworks we are integrating into... and
> that's still under discussion with Tejun on PATCH 08/12.
>
> Thanks again for your review!
>
> Cheers Patrick
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
>

--00000000000088a3b70571ee47ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry for the delay. Overlooked this comment...<br><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Jul 24, 2018 at =
8:49 AM, Patrick Bellasi <span dir=3D"ltr">&lt;<a href=3D"mailto:patrick.be=
llasi@arm.com" target=3D"_blank">patrick.bellasi@arm.com</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gma=
il-">On 24-Jul 08:28, Suren Baghdasaryan wrote:<br>
&gt; Hi Patrick. Thanks for the explanation and links. No more questions<br=
>
&gt; from me on this one :)<br>
<br>
</span>No problems at all!<br>
<br>
The important question is instead: does it makes sense for you too?<br></bl=
ockquote><div><br></div><div>Well, it still feels unnatural to me due to th=
e definition of the boost (at least this much CPU b<span style=3D"font-size=
:small;background-color:rgb(255,255,255);text-decoration-style:initial;text=
-decoration-color:initial;float:none;display:inline">andwidth=C2=A0</span>b=
ut higher should be fine).</div><div>Say I have a task which normally has s=
pecific boost and clamp requirements (say TG.UCLAMP_MIN=3D20,=C2=A0<span st=
yle=3D"font-size:small;background-color:rgb(255,255,255);text-decoration-st=
yle:initial;text-decoration-color:initial;float:none;display:inline">TG.</s=
pan><span style=3D"font-size:12.8px;background-color:rgb(255,255,255);text-=
decoration-style:initial;text-decoration-color:initial;float:none;display:i=
nline">UCLAMP_MAX=3D80)</span>=C2=A0which I want to temporarily boost using=
 a syscall to <span style=3D"font-size:small;background-color:rgb(255,255,2=
55);text-decoration-style:initial;text-decoration-color:initial;float:none;=
display:inline">UCLAMP_MIN</span><span style=3D"font-size:small;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;float:none;display:inline">=3D60 (let&#39;s say=C2=A0</span>a proce=
ss should handle some request and temporarily needs more CPU bandwidth). Wi=
th this interface we can clamp more than <span style=3D"font-size:small;tex=
t-decoration-style:initial;text-decoration-color:initial;background-color:r=
gb(255,255,255);float:none;display:inline">TG.</span><span style=3D"text-de=
coration-style:initial;text-decoration-color:initial;font-size:12.8px;backg=
round-color:rgb(255,255,255);float:none;display:inline">UCLAMP_MAX</span>=
=C2=A0value but we can&#39;t boost more than <span style=3D"font-size:small=
;background-color:rgb(255,255,255);text-decoration-style:initial;text-decor=
ation-color:initial;float:none;display:inline">TG.UCLAMP_MIN</span>. For th=
is usecase I would have to set TG.<span style=3D"font-size:small;background=
-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color=
:initial;float:none;display:inline">UCLAMP_MIN</span><span style=3D"font-si=
ze:small;background-color:rgb(255,255,255);text-decoration-style:initial;te=
xt-decoration-color:initial;float:none;display:inline">=3D80, then use sysc=
all to set SYSCALL<span style=3D"text-decoration-style:initial;text-decorat=
ion-color:initial;float:none;display:inline">.</span><span style=3D"text-de=
coration-style:initial;text-decoration-color:initial;float:none;display:inl=
ine">UCLAMP_MIN</span><span style=3D"text-decoration-style:initial;text-dec=
oration-color:initial;float:none;display:inline">=3D20 to get effective=C2=
=A0<span style=3D"font-size:small;background-color:rgb(255,255,255);text-de=
coration-style:initial;text-decoration-color:initial;float:none;display:inl=
ine">UCLAMP_MIN=3D20</span></span> and then set=C2=A0<span style=3D"text-de=
coration-style:initial;text-decoration-color:initial;float:none;display:inl=
ine">SYSCALL</span><span style=3D"text-decoration-style:initial;text-decora=
tion-color:initial;float:none;display:inline">.</span><span style=3D"text-d=
ecoration-style:initial;text-decoration-color:initial;float:none;display:in=
line">UCLAMP_MIN=3D60</span>=C2=A0when I need that temporary boost.</span><=
/div><div><span style=3D"font-size:small;background-color:rgb(255,255,255);=
text-decoration-style:initial;text-decoration-color:initial;float:none;disp=
lay:inline">To summarize, while this API does not stop me from achieving th=
e desired result it requires some hoop-jumping :)</span></div><div>=C2=A0<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I think the important bits are that we are all on the same page about<br>
the end goals and features we like to have as well as the interface we use.=
<br>
This last has to fits best our goals and features while still being<br>
perfectly aligned with the frameworks we are integrating into... and<br>
that&#39;s still under discussion with Tejun on PATCH 08/12.<br>
<br>
Thanks again for your review!<br>
<br>
Cheers Patrick<br>
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
-- <br>
#include &lt;best/regards.h&gt;<br>
<br>
Patrick Bellasi<br>
</div></div></blockquote></div><br></div></div>

--00000000000088a3b70571ee47ef--
