From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Thu, 7 May 2009 11:50:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905071147260.26631__33805.8613743216$1241722503$gmane$org@chino.kir.corp.google.com>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905060120.35698.rjw@sisk.pl>
	<20090505164028.e9d807a1.akpm@linux-foundation.org>
	<200905072009.53406.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905072009.53406.rjw@sisk.pl>
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

> Unfortunately it fails too quickly with the combination as well, so it looks
> like we can't use __GFP_NORETRY during hibernation.
> 

If you know that no other tasks are in the oom killer at suspend time, you 
can do what I mentioned earlier:

	struct zone *z;
	for_each_populated_zone(z)
		zone_set_flag(z, ZONE_OOM_LOCKED);

and then later

	for_each_populated_zone(z)
		zone_clear_flag(z, ZONE_OOM_LOCKED);

The only race there is if a task is currently in the oom killer and will 
subsequently clear ZONE_OOM_LOCKED for its zonelist.
