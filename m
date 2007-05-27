From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 3/3] PM: Disable _request_firmware
	before hibernation/suspend
Date: Sun, 27 May 2007 23:45:03 +0200
Message-ID: <200705272345.04518.rjw__46021.2693120868$1180302035$gmane$org@sisk.pl>
References: <200705272229.21263.rjw@sisk.pl> <200705272231.54535.rjw@sisk.pl>
	<20070527204955.GA22202@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070527204955.GA22202@srcf.ucam.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 27 May 2007 22:49, Matthew Garrett wrote:
> On Sun, May 27, 2007 at 10:31:53PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Use a hibernation and suspend notifier to disable the firmware requesting
> > mechanism before a hibernation/suspend and enable it after the operation.
> 
> This avoids the problem of .resume methods calling userspace while 
> userspace is frozen and a resulting hang, but does it actually result in 
> the drivers beginning to work again?

Well, this was acutally invented before you've decided to remove the freezing
of tasks from the suspend code path (which I think is a mistake, but that's
only my personal opinion, so it doesn't matter very much ;-)) and I regard it
as a workaround.

> If we remove process freezing in STR, this should just work[1] without the
> need to complicate things. 

Under the (optimistic, IMO) assumption that the relevant user space task won't
block on I/O with a suspended device involved or something like this.

BTW, I know of two subsystems that want their kernel threads to be frozen for
synchronization purposes.  Please see these messages:

1) https://lists.linux-foundation.org/pipermail/linux-pm/2007-May/012592.html
(plus follow up)

2) http://marc.info/?l=linux-kernel&m=117919066830575&w=2

Your patch breaks them and I suspect there are more cases like these.

Besides, there's the hibernation that needs to freeze tasks for another reason,
so it needs some way to ensure that drivers won't request firmware while
the user land is frozen.

> On the other hand, if we don't want to support these functions in the 
> suspend and resume methods we could just audit the kernel and remove 
> them all.

Yes, I think we should do this.

Greetings,
Rafael
