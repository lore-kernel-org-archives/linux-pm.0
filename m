Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D294CC433EF
	for <linux-pm@archiver.kernel.org>; Wed, 27 Apr 2022 13:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiD0Njp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 27 Apr 2022 09:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiD0Njc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 09:39:32 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C134B43A;
        Wed, 27 Apr 2022 06:36:20 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:46958)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njhq4-00BNMo-N6; Wed, 27 Apr 2022 07:36:16 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35834 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njhq3-008HKf-Lv; Wed, 27 Apr 2022 07:36:16 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
        <20220426225211.308418-5-ebiederm@xmission.com>
        <YmjlScztfmfWBfGi@linutronix.de>
Date:   Wed, 27 Apr 2022 08:35:47 -0500
In-Reply-To: <YmjlScztfmfWBfGi@linutronix.de> (Sebastian Andrzej Siewior's
        message of "Wed, 27 Apr 2022 08:40:09 +0200")
Message-ID: <87tuaebqdo.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1njhq3-008HKf-Lv;;;mid=<87tuaebqdo.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX186AxdiWfPFH1v/oamRbqPMj7VzLJuq57s=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 5/9] signal: Protect parent child relationships by
 childs siglock
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2022-04-26 17:52:07 [-0500], Eric W. Biederman wrote:
>> The functions ptrace_stop and do_signal_stop have to drop siglock
>> and grab tasklist_lock because the parent/child relation ship
>> is guarded by siglock and not siglock.
>
>  "is guarded by tasklist_lock and not siglock." ?

Yes.   Thank you.  I will fix that.

>> Simplify things by guarding the parent/child relationship
>> with siglock.  For the most part this just requires a little bit
>> of code motion.  In a couple of places more locking was needed.
>> 
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Sebastian

Eric
