From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Thu, 05 Dec 2013 18:11:19 +0530
Message-ID: <52A0746F.9010705@linux.vnet.ibm.com>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no> <529F04B2.7050303@linaro.org> <87fvq8lsxt.fsf@nemi.mork.no> <CAKohpomBeJSMc3=BSPbo97nkGbc5MRRvTtJn1z062FN01B51Qw@mail.gmail.com> <87li00y66e.fsf@nemi.mork.no> <CAKohponu3Fu=WaBHXP1iBJM87V9g=+hDPe=M168U_weODenZdQ@mail.gmail.com> <878uvzyecg.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <878uvzyecg.fsf@nemi.mork.no>
Sender: cpufreq-owner@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM mailing list <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/05/2013 12:27 PM, Bj=C3=B8rn Mork wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
>=20
>> Sending from phone.. html.. so left list.
>>
>> Here is the old thread where we discussed this.. see if this helps..
>>
>> http://marc.info/?t=3D136845016900003&r=3D1&w=3D2
>=20
> Thanks.  That helped a lot.
>=20
> Unless I miss something, it looks like the permission problem *starte=
d*
> with fallout from special suspend code - surprising the user by not
> creating any offline/online event on suspend/resume.  Quoting from
> http://marc.info/?l=3Dlinux-pm&m=3D136847781510358 :
>=20
>   (And yes, even code-wise, we use a slightly different
>    path in the S3 code, to initiate hotplug. That's why the uevents
>    are by-passed.)
>=20

I hope you didn't miss the main idea I was trying to convey in that
reply:=20
"IMHO, using CPU hotplug (offline/online of CPUs) in the S3 path is
supposed to be totally internal to the suspend/resume code. It is not
intended for userspace to know that we are internally offlining/
onlining CPUs."

=2E..

"The user initiated an S3 operation, not CPU hotplug. So there is
no reason to surprise the user with unexpected events. Put another
way, in the future, if we change the kernel code to do S3 without
using hotplug, then there should be no visible change in userspace,
because how S3 is handled in the kernel is intended to be an "internal"
operation."


> So instead of going in the direction of even more special treatment t=
o
> hide the fact that a offline/online is done, you could also have solv=
ed
> the problem by removed the existing special treatment.  That would
> likely have simplified the code and made it do what userspace expects=
=2E
>=20

You seem to be getting confused as to what the *actual* userspace
expectation was, in that mail thread. The expectation was that suspend/
resume is a kernel operation that brings back the system to the same
state (as much as possible) at the end of resume, as it was before
suspend. And that is a perfectly valid expectation, and it is something
that the kernel has to try its level best to honor.

And in this particular case, the specific expectation was that the sysf=
s
file permissions set by the user for cpufreq files will remain as it is
even after a suspend/resume cycle. That's it. There is _absolutely_ _no=
_
talk about CPU hotplug here.

Robert _happened_ to dig this further and observe that suspend/resume
actually does offline/online of CPUs, and thought that he should have
also seen the associated udev events as well. But we have purposefully
not exposed the fact that suspend/resume involves CPU hotplug. Today,
suspend/resume uses CPU hotplug internally because we don't have any
other better alternative. The very concept/semantic of suspend/resume
_does_ _not_ imply CPU hotplug - it is just an implementation detail
that userspace should not need to care about or rely on.

Moreover, cpufreq is not the only subsystem that participates in suspen=
d/
resume and CPU hotplug. And fundamentally, regular CPU hotplug has _ver=
y_
different semantics and guarantees than the hotplug done in suspend/res=
ume.
=46or example, if you offline CPUs normally, the cpusets associated wit=
h
those CPUs will get destroyed, potentially in ways that _won't_ bring
them back to the same state when you online those exact same CPUs!
And this would have been totally unacceptable to a user innocuously
using suspend/resume. Look at commit d35be8bab9 (CPU hotplug, cpusets,
suspend: Don't modify cpusets during suspend/resume), for more details
on how we fixed that problem.


So, to summarize, suspend/resume should mean one simple thing to
userspace - "the kernel will transparently (to the extent possible)
perform suspend/resume and bring back the system during resume, to a
state as close as possible compared to how it was before suspend".
Any implementation challenges must be handled in the kernel (as far as
possible), and we should avoid burdening userspace with extraneous
events etc.

> You have chosen to do offline+online.  Userspace expects to see the
> offline+online.  Don't try to hide the implementation.  That's only
> confusing.
>=20

I hope my above explanation answers your questions. We are not trying
to hide the implementation for no reason. We want to do it to preserve
sane semantics for suspend/resume. And that effectively translates to
"provide userspace with a transparent suspend/resume operation".

=20
Regards,
Srivatsa S. Bhat

