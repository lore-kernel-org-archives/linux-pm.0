From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC][PATCH] PM: Force GFP_NOIO during
	suspend/resume (was: Re: Memory allocations in .suspend
	became very unreliable)
Date: Tue, 19 Jan 2010 10:25:37 +0100
Message-ID: <201001191025.37579.oliver__3008.78076018325$1263893181$gmane$org@neukum.org>
References: <1263549544.3112.10.camel@maxim-laptop>
	<201001181800.38574.oliver@neukum.org>
	<201001182141.49907.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001182141.49907.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Montag, 18. Januar 2010 21:41:49 schrieb Rafael J. Wysocki:
> On Monday 18 January 2010, Oliver Neukum wrote:
> > Am Sonntag, 17. Januar 2010 14:55:55 schrieb Rafael J. Wysocki:
> > > +void mm_force_noio_allocations(void)
> > > +{
> > > +       /* Wait for all slowpath allocations using the old mask to complete */
> > > +       down_write(&gfp_allowed_mask_sem);
> > > +       saved_gfp_allowed_mask = gfp_allowed_mask;
> > > +       gfp_allowed_mask &= ~(__GFP_IO | __GFP_FS);
> > > +       up_write(&gfp_allowed_mask_sem);
> > > +}
> > 
> > In addition to this you probably want to exhaust all memory reserves
> > before you fail a memory allocation
> 
> I'm not really sure what you mean.

Forget it, it was foolish. Instead there's a different problem.
Suppose we are tight on memory. The problem is that we must not
exhaust all memory. If we are really out of memory we may be unable
to satisfy memory allocations in resume()

	Regards
		Oliver
