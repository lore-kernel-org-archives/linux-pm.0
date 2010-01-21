From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Thu, 21 Jan 2010 21:21:50 +0100
Message-ID: <201001212121.50272.rjw__43967.1637410813$1264105542$gmane$org@sisk.pl>
References: <20100120085053.405A.A69D9226@jp.fujitsu.com>
	<201001202221.34804.rjw@sisk.pl>
	<20100121091023.3775.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100121091023.3775.A69D9226@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 21 January 2010, KOSAKI Motohiro wrote:
> > > Hi Rafael,
> > > 
> > > Do you mean this is the unrelated issue of nVidia bug?
> > 
> > The nvidia driver _is_ buggy, but Maxim said he couldn't reproduce the
> > problem if all the allocations made by the nvidia driver during suspend
> > were changed to GFP_ATOMIC.
> > 
> > > Probably I haven't catch your point. I don't find Maxim's original bug
> > > report. Can we share the test-case and your analysis detail?
> > 
> > The Maxim's original report is here:
> > https://lists.linux-foundation.org/pipermail/linux-pm/2010-January/023982.html
> > 
> > and the message I'm referring to is at:
> > https://lists.linux-foundation.org/pipermail/linux-pm/2010-January/023990.html
> 
> Hmmm...
> 
> Usually, Increasing I/O isn't caused MM change. either subsystem change
> memory alloc/free pattern and another subsystem receive such effect ;)
> I don't think this message indicate MM fault.
> 
> And, 2.6.33 MM change is not much. if the fault is in MM change
> (note: my guess is no), The most doubtful patch is my "killing shrink_all_zones"
> patch. If old shrink_all_zones reclaimed memory much rather than required. 
> The patch fixed it. IOW, the patch can reduce available free memory to be used
> buggy .suspend of the driver. but I don't think it is MM fault.
> 
> As I said, drivers can't use memory freely as their demand in suspend method.
> It's obvious. They should stop such unrealistic assumption. but How should we fix
> this?
>  - Gurantee suspend I/O device at last?
>  - Make much much free memory before calling .suspend method? even though
>    typical drivers don't need.

That doesn't help already.  Maxim tried to increase SPARE_PAGES (in
kernel/power/power.h) and that had no effect.

>  - Ask all drivers how much they require memory before starting suspend and
>    Make enough free memory at first?

That's equivalent to reworking all drivers to allocate memory before suspend
eg. with the help of PM notifiers.  Which IMHO is unrealistic.

>  - Or, do we have an alternative way?

The $subject patch?

> Probably we have multiple option. but I don't think GFP_NOIO is good
> option. It assume the system have lots non-dirty cache memory and it isn't
> guranteed.

Basically nothing is guaranteed in this case.  However, does it actually make
things _worse_?  What _exactly_ does happen without the $subject patch if the
system doesn't have non-dirty cache memory and someone makes a GFP_KERNEL
allocation during suspend?

Rafael
