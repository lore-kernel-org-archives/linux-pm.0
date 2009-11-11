From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GPF in
 run_workqueue()/list_del_init(cwq->worklist.next) on resume (was: Re: Help
 needed: Resume problems in 2.6.32-rc,
 perhaps related to preempt_count leakage in keventd)
Date: Wed, 11 Nov 2009 12:11:00 -0800 (PST)
Message-ID: <alpine.LFD.2.01.0911111202490.31845__26777.1581573927$1257970464$gmane$org@localhost.localdomain>
References: <200911091250.31626.rjw@sisk.pl>
	<alpine.LFD.2.01.0911101343590.31845@localhost.localdomain>
	<20091111161348.GA27394@redhat.com>
	<200911112100.16561.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911112100.16561.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Marcel Holtmann <marcel@holtmann.org>, Mike Galbraith <efault@gmx.de>, Oleg Nesterov <oleg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, linux-bluetooth@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 11 Nov 2009, Rafael J. Wysocki wrote:
> 
> I applied the patch and this is the result of 'dmesg | grep ERR' after 10-or-so
> consecutive suspend-resume and hibernate-resume cycles:
> 
> [  129.008689] ERR!! btusb_waker+0x0/0x27 [btusb]
> [  166.477373] ERR!! btusb_waker+0x0/0x27 [btusb]
> [  203.983665] ERR!! btusb_waker+0x0/0x27 [btusb]
> [  241.636547] ERR!! btusb_waker+0x0/0x27 [btusb]
> 
> which kind of confirms my previous observation that the problem was not
> reproducible without Bluetooth.

.. and that btusb thing matches my observation that only a few BT drivers 
seem to use workqueues, and btusb_disconnect() isn't doing any work 
cancel.

> I'm going to test the appended patch, then.

Hmm. the USB disconnect doesn't call hci_dev_put(), it calls 
hci_free_dev() and doesn't seem to call the ->destruct thing. 

Although again, maybe that gets called indirectly.

So I'd put the cancel work in the actual disconnect routine. But maybe 
thar's just me.

		Linus
