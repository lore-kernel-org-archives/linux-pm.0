From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: lockdep splat in CPU hotplug
Date: Wed, 22 Oct 2014 22:57:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1410222255540.17725@pobox.suse.cz>
References: <alpine.LNX.2.00.1410211255531.24255@pobox.suse.cz> <alpine.LNX.2.00.1410221125280.22681@pobox.suse.cz> <20141022143837.GW4977@linux.vnet.ibm.com> <20141022165433.GA22874@linux.vnet.ibm.com> <20141022185712.GA9570@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47530 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932111AbaJVU52 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 Oct 2014 16:57:28 -0400
In-Reply-To: <20141022185712.GA9570@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Steven Rostedt <rostedt@goodmis.org>, Dave Jones <davej@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 22 Oct 2014, Paul E. McKenney wrote:

> rcu: More on deadlock between CPU hotplug and expedited grace periods
> 
> Commit dd56af42bd82 (rcu: Eliminate deadlock between CPU hotplug and
> expedited grace periods) was incomplete.  Although it did eliminate
> deadlocks involving synchronize_sched_expedited()'s acquisition of
> cpu_hotplug.lock via get_online_cpus(), it did nothing about the similar
> deadlock involving acquisition of this same lock via put_online_cpus().
> This deadlock became apparent with testing involving hibernation.
> 
> This commit therefore changes put_online_cpus() acquisition of this lock
> to be conditional, and increments a new cpu_hotplug.puts_pending field
> in case of acquisition failure.  Then cpu_hotplug_begin() checks for this
> new field being non-zero, and applies any changes to cpu_hotplug.refcount.
> 

Yes, this works. FWIW, please feel free to add 

	Reported-and-tested-by: Jiri Kosina <jkosina@suse.cz>

once merging it.

Why lockdep produced such an incomplete stacktrace still remains 
unexplained.

Thanks,

-- 
Jiri Kosina
SUSE Labs
