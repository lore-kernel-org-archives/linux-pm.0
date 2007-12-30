From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Hibernation: Document
	__save_processor_state() on x86-64
Date: Sun, 30 Dec 2007 23:37:23 +0100
Message-ID: <200712302337.23896.rjw__2157.14415903694$1199053149$gmane$org@sisk.pl>
References: <200712281353.37976.rjw@sisk.pl> <200712302308.51562.rjw@sisk.pl>
	<20071230215745.GB31386@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071230215745.GB31386@elte.hu>
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
> > > what's exactly in the hibernation image? Dirty data i suppose
> > 
> > No, everything, including the kernel code, page tables etc. :-)
> > 
> > > - but what about kernel-internal pages. What if we go from SLAB to 
> > > SLUB? What if the size of a structure changes? Etc.
> > 
> > We can go from SLAB to SLUB just fine, it doesn't matter.  The only 
> > thing that matters is we have to jump to the right address at the end 
> > of core_restore_code() (defined in arch/x86/kernel/suspend_asm_64.S).
> 
> ok, just to make sure we are talking about the same thing. Do you mean 
> we can restore an image saved by v2.6.12 into v2.6.24? I.e. a 2.6.24 
> kernel will be able to run a 2.6.12 kernel's hibernation image, with all 
> the kernel internal data from v2.6.12, etc? No way can that work.

Well, not exactly.  The support for different boot and image kernels has
only been merged recently, but we can use the current git to restore
2.6.24-rc6-mm1, for example.

The trick is to pass a little additional information in the image header
that can be used by the boot kernel to locate the entry point to the image
kernel and the image kernel's page tables.

Rafael
