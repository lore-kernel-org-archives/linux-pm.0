From: Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/1] kernel/sysctl.c: Add /proc/sys/vm/shrink_memory
 feature
Date: Fri, 3 Jul 2015 14:38:09 -0400
Message-ID: <20150703183809.GA6781@cmpxchg.org>
References: <1435929607-3435-1-git-send-email-pintu.k@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435929607-3435-1-git-send-email-pintu.k@samsung.com>
Sender: linux-doc-owner@vger.kernel.org
To: Pintu Kumar <pintu.k@samsung.com>
Cc: corbet@lwn.net, akpm@linux-foundation.org, vbabka@suse.cz, gorcunov@openvz.org, mhocko@suse.cz, emunson@akamai.com, kirill.shutemov@linux.intel.com, standby24x7@gmail.com, vdavydov@parallels.com, hughd@google.com, minchan@kernel.org, tj@kernel.org, rientjes@google.com, xypron.glpk@gmx.de, dzickus@redhat.com, prarit@redhat.com, ebiederm@xmission.com, rostedt@goodmis.org, uobergfe@redhat.com, paulmck@linux.vnet.ibm.com, iamjoonsoo.kim@lge.com, ddstreet@ieee.org, sasha.levin@oracle.com, koct9i@gmail.com, mgorman@suse.de, cj@linux.com, opensource.ganesh@gmail.com, vinmenon@codeaurora.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, cpgs@samsung.com, pintu_agarwal@yahoo.com, vishnu.ps@samsung.com, rohit.kr@samsung.com, iqbal.ams@samsung.com
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 03, 2015 at 06:50:07PM +0530, Pintu Kumar wrote:
> This patch provides 2 things:
> 1. Add new control called shrink_memory in /proc/sys/vm/.
> This control can be used to aggressively reclaim memory system-wide
> in one shot from the user space. A value of 1 will instruct the
> kernel to reclaim as much as totalram_pages in the system.
> Example: echo 1 > /proc/sys/vm/shrink_memory
> 
> 2. Enable shrink_all_memory API in kernel with new CONFIG_SHRINK_MEMORY.
> Currently, shrink_all_memory function is used only during hibernation.
> With the new config we can make use of this API for non-hibernation case
> also without disturbing the hibernation case.
> 
> The detailed paper was presented in Embedded Linux Conference, Mar-2015
> http://events.linuxfoundation.org/sites/events/files/slides/
> %5BELC-2015%5D-System-wide-Memory-Defragmenter.pdf
> 
> Scenarios were this can be used and helpful are:
> 1) Can be invoked just after system boot-up is finished.

The allocator automatically reclaims when memory is needed, that's why
the metrics quoted in those slides, free pages and fragmentation level,
don't really mean much.  We don't care how much memory is free or how
fragmented it is UNTIL somebody actually asks for it.  The only metric
that counts is the allocation success ratio (and possibly the latency).

> 2) Can be invoked just before entering entire system suspend.

Why is that?  Suspend already allocates as much as it needs to create
the system image.

> 3) Can be invoked from kernel when order-4 pages starts failing.

We have compaction for that, and compaction invokes page reclaim
automatically to satisfy its need for free pages.

> 4) Can be helpful to completely avoid or delay the kerenl OOM condition.

That's not how OOM works.  An OOM is triggered when there is demand for
memory but no more pages to reclaim, telling the kernel to look harder
will not change that.

> 5) Can be developed as a system-tool to quickly defragment entire system
>    from user space, without the need to kill any application.

Again, the kernel automatically reclaims and compacts memory on demand.
If the existing mechanisms don't do this properly, and you have actual
problems with them, they should be reported and fixed, not bypassed.
But the metrics you seem to base this change on are not representative
of something that should matter in practice.
