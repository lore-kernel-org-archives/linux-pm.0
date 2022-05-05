Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81275C433F5
	for <linux-pm@archiver.kernel.org>; Thu,  5 May 2022 16:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382050AbiEEQwo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 5 May 2022 12:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244049AbiEEQwn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2022 12:52:43 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D939157B14;
        Thu,  5 May 2022 09:49:03 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:41442)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmeey-006uoh-6M; Thu, 05 May 2022 10:49:00 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37064 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmeex-0031MX-9y; Thu, 05 May 2022 10:48:59 -0600
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
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
References: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
        <20220504224058.476193-9-ebiederm@xmission.com>
        <YnPIF9DvM9L0k+0U@linutronix.de>
Date:   Thu, 05 May 2022 11:48:34 -0500
In-Reply-To: <YnPIF9DvM9L0k+0U@linutronix.de> (Sebastian Andrzej Siewior's
        message of "Thu, 5 May 2022 14:50:31 +0200")
Message-ID: <87ee189b8d.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nmeex-0031MX-9y;;;mid=<87ee189b8d.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1++Z+axhusfo6JndgThNVMSOQtg9/DxfAc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 09/11] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2022-05-04 17:40:56 [-0500], Eric W. Biederman wrote:
>> Stop playing with tsk->__state to remove TASK_WAKEKILL while a ptrace
>> command is executing.
>> 
>> Instead remove TASK_WAKEKILL from the definition of TASK_TRACED, and
>> implemention a new jobctl flag TASK_PTRACE_FROZEN.  This new flag is
> implement ?

Yes.  Thank you.

Eric
