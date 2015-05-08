From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] PM, freezer: Don't thaw when it's intended frozen
 processes
Date: Fri, 8 May 2015 11:25:13 -0400
Message-ID: <20150508152513.GB28439@htj.duckdns.org>
References: <20150507064557.GA26928@july>
 <20150507154212.GA12245@htj.duckdns.org>
 <CAH9JG2UAVRgX0Mg0d7WgG0URpkgu4q_bbNMXyOOEh9WFPztppQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CAH9JG2UAVRgX0Mg0d7WgG0URpkgu4q_bbNMXyOOEh9WFPztppQ@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "\\Rafael J. Wysocki\\" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello, Kyungmin.

On Fri, May 08, 2015 at 09:04:26AM +0900, Kyungmin Park wrote:
> > I need to think more about it but as an *optimization* we can add
> > freezing() test before actually waking tasks up during resume, but can
> > you please clarify what you're seeing?
> 
> The mobile application has life cycle and one of them is 'suspend'
> state. it's different from 'pause' or 'background'.
> if there are some application and enter go 'suspend' state. all
> behaviors are stopped and can't do anything. right it's suspended. but
> after system suspend & resume, these application is thawed and
> running. even though system know it's suspended.
> 
> We made some test application, print out some message within infinite
> loop. when it goes 'suspend' state. nothing is print out. but after
> system suspend & resume, it prints out again. that's not desired
> behavior. and want to address it.
> 
> frozen user processes should be remained as frozen while system
> suspend & resume.

Yes, they should and I'm not sure why what you're saying is happening
because freezing() test done from the frozen tasks themselves should
keep them in the freezer.  Which kernel version did you test?  Can you
please verify it against a recent kernel?

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
