Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80374C433F5
	for <linux-pm@archiver.kernel.org>; Wed, 27 Apr 2022 13:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbiD0Nzh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 27 Apr 2022 09:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiD0Nxs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 09:53:48 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC5C3F8B5;
        Wed, 27 Apr 2022 06:50:36 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:40602)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nji3u-00BTkD-8a; Wed, 27 Apr 2022 07:50:34 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35842 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nji3t-008PdZ-0B; Wed, 27 Apr 2022 07:50:33 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <20220426225211.308418-3-ebiederm@xmission.com>
        <f6d31801de631dfe6e1a2da25370cddf2aca32ad.camel@sipsolutions.net>
Date:   Wed, 27 Apr 2022 08:50:25 -0500
In-Reply-To: <f6d31801de631dfe6e1a2da25370cddf2aca32ad.camel@sipsolutions.net>
        (Johannes Berg's message of "Wed, 27 Apr 2022 09:10:47 +0200")
Message-ID: <87tuaeab4u.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nji3t-008PdZ-0B;;;mid=<87tuaeab4u.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18fBOV3Y1pE4P9eWAoKmnfOqa0I2VzX21o=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 3/9] ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2022-04-26 at 17:52 -0500, Eric W. Biederman wrote:
>> User mode linux is the last user of the PT_DTRACE flag.  Using the flag to indicate
>> single stepping is a little confusing and worse changing tsk->ptrace without locking
>> could potentionally cause problems.
>> 
>> So use a thread info flag with a better name instead of flag in tsk->ptrace.
>> 
>> Remove the definition PT_DTRACE as uml is the last user.
>
>
> Looks fine to me.
>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>

Thanks.

> Looking at pending patches, I don't see any conflicts from this. I'm
> guessing anyway you'll want/need to take these through some tree all
> together.

Taking them all through a single tree looks like it will be easiest.
So I am planning on taking them through my signal tree.

Now that I think of it, the lack of locking also means I want to
Cc stable.

Eric
