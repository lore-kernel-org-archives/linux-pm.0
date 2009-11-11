From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GPF in
 run_workqueue()/list_del_init(cwq->worklist.next) on resume (was: Re: Help
 needed: Resume problems in 2.6.32-rc,
 perhaps related to preempt_count leakage in keventd)
Date: Wed, 11 Nov 2009 12:25:54 -0800 (PST)
Message-ID: <alpine.LFD.2.01.0911111222400.31845@localhost.localdomain>
References: <200911091250.31626.rjw@sisk.pl> <200911100119.38019.rjw@sisk.pl>
	<alpine.LFD.2.01.0911101343590.31845@localhost.localdomain>
	<200911111252.48214.rjw@sisk.pl>
	<alpine.LFD.2.01.0911111142340.31845@localhost.localdomain>
	<1257970719.21467.4.camel@violet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1257970719.21467.4.camel@violet>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg KH <gregkh@suse.de>, linux-bluetooth@vger.kernel.org, Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 11 Nov 2009, Marcel Holtmann wrote:
> 
> As it seems the btusb_close() only cancels the work workqueue and not
> the waker workqueue. Could that be the problem.

It's the waker workqueue that Rafael apparently sees with the debug patch 
from Oleg, so yeah, that sounds possible.

Rafael, since apparently htusb_close() _is_ called, does the following 
simpler patch fix it for you? I bet your patch does it too.

		Linus

---
 drivers/bluetooth/btusb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7ba91aa..2fb3802 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -591,6 +591,7 @@ static int btusb_close(struct hci_dev *hdev)
 		return 0;
 
 	cancel_work_sync(&data->work);
+	cancel_work_sync(&data->waker);
 
 	clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
 	clear_bit(BTUSB_BULK_RUNNING, &data->flags);
