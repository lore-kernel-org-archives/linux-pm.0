From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [4.9-rc1] Build-time 2x slower
Date: Fri, 21 Oct 2016 02:52:06 +0200
Message-ID: <CA+icZUVXgxk7m_Y6er5BxXNu=CG6mioZKsGs2eDRSJSU2mZoHQ@mail.gmail.com>
References: <CA+icZUWJfbY28yQDhPRGc0_-jO42CJyyp_mgX_RGLqywhTQpaw@mail.gmail.com>
 <2813073.ZhfuKSkB6i@vostro.rjw.lan> <CA+icZUU2TWCzeB48XARaCaufVqzLehgs4HNz05i=t6HpavpUqg@mail.gmail.com>
 <1774714.42MJfCaf0o@vostro.rjw.lan>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33558 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbcJUAwI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Oct 2016 20:52:08 -0400
In-Reply-To: <1774714.42MJfCaf0o@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Michal Marek <mmarek@suse.com>, Ming Lei <tom.leiming@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, Oct 20, 2016 at 4:32 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrot=
e:
> On Thursday, October 20, 2016 04:20:44 PM Sedat Dilek wrote:
>> On Thu, Oct 20, 2016 at 1:15 PM, Rafael J. Wysocki <rjw@rjwysocki.net> w=
rote:
>> > On Thursday, October 20, 2016 09:41:34 AM Sedat Dilek wrote:
>> >> On Wed, Oct 19, 2016 at 10:55 PM, Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>> >> > On Wednesday, October 19, 2016 06:59:35 PM J=C3=B6rg Otte wrote:
>> >> >> 2016-10-19 17:29 GMT+02:00 Linus Torvalds <torvalds@linux-foundati=
on.org>:
>> >> >> > On Wed, Oct 19, 2016 at 4:07 AM, J=C3=B6rg Otte <jrg.otte@gmail.=
com> wrote:
>> >> >> >>
>> >> >> >> Additional info: I usally use schedutil governor.
>> >> >> >> If I switch to performance governor problems go away.
>> >> >> >> Maybe a cpufreq problem?
>> >> >> >
>> >> >> > Oh, I completely misread the original bug report, and then didn'=
t read
>> >> >> > your confirmation email right.
>> >> >> >
>> >> >> > I thought you had a slower build of the different kernels (when
>> >> >> > building on the same kernel), and that the _build_ itself had sl=
owed
>> >> >> > down for some reason. But you're actually saying that doing the =
_same_
>> >> >> > build actually takes longer when running on 4.9-rc1.
>> >> >>
>> >> >> Exactly!
>> >> >>
>> >> >> Btw: ondemand governor is also good.
>> >> >>
>> >> >> > There are a few small cpufreq changes there in between commit
>> >> >> > 29fbff8698fc (that you reported was fine - please tell me I got =
_that_
>> >> >> > right, at least?) and 4.9-rc1.
>> >> >>
>> >> >> Perfect! That's what I mean.
>> >> >>
>> >> >> > Adding Rafael to the cc.
>> >> >> >
>> >> >> > That said, none of them look all that likely to me. It *would* b=
e good
>> >> >> > if you could bisect it a bit (perhaps not fully, but a couple of
>> >> >> > bisection steps to narrow down what area it is).
>> >> >>
>> >> >> I try that tomorrow.
>> >> >
>> >> > Well, please try commit ef98988ba369 (Merge tag 'pm-extra-4.9-rc1' =
of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm) which is =
the
>> >> > merge introducing the late cpufreq changes.  If the issue is there,=
 please
>> >> > try to revert commit 899bb6642f2a (cpufreq: skip invalid entries wh=
en searching
>> >> > the frequency) which is the only cpufreq one that may matter for th=
e schedutil
>> >> > governor (and I have one fix for that commit queued up already).
>> >> >
>> >>
>> >> Is "cpufreq: fix overflow in cpufreq_table_find_index_dl()" the fix
>> >> you are speaking of?
>> >>
>> >> Fixes: 899bb6642f2a (cpufreq: skip invalid entries when searching the=
 frequency)
>> >
>> > Yes.
>> >
>> >> If yes, can you add a hint in the commit message describing the impac=
t
>> >> like here a slow-down of building a linux-kernel.
>> >> With a reference to this ML-thread?
>> >
>> > I will if that turns out to be the case.
>> >
>>
>> I have tried the revert and the patch from Sergey Senozhatsk pending
>> in linux-pm.git#linux-next.
>> Both fixes the issue for me.
>
> OK, thanks for the confirmation!
>
>> Feel free to give appropriate credits and many thanks to J=C3=B6rg.
>>
>> I tried 'make -j3' in my last build and it was approx. 5mins faster in
>> my customized setup.
>> Will switch back to 2 parallel-make-jobs - it's safer for me.
>>
>> Can you explain why this issue was not seen when building under Linux v4=
.8.x?
>> [1] says...
>> Cc: 4.8+ <stable@vger.kernel.org> # 4.8+
>
> The commit in question might not make it into 4.8.y yet.
>

For all followers...

The fix is now in Linus tree (see [1]).

- Sedat -

[1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dc6fe46a79ecd79606bb96fada4515f6b23f87b62
