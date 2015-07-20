From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v3 1/1] kernel/sysctl.c: Add /proc/sys/vm/shrink_memory
 feature
Date: Mon, 20 Jul 2015 10:49:32 +0200
Message-ID: <20150720084932.GC1211@dhcp22.suse.cz>
References: <1437114578-2502-1-git-send-email-pintu.k@samsung.com>
 <1437366544-32673-1-git-send-email-pintu.k@samsung.com>
 <20150720082810.GG2561@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150720082810.GG2561@suse.de>
Sender: linux-doc-owner@vger.kernel.org
To: Mel Gorman <mgorman@suse.de>
Cc: Pintu Kumar <pintu.k@samsung.com>, akpm@linux-foundation.org, corbet@lwn.net, vbabka@suse.cz, gorcunov@openvz.org, emunson@akamai.com, kirill.shutemov@linux.intel.com, standby24x7@gmail.com, hannes@cmpxchg.org, vdavydov@parallels.com, hughd@google.com, minchan@kernel.org, tj@kernel.org, rientjes@google.com, xypron.glpk@gmx.de, dzickus@redhat.com, prarit@redhat.com, ebiederm@xmission.com, rostedt@goodmis.org, uobergfe@redhat.com, paulmck@linux.vnet.ibm.com, iamjoonsoo.kim@lge.com, ddstreet@ieee.org, sasha.levin@oracle.com, koct9i@gmail.com, cj@linux.com, opensource.ganesh@gmail.com, vinmenon@codeaurora.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, qiuxishi@huawei.com, Valdis.Kletnieks@vt.edu, cpgs@samsung.com, pintu_agarwal@yahoo.com, vishnu.ps@samsung.com, rohit.kr@samsung.com, iqbal.ams@samsung.com, pintu.p
List-Id: linux-pm@vger.kernel.org

On Mon 20-07-15 09:28:10, Mel Gorman wrote:
[...]
> If high-order allocation latency or reliability is important then you
> really need a different solution because unless this thing runs
> continually to keep memory unused then it'll eventually fail hard and
> the system will perform poorly in the meantime.

Completely agreed. E.g. Vlastimil was suggesting a background compaction
daemon which might be a way to go.
-- 
Michal Hocko
SUSE Labs
