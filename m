From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/4] OOM, PM: OOM killed task shouldn't escape PM suspend
Date: Thu, 6 Nov 2014 11:12:11 -0500
Message-ID: <20141106161211.GC25642@htj.dyndns.org>
References: <20141105134219.GD4527@dhcp22.suse.cz>
 <20141105154436.GB14386@htj.dyndns.org>
 <20141105160115.GA28226@dhcp22.suse.cz>
 <20141105162929.GD14386@htj.dyndns.org>
 <20141105163956.GD28226@dhcp22.suse.cz>
 <20141105165428.GF14386@htj.dyndns.org>
 <20141105170111.GG14386@htj.dyndns.org>
 <20141106130543.GE7202@dhcp22.suse.cz>
 <20141106150927.GB25642@htj.dyndns.org>
 <20141106160158.GI7202@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20141106160158.GI7202@dhcp22.suse.cz>
Sender: owner-linux-mm@kvack.org
To: Michal Hocko <mhocko@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, Cong Wang <xiyou.wangcong@gmail.com>, David Rientjes <rientjes@google.com>, Oleg Nesterov <oleg@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 06, 2014 at 05:01:58PM +0100, Michal Hocko wrote:
> Yes, OOM killer simply kicks the process sets TIF_MEMDIE and terminates.
> That will release the read_lock, allow this to take the write lock and
> check whether it the current has been killed without any races.
> OOM killer doesn't wait for the killed task. The allocation is retried.
> 
> Does this explain your concern?

Draining oom killer then doesn't mean anything, no?  OOM killer may
have been disabled and drained but the killed tasks might wake up
after the PM freezer considers them to be frozen, right?  What am I
missing?

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
