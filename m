From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Sun, 17 Jan 2010 14:27:27 +0100
Message-ID: <201001171427.27954.rjw__41327.043870888$1263734903$gmane$org@sisk.pl>
References: <1263549544.3112.10.camel@maxim-laptop>
	<201001170138.37283.rjw@sisk.pl>
	<201001170224.36267.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001170224.36267.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 17 January 2010, Oliver Neukum wrote:
> Am Sonntag, 17. Januar 2010 01:38:37 schrieb Rafael J. Wysocki:
> > > Now having said that, we've been considering a change that will turn all
> > > GFP_KERNEL allocations into GFP_NOIO during suspend/resume, so perhaps I'll
> > > prepare a patch to do that and let's see what people think.
> > 
> > If I didn't confuse anything (which is likely, because it's a bit late here
> > now), the patch below should do the trick.  I have only checked that it doesn't
> > break compilation, so please take it with a grain of salt.
> > 
> > Comments welcome.
> 
> I think this is a bad idea as it makes the mm subsystem behave differently
> in the runtime and in the whole system cases.

s/runtime/suspend/ ?

Yes it will, but why exactly shouldn't it?  System suspend/resume _is_ a
special situation anyway.

> What's so hard about telling people that they need to use GFP_NOIO in
> suspend() and resume()?

Memory allocations are made for other purposes during suspend/resume too.  For
example, new kernel threads may be created (for async suspend/resume among
other things).

Besides, the fact that you tell people to do something doesn't necessary imply
that they will listen. :-)

I have discussed that with Ben for a couple of times and we have generally
agreed that memory allocation problems during suspend/resume are not avoidable
in general unless we disable __GFP_FS and __GFP_IO at the high level.

Rafael
