From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 2 Jun 2010 23:58:37 -0700
Message-ID: <AANLkTinxP73uOG4XtnTtS1LZnWDvvgpAFN5Uv_xdKEwk__26810.0912952379$1275548375$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.1005271141410.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1005271751240.3032@localhost.localdomain>
	<20100603042403.GC20028@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100603042403.GC20028@linux-sh.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 2, 2010 at 9:24 PM, Paul Mundt <lethal@linux-sh.org> wrote:
>
> On the other hand, while this isn't that difficult for the UP case it
> does pose more problems for the SMP case. Presently the suspend paths
> (suspend-to-RAM/hibernate/kexec jump) all deal with disabling and
> enabling of non-boot CPUs via CPU hotplug explicitly, which will clear
> them from the online CPU map. We would have to rework the semantics a bit
> if cpuidle were also permitted to opportunistically offline CPUs.

That's definitely something we'd be interested in looking at.  Some
upcoming ARM v7 architecture SMP SoCs we're seeing will support full
independent clock scaling and power gating for the individual cores --
if there's not enough work to keep the 2nd (or nth) cpu busy, there
would be good power savings to be had shutting it down.

I haven't poked around too much with how things work in SMP
environments -- are there per-cpu idle threads?

Brian
