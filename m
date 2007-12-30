From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Hibernation: Document
	__save_processor_state() on x86-64
Date: Sun, 30 Dec 2007 22:31:26 +0100
Message-ID: <20071230213126.GB14654__15904.7674773776$1199050384$gmane$org@elte.hu>
References: <200712281353.37976.rjw@sisk.pl> <200712302204.56977.rjw@sisk.pl>
	<20071230205104.GB26120@elte.hu> <200712302248.03567.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200712302248.03567.rjw@sisk.pl>
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
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > how different can it be, for resume to work? I mean, we'll have 
> > deeply kernel version dependent variables in RAM. Am i missing 
> > something obvious?
> 
> On x86-64 it can be almost totally different (by restoring a 
> hibernation image we replace the entire contents of RAM with almost no 
> constraints).
> 
> [Well, using a relocatable kernel for restoring an image with 
> nonrelocatable one or vice versa is rather not the best idea, but 
> everything else should work in theory.]
> 
> On i386 the boot kernel is still required to be the same as the one in 
> the image.

what's exactly in the hibernation image? Dirty data i suppose - but what 
about kernel-internal pages. What if we go from SLAB to SLUB? What if 
the size of a structure changes? Etc.

	Ingo
