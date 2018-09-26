From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [RFC workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
Date: Wed, 26 Sep 2018 15:05:17 -0700
Message-ID: <9b002bbb-3e6d-9e99-d8f9-36df4306093e@linux.intel.com>
References: <20180926214433.13512.30289.stgit@localhost.localdomain>
 <20180926215138.13512.33146.stgit@localhost.localdomain>
 <20180926215307.GA270328@devbig004.ftw2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926215307.GA270328@devbig004.ftw2.facebook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-nvdimm@lists.01.org, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, len.brown@intel.com, dave.jiang@intel.com, rafael@kernel.org, vishal.l.verma@intel.com, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com
List-Id: linux-pm@vger.kernel.org



On 9/26/2018 2:53 PM, Tejun Heo wrote:
> Hello,
> 
> On Wed, Sep 26, 2018 at 02:51:38PM -0700, Alexander Duyck wrote:
>> This patch provides a new function queue_work_near which is meant to
>> schedule work on the nearest unbound CPU to the requested NUMA node. The
>> main motivation for this is to help assist asynchronous init to better
>> improve boot times for devices that are local to a specific node.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Why not just use unbound workqueues, which are NUMA-affine by default?
> Are there big enough advantages?
> 
> Thanks.

I am using unbound workqueues. However there isn't an interface that 
exposes the NUMA bits of them directly. All I am doing with this patch 
is adding "queue_work_near" which takes a NUMA node as an argument and 
then copies the logic of "queue_work_on" with the exception that I am 
doing a check to verify that there is an intersection between 
wq_unbound_cpumask and the cpumask of the node, and then passing a CPU 
from that intersection into "__queue_work".

Thanks.

- Alex
