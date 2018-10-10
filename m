From: Tejun Heo <tj@kernel.org>
Subject: Re: [workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
Date: Wed, 10 Oct 2018 08:37:02 -0700
Message-ID: <20181010153702.GN270328@devbig004.ftw2.facebook.com>
References: <20181005183239.8790.28631.stgit@localhost.localdomain>
 <20181005183406.8790.70621.stgit@localhost.localdomain>
 <20181010153011.GM270328@devbig004.ftw2.facebook.com>
 <36fd7d36-ea79-bd69-4576-06ab4635f0d3@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <36fd7d36-ea79-bd69-4576-06ab4635f0d3@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

On Wed, Oct 10, 2018 at 08:34:06AM -0700, Alexander Duyck wrote:
> >Maybe we wanna round-robin within the node?
> 
> I had thought about it. It adds extra complexity to do it and for
> unbound work queues it doesn't really add anything since it gets
> converted back into a node anyway.

Yeap, it only makes sense for per-cpu workqueues.

> If you wanted I could look at adding extra logic that would do the
> round-robin for non-unbound workqueues. I just wasn't sure if it was
> worth the effort since the current users are all unbound workqueues.

It doesn't have to be complex, just a per-node unsynchronized int
which gets incremented and %'s would work fine.  Alternatively, we can
trigger WARN_ON_ONCE() if the function is used on a per-cpu workqueue.

Thanks.

-- 
tejun
