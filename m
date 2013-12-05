From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Thu, 05 Dec 2013 14:21:55 +0100
Message-ID: <87zjofv3f0.fsf@nemi.mork.no>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no>
	<529F04B2.7050303@linaro.org> <87fvq8lsxt.fsf@nemi.mork.no>
	<CAKohpomBeJSMc3=BSPbo97nkGbc5MRRvTtJn1z062FN01B51Qw@mail.gmail.com>
	<87li00y66e.fsf@nemi.mork.no>
	<CAKohponu3Fu=WaBHXP1iBJM87V9g=+hDPe=M168U_weODenZdQ@mail.gmail.com>
	<878uvzyecg.fsf@nemi.mork.no> <52A0746F.9010705@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <52A0746F.9010705@linux.vnet.ibm.com> (Srivatsa S. Bhat's message
	of "Thu, 05 Dec 2013 18:11:19 +0530")
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM mailing list <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> writes:

> You seem to be getting confused as to what the *actual* userspace
> expectation was, in that mail thread. The expectation was that suspen=
d/
> resume is a kernel operation that brings back the system to the same
> state (as much as possible) at the end of resume, as it was before
> suspend. And that is a perfectly valid expectation, and it is somethi=
ng
> that the kernel has to try its level best to honor.

Our understanding of the thread is obviously biased by our respective
views of the matter ;-)

> And in this particular case, the specific expectation was that the sy=
sfs
> file permissions set by the user for cpufreq files will remain as it =
is
> even after a suspend/resume cycle. That's it. There is _absolutely_ _=
no_
> talk about CPU hotplug here.

This is not a cpufreq problem.  It is a CPU problem.  You are only
complicating things by trying to solve it in cpufreq.  What about
permissions on the other CPU sysfs attributes?

> Robert _happened_ to dig this further and observe that suspend/resume
> actually does offline/online of CPUs, and thought that he should have
> also seen the associated udev events as well. But we have purposefull=
y
> not exposed the fact that suspend/resume involves CPU hotplug.

Well, that is a bug in my opinion.  You are adding lots of kernel code
to avoid a very simple userspace configuration.  Seems very backwards.
This is mostly a documentation problem, if a problem at all.  I do note
that Robert did try the udev way before concluding that this was a
kernel bug.

> Today,
> suspend/resume uses CPU hotplug internally because we don't have any
> other better alternative. The very concept/semantic of suspend/resume
> _does_ _not_ imply CPU hotplug - it is just an implementation detail
> that userspace should not need to care about or rely on.
>
> Moreover, cpufreq is not the only subsystem that participates in susp=
end/
> resume and CPU hotplug. And fundamentally, regular CPU hotplug has _v=
ery_
> different semantics and guarantees than the hotplug done in suspend/r=
esume.
> For example, if you offline CPUs normally, the cpusets associated wit=
h
> those CPUs will get destroyed, potentially in ways that _won't_ bring
> them back to the same state when you online those exact same CPUs!
> And this would have been totally unacceptable to a user innocuously
> using suspend/resume. Look at commit d35be8bab9 (CPU hotplug, cpusets=
,
> suspend: Don't modify cpusets during suspend/resume), for more detail=
s
> on how we fixed that problem.

Yes, I do see that point.  The special suspend/resume handling is
definitely necessary in this case.

> So, to summarize, suspend/resume should mean one simple thing to
> userspace - "the kernel will transparently (to the extent possible)
> perform suspend/resume and bring back the system during resume, to a
> state as close as possible compared to how it was before suspend".
> Any implementation challenges must be handled in the kernel (as far a=
s
> possible), and we should avoid burdening userspace with extraneous
> events etc.

OK, I think we may have different views on how much kernel
implementation details userspace need to know :-)

That's fine, and it really was not my intention to question the way
cpufreq handled this.  It all just seemed so meaningless to me.  I now
understand that it has a meaning to you, which of course is what
matters.

I am glad I could help removing the most obvious bugs.


Bj=C3=B8rn

