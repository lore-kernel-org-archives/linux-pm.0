From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] OOM vs. freezer interaction fixes
Date: Thu, 09 Oct 2014 00:11:33 +0200
Message-ID: <2107592.sy6uXko7kW@vostro.rjw.lan>
References: <1412777266-8251-1-git-send-email-mhocko@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1412777266-8251-1-git-send-email-mhocko@suse.cz>
Sender: owner-linux-mm@kvack.org
To: Michal Hocko <mhocko@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Cong Wang <xiyou.wangcong@gmail.com>, David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, October 08, 2014 04:07:43 PM Michal Hocko wrote:
> Hi Andrew, Rafael,
> 
> this has been originally discussed here [1] but didn't lead anywhere AFAICS
> so I would like to resurrect them.

OK

So any chance to CC linux-pm too next time?  There are people on that list
who may be interested as well and are not in the CC directly either.

> The first and third patch are regression fixes and they are a stable
> material IMO. The second patch is a simple cleanup.
> 
> The 1st patch is fixing a regression introduced in 3.3 since when OOM
> killer is not able to kill any frozen task and live lock as a result.
> The fix gets us back to the 3.2. As it turned out during the discussion [2]
> this was still not 100% sufficient and that's why we need the 3rd patch.
> 
> I was thinking about the proper 1st vs. 3rd patch ordering because
> the 1st patch basically opens a race window fixed by the later patch.
> Original patch from Cong Wang has covered this by cgroup_freezing(current)
> check in should_thaw_current(). But this approach still suffers from OOM
> vs. PM freezer interaction (OOM killer would still live lock waiting for a
> PM frozen task this time).
> 
> So I think the most straight forward way is to address only OOM vs.
> frozen task interaction in the first patch, mark it for stable 3.3+ and
> leave the race to a separate follow up patch which is applicable to
> stable 3.2+ (before a3201227f803 made it inefficient).
> 
> Switching 1st and 3rd patches would make some sense as well but then
> it might end up even more confusing because we would be fixing a
> non-existent issue in upstream first...
> 
> ---
> [1] http://marc.info/?l=linux-kernel&m=140986986423092
> [2] http://marc.info/?l=linux-kernel&m=141074263721166
> 

I'm fine with the approach in general, but I need to stare at patch 3
for a little bit longer before I ACK it.  Which may not happen really
soon as I'll be rather busy on Thu/Fri and then I'll be traveling to
the LPC/LCEU next week.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
