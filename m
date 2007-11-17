From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: apm emulation driver broken ?
Date: Sat, 17 Nov 2007 12:09:07 +0100
Message-ID: <200711171209.09985.rjw__46651.5498505489$1195296787$gmane$org@sisk.pl>
References: <cda58cb80711160706l2cfac2b1p81c7a1090f228f2e@mail.gmail.com>
	<473EAC1A.1000205@gmail.com> <200711171059.57462.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711171059.57462.rjw@sisk.pl>
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
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 17 of November 2007, Rafael J. Wysocki wrote:
> On Saturday, 17 of November 2007, Franck Bui-Huu wrote:
> > Rafael J. Wysocki wrote:
> > > However, using PF_NOFREEZE to prevent this from happening doesn't seem to be
> > > a good idea.
> > > 
> > 
> > Indeed but...
> > 
> > > I'd probably use wait_event_freezable() (defined in
> > > include/linux/freezer.h) for that.
> > 
> > ...I would just revert this bits from now to make sure this driver
> > work again for v2.6.24.
> 
> I'd prefer not to.
> 
> The PF_NOFREEZE was not present in 2.6.23 already and I wouldn't like to
> reintroduce it now.
> 
> Why do you think that using wait_event_freezable() would not work, BTW?
> 
> > > It tries to send them fake signals and waits for them to freeze.  If
> > > they don't freeze within the timeout, it fails and clears their
> > > TIF_FREEZE bits.
> > 
> > But send_fake_signal() seems to wake up task in INTERRUPTIBLE state
> > only. Looking at signal_wake_up(), it basically do:
> > 
> > 	wake_up_state(t, TASK_INTERRUPTIBLE);
> > 
> > What am I missing ?
> 
> Nothing. :-)
> 
> I didn't remember the change that made the freezer use TASK_INTERRUPTIBLE
> explicitly in there (should have looked at the current code before replying).

Actually, not even that one.  You're right anyway.

Below is a patch that IMO should fix the issue with apm_ioctl().

Greetings,
Rafael


---
From: Rafael J. Wysocki <rjw@sisk.pl>

The code in apm_ioctl() allows user space tasks waiting for a suspend to
complete to be woken up prematurely as a result of the thawing of tasks carried
out by the freezer.  Fix it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/char/apm-emulation.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/char/apm-emulation.c
===================================================================
--- linux-2.6.orig/drivers/char/apm-emulation.c
+++ linux-2.6/drivers/char/apm-emulation.c
@@ -364,7 +364,7 @@ apm_ioctl(struct inode * inode, struct f
 			 */
 			flags = current->flags;
 
-			wait_event_interruptible(apm_suspend_waitqueue,
+			wait_event_freezable(apm_suspend_waitqueue,
 					 as->suspend_state == SUSPEND_DONE);
 		}
 
