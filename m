From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/6] PM/Hibernate: Rework memory shrinking
	(rev. 3)
Date: Sun, 10 May 2009 15:48:56 +0200
Message-ID: <200905101548.57557.rjw__35481.8467902534$1241964923$gmane$org@sisk.pl>
References: <200905070040.08561.rjw@sisk.pl> <200905072348.59856.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905072348.59856.rjw@sisk.pl>
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
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Rientjes <rientjes@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 07 May 2009, Rafael J. Wysocki wrote:
> On Thursday 07 May 2009, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > The following patchset is an attempt to rework the memory shrinking mechanism
> > used during hibernation to make room for the image.  It is a work in progress
> > and most likely it's going to be modified, but it has been discussed recently
> > and I'd like to get comments on the current version.
> > 
> > [1/5] - disable the OOM kernel after freezing tasks (this will be dropped if
> >         it's verified that we can avoid the OOM killing by using
> >         __GFP_FS|__GFP_WAIT|__GFP_NORETRY|__GFP_NOWARN
> >         in the next patches).
> > 
> > [2/5] - drop memory shrinking from the suspend (to RAM) code path
> > 
> > [3/5] - move swsusp_shrink_memory() to snapshot.c
> > 
> > [4/5] - rework swsusp_shrink_memory() (to use memory allocations for applying
> >         memory pressure)
> > 
> > [5/5] - allocate image pages along with the shrinking.
> 
> Updated patchset follows.

I the meantime I added a patch that attempts to computer the size of the hard
core working set.  I also had to rework the patch reworking
swsusp_shrink_memory() so that it takes highmem into account.

Currently, the patchset consists of the following patches:

[1/6] - disable the OOM kernel after freezing tasks (this will be dropped if
        it's verified that we can avoid the OOM killing by using
        __GFP_FS|__GFP_WAIT|__GFP_NORETRY|__GFP_NOWARN
        in the next patches).

[2/6] - drop memory shrinking from the suspend (to RAM) code path

[3/6] - move swsusp_shrink_memory() to snapshot.c

[4/6] - rework swsusp_shrink_memory() (to use memory allocations for applying
        memory pressure)

[5/6] - allocate image pages along with the shrinking

[6/6] - estimate the size of the hard core working set and use it as the lower
        limit of the image size.

Comments welcome.

Thanks,
Rafael
