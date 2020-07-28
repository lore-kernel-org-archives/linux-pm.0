Return-Path: <SRS0=HuBt=BH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECD0C433EC
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jul 2020 13:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F76206F5
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jul 2020 13:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgG1NXv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:23:51 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:32900 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgG1NXv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 09:23:51 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1k0Pa8-0008S8-In; Tue, 28 Jul 2020 07:23:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k0Pa7-0004Jh-IY; Tue, 28 Jul 2020 07:23:48 -0600
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
Date:   Tue, 28 Jul 2020 08:20:41 -0500
In-Reply-To: <87d04fhkyz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 28 Jul 2020 07:39:48 -0500")
Message-ID: <87h7trg4ie.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k0Pa7-0004Jh-IY;;;mid=<87h7trg4ie.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Lsxp9D29SGoF42ZMFfbqoBJ10C5tdn2s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC][PATCH] exec: Freeze the other threads during a multi-threaded exec
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> It also makes for a possible _huge_ latency regression for execve(),
>> since freezing really has never been a very low-latency operation.
>>
>> Other threads doing IO can now basically block execve() for a long
>> long long time.
>
> Hmm.  Potentially.  The synchronization with the other threads must
> happen in a multi-threaded exec in de_thread.
>
> So I need to look at the differences between where de_thread thread
> can kill a thread and the freezer can not freeze a thread.  I am hoping
> that the freezer has already instrumented most of those sleeps but I
> admit I have not looked yet.

Alright I have looked at the freezer a bit more and I now see that the
point of marking things freezable is for kernel threads rather that user
space threads.  I think there are 5 maybe 6 places the code sleeps
reachable by userspace threads that are marked as freezable and most
of those are callable from get_signal.

For exec all I care about are user space threads.  So it appears the
freezer infrastructure adds very little.

Now to see if I can find another way to divert a task into a slow path
as it wakes up, so I don't need to manually wrap all of the sleeping
calls.  Something that plays nice with the scheduler.

Eric

