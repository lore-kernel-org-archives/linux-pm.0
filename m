From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] OOM, PM: OOM killed task shouldn't escape PM suspend
Date: Tue, 4 Nov 2014 14:27:05 -0500
Message-ID: <20141104192705.GA22163@htj.dyndns.org>
References: <1413876435-11720-1-git-send-email-mhocko@suse.cz>
 <2156351.pWp6MNRoWm@vostro.rjw.lan>
 <20141021141159.GE9415@dhcp22.suse.cz>
 <4766859.KSKPTm3b0x@vostro.rjw.lan>
 <20141021142939.GG9415@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20141021142939.GG9415@dhcp22.suse.cz>
Sender: owner-linux-mm@kvack.org
To: Michal Hocko <mhocko@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, Cong Wang <xiyou.wangcong@gmail.com>, David Rientjes <rientjes@google.com>, Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello,

Sorry about the delay.

On Tue, Oct 21, 2014 at 04:29:39PM +0200, Michal Hocko wrote:
> Reduce the race window by checking all tasks after OOM killer has been

Ugh... this is never a good direction to take.  It often just ends up
making bugs harder to reproduce and track down.

> disabled. This is still not race free completely unfortunately because
> oom_killer_disable cannot stop an already ongoing OOM killer so a task
> might still wake up from the fridge and get killed without
> freeze_processes noticing. Full synchronization of OOM and freezer is,
> however, too heavy weight for this highly unlikely case.

Both oom killing and PM freezing are exremely rare events and I have
difficult time why their exclusion would be heavy weight.  Care to
elaborate?

Overall, this is a lot of complexity for something which doesn't
really fix the problem and the comments while referring to the race
don't mention that the implemented "fix" is broken, which is pretty
bad as it gives readers of the code a false sense of security and
another hurdle to overcome in actually tracking down what went wrong
if this thing ever shows up as an actual breakage.

I'd strongly recommend implementing something which is actually
correct.

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
