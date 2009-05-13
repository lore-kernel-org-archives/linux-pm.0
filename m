From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 4/6] PM/Hibernate: Rework shrinking of memory
Date: Wed, 13 May 2009 23:56:38 +0200
Message-ID: <200905132356.39481.rjw__9616.39078236676$1242251917$gmane$org@sisk.pl>
References: <200905070040.08561.rjw@sisk.pl> <200905132255.04681.rjw@sisk.pl>
	<20090513141647.076b67f0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090513141647.076b67f0.akpm@linux-foundation.org>
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
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com, linux-pm@lists.linux-foundation.org, fengguang.wu@intel.com
List-Id: linux-pm@vger.kernel.org

On Wednesday 13 May 2009, Andrew Morton wrote:
> On Wed, 13 May 2009 22:55:03 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Wednesday 13 May 2009, Andrew Morton wrote:
> > > On Wed, 13 May 2009 10:39:25 +0200
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > Rework swsusp_shrink_memory() so that it calls shrink_all_memory()
> > > > just once to make some room for the image and then allocates memory
> > > > to apply more pressure to the memory management subsystem, if
> > > > necessary.
> > > > 
> > > > Unfortunately, we don't seem to be able to drop shrink_all_memory()
> > > > entirely just yet, because that would lead to huge performance
> > > > regressions in some test cases.
> > > > 
> > > 
> > > Isn't this a somewhat large problem?
> > 
> > Yes, it is.  The thing is 8 times slower (15 s vs 2 s) without the
> > shrink_all_memory() in at least one test case.  100% reproducible.
> 
> erk.  Any ideas why?

The swapping out things appears to be too slow.  Actually, no wonder, as it is
done one page at a time, while it looks like shrink_all_memory() appears to
make them swap out in big chunks.

> A quick peek at a kernel profile and perhaps the before-and-after delta in
> the /proc/vmstat numbers would probably guide us there.

I'm planning to do some investigation on that later.

> > > The main point (I thought) was to remove shrink_all_memory().  Instead,
> > > we're retaining it and adding even more stuff?
> > 
> > The idea is that afterwards we can drop shrink_all_memory() once the
> > performance problem has been resolved.  Also, we now allocate memory for the
> > image using GFP_KERNEL instead of doing it with GFP_ATOMIC after freezing
> > devices.  I'd think that's an improvement?
> 
> Dunno.  GFP_KERNEL might attempt to do writeback/swapout/etc, which
> could be embarrassing if the devices are frozen.

They aren't, because the preallocation is done upfront, so once the OOM killer
has been taken care of, it's totally safe. :-)
