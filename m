From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [4.9-rc1] Build-time 2x slower
Date: Thu, 20 Oct 2016 16:32:19 +0200
Message-ID: <1774714.42MJfCaf0o@vostro.rjw.lan>
References: <CA+icZUWJfbY28yQDhPRGc0_-jO42CJyyp_mgX_RGLqywhTQpaw@mail.gmail.com> <2813073.ZhfuKSkB6i@vostro.rjw.lan> <CA+icZUU2TWCzeB48XARaCaufVqzLehgs4HNz05i=t6HpavpUqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46702 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S934960AbcJTOZX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2016 10:25:23 -0400
In-Reply-To: <CA+icZUU2TWCzeB48XARaCaufVqzLehgs4HNz05i=t6HpavpUqg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Michal Marek <mmarek@suse.com>, Ming Lei <tom.leiming@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thursday, October 20, 2016 04:20:44 PM Sedat Dilek wrote:
> On Thu, Oct 20, 2016 at 1:15 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, October 20, 2016 09:41:34 AM Sedat Dilek wrote:
> >> On Wed, Oct 19, 2016 at 10:55 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Wednesday, October 19, 2016 06:59:35 PM Jörg Otte wrote:
> >> >> 2016-10-19 17:29 GMT+02:00 Linus Torvalds <torvalds@linux-foundation.org>:
> >> >> > On Wed, Oct 19, 2016 at 4:07 AM, Jörg Otte <jrg.otte@gmail.com> wrote:
> >> >> >>
> >> >> >> Additional info: I usally use schedutil governor.
> >> >> >> If I switch to performance governor problems go away.
> >> >> >> Maybe a cpufreq problem?
> >> >> >
> >> >> > Oh, I completely misread the original bug report, and then didn't read
> >> >> > your confirmation email right.
> >> >> >
> >> >> > I thought you had a slower build of the different kernels (when
> >> >> > building on the same kernel), and that the _build_ itself had slowed
> >> >> > down for some reason. But you're actually saying that doing the _same_
> >> >> > build actually takes longer when running on 4.9-rc1.
> >> >>
> >> >> Exactly!
> >> >>
> >> >> Btw: ondemand governor is also good.
> >> >>
> >> >> > There are a few small cpufreq changes there in between commit
> >> >> > 29fbff8698fc (that you reported was fine - please tell me I got _that_
> >> >> > right, at least?) and 4.9-rc1.
> >> >>
> >> >> Perfect! That's what I mean.
> >> >>
> >> >> > Adding Rafael to the cc.
> >> >> >
> >> >> > That said, none of them look all that likely to me. It *would* be good
> >> >> > if you could bisect it a bit (perhaps not fully, but a couple of
> >> >> > bisection steps to narrow down what area it is).
> >> >>
> >> >> I try that tomorrow.
> >> >
> >> > Well, please try commit ef98988ba369 (Merge tag 'pm-extra-4.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm) which is the
> >> > merge introducing the late cpufreq changes.  If the issue is there, please
> >> > try to revert commit 899bb6642f2a (cpufreq: skip invalid entries when searching
> >> > the frequency) which is the only cpufreq one that may matter for the schedutil
> >> > governor (and I have one fix for that commit queued up already).
> >> >
> >>
> >> Is "cpufreq: fix overflow in cpufreq_table_find_index_dl()" the fix
> >> you are speaking of?
> >>
> >> Fixes: 899bb6642f2a (cpufreq: skip invalid entries when searching the frequency)
> >
> > Yes.
> >
> >> If yes, can you add a hint in the commit message describing the impact
> >> like here a slow-down of building a linux-kernel.
> >> With a reference to this ML-thread?
> >
> > I will if that turns out to be the case.
> >
> 
> I have tried the revert and the patch from Sergey Senozhatsk pending
> in linux-pm.git#linux-next.
> Both fixes the issue for me.

OK, thanks for the confirmation!

> Feel free to give appropriate credits and many thanks to Jörg.
> 
> I tried 'make -j3' in my last build and it was approx. 5mins faster in
> my customized setup.
> Will switch back to 2 parallel-make-jobs - it's safer for me.
> 
> Can you explain why this issue was not seen when building under Linux v4.8.x?
> [1] says...
> Cc: 4.8+ <stable@vger.kernel.org> # 4.8+

The commit in question might not make it into 4.8.y yet.

Thanks,
Rafael

