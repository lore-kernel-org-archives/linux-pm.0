From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Tue, 1 Jul 2008 22:39:43 +0200
Message-ID: <200807012239.44105.rjw__48152.7989068583$1214944804$gmane$org@sisk.pl>
References: <200807010148.02135.rjw@sisk.pl> <20080701063133.GC16642@elte.hu>
	<4869D4A3.3020000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4869D4A3.3020000@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, kernel-testers@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 1 of July 2008, H. Peter Anvin wrote:
> Ingo Molnar wrote:
> > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > 
> >> Hi,
> >>
> >> The appended patch fixes a regression and is considered as 2.6.26 
> >> material. Everyone having a box with working suspend to RAM is gently 
> >> requested to test it and verify if it doesn't break things.
> >>
> >> The patch applies to the current -git.
> > 
> > it's been under testing in tip/out-of-tree for about a week:
> > 
> > | commit ee901dc1b9ab94a37ba2efc296fe9ba72bc75adf
> > | Author:     H. Peter Anvin <hpa@zytor.com>
> > | AuthorDate: Tue Jun 24 23:03:48 2008 +0200
> > | Commit:     Ingo Molnar <mingo@elte.hu>
> > | CommitDate: Wed Jun 25 18:48:13 2008 +0200
> > |
> > |     x86 ACPI: normalize segment descriptor register on resume
> > 
> > no problems caused by it so far.
> > 
> 
> Here is the incremental patch which should stick "strictly to the 
> script" of ljmp immediately after writing CR0.PE.  This should be done 
> to the boot code as well; I'm waiting for confirmation from the Elan 
> original reporter before submitting that patch.
> 
> I decided to make this an incremental patch to make it bisectable versus 
> the other one, however, it should probably be considered the right thing.
> 
> Note: I have not tested this beyond compilation, I'm afraid.

I have tested it on the nx6325 (64-bit) on top of the today's linux-next.  It
works fine for me.

Thanks,
Rafael
