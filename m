From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] mm: Add __GFP_NO_OOM_KILL flag
Date: Thu, 7 May 2009 20:09:52 +0200
Message-ID: <200905072009.53406.rjw__5733.79398924789$1241720052$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905060120.35698.rjw@sisk.pl>
	<20090505164028.e9d807a1.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090505164028.e9d807a1.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kernel-testers@vger.kernel.org, rientjes@google.com, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, linux-pm@lists.linux-foundation.org, fengguang.wu@intel.com, torvalds@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 06 May 2009, Andrew Morton wrote:
> On Wed, 6 May 2009 01:20:34 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Wednesday 06 May 2009, Andrew Morton wrote:
> > > On Wed, 6 May 2009 00:19:35 +0200
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > > > +			&& !processes_are_frozen()) {
> > > > > >  		if (!try_set_zone_oom(zonelist, gfp_mask)) {
> > > > > >  			schedule_timeout_uninterruptible(1);
> > > > > >  			goto restart;
> > > > > 
> > > > > Cool, that looks like the semantics of __GFP_NO_OOM_KILL without requiring 
> > > > > a new gfp flag.  Thanks.
> > > > 
> > > > Well, you're welcome.
> > > > 
> > > > BTW, I think that Andrew was actually right when he asked if I checked whether
> > > > the existing __GFP_NORETRY would work as-is for __GFP_FS set and
> > > > __GFP_NORETRY unset.  Namely, in that case we never reach the code before
> > > > nopage: that checks __GFP_NORETRY, do we?
> > > > 
> > > > So I think we shouldn't modify the 'else if' condition above and check for
> > > > !processes_are_frozen() at the beginning of the block below.
> > > 
> > > Confused.
> > > 
> > > I'm suspecting that hibernation can allocate its pages with
> > > __GFP_FS|__GFP_WAIT|__GFP_NORETRY|__GFP_NOWARN, and the page allocator
> > > will dtrt: no oom-killings.
> > > 
> > > In which case, processes_are_frozen() is not needed at all?
> > 
> > __GFP_NORETRY alone causes it to fail relatively quickly, but I'll try with
> > the combination.
> 
> OK.  __GFP_WAIT is the big hammer.

Unfortunately it fails too quickly with the combination as well, so it looks
like we can't use __GFP_NORETRY during hibernation.
