From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC,PATCHv3 0/3] sdhci runtime_pm implementation
Date: Tue, 1 Mar 2011 22:07:22 +0100
Message-ID: <201103012207.22798.rjw__13928.6793805242$1299013895$gmane$org@sisk.pl>
References: <cover.1298820825.git.tardyp@gmail.com>
	<Pine.LNX.4.44L0.1103011431400.2034-100000@iolanthe.rowland.org>
	<AANLkTi=ogThxB_2bxANV4hUsLGZs04gzHSCyH90Bm87U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=ogThxB_2bxANV4hUsLGZs04gzHSCyH90Bm87U@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 01, 2011, Pierre Tardy wrote:
> On Tue, Mar 1, 2011 at 8:33 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Tue, 1 Mar 2011, Pierre Tardy wrote:
> >
> >> Please find sdhci runtime_pm implementation.
> >>
> >> It uses clock gating fw as a tip to know when our chip is idle.
> >> It implements wake up from card insertion/removal.
> >>
> >> This is RFC, please dont merge yet. I really would like to have deep review
> >> from PCI linux-pm guys.
> >>
> >> Opens are:
> >>
> >> 1/ Not sure if the pci configs in the driver in rpm_suspend/resume flow
> >>  are not duplicate from what the core is doing.
> >
> > There may be one or two small errors.
> >
> >> 2/ Wakeup from D3hot: I cannot find any driver that is implementing it in current upstream,
> >
> > Other drivers do it, but they use PCI PME# instead of interrupts.
> Could you please elaborate?
> My understanding is that PCI PME will generate MSI, which translate in
> interrupt.

Your driver won't get those interrupts.

How it works is, basically, that when the device signals wakeup, it either
causes a PME# signal to be raised (parallel PCI), or a PME Message to be
sent upstream (PCIe).  In the first case it will cause a platform event
(eg. ACPI GPE) to occur and the handle of that event will resume your
device (using pm_request_resume()).  In the second case it will cause the PCIe
root port handling the PME Message to generate an interrupt and the handler of
that interrupt will resume your device.

And this is a good reason why your driver shouldn't touch the PCI-specific
part of suspend/resume handling (it may not really know what it's doing).

In fact, there are a few drivers in the tree using this mechanism already
(r8169, e1000e, i believe PCI HCDs too).

Thanks,
Rafael
