From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: suspend regression in 4.1-rc1
Date: Mon, 18 May 2015 10:10:50 -0700
Message-ID: <CA+55aFzx2j-yZH0CgMGJ_uw0KbdqaUanEJPKwdm-yXYaFLhRXw@mail.gmail.com>
References: <20150517185041.GA5897@dhcp22.suse.cz>
	<CA+55aFy2wWy-k0O-Sb2vUCLiLjeKMu7r95bf294qP5UqQHuxfw@mail.gmail.com>
	<20150518073046.GO17717@twins.programming.kicks-ass.net>
	<20150518090336.GA6393@dhcp22.suse.cz>
	<20150518093150.GC21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33536 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbbERRKu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 13:10:50 -0400
In-Reply-To: <20150518093150.GC21418@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Hocko <mhocko@suse.cz>, Stephane Eranian <eranian@google.com>, Ulrich Obergfell <uobergfe@redhat.com>, Don Zickus <dzickus@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, May 18, 2015 at 2:31 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> Subject: watchdog: Fix merge 'conflict'
>
> Two watchdog changes that came through different trees had a non
> conflicting conflict, that is, one changed the semantics of a variable
> but no actual code conflict happened. So the merge appeared fine, but
> the resulting code did not behave as expected.

Ok, I see that people are still discussing this, but I'll apply it
as-is since I want to get rc4 out the door, and I guess people can
tweak this if there's anything else we want to do longer-term.

             Linus
