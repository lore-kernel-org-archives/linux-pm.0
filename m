From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Fri, 8 May 2009 15:42:47 +0200
Message-ID: <200905081542.48942.rjw__35064.5294333392$1241790339$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905080111.31273.rjw@sisk.pl>
	<20090508101651.aa4d513d.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090508101651.aa4d513d.kamezawa.hiroyu@jp.fujitsu.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: kernel-testers@vger.kernel.org, jens.axboe@oracle.com, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, fengguang.wu@intel.com, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 08 May 2009, KAMEZAWA Hiroyuki wrote:
> On Fri, 8 May 2009 01:11:30 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > +	for_each_populated_zone(zone)
> > +		zone_set_flag(zone, ZONE_OOM_LOCKED);
> 
> > +	for_each_populated_zone(zone)
> > +		zone_clear_flag(zone, ZONE_OOM_LOCKED);
> > +
> 
> Isn't it better to make above 2 be functions and move to mm/oom_kill.c ?

Hmm, OK.  I'll do it.

Well, in fact snapshot.c is all about memory management, so perhaps it's a good
idea to move it into mm as a whole. ;-)

Best,
Rafael
