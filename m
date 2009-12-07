From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 13:41:50 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912071337020.3560__32487.0990742513$1260222163$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912071610520.15701-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912071610520.15701-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 7 Dec 2009, Alan Stern wrote:
> 
> It only seems that way because you didn't take into account devices 
> that suspend synchronously but whose children suspend asynchronously.

But why would I care? If somebody suspends synchronously, then that's what 
he wants.

> A synchronous suspend routine for a device with async child suspends
> would have to look just like your usb_node_suspend():

Sure. But that sounds like a "Doctor, it hurts when I do this" situation. 
Don't do that.

Make the USB host controller do its suspend asynchronously. We don't 
suspend PCI bridges anyway, iirc (but I didn't actually check). And at 
worst, we can make the PCI _bridges_ know about async suspends, and solve 
it that way - without actually making any normal PCI drivers do it.

		Linus
