From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
Subject: Re: [PATCH] Hibernation: Document
	__save_processor_state() on x86-64
Date: Mon, 31 Dec 2007 10:29:10 +0100
Message-ID: <64bb37e0712310129s5b03b490wc1a8a4f9ec9da529__47285.4073196233$1199122005$gmane$org@mail.gmail.com>
References: <200712281353.37976.rjw@sisk.pl> <200712302248.03567.rjw@sisk.pl>
	<20071230213126.GB14654@elte.hu> <200712302308.51562.rjw@sisk.pl>
	<20071230215745.GB31386@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Dec 30, 2007 10:57 PM, Ingo Molnar <mingo@elte.hu> wrote:
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

I suspect here is a slight misunderstanding: It will never be possible
to switch a kernel with a hibernation/resume cycle.
The new thing is, that you can use a 2.6.24-SLUB-kernel to load a
2.6.12-SLAB-kernel(*) and then have the *2.6.12* kernel continue to
run.

The jump that Rafael talks about is a complete switchover from the
kernel doing the resume to the old kernel (and all of its data
structures) from the hibernation image. The now again running old
kernel will discard any internal data from the resuming kernel and so
it is not important if there was a SLAB vs SLUB difference.

In some way you could see the kernel loading the image as a gigantic
bootloader and just as is does not matter if you use lilo or grub it
should no longer matter what bootloader/kernel was used for resuming,
now that a ABI for the resume has been defined.

Torsten

(*): 2.6.12 might not work, as Rafael said the feature supporting
different kernel versions was only merge recently.
