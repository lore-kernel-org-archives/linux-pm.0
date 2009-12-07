From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 23:02:57 +0100
Message-ID: <200912072302.57318.rjw__12475.9785518565$1260223394$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912071610520.15701-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0912071337020.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912071337020.3560@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 07 December 2009, Linus Torvalds wrote:
> 
> On Mon, 7 Dec 2009, Alan Stern wrote:
> > 
> > It only seems that way because you didn't take into account devices 
> > that suspend synchronously but whose children suspend asynchronously.
> 
> But why would I care? If somebody suspends synchronously, then that's what 
> he wants.
> 
> > A synchronous suspend routine for a device with async child suspends
> > would have to look just like your usb_node_suspend():
> 
> Sure. But that sounds like a "Doctor, it hurts when I do this" situation. 
> Don't do that.
> 
> Make the USB host controller do its suspend asynchronously. We don't 
> suspend PCI bridges anyway, iirc (but I didn't actually check). And at 
> worst, we can make the PCI _bridges_ know about async suspends, and solve 
> it that way - without actually making any normal PCI drivers do it.

BTW, I still don't quite understand why not to put the parent's down_write
operation into the core.  It's not going to hurt for the "synchronous" devices
and the "asynchronous" ones will need to do it anyway.

Also it looks like that's something to do unconditionally for all nodes
having children, because the parent need not know if the children do async
operations.

Rafael
