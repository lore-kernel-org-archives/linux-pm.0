From: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
Date: Mon, 1 Oct 2018 14:54:39 -0700
Message-ID: <4eebc017-23a2-a26e-095c-66433061a141@linux.intel.com>
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215138.13512.33146.stgit@localhost.localdomain>
 <20180926215307.GA270328@devbig004.ftw2.facebook.com>
 <9b002bbb-3e6d-9e99-d8f9-36df4306093e@linux.intel.com>
 <20180926220957.GB270328@devbig004.ftw2.facebook.com>
 <ba72f007-84e2-6fe0-b128-d876dadef5f5@linux.intel.com>
 <20181001160142.GE270328@devbig004.ftw2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20181001160142.GE270328-LpCCV3molIbIZ9tKgghJQw2O0Ztt9esIQQ4Iyu8u01E@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 10/1/2018 9:01 AM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 26, 2018 at 03:19:21PM -0700, Alexander Duyck wrote:
>> On 9/26/2018 3:09 PM, Tejun Heo wrote:
>> I could just use queue_work_on probably, but is there any issue if I
>> am passing CPU values that are not in the wq_unbound_cpumask? That
> 
> That should be fine.  If it can't find any available cpu, it'll fall
> back to round-robin.  We probably can improve it so that it can
> consider the numa distance when falling back.
> 
>> was mostly my concern. Also for an unbound queue do I need to worry
>> about the hotplug lock? I wasn't sure if that was the case or not as
> 
> Issuers don't need to worry about them.
> 
>> I know it is called out as something to be concerned with using
>> queue_work_on, but in __queue_work the value is just used to
>> determine which node to grab a work queue from.
> 
> It might be better to leave queue_work_on() to be used for per-cpu
> workqueues and introduce queue_work_near() as you suggseted.  I just
> don't want it to duplicate the node selection code in it.  Would that
> work?

So if I understand what you are saying correctly we default to 
round-robin on a given node has no CPUs attached to it. I could probably 
work with that if that is the default behavior instead of adding much of 
the complexity I already have.

The question I have then is what should I do about workqueues that 
aren't WQ_UNBOUND if they attempt to use queue_work_near? In that case I 
should be looking for some way to go from a node to a CPU shouldn't I? 
If so should I look at doing something like wq_select_unbound_cpu that 
uses the node cpumask instead of the wq_unbound_cpumask?

- Alex
