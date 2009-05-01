From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] PM: Disable OOM killer during
 system-wide power transitions
Date: Fri, 1 May 2009 16:09:31 -0700
Message-ID: <20090501160931.1dbd2abc.akpm__7049.55843179977$1241219712$gmane$org@linux-foundation.org>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera>
	<20090422131943.69288af3.akpm@linux-foundation.org>
	<200905020026.19027.rjw@sisk.pl> <200905020027.31244.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905020027.31244.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, kernel-testers@vger.kernel.org, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, 2 May 2009 00:27:30 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The OOM killer is not particularly useful during system-wide power
> transitions, so do not use it if such a transition is in progress.
> 

so...  I think what you've done here is to arrange for the page
allocator to return NULL if we're hibernating rather than oom-killing,
yes?

Does the same apply to suspending?  If so, why?

I think this is an OK change, as long as the only thing which is
allocating memory is hibernation itself.  If random processes are still
doing random memory allocations at this time then their failed memory
allocation could be just as fatal as an oom-killing.  Moreso if they're
s/bin/init or whatever.

So is it the case that pm_transition_in_progress() is only true during
the highly-constrained hibernation process?  After everything is frozen?

If so, there are alternatives - the calling process could set
PF_DONT_KILL_ANYONE_FOR_ME, or could pass __GFP_DONT_KILL_ANYONE_FOR_ME. 
Those might be worse alternatives, dunno - I'm just asking probing
questions ;)
