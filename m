From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv2 6/6] sched/fair: Bound non idle core search by DIE domain
Date: Wed, 15 May 2019 18:44:14 +0200
Message-ID: <20190515164414.GY2589@hirez.programming.kicks-ass.net>
References: <20190515135322.19393-1-parth@linux.ibm.com>
 <20190515135322.19393-7-parth@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190515135322.19393-7-parth@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Parth Shah <parth@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, dsmythies@telus.net
List-Id: linux-pm@vger.kernel.org

On Wed, May 15, 2019 at 07:23:22PM +0530, Parth Shah wrote:
> This patch specifies the sched domain to search for a non idle core.
> 
> The select_non_idle_core searches for the non idle cores across whole
> system. But in the systems with multiple NUMA domains, the Turbo frequency
> can be sustained within the NUMA domain without being affected from other
> NUMA.
> 
> This patch provides an architecture specific implementation for defining
> the turbo domain to make searching of the core to be bound within the NUMA.

NAK, this is insane. You don't need arch hooks to find the numa domain.
