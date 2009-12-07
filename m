From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 17:01:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912071652040.15701-100000__43590.2664009065$1260223355$gmane$org@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912071337020.3560@localhost.localdomain>
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

On Mon, 7 Dec 2009, Linus Torvalds wrote:

> On Mon, 7 Dec 2009, Alan Stern wrote:
> > 
> > It only seems that way because you didn't take into account devices 
> > that suspend synchronously but whose children suspend asynchronously.
> 
> But why would I care? If somebody suspends synchronously, then that's what 
> he wants.

It doesn't mean he wants to block unrelated devices from suspending 
asynchronously, merely because they happen to come earlier in the list.

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

This sounds suspiciously like pushing the problem up a level and 
hoping it will go away.  (Sometimes that even works.)

In the end it isn't a very big issue.  Using one vs. two passes in 
dpm_suspend() is pretty unimportant.

Alan Stern

P.S.: In fact I planned all along to handle USB host controllers 
asynchronously anyway, since their resume routines contain some long 
delays.  I was merely using them as an example.
