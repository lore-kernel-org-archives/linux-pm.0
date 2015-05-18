From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: suspend regression in 4.1-rc1
Date: Mon, 18 May 2015 09:30:46 +0200
Message-ID: <20150518073046.GO17717@twins.programming.kicks-ass.net>
References: <20150517185041.GA5897@dhcp22.suse.cz>
 <CA+55aFy2wWy-k0O-Sb2vUCLiLjeKMu7r95bf294qP5UqQHuxfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:43624 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbbERHbE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 03:31:04 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFy2wWy-k0O-Sb2vUCLiLjeKMu7r95bf294qP5UqQHuxfw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.cz>, Stephane Eranian <eranian@google.com>, Ulrich Obergfell <uobergfe@redhat.com>, Don Zickus <dzickus@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sun, May 17, 2015 at 09:33:56PM -0700, Linus Torvalds wrote:
> On Sun, May 17, 2015 at 11:50 AM, Michal Hocko <mhocko@suse.cz> wrote:
> >
> > The merge commit is empty and both 80dcc31fbe55 and e4b0db72be24 work
> > properly but the merge is bad. So it seems like some of the commits in
> > either branch has a side effect which needs other branch in order to
> > reproduce.
> >
> > So've tried to bisect ^80dcc31fbe55 e4b0db72be24 and merged 80dcc31fbe55
> > in each step.
> 
> Good extra work! Thanks.
> 
> > This lead to:
> >
> > commit 195daf665a6299de98a4da3843fed2dd9de19d3a
> > Author: Ulrich Obergfell <uobergfe@redhat.com>
> > Date:   Tue Apr 14 15:44:13 2015 -0700
> >
> >     watchdog: enable the new user interface of the watchdog mechanism
> >
> > The patch doesn't revert because of follow up changes so I have reverted
> > all three:
> > 692297d8f968 ("watchdog: introduce the hardlockup_detector_disable() function")
> > b2f57c3a0df9 ("watchdog: clean up some function names and arguments")
> > 195daf665a62 ("watchdog: enable the new user interface of the watchdog mechanism")
> 
> Hmm. I guess we should just revert those three then. Unless somebody
> can see what the subtle interaction is.
> 
> Actually, looking closer, on the *other* side of the merge, the only
> commit that looks like it might be conflicting is
> 
>     b3738d293233 "watchdog: Add watchdog enable/disable all functions"
> 
> which is then used by
> 
>     b37609c30e41 "perf/x86/intel: Make the HT bug workaround
> conditional on HT enabled"
> 
> Does the problem go away if you revert *those* two commits instead?
> 
> At least that would tell is what the exact bad interaction is.
> 
> Adding Stephane (author of those watchdog/perf patches) to the Cc. And
> PeterZ, who signed them off (Ingo also did, but was already on the
> participants list).
> 
> Anybody see it?

The 'obvious' discrepancy is that 195daf665a62 ("watchdog: enable the
new user interface of the watchdog mechanism") changes the semantics of
watchdog_user_enabled, which thereafter is only used by the functions
introduced by b3738d293233 ("watchdog: Add watchdog enable/disable all
functions").

There further appears to be a distinct lack of serialization between
setting and using watchdog_enabled, so perhaps we should wrap the
{en,dis}able_all() things in watchdog_proc_mutex.

Let me go see if I can reproduce / test this.. as is the below is
entirely untested.

---
 kernel/watchdog.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 2316f50b07a4..56aeedb087e3 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -608,19 +608,25 @@ void watchdog_nmi_enable_all(void)
 {
 	int cpu;
 
-	if (!watchdog_user_enabled)
+	mutex_lock(&watchdog_proc_mutex);
+
+	if (!(watchdog_enabled & NMI_WATCHDOG_ENABLED))
 		return;
 
 	get_online_cpus();
 	for_each_online_cpu(cpu)
 		watchdog_nmi_enable(cpu);
 	put_online_cpus();
+
+	mutex_unlock(&watchdog_proc_mutex);
 }
 
 void watchdog_nmi_disable_all(void)
 {
 	int cpu;
 
+	mutex_lock(&watchdog_proc_mutex);
+
 	if (!watchdog_running)
 		return;
 
@@ -628,6 +634,8 @@ void watchdog_nmi_disable_all(void)
 	for_each_online_cpu(cpu)
 		watchdog_nmi_disable(cpu);
 	put_online_cpus();
+
+	mutex_unlock(&watchdog_proc_mutex);
 }
 #else
 static int watchdog_nmi_enable(unsigned int cpu) { return 0; }
