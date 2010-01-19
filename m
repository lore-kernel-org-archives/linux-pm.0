From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
 suspend/resume (was: Re: Memory allocations in .suspend became very
 unreliable)
Date: Tue, 19 Jan 2010 14:19:54 +1100
Message-ID: <1263871194.724.520.camel__22237.9008810551$1263871291$gmane$org@pasglop>
References: <20100118110324.AE30.A69D9226@jp.fujitsu.com>
	<201001182155.09727.rjw@sisk.pl>
	<20100119101101.5F2E.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100119101101.5F2E.A69D9226@jp.fujitsu.com>
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

On Tue, 2010-01-19 at 10:19 +0900, KOSAKI Motohiro wrote:
> I think the race happen itself is bad. memory and I/O subsystem can't solve such race
> elegantly. These doesn't know enough suspend state knowlege. I think the practical 
> solution is that higher level design prevent the race happen.
> 
> 
> > My patch attempts to avoid these two problems as well as the problem with
> > drivers using GFP_KERNEL allocations during suspend which I admit might be
> > solved by reworking the drivers.
> 
> Agreed. In this case, only drivers change can solve the issue. 

As I explained earlier, this is near to impossible since the allocations
are too often burried deep down the call stack or simply because the
driver doesn't know that we started suspending -another- driver...

I don't think trying to solve those problems at the driver level is
realistic to be honest. This is one of those things where we really just
need to make allocators 'just work' from a driver perspective.

It can't be perfect of course, as mentioned earlier, there will be a
problem if too little free memory is really available due to lots of
dirty pages around, but most of this can be somewhat alleviated in
practice, for example by pushing things out a bit at suspend time,
making some more memory free etc... But yeah, nothing replaces proper
error handling in drivers for allocation failures even with
GFP_KERNEL :-)

Cheers,
Ben.
