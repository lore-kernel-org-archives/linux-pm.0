From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] PM/Hibernate: Use memory allocations to
	free memory
Date: Sat, 2 May 2009 10:49:47 -0700
Message-ID: <20090502104947.2720f173.akpm__48588.241733569$1241287168$gmane$org@linux-foundation.org>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905020029.39181.rjw@sisk.pl>
	<20090501161423.94b37d5b.akpm@linux-foundation.org>
	<200905021346.34967.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905021346.34967.rjw@sisk.pl>
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

On Sat, 2 May 2009 13:46:34 +0200 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > Do we need the bitmap?  I expect we can just string all these pages
> > onto a local list via page.lru.  Would need to check that - the
> > pageframe fields are quite overloaded.
> 
> This is the reason why we use the bitmaps for hibernation. :-)

grep the tree for page->lru and you'll see that quite a few page
consumers are using it.  So you'd be pretty safe doing it this way.

Whether it's _worth_ doing it this way is debatable, given that
hibernation uses bitmaps elsewhere.  But it would shrink the patch a
bit I expect?
