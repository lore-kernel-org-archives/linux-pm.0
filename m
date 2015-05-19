From: Michal Hocko <mhocko@suse.cz>
Subject: Re: suspend regression in 4.1-rc1
Date: Tue, 19 May 2015 09:12:59 +0200
Message-ID: <20150519071259.GA6847@dhcp22.suse.cz>
References: <20150517185041.GA5897@dhcp22.suse.cz>
 <CA+55aFy2wWy-k0O-Sb2vUCLiLjeKMu7r95bf294qP5UqQHuxfw@mail.gmail.com>
 <20150518073046.GO17717@twins.programming.kicks-ass.net>
 <20150518090336.GA6393@dhcp22.suse.cz>
 <20150518093150.GC21418@twins.programming.kicks-ass.net>
 <CA+55aFzx2j-yZH0CgMGJ_uw0KbdqaUanEJPKwdm-yXYaFLhRXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34170 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbESHNE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 03:13:04 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzx2j-yZH0CgMGJ_uw0KbdqaUanEJPKwdm-yXYaFLhRXw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Ulrich Obergfell <uobergfe@redhat.com>, Don Zickus <dzickus@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon 18-05-15 10:10:50, Linus Torvalds wrote:
> On Mon, May 18, 2015 at 2:31 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > Subject: watchdog: Fix merge 'conflict'
> >
> > Two watchdog changes that came through different trees had a non
> > conflicting conflict, that is, one changed the semantics of a variable
> > but no actual code conflict happened. So the merge appeared fine, but
> > the resulting code did not behave as expected.
> 
> Ok, I see that people are still discussing this, but I'll apply it
> as-is since I want to get rc4 out the door, and I guess people can
> tweak this if there's anything else we want to do longer-term.

The final patch from Peter has a typo. Without the following the system
deadlocks obviously:
---
>From 215266efd5e14938d14f0f4258a70fb32f6a455b Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.cz>
Date: Tue, 19 May 2015 09:07:27 +0200
Subject: [PATCH] watchdog: fix double lock in watchdog_nmi_enable_all

ab992dc38f9a ("watchdog: Fix merge 'conflict'") has introduced an
obvious deadlock because of a typo. watchdog_proc_mutex should be
unlocked on exit.

Thanks to Miroslav Benes who was staring at the code with me and noticed
this.

Signed-off-by: Michal Hocko <mhocko@suse.cz>
---
 kernel/watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 506edcc500c4..581a68a04c64 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -621,7 +621,7 @@ void watchdog_nmi_enable_all(void)
 	put_online_cpus();
 
 unlock:
-	mutex_lock(&watchdog_proc_mutex);
+	mutex_unlock(&watchdog_proc_mutex);
 }
 
 void watchdog_nmi_disable_all(void)
-- 
2.1.4

-- 
Michal Hocko
SUSE Labs
