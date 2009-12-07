From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 17:21:36 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912071716080.15701-100000__7860.7355979786$1260224632$gmane$org@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912071403520.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912071403520.3560@localhost.localdomain>
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

> I also suspect that even if you do the USB host controller suspend 
> synchronously, doing the actual USB devices asynchronously would still 
> help - even if it's only "asynchronously per bus" thing. 
> 
> So in fact, it's probably a good first step to start off doing only the 
> USB devices, not the controller.

Interesting you should say that.  The patch I asked Arjan to test 
involved not suspending USB devices at all (root hubs being the 
exception).  That is in fact just what we do when CONFIG_USB_SUSPEND 
isn't set.

There's no need to suspend the individual devices when the whole system 
is going down.  They will automatically suspend when the controller 
stops sending out SOF packets, which occurs when the root hub is 
suspended.  The USB spec describes this, grandiosely, as a "global 
suspend".

But yes, I agree.  Doing just the USB devices is a good first step.

Alan Stern
