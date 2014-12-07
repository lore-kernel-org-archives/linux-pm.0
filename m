From: Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH -v2 5/5] OOM, PM: make OOM detection in the freezer path
 raceless
Date: Sun, 7 Dec 2014 11:11:18 +0100
Message-ID: <20141207101118.GD15892@dhcp22.suse.cz>
References: <20141110163055.GC18373@dhcp22.suse.cz>
 <1417797707-31699-1-git-send-email-mhocko@suse.cz>
 <1417797707-31699-6-git-send-email-mhocko@suse.cz>
 <20141206131115.GF18711@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20141206131115.GF18711@htj.dyndns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat 06-12-14 08:11:15, Tejun Heo wrote:
> On Fri, Dec 05, 2014 at 05:41:47PM +0100, Michal Hocko wrote:
> > 5695be142e20 (OOM, PM: OOM killed task shouldn't escape PM suspend)
> > has left a race window when OOM killer manages to note_oom_kill after
> > freeze_processes checks the counter. The race window is quite small and
> > really unlikely and partial solution deemed sufficient at the time of
> > submission.
> 
> This patch doesn't apply on top of v3.18-rc3, latest mainline, -mm or
> -next.  Did I miss something?  Can you please check the patch?

The original cover letter which didn't make it to the mailing list has
mentioned that. I have reposted it now. Anyway this is on top of
http://marc.info/?l=linux-kernel&m=141779091114777 which hasn't landed
into -mm tree at the time I was posting this. Sorry about the confusion.

-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
