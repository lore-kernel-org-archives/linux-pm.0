From: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
Date: Tue, 2 Oct 2018 11:23:26 -0700
Message-ID: <be9081de-f186-b265-934d-78cec2a8792f@linux.intel.com>
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215138.13512.33146.stgit@localhost.localdomain>
 <20180926215307.GA270328@devbig004.ftw2.facebook.com>
 <9b002bbb-3e6d-9e99-d8f9-36df4306093e@linux.intel.com>
 <20180926220957.GB270328@devbig004.ftw2.facebook.com>
 <ba72f007-84e2-6fe0-b128-d876dadef5f5@linux.intel.com>
 <20181001160142.GE270328@devbig004.ftw2.facebook.com>
 <4eebc017-23a2-a26e-095c-66433061a141@linux.intel.com>
 <20181002174116.GG270328@devbig004.ftw2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20181002174116.GG270328-LpCCV3molIbIZ9tKgghJQw2O0Ztt9esIQQ4Iyu8u01E@public.gmane.org>
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

On 10/2/2018 10:41 AM, Tejun Heo wrote:
> Hello,
> 
> On Mon, Oct 01, 2018 at 02:54:39PM -0700, Alexander Duyck wrote:
>>> It might be better to leave queue_work_on() to be used for per-cpu
>>> workqueues and introduce queue_work_near() as you suggseted.  I just
>>> don't want it to duplicate the node selection code in it.  Would that
>>> work?
>>
>> So if I understand what you are saying correctly we default to
>> round-robin on a given node has no CPUs attached to it. I could
>> probably work with that if that is the default behavior instead of
>> adding much of the complexity I already have.
> 
> Yeah, it's all in wq_select_unbound_cpu().  Right now, if the
> requested cpu isn't in wq_unbound_cpumask, it falls back to dumb
> round-robin.  We can probably do better there and find the nearest
> node considering topology.

Well if we could get wq_select_unbound_cpu doing the right thing based 
on node topology that would be most of my work solved right there. 
Basically I could just pass WQ_CPU_UNBOUND with the correct node and it 
would take care of getting to the right CPU.

>> The question I have then is what should I do about workqueues that
>> aren't WQ_UNBOUND if they attempt to use queue_work_near? In that
> 
> Hmm... yeah, let's just use queue_work_on() for now.  We can sort it
> out later and users could already do that anyway.
> 
> Thanks.

So are you saying I should just return an error for now if somebody 
tries to use something other than an unbound workqueue with 
queue_work_near, and expect everyone else to just use queue_work_on for 
the other workqueue types?

Thanks.

- Alex
