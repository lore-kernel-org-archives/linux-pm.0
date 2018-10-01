From: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
Date: Mon, 1 Oct 2018 09:01:42 -0700
Message-ID: <20181001160142.GE270328@devbig004.ftw2.facebook.com>
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215138.13512.33146.stgit@localhost.localdomain>
 <20180926215307.GA270328@devbig004.ftw2.facebook.com>
 <9b002bbb-3e6d-9e99-d8f9-36df4306093e@linux.intel.com>
 <20180926220957.GB270328@devbig004.ftw2.facebook.com>
 <ba72f007-84e2-6fe0-b128-d876dadef5f5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ba72f007-84e2-6fe0-b128-d876dadef5f5-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Wed, Sep 26, 2018 at 03:19:21PM -0700, Alexander Duyck wrote:
> On 9/26/2018 3:09 PM, Tejun Heo wrote:
> I could just use queue_work_on probably, but is there any issue if I
> am passing CPU values that are not in the wq_unbound_cpumask? That

That should be fine.  If it can't find any available cpu, it'll fall
back to round-robin.  We probably can improve it so that it can
consider the numa distance when falling back.

> was mostly my concern. Also for an unbound queue do I need to worry
> about the hotplug lock? I wasn't sure if that was the case or not as

Issuers don't need to worry about them.

> I know it is called out as something to be concerned with using
> queue_work_on, but in __queue_work the value is just used to
> determine which node to grab a work queue from.

It might be better to leave queue_work_on() to be used for per-cpu
workqueues and introduce queue_work_near() as you suggseted.  I just
don't want it to duplicate the node selection code in it.  Would that
work?

> I forgot to address your question about the advantages. They are
> pretty significant. The test system I was working with was
> initializing 3TB of nvdimm memory per node. If the node is aligned
> it takes something like 24 seconds, whereas an unaligned core can
> take 36 seconds or more.

Oh yeah, sure, numa affinity matters quite a bit on memory heavy
workloads.  I was mistaken that you were adding adding numa affinity
to per-cpu workqueues.

Thanks.

-- 
tejun
