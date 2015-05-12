From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] PM, freezer: Don't thaw when it's intended frozen
 processes
Date: Tue, 12 May 2015 10:40:32 -0400
Message-ID: <20150512144032.GN11388@htj.duckdns.org>
References: <20150507064557.GA26928@july>
 <20150507154212.GA12245@htj.duckdns.org>
 <CAH9JG2UAVRgX0Mg0d7WgG0URpkgu4q_bbNMXyOOEh9WFPztppQ@mail.gmail.com>
 <20150508152513.GB28439@htj.duckdns.org>
 <CAJKOXPfmzvE_P15jTrkrXMDuWdqewj2uhM6N1vt=QBD2_ZFhrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPfmzvE_P15jTrkrXMDuWdqewj2uhM6N1vt=QBD2_ZFhrg@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "\\Rafael J. Wysocki\\" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 11, 2015 at 03:33:10PM +0900, Krzysztof Kozlowski wrote:
> > Yes, they should and I'm not sure why what you're saying is happening
> > because freezing() test done from the frozen tasks themselves should
> > keep them in the freezer.  Which kernel version did you test?  Can you
> > please verify it against a recent kernel?
> 
> I tested it on v4.1-rc3 and next-20150508.
> 
> Task was moved to frozen cgroup:
> -----
> root@localhost:/sys/fs/cgroup/freezer/frozen# grep . *
> cgroup.clone_children:0
> cgroup.procs:2750
> freezer.parent_freezing:0
> freezer.self_freezing:1
> freezer.state:FROZEN
> notify_on_release:0
> tasks:2750
> tasks:2773
> -----
> 
> Unfortunately during system resume the process was woken up. The "if
> (frozen(p))" check was true. Is it expected behaviour?

It isn't optimal but doesn't break anything either.  Whether a task
stays in the freezer or not is solely decided by freezing() test by
the task itself.  Being woken up spuriously doesn't break anything.

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
