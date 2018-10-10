From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
Date: Wed, 10 Oct 2018 08:34:06 -0700
Message-ID: <36fd7d36-ea79-bd69-4576-06ab4635f0d3@linux.intel.com>
References: <20181005183239.8790.28631.stgit@localhost.localdomain>
 <20181005183406.8790.70621.stgit@localhost.localdomain>
 <20181010153011.GM270328@devbig004.ftw2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010153011.GM270328@devbig004.ftw2.facebook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
List-Id: linux-pm@vger.kernel.org



On 10/10/2018 8:30 AM, Tejun Heo wrote:
> Hello,
> 
>> +static int workqueue_select_cpu_near(int node)
>> +{
> ...
>> +	/* Use "random" otherwise know as "first" online CPU of node */
>> +	cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);
> 
> Maybe we wanna round-robin within the node?

I had thought about it. It adds extra complexity to do it and for 
unbound work queues it doesn't really add anything since it gets 
converted back into a node anyway.

If you wanted I could look at adding extra logic that would do the 
round-robin for non-unbound workqueues. I just wasn't sure if it was 
worth the effort since the current users are all unbound workqueues.

>> +bool queue_work_near(int node, struct workqueue_struct *wq,
>> +		     struct work_struct *work)
> 
> Can we name it queue_work_node() to stay consistent with numa-aware
> memory interface?

Yes. No problem.

> Thanks.

Thanks for the review feedback.

- Alex
