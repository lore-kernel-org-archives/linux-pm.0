From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv2 3/6] sched/core: Update turbo_sched count only when
 required
Date: Wed, 15 May 2019 18:31:15 +0200
Message-ID: <20190515163115.GV2589@hirez.programming.kicks-ass.net>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-4-parth@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190515135322.19393-4-parth@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Parth Shah <parth@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 07:23:19PM +0530, Parth Shah wrote:
> Use the get/put methods to add/remove the use of TurboSched support from
> the cgroup.

Didn't anybody tell you that cgroup only interfaces are frowned upon?
