From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: suspend regression in 4.1-rc1
Date: Sun, 17 May 2015 21:33:56 -0700
Message-ID: <CA+55aFy2wWy-k0O-Sb2vUCLiLjeKMu7r95bf294qP5UqQHuxfw@mail.gmail.com>
References: <20150517185041.GA5897@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38095 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbEREd5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 00:33:57 -0400
In-Reply-To: <20150517185041.GA5897@dhcp22.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Hocko <mhocko@suse.cz>, Stephane Eranian <eranian@google.com>
Cc: Ulrich Obergfell <uobergfe@redhat.com>, Don Zickus <dzickus@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>

On Sun, May 17, 2015 at 11:50 AM, Michal Hocko <mhocko@suse.cz> wrote:
>
> The merge commit is empty and both 80dcc31fbe55 and e4b0db72be24 work
> properly but the merge is bad. So it seems like some of the commits in
> either branch has a side effect which needs other branch in order to
> reproduce.
>
> So've tried to bisect ^80dcc31fbe55 e4b0db72be24 and merged 80dcc31fbe55
> in each step.

Good extra work! Thanks.

> This lead to:
>
> commit 195daf665a6299de98a4da3843fed2dd9de19d3a
> Author: Ulrich Obergfell <uobergfe@redhat.com>
> Date:   Tue Apr 14 15:44:13 2015 -0700
>
>     watchdog: enable the new user interface of the watchdog mechanism
>
> The patch doesn't revert because of follow up changes so I have reverted
> all three:
> 692297d8f968 ("watchdog: introduce the hardlockup_detector_disable() function")
> b2f57c3a0df9 ("watchdog: clean up some function names and arguments")
> 195daf665a62 ("watchdog: enable the new user interface of the watchdog mechanism")

Hmm. I guess we should just revert those three then. Unless somebody
can see what the subtle interaction is.

Actually, looking closer, on the *other* side of the merge, the only
commit that looks like it might be conflicting is

    b3738d293233 "watchdog: Add watchdog enable/disable all functions"

which is then used by

    b37609c30e41 "perf/x86/intel: Make the HT bug workaround
conditional on HT enabled"

Does the problem go away if you revert *those* two commits instead?

At least that would tell is what the exact bad interaction is.

Adding Stephane (author of those watchdog/perf patches) to the Cc. And
PeterZ, who signed them off (Ingo also did, but was already on the
participants list).

Anybody see it?

               Linus
