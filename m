From: Tejun Heo <tj@kernel.org>
Subject: Re: [workqueue/driver-core PATCH 1/5] workqueue: Provide
 queue_work_near to queue work near a given NUMA node
Date: Wed, 10 Oct 2018 08:30:11 -0700
Message-ID: <20181010153011.GM270328@devbig004.ftw2.facebook.com>
References: <20181005183239.8790.28631.stgit@localhost.localdomain>
 <20181005183406.8790.70621.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005183406.8790.70621.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

> +static int workqueue_select_cpu_near(int node)
> +{
...
> +	/* Use "random" otherwise know as "first" online CPU of node */
> +	cpu = cpumask_any_and(cpumask_of_node(node), cpu_online_mask);

Maybe we wanna round-robin within the node?

> +bool queue_work_near(int node, struct workqueue_struct *wq,
> +		     struct work_struct *work)

Can we name it queue_work_node() to stay consistent with numa-aware
memory interface?

Thanks.

-- 
tejun
