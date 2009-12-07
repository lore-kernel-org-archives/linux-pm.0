From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 18:16:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912071811300.15701-100000__4519.84883188761$1260227924$gmane$org@iolanthe.rowland.org>
References: <alpine.LFD.2.00.0912071426100.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912071426100.3560@localhost.localdomain>
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

> 
> 
> On Mon, 7 Dec 2009, Alan Stern wrote:
> > 
> > There's no need to suspend the individual devices when the whole system 
> > is going down.  They will automatically suspend when the controller 
> > stops sending out SOF packets, which occurs when the root hub is 
> > suspended.  The USB spec describes this, grandiosely, as a "global 
> > suspend".
> 
> Ahh, but the sync vs async would then still matter on resume. No?

That's complicated.  If we assume the devices weren't runtime-suspended 
before the sleep began, then they would automatically resume themselves 
when the controller started transmitting EOF packets.  So in that case 
resume would be fast and async wouldn't matter.

But if the devices were runtime-suspended, then what?  The safest
course is to resume them during the system-wide resume.  In that case
yes, the sync vs async would matter.

And if (as happens on many machines) the firmware messes up the
controller settings during resume, then all the USB devices would have
to be reset -- another slow procedure.

Alan Stern
