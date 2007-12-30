From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Hibernation: Document
	__save_processor_state() on x86-64
Date: Sun, 30 Dec 2007 22:57:45 +0100
Message-ID: <20071230215745.GB31386@elte.hu>
References: <200712281353.37976.rjw@sisk.pl> <200712302248.03567.rjw@sisk.pl>
	<20071230213126.GB14654@elte.hu> <200712302308.51562.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200712302308.51562.rjw@sisk.pl>
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

> > what's exactly in the hibernation image? Dirty data i suppose
> 
> No, everything, including the kernel code, page tables etc. :-)
> 
> > - but what about kernel-internal pages. What if we go from SLAB to 
> > SLUB? What if the size of a structure changes? Etc.
> 
> We can go from SLAB to SLUB just fine, it doesn't matter.  The only 
> thing that matters is we have to jump to the right address at the end 
> of core_restore_code() (defined in arch/x86/kernel/suspend_asm_64.S).

ok, just to make sure we are talking about the same thing. Do you mean 
we can restore an image saved by v2.6.12 into v2.6.24? I.e. a 2.6.24 
kernel will be able to run a 2.6.12 kernel's hibernation image, with all 
the kernel internal data from v2.6.12, etc? No way can that work.

	Ingo
