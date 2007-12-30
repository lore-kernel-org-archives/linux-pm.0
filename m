From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Hibernation: Document
	__save_processor_state() on x86-64
Date: Sun, 30 Dec 2007 23:08:50 +0100
Message-ID: <200712302308.51562.rjw__4677.48872838474$1199051439$gmane$org@sisk.pl>
References: <200712281353.37976.rjw@sisk.pl> <200712302248.03567.rjw@sisk.pl>
	<20071230213126.GB14654@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071230213126.GB14654@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 30 of December 2007, Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > > how different can it be, for resume to work? I mean, we'll have 
> > > deeply kernel version dependent variables in RAM. Am i missing 
> > > something obvious?
> > 
> > On x86-64 it can be almost totally different (by restoring a 
> > hibernation image we replace the entire contents of RAM with almost no 
> > constraints).
> > 
> > [Well, using a relocatable kernel for restoring an image with 
> > nonrelocatable one or vice versa is rather not the best idea, but 
> > everything else should work in theory.]
> > 
> > On i386 the boot kernel is still required to be the same as the one in 
> > the image.
> 
> what's exactly in the hibernation image? Dirty data i suppose

No, everything, including the kernel code, page tables etc. :-)

> - but what about kernel-internal pages. What if we go from SLAB to SLUB?
> What if the size of a structure changes? Etc.

We can go from SLAB to SLUB just fine, it doesn't matter.  The only thing
that matters is we have to jump to the right address at the end of
core_restore_code() (defined in arch/x86/kernel/suspend_asm_64.S).

Rafael
