Return-Path: <SRS0=HuBt=BH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BABC433E3
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jul 2020 12:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4182074F
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jul 2020 12:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgG1Mm6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:42:58 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53462 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbgG1Mm5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 08:42:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1k0OwZ-0005JD-K7; Tue, 28 Jul 2020 06:42:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k0OwY-0007iG-Ng; Tue, 28 Jul 2020 06:42:55 -0600
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
Date:   Tue, 28 Jul 2020 07:39:48 -0500
In-Reply-To: <CAHk-=wj34Pq1oqFVg1iWYAq_YdhCyvhyCYxiy-CG-o76+UXydQ@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 27 Jul 2020 17:20:03 -0700")
Message-ID: <87d04fhkyz.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k0OwY-0007iG-Ng;;;mid=<87d04fhkyz.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+orpJOfA4E1RYpBdWcznCcQQLAlVJoQF8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] exec: Freeze the other threads during a multi-threaded exec
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Jul 27, 2020 at 2:06 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Therefore make it simpler to get exec correct by freezing the other
>> threads at the beginning of exec.  This removes an entire class of
>> races, and makes it tractable to fix some of the long standing
>> issues with exec.
>
> I hate the global state part of the freezer.
>
> It's also pointless. We don't want to trigger all the tests that
> various random driver kernel threads do.
>
> I also really don't like how now execve() by any random person will
> suddenly impact everything that might be doing freezing.

Yes.  system_freezing_cnt as an enable/disable that affects all
tasks in the system does seem like a misfeature for use in the context
of exec where only a few tasks need to be dealt with.

> It also makes for a possible _huge_ latency regression for execve(),
> since freezing really has never been a very low-latency operation.
>
> Other threads doing IO can now basically block execve() for a long
> long long time.

Hmm.  Potentially.  The synchronization with the other threads must
happen in a multi-threaded exec in de_thread.

So I need to look at the differences between where de_thread thread
can kill a thread and the freezer can not freeze a thread.  I am hoping
that the freezer has already instrumented most of those sleeps but I
admit I have not looked yet.

> Finally, I think your patch is fundamentally broken for another
> reason: it depends on CONFIG_FREEZER, and that isn't even required to
> be set!

Very true.  I absolutely missed that detail.

> So no, this is not at all acceptable in that form.
>
> Now, maybe we could _make_ it acceptable, by
>
>  (a) add a per-process freezer count to avoid the global state for this case

Perhaps even a single bit.


>  (b)  make a small subset of the freezing code available for the
> !CONFIG_FREEZER thing

The code that is controlled by CONFIG_FREEZER is just kernel/freezer.c,
and include/linux/freezer.h.  Which is 177 + 303 lines respectively
so not much.

Or are you thinking about all of the locations that already include
freezable sleeps?

>  (c) fix this "simple freezer" to not actually force wakeups etc, but
> catch things in the

To catch things in the scheduler I presume?

The thing is the freezer code does not wake up anything if it is in a
sleep that it has wrapped.  Which I thought was just about all
significant ones but I need to verify that.

> but honestly, at that point nothing of the "CONFIG_FREEZER" code even
> really exists any more. It would be more of a "execve_synchronize()"
> thing, where we'd catch things in the scheduler and/or system call
> entry/exit or whatever.

Yes.  Where we catch things seems to be key.  I believe if all sleeps
that are killable plus system call exit should be enough, to be a noop.
As those are the places where the code can be killed now.

The tricky part is to mark processes that are sleeping in such a way
that then they wake up they go into a slow path and they get trapped
by the freezing code.

> Also, that makes these kinds of nasty hacks that just make the
> existign freezer code even harder to figure out:


>> A new function exec_freeze_threads based upon
>> kernel/power/process.c:try_to_freeze_tasks is added.  To play well
>> with other uses of the kernel freezer it uses a killable sleep wrapped
>> with freezer_do_not_count/freezer_count.
>
> Ugh. Just _ugly_.
>
> And honestly, completely and utterly broken. See above.
>
> I understand the wish to re-use existing infrastructure. But the fact
> is, the FREEZER code is just about the _last_ thing you should want to
> use. That, and stop_machine(), is just too much of a big hammer.

Part of my challenge is that it the more layers that get put around a
sleep the trickier it is to subsequently wrap.

I can see the point of building something very simple and more
fundamental that doesn't need as much support as the current freezer.
Perhaps something the freezer can the be rebuilt upon.


If the basic idea of stopping other threads early before we kill them in
exec sounds plausible then I will see what I can do.

Eric
