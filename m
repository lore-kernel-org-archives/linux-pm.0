From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Re: [RFC][PATCH 4/5] PM/Hibernate: Rework shrinking of
	memory
Date: Fri, 08 May 2009 06:53:14 +1000
Message-ID: <1241729594.19600.219.camel__537.452850449149$1241729768$gmane$org@nigel-laptop>
References: <200905070040.08561.rjw@sisk.pl>
	<1241652436.19600.176.camel@nigel-laptop>
	<200905071418.05035.rjw@sisk.pl> <200905072200.30777.rjw@sisk.pl>
Reply-To: nigel@tuxonice.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905072200.30777.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi.

On Thu, 2009-05-07 at 22:00 +0200, Rafael J. Wysocki wrote:
> On Thursday 07 May 2009, Rafael J. Wysocki wrote:
> > On Thursday 07 May 2009, Nigel Cunningham wrote:
> > > Hi.
> > 
> > Hi,
> > 
> > > On Thu, 2009-05-07 at 00:44 +0200, Rafael J. Wysocki wrote:
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
> > > 
> > > I know it doesn't fit with your current way of doing things, but have
> > > you considered trying larger order allocations as a means of getting
> > > memory freed?
> > 
> > Actually, I was thinking about that.  What's your experience with this
> > approach?
> > 
> > > I have code in tuxonice_prepare_image.c (look for extra_pages_allocated) that
> > > might be helpful for this purpose.
> > 
> > OK, thanks.  I'll have a look at it.
> 
> I have tried it, but the results are even worse than with 0-order allocations
> only.
> 
> So far, I have got the best results with shrink_all_memory() called once and
> followed by allocating as much memory as we want to be free using 0-order
> allocations.  Like in this patch. :-)

Hmm. That's surprising. It would be interesting to look at what's going
on. Unfortunately, I just don't have the time at the moment to help.

Regards,

Nigel
