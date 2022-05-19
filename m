Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07BCC433EF
	for <linux-pm@archiver.kernel.org>; Thu, 19 May 2022 06:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbiESGTq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 19 May 2022 02:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiESGTp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 02:19:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA09ABD8;
        Wed, 18 May 2022 23:19:44 -0700 (PDT)
Date:   Thu, 19 May 2022 08:19:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652941182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p4RweUPS77rmO8bK1cUfMLMF5vHfob7E/RdPJYYlKAM=;
        b=K5e/9lbnTYDWbIk601eMIjjzqfkio58vfeiTKarUFKwIb/hEM6KA3V1dLV8bv/aJvfSaf0
        ULtbgdi9vLosfwtQ5ZR0DdwCIuU7bXOdSxBEXC6wqqHjAxG/5nzqXGfom+lrTsbMKca5Hp
        pKtnvDEMRWTANMMAM8wNTIXlybkuP6p9JsIMRyVkum3UTEsjDCovVgzxqMcxLfFaBvqEzQ
        kJojumUlnRMKb1KdqE+NsJ8txHtZP0ZboUTXtygKLWPwEQpWfEFFv6Z0xm1Lcu9vUGy9dH
        nFh0OV8Nw3WaXnKW+sb9gndLPwi22A1tMkmzTz/GIl35hD1VTUbwRpbNsTGC7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652941182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p4RweUPS77rmO8bK1cUfMLMF5vHfob7E/RdPJYYlKAM=;
        b=mgux4xHBBI/r7rgHoEmCsd4Y5P8NBE9oThfftcXoCCrZKi4XTl7LBGeEj9ESywM0jNaYh7
        x3nHuMOC1ru0KpBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kyle Huey <khuey@pernos.co>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        oleg@redhat.com, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org,
        Robert O'Callahan <roc@pernos.co>,
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
Subject: Re: [PATCH 00/16] ptrace: cleanups and calling do_cldstop with only
 siglock
Message-ID: <YoXhfGGPKnT/YFC1@linutronix.de>
References: <20220421150248.667412396@infradead.org>
 <20220421150654.817117821@infradead.org>
 <87czhap9dy.fsf@email.froward.int.ebiederm.org>
 <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
 <CALWUPBdFDLuT7JaNGSJ_UXbHf8y9uKdC-SkAqzd=FQC0MX4nNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALWUPBdFDLuT7JaNGSJ_UXbHf8y9uKdC-SkAqzd=FQC0MX4nNQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2022-05-18 20:26:05 [-0700], Kyle Huey wrote:
> Is there a git branch somewhere I can pull to test this? It doesn't apply
> cleanly to Linus's tip.

https://kernel.googlesource.com/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace_stop-cleanup-for-v5.19

> - Kyle

Sebastian
