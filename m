Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1B9C433EF
	for <linux-pm@archiver.kernel.org>; Mon,  6 Jun 2022 22:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiFFWQU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 6 Jun 2022 18:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiFFWQU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jun 2022 18:16:20 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9352AE1;
        Mon,  6 Jun 2022 15:16:19 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:56556)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyL18-00Dr2R-6X; Mon, 06 Jun 2022 16:16:10 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:53752 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyL17-008WKx-AS; Mon, 06 Jun 2022 16:16:09 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
        <20220518225355.784371-8-ebiederm@xmission.com>
        <20220524152725.GE14347@redhat.com>
Date:   Mon, 06 Jun 2022 17:16:01 -0500
In-Reply-To: <20220524152725.GE14347@redhat.com> (Oleg Nesterov's message of
        "Tue, 24 May 2022 17:27:25 +0200")
Message-ID: <87pmjl1lr2.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nyL17-008WKx-AS;;;mid=<87pmjl1lr2.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+XLuQrB0IHmo0lv55ADS0tXNzKSUteaDM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 08/16] ptrace: Only populate last_siginfo from ptrace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/18, Eric W. Biederman wrote:
>>
>> The code in ptrace_signal to populate siginfo if the signal number
>> changed is buggy.  If the tracer contined the tracee using
>> ptrace_detach it is guaranteed to use the real_parent (or possibly a
>> new tracer) but definitely not the origional tracer to populate si_pid
>> and si_uid.
>
> I guess nobody cares. As the comment says
>
> 	 If the debugger wanted something
> 	 specific in the siginfo structure then it should
> 	 have updated *info via PTRACE_SETSIGINFO.
>
> otherwise I don't think si_pid/si_uid have any value.

No one has complained so it is clearly no one cares.  So it is
definitely not a regression.  Or even anything that needs to be
backported.

However si_pid and si_uid are defined with SI_USER are defined
to be whomever sent the signal.  So I would argue by definition
those values are wrong.

> However the patch looks fine to me, just the word "buggy" looks a bit
> too strong imo.

I guess I am in general agreement.  Perhaps I can just say they values
are wrong by definition?

Eric


