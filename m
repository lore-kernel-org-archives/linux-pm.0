Return-Path: <SRS0=1j1E=BK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416D3C433E0
	for <linux-pm@archiver.kernel.org>; Fri, 31 Jul 2020 20:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311E6208E4
	for <linux-pm@archiver.kernel.org>; Fri, 31 Jul 2020 20:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgGaUKW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:10:22 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:38444 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaUKV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2020 16:10:21 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1bMB-004Bqh-An; Fri, 31 Jul 2020 14:10:19 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k1bM9-0003KN-MC; Fri, 31 Jul 2020 14:10:18 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <87h7tsllgw.fsf@x220.int.ebiederm.org>
        <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
        <87d04fhkyz.fsf@x220.int.ebiederm.org>
        <87h7trg4ie.fsf@x220.int.ebiederm.org>
        <CAHk-=wj+ynePRJC3U5Tjn+ZBRAE3y7=anc=zFhL=ycxyKP8BxA@mail.gmail.com>
        <878sf16t34.fsf@x220.int.ebiederm.org>
        <87pn8c1uj6.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wjMcHGDh8Wx+dwaYHOGVNN+zzCPEKZEc5qb3spsEydNKg@mail.gmail.com>
        <87pn8by58y.fsf@x220.int.ebiederm.org>
        <CAHk-=wh_5Lu_3OACT4pSqrf1eJ3=PR_fUjL1vLSbBZM2_OAC5w@mail.gmail.com>
Date:   Fri, 31 Jul 2020 15:07:07 -0500
In-Reply-To: <CAHk-=wh_5Lu_3OACT4pSqrf1eJ3=PR_fUjL1vLSbBZM2_OAC5w@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 31 Jul 2020 10:41:48 -0700")
Message-ID: <87tuxnwis4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k1bM9-0003KN-MC;;;mid=<87tuxnwis4.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX198s0rrR4a+N9N2dvHxXsg20KO1oB//4cY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] exec: Conceal the other threads from wakeups during exec
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jul 31, 2020 at 10:19 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Even limited to opt-in locations I think the trick of being able to
>> transform the wait-state may solve that composition problem.
>
> So the part I found intriguing was the "catch things in the signal
> handling path".
>
> Catching things there - and *only* there - would avoid a lot of the
> problems we had with the freezer. When you're about to return to user
> mode, there are no lock inversions etc.
>
> And it kind of makes conceptual sense to do, since what you're trying
> to capture is the signal group - so using the signal state to do so
> seems like a natural thing to do. No touching of any runqueues or
> scheduler data structures, do everything _purely_ with the signal
> handling pathways.
>
> So that "feels" ok to me.
>
> That said, I do wonder if there are nasty nasty latency issues with
> odd users. Normally, you'd expect that execve() with other threads in
> the group shouldn't be a performance issue, because people simply
> shouldn't do that. So it might be ok.
>
> And if you capture them all in the signal handling pathway, that ends
> up being a very convenient place to zap them all too, so maybe my
> latency worry is misguided.
>
> IOW, I think that you could try to do your "freese other threads" not
> at all like the freezer, but more like a "collect all threads in their
> signal handler parts as the first phase of zapping them".
>
> So maybe this approach is salvageable. I see where something like the
> above could work well. But I say that with a lot of handwaving, and
> maybe if I see the patch I'd go "Christ, I was a complete idiot for
> ever even suggesting that".

Yes.

The tricky bit is that there are a handful of stops that must
be handled, or it is impossible to stop everything without causing
disruption if the exec fails.  The big ones are TASK_STOPPED and
TASK_TRACED.  There is another in wait_for_vfork_done.

At which point I am looking at writting a wrapper around schedule that
changes task state to something like TASK_WAKEKILL when asked, and then
restores the state when released.  Something that is independent of
which freezer the code is using.

It could be the scheduler to with a special bit in state that says
opt-in.  But if we have to opt in it is probably much less error
prone to write the code as an wrapper around schedule, and only
modify the core scheduling code if necessary.

If I can make TASK_STOPPED and TASK_TRACED handle spurious wake-ups
I think I can build something that is independent of the rest of the
freezers so the code doesn't have to go 3 deep on wrappers of different
freezer at those locations.  It is already 2 layers deep.

But I really don't intend to work on that again for a while.


Right now I am in the final stages of ressurecting:
https://lore.kernel.org/linux-fsdevel/87a7ohs5ow.fsf@xmission.com/

The hard part looks like cleaning up and resurrecting Oleg's patch
to prevent the abuse of files_struct->count.
https://lore.kernel.org/linux-fsdevel/20180915160423.GA31461@redhat.com/

I am close but dotting all of the i's and crossing all of the t's is
taking ab bit.

Eric
