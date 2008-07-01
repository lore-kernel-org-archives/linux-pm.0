From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Tue, 1 Jul 2008 09:45:47 +0200
Message-ID: <20080701074547.GA16262__28163.3965940729$1214898517$gmane$org@elte.hu>
References: <200807010148.02135.rjw@sisk.pl> <20080701072024.GB26601@elte.hu>
	<20080701002856.2457a75d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080701002856.2457a75d.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, pm list <linux-pm@lists.linux-foundation.org>, kernel-testers@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org


* Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 1 Jul 2008 09:20:24 +0200 Ingo Molnar <mingo@elte.hu> wrote:
> 
> > * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > 
> > > Hi,
> > > 
> > > The appended patch fixes a regression and is considered as 2.6.26 
> > > material. Everyone having a box with working suspend to RAM is gently 
> > > requested to test it and verify if it doesn't break things.
> > > 
> > > The patch applies to the current -git.
> > 
> > The fix is _really_ tempting, but i think it's 2.6.26.1 material at the 
> > earliest. I just counted about 8 red flag items in that commit:
> > 
> >   - "assembly code"
> >   - "fresh change"
> >   - "suspend/resume"
> >   - "real-mode code"
> >   - "ACPI"
> >   - "SMM"
> >   - "CPU erratas"
> >   - "boot code"
> > 
> > I'd say it's probably 90% fine, but it's just too much risk at this 
> > stage i think. The regression was only found 2 weeks ago, and the commit 
> > that broke it was upstream for 2 months (and was under testing for about 
> > 4 months).
> 
> Merge it into 2.6.27-rc1 and add Cc: <stable@kernel.org> to the changelog with
> a note "needed in 2.6.26.x after a couple of weeks testing in mainline" or
> something like that.

ok.

> I expect 2.6.25.x will be maintained for a while yet too...

2.6.25.x is not affected by the suspend+resume aspect of this problem.

	Ingo
