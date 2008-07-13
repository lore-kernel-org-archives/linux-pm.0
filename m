From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Sun, 13 Jul 2008 22:32:00 +0200
Message-ID: <200807132232.01489.rjw__23840.9806545407$1215981165$gmane$org@sisk.pl>
References: <200807010148.02135.rjw@sisk.pl> <487A62B3.8010207@zytor.com>
	<487A63D2.9040006@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <487A63D2.9040006@firstfloor.org>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, public-kernel-testers-u79uwXL29TY76Z2rM5mHXA@lo.gmane.org, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 13 of July 2008, Andi Kleen wrote:
> H. Peter Anvin wrote:
> > Andi Kleen wrote:
> >>
> >> Hmm, but the change was not supposed to break the s3 bios. Something
> >> fishy is going on. It sounds like the s3 bios relies on some earlier
> >> segment register setup.
> >>
> >> If true this means the segment register reset would need to be moved
> >> later after S3 bios ran. Saving/restoring is unfortunately not possible
> >> because we cannot save/restore the hidden state loaded from the GDT
> >> earlier.
> >>
> > 
> > That really doesn't make sense, though.  The VESA BIOS has to be entered
> > in clean real mode; it's designed to be entered from reset, after all.
> > There is definitely something fishy going on, but I don't think this
> > particular aspect is it.
> 
> It probably switches to protected mode. I noticed this on my old
> Fujitsu laptop when I tried to make the S3 wakeup run in the s2ram x86 emulator
> and found it entered protected mode at some point, which x86emu
> didn't support.
> 
> I guess Lenovo is doing the same.
> 
> And that protected mode code relies on some GDT values that have been
> loaded earlier when the BIOS also went into protected mode.
> 
> It seems the BIOS programmers really don't like real mode anymore.
> Somehow understandable.

So should we check if we are in real mode at the entry point?

That would compilcate things a lot.

Thanks,
Rafael
