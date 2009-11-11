From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: GPF in
	run_workqueue()/list_del_init(cwq->worklist.next) on resume
	(was: Re: Help needed: Resume problems in 2.6.32-rc,
	perhaps related to preempt_count leakage in keventd)
Date: Wed, 11 Nov 2009 12:52:48 +0100
Message-ID: <200911111252.48214.rjw__2025.50150356746$1257940396$gmane$org@sisk.pl>
References: <200911091250.31626.rjw@sisk.pl> <200911100119.38019.rjw@sisk.pl>
	<alpine.LFD.2.01.0911101343590.31845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.01.0911101343590.31845@localhost.localdomain>
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
Cc: Mike Galbraith <efault@gmx.de>, Marcel Holtmann <marcel@holtmann.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, linux-bluetooth@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 10 November 2009, Linus Torvalds wrote:
> 
...
> 
> So I don't know, but it might be worthwhile to see if the problem goes 
> away if you disable sound. Just to narrow down what has changed.

I thought that the problem was somehow related to user space, because it only
happens after we've thawed tasks.  At least, all of the call traces I was able
to collect indicated so.

Moreover, in a few cases I got

kernel: PM: Finishing wakeup.
kernel: Restarting tasks ...
kernel: usb 5-2: USB disconnect, address 2
kernel: done.
bluetoothd[3445]: HCI dev 0 unregistered
bluetoothd[3445]: Unregister path: /org/bluez/3445/hci0
bluetoothd[3445]: Unregistered interface org.bluez.NetworkPeer on path /org/bluez/3445/hci0
bluetoothd[3445]: Unregistered interface org.bluez.NetworkHub on path /org/bluez/3445/hci0
bluetoothd[3445]: Unregistered interface org.bluez.NetworkRouter on path /org/bluez/3445/hci0
kernel: Slab corruption: size-512 start=ffff88007f1182b0, len=512

and so on (of course, the bluetoothd PID was different each time), so I thought
that the problem might be related to Bluetooth.

So, I've disabled the Bluetooth subsystem in the kernel config and I'm not able
to reproduce the problem any more (at least not within 50 consecutive
suspend-resume and hibernate-resume cycles).  Thus Bluetooth seems to be
at least necessary to reproduce the issue and perhaps it's also the cause of
it.

Rafael
