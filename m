From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [uclinux-dist-devel] freezer: should barriers be smp
 ?
Date: Wed, 13 Apr 2011 18:11:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104131805090.2005-100000__47613.4880599149$1302732843$gmane$org@iolanthe.rowland.org>
References: <201104132353.09282.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104132353.09282.rjw@sisk.pl>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-pm@lists.linux-foundation.org, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Apr 2011, Rafael J. Wysocki wrote:

> The above means that smp_*mb() are defined as *mb() if CONFIG_SMP is set,
> which basically means that *mb() are more restrictive than the corresponding
> smp_*mb().  More precisely, they also cover the cases in which the CPU
> reorders instructions on uniprocessor, which we definitely want to cover.
> 
> IOW, your patch would break things on uniprocessor where the CPU reorders
> instructions.

How could anything break on a UP system?  CPUs don't reorder 
instructions that drastically.  For example, no CPU will ever violate
this assertion:

	x = 0;
	y = x;
	x = 1;
	assert(y == 0);

even if it does reorder the second and third statements internally.  
This is guaranteed by the C language specification.

> > Documentation/memory-barriers.txt:
> > SMP memory barriers are reduced to compiler barriers on uniprocessor compiled
> > systems because it is assumed that a CPU will appear to be self-consistent,
> > and will order overlapping accesses correctly with respect to itself.
> 
> Exactly, which is not guaranteed in general (e.g. on Alpha).  That is, some
> CPUs can reorder instructions in such a way that a compiler barrier is not
> sufficient to prevent breakage.

I don't think this is right.  You _can_ assume that Alphas appear to be
self-consistent.  If they didn't, you wouldn't be able to use them at
all.

Alan Stern
