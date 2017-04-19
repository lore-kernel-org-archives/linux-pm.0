From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: Re: Re: "mm: move pcp and lru-pcp draining into single wq" broke resume
 from s2ram
Date: Wed, 19 Apr 2017 16:26:10 +0900
Message-ID: <201704190726.v3J7QAiC076509@www262.sakura.ne.jp>
References: <201704190541.v3J5fUE3054131@www262.sakura.ne.jp> <20170419071039.GB28263@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170419071039.GB28263@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux PM list <linux-pm@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

> On Wed 19-04-17 14:41:30, Tetsuo Handa wrote:
> [...]
> > Somebody is waiting forever with cpu_hotplug.lock held?
> 
> Why would that matter for drain_all_pages? It doesn't use
> get_online_cpus since a459eeb7b852 ("mm, page_alloc: do not depend on
> cpu hotplug locks inside the allocator") while ce612879ddc7 ("mm: move
> pcp and lru-pcp draining into single wq") was merged later.
> 

Looking at ce612879ddc7 ("mm: move pcp and lru-pcp draining into single wq"),
we merged "lru-add-drain" (!WQ_FREEZABLE && WQ_MEM_RECLAIM) workqueue and
"vmstat" (WQ_FREEZABLE && WQ_MEM_RECLAIM) workqueue into
"mm_percpu_wq" (WQ_FREEZABLE && WQ_MEM_RECLAIM) workqueue.

-       lru_add_drain_wq = alloc_workqueue("lru-add-drain", WQ_MEM_RECLAIM, 0);
-       vmstat_wq = alloc_workqueue("vmstat", WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+       mm_percpu_wq = alloc_workqueue("mm_percpu_wq",
+                                      WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);

That means "lru-add-drain" became freezable, doesn't it? And this problem
occurs around resume operation where all freezable threads are frozen?
Then, lru_add_drain_per_cpu() cannot be performed due to mm_percpu_wq frozen?
