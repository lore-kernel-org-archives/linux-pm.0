From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Thu, 7 May 2009 15:59:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905071554490.10759__25912.7865815119$1241737294$gmane$org@chino.kir.corp.google.com>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905072218.50782.rjw@sisk.pl>
	<alpine.DEB.2.00.0905071321440.646@chino.kir.corp.google.com>
	<200905072238.14558.rjw@sisk.pl>
	<20090507135615.e7db550d.akpm@linux-foundation.org>
	<alpine.DEB.2.00.0905071417160.24417@chino.kir.corp.google.com>
	<20090507145041.9b59f4eb.akpm@linux-foundation.org>
	<alpine.DEB.2.00.0905071508190.2164@chino.kir.corp.google.com>
	<20090507154502.a7f51dd9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507154502.a7f51dd9.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, fengguang.wu@intel.com, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 7 May 2009, Andrew Morton wrote:

> The setting and clearing of that thing looks gruesomely racy..
> 

It's not racy currently because zone_scan_lock ensures ZONE_OOM_LOCKED 
gets test/set and cleared atomically for the entire zonelist (the clear 
happens for the same zonelist that was test/set).

Using it for hibernation in the way I've proposed will open it up to the 
race I earlier described: when a kthread is in the oom killer and 
subsequently clears its zonelist of ZONE_OOM_LOCKED (all other tasks are 
frozen so they can't be in the oom killer).  That's perfectly acceptable, 
however, since the system is by definition already oom if kthreads can't 
get memory so it will end up killing a user task even though it's stuck in 
D state and will exit on thaw; we aren't concerned about killing 
needlessly because the oom killer becomes a no-op when it finds a task 
that has already been killed but hasn't exited by way of TIF_MEMDIE.
