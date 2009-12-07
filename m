From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 14:06:59 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912071403520.3560__4598.44431975416$1260223677$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912071652040.15701-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912071652040.15701-100000@iolanthe.rowland.org>
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
> > 
> > Make the USB host controller do its suspend asynchronously. We don't 
> > suspend PCI bridges anyway, iirc (but I didn't actually check). And at 
> > worst, we can make the PCI _bridges_ know about async suspends, and solve 
> > it that way - without actually making any normal PCI drivers do it.
> 
> This sounds suspiciously like pushing the problem up a level and 
> hoping it will go away.  (Sometimes that even works.)

The "we don't suspend bridges anyway" is definitely a "hoping it will go 
away" issue. I think we did suspend bridges for a short while during the 
PM switch-over some time ago, and it worked most of the time, and then on 
some machines it just didn't work at all. Probably because ACPI ends up 
touching registers behind bridges that we closed down etc.

So PCI bridges are kind of special. Right now we don't touch them, and if 
we ever do, that will be another issue.

> In the end it isn't a very big issue.  Using one vs. two passes in 
> dpm_suspend() is pretty unimportant.

I also suspect that even if you do the USB host controller suspend 
synchronously, doing the actual USB devices asynchronously would still 
help - even if it's only "asynchronously per bus" thing. 

So in fact, it's probably a good first step to start off doing only the 
USB devices, not the controller.

		Linus
