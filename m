From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Sun, 9 Mar 2008 14:50:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803091447090.13999-100000__6503.59293581477$1205088773$gmane$org@netrider.rowland.org>
References: <20080309151659.63d54f38@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080309151659.63d54f38@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 9 Mar 2008, Pierre Ossman wrote:

> I'm beginning to think this is a lost cause. I've tried several variants, all without satisfactory results.
> 
> In case anyone else has any more ideas, I'll detail what I've found influences the noise:
> 
> 1. C state
> 
> This is the big one. There is no noise as long as C3 is avoided (processor.max_cstate).
> 
> 2. uhci_hcd driver
> 
> USB is somehow involved in this problem. Unloading the uhci_hcd driver almost entirely kills the noise on a 1000 HZ NO_HZ kernel. On a 100 HZ, no NO_HZ kernel, the effect is very small, but still there.
> 
> 3. Low speed USB devices
> 
> Related, the noise goes away if I insert a USB mouse (low speed). A high-speed device does not effect the noise, neither does the two built-in low speed devices (a fingerprint reader and a bluetooth host).

The relation to UHCI probably has to do with ongoing DMA.  The amount
of DMA varies according to whether or not the USB devices are
suspended, whether or not they have drivers, and the speed at which 
they run.

You can test whether suspending the onboard USB devices changes 
anything.  See Documentation/usb/power-management.txt.

Alan Stern
