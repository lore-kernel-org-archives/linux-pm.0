From: Michal Hocko <mhocko@kernel.org>
Subject: Re: Re: "mm: move pcp and lru-pcp draining into single wq" broke
 resume from s2ram
Date: Wed, 19 Apr 2017 09:10:39 +0200
Message-ID: <20170419071039.GB28263@dhcp22.suse.cz>
References: <CAMuHMdUJSfrZ=2zy88_zojDek3CHEWKhv_qoJAVgDpPWz8V=Ew@mail.gmail.com>
 <20170418201907.GC20671@dhcp22.suse.cz>
 <201704190541.v3J5fUE3054131@www262.sakura.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201704190541.v3J5fUE3054131@www262.sakura.ne.jp>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux PM list <linux-pm@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed 19-04-17 14:41:30, Tetsuo Handa wrote:
[...]
> Somebody is waiting forever with cpu_hotplug.lock held?

Why would that matter for drain_all_pages? It doesn't use
get_online_cpus since a459eeb7b852 ("mm, page_alloc: do not depend on
cpu hotplug locks inside the allocator") while ce612879ddc7 ("mm: move
pcp and lru-pcp draining into single wq") was merged later.

-- 
Michal Hocko
SUSE Labs
