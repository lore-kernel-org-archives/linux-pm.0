From: Tejun Heo <tj@kernel.org>
Subject: Re: [workqueue/driver-core PATCH v2 1/5] workqueue: Provide
 queue_work_node to queue work near a given NUMA node
Date: Thu, 11 Oct 2018 08:04:17 -0700
Message-ID: <20181011150417.GO270328@devbig004.ftw2.facebook.com>
References: <20181010230435.10609.77825.stgit@localhost.localdomain>
 <20181010230715.10609.83647.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010230715.10609.83647.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 10, 2018 at 04:07:42PM -0700, Alexander Duyck wrote:
> This patch provides a new function queue_work_node which is meant to
> schedule work on a "random" CPU of the requested NUMA node. The main
> motivation for this is to help assist asynchronous init to better improve
> boot times for devices that are local to a specific node.
> 
> For now we just default to the first CPU that is in the intersection of the
> cpumask of the node and the online cpumask. The only exception is if the
> CPU is local to the node we will just use the current CPU. This should work
> for our purposes as we are currently only using this for unbound work so
> the CPU will be translated to a node anyway instead of being directly used.
> 
> As we are only using the first CPU to represent the NUMA node for now I am
> limiting the scope of the function so that it can only be used with unbound
> workqueues.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Acked-by: Tejun Heo <tj@kernel.org>

Please let me know how you wanna route the patch.

Thanks.

-- 
tejun
