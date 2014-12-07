From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/4] OOM vs PM freezer fixes
Date: Sun, 7 Dec 2014 08:55:51 -0500
Message-ID: <20141207135551.GA19034@htj.dyndns.org>
References: <20141110163055.GC18373@dhcp22.suse.cz>
 <1417797707-31699-1-git-send-email-mhocko@suse.cz>
 <20141207100953.GC15892@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20141207100953.GC15892@dhcp22.suse.cz>
Sender: owner-linux-mm@kvack.org
To: Michal Hocko <mhocko@suse.cz>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, "\\\"Rafael J. Wysocki\\\"" <rjw@rjwysocki.net>, David Rientjes <rientjes@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Oleg Nesterov <oleg@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 07, 2014 at 11:09:53AM +0100, Michal Hocko wrote:
> this is another attempt to address OOM vs. PM interaction. More
> about the issue is described in the last patch. The other 4 patches
> are just clean ups. This is based on top of 3.18-rc3 + Johannes'
> http://marc.info/?l=linux-kernel&m=141779091114777 which is not in the
> Andrew's tree yet but I wanted to prevent from later merge conflicts.

When the patches are based on a custom tree, it's often a good idea to
create a git branch of the patches to help reviewing.

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
