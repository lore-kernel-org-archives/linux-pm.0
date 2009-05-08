From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Fri, 8 May 2009 02:18:52 +0200
Message-ID: <200905080218.53142.rjw__44196.3390484036$1241742146$gmane$org@sisk.pl>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<1241739155.19600.233.camel@nigel-laptop>
	<20090507164334.0d3890ef@jbarnes-g45>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090507164334.0d3890ef@jbarnes-g45>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, Fabio Comolli <fabio.comolli@gmail.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

On Friday 08 May 2009, Jesse Barnes wrote:
> On Fri, 08 May 2009 09:32:34 +1000
> Nigel Cunningham <nigel@tuxonice.net> wrote:
> 
> > Hi.
> > 
> > On Thu, 2009-05-07 at 16:14 -0700, Jesse Barnes wrote:
> > > On Fri, 08 May 2009 06:41:00 +1000
> > > Nigel Cunningham <nigel@tuxonice.net> wrote:
> > > 
> > > > Hi.
> > > > 
> > > > On Thu, 2009-05-07 at 21:27 +0200, Rafael J. Wysocki wrote:
> > > > > In fact I agree, but there's a catch.  The way in which TuxOnIce
> > > > > operates LRU pages is based on some assumptions that may or may
> > > > > not be satisfied in future, so if we decide to merge it, then
> > > > > we'll have to make sure these assumptions will be satisfied.
> > > > > That in turn is going to require quite some discussion I guess.
> > > > 
> > > > Agreed. That's why I've got that GEMS patch - it's putting pages
> > > > on the LRU that don't satisfy the former assumptions: they are
> > > > used during hibernating and need to be atomically copied. If
> > > > there are further developments in that area, I would hope we
> > > > could just extend what's been done with GEMS.
> > > 
> > > Another option here would be to suspend all DRM operations earlier.
> > > The suspend hook for i915 already does this, but maybe it needs to
> > > happen sooner?  We'll probably want a generic DRM suspend hook soon
> > > too (as the radeon memory manager lands) to shut down GPU activity
> > > in the suspend and hibernate cases.
> > > 
> > > All that assumes I understand what's going on here though. :)  It
> > > appears you delay saving the GEM (just GEM by the way, for
> > > Graphics/GPU Execution Manager) backing store until late to avoid
> > > having the pages move around out from under you?
> > 
> > Yeah. TuxOnIce saves some pages without doing an atomic copy of them.
> > Up 'til now, the algorithm has been LRU pages - pages used for
> > TuxOnIce's userspace helpers. With GEM, we also need to make sure GEM
> > pages are atomically copied and so also 'subtract' them from the list
> > of pages that aren't atomically copied.
> > 
> > It's no great problem to do this, so I wouldn't ask you to change GEM
> > to suspend DRM operations earlier. It's more important that GEM
> > doesn't allocate extra pages unexpectedly - and I don't think that's
> > likely anyway since we've switched away from X. This is important
> > because TuxOnIce depends (for reliability) on having memory usage
> > being predictable much more than swsusp and uswsusp do. (Larger
> > images, less free RAM to begin with).
> 
> Yeah X is typically the one causing GEM allocations and performing
> execution, but there are other possibilities too.  E.g. Wayland is a
> non-X based display system that may be running instead, or maybe
> there's an EGL or GPGPU program running in the background.
> 
> So I think it's best if we suspend DRM fairly early, otherwise you
> *may* get extra allocations and will probably see all sorts of GPU
> memory mapping activity and execution while you're trying to hibernate
> things.  On the plus side I don't think this is a radical redesign or
> anything, and mostly something we can do in our suspend and hibernate
> callbacks.

I think hibernate callbacks are too late for that.  PM notifiers, OTOH, are
probably too early.

So, I really think we'll need to do something special about it.

Thanks,
Rafael
