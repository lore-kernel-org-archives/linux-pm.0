From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 1 Jun 2010 00:17:13 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006010006320.2933__33362.911156337$1275344301$gmane$org@localhost.localdomain>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100527223605.GB11364@srcf.ucam.org>
	<20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>
	<20100528043114.GC26177@thunk.org>
	<1275030704.32462.11.camel@laptop>
	<AANLkTikEtlbkT4Ws3H2YGt_9QC46B5dr-b1oxJOcG4GN@mail.gmail.com>
	<1275120618.27810.12699.camel@twins>
	<1275149418.4503.128.camel@mulgrave.site>
	<alpine.LFD.2.00.1005312231120.2933@localhost.localdomain>
	<1275340869.2823.344.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275340869.2823.344.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon, 31 May 2010, James Bottomley wrote:

> On Mon, 2010-05-31 at 22:49 +0200, Thomas Gleixner wrote:
> > On Sat, 29 May 2010, James Bottomley wrote:
> > > The job of the kernel is to accommodate hardware as best it can ...
> > > sometimes it might not be able to, but most of the time it does a pretty
> > > good job.
> > > 
> > > The facts are that C states and S states are different and are entered
> > > differently. 
> > 
> > That's an x86'ism which is going away. And that's really completely
> > irrelevant for the mobile device space. Can we please stop trying to
> > fix todays x86 based laptop problems? They are simply not fixable.
> 
> You're the one mentioning x86, not me.  I already explained that some
> MSM hardware (the G1 for example) has lower power consumption in S3
> (which I'm using as an ACPI shorthand for suspend to ram) than any
> suspend from idle C state.

Those machines can go from idle into S2RAM just fine w/o touching the
/sys/power/state S2RAM mechanism.

It's just a deeper "C" state, really.

The confusion is that S3 is considered to be a complete different
mechanism - which is true for PC style x86 - but not relevant for
hardware which is sane from the PM point of view.

Now some people think, that suspend blockers are a cure for the
existing x86/ACPI/BIOS mess, which cannot go to S3 from idle, but
that's simply not feasible.

Thanks,

	tglx
