From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Thu, 7 May 2009 13:25:06 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905071321440.646__38776.3065089986$1241728128$gmane$org@chino.kir.corp.google.com>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905072133.48917.rjw@sisk.pl>
	<20090507130202.34cbe37a.akpm@linux-foundation.org>
	<200905072218.50782.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905072218.50782.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, fengguang.wu@intel.com, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 7 May 2009, Rafael J. Wysocki wrote:

> OK, let's try with __GFP_NO_OOM_KILL first.  If there's too much disagreement,
> I'll use the freezer-based approach instead.
> 

Third time I'm going to suggest this, and I'd like a response on why it's 
not possible instead of being ignored.

All of your tasks are in D state other than kthreads, right?  That means 
they won't be in the oom killer (thus no zones are oom locked), so you can 
easily do this

	struct zone *z;
	for_each_populated_zone(z)
		zone_set_flag(z, ZONE_OOM_LOCKED);

and then

	for_each_populated_zone(z)
		zone_clear_flag(z, ZONE_OOM_LOCKED);

The serialization is done with trylocks so this will never invoke the oom 
killer because all zones in the allocator's zonelist will be oom locked.

Why does this not work for you?
