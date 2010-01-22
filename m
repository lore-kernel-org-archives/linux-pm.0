From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Fri, 22 Jan 2010 21:58:46 +0100
Message-ID: <201001222158.46337.rjw__33082.960433285$1264193935$gmane$org@sisk.pl>
References: <20100121091023.3775.A69D9226@jp.fujitsu.com>
	<201001212121.50272.rjw@sisk.pl>
	<20100122100155.6C03.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100122100155.6C03.A69D9226@jp.fujitsu.com>
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

On Friday 22 January 2010, KOSAKI Motohiro wrote:
> > > Probably we have multiple option. but I don't think GFP_NOIO is good
> > > option. It assume the system have lots non-dirty cache memory and it isn't
> > > guranteed.
> > 
> > Basically nothing is guaranteed in this case.  However, does it actually make
> > things _worse_?  
> 
> Hmm..
> Do you mean we don't need to prevent accidental suspend failure?
> Perhaps, I did misunderstand your intention. If you think your patch solve
> this this issue, I still disagree.

No, I don't.

> but If you think your patch mitigate the pain of this issue, I agree it.

That's what I wanted to say really.

> I don't have any reason to oppose your first patch.

Great!

> > What _exactly_ does happen without the $subject patch if the
> > system doesn't have non-dirty cache memory and someone makes a GFP_KERNEL
> > allocation during suspend?
> 
> Page allocator prefer to spent lots time for reclaimable memory searching than
> returning NULL. IOW, it can spent time few second if it doesn't have
> reclaimable memory.
> In typical case, OOM killer forcely make enough free memory if the system
> don't have any memory. But under suspending time, oom killer is disabled.
> So, if the caller (probably drivers) call alloc >1000times, the system
> spent lots seconds.
> 
> In this case, GFP_NOIO doesn't help. slowness behavior is caused by
> freeable memory search, not slow i/o.
> 
> However, if strange i/o device makes any i/o slowness, GFP_NOIO might help.
> In this case, please don't ask me about i/o thing. I don't know ;)

OK, thanks for the explanation.

Rafael
