From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Make it possible to avoid wakeup events
 from being lost
Date: Tue, 29 Jun 2010 15:57:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006291533130.1314-100000__7831.08348628065$1277841516$gmane$org@iolanthe.rowland.org>
References: <53596.65110.qm@web180310.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <53596.65110.qm@web180310.mail.gq1.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: mark gross <640e9920@gmail.com>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Arve@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 28 Jun 2010, David Brownell wrote:

> Did someone post the canonical driver changes
> to make use of this?

No, not really.  The patch itself contains an example (PCI) but it 
doesn't demonstrate the full range of possible usages.

>  Something like
> 
>   suspend() { /* if wake-enabled, up count */ }
>   resume() { /* if upcounted, downcount */ }
> 
> is what first comes to mind.. expecting that
> the suspend/resume methods in the driver are
> already doing the right things for enabling
> and later disabling the "system wake" behavior
> on the various relevant hardware events...

The PCI example looks like this:

	resume()
	{
		...
		if (device_may_wakeup(dev))
			pm_wakeup_event(dev, TIMEOUT_GUESS);
		...
	}

where TIMEOUT_GUESS is an estimate of how long to wait before allowing 
the system to sleep.

For things like keyboards, an example would go more like this:

	irq_handler()
	{
		...
		if (key-press event occurred) {
			...
			if (input queue is empty)
				pm_stay_awake(dev);
			add event to input queue;
			...
		}
		...
	}

	read_queue()
	{
		...
		send queued data to userspace
		if (input queue is empty)
			pm_relax();
		...
	}

I left out the device_may_wakeup tests; things become rather 
complicated if you can have more than one keyboard feeding the same 
input queue and some of them are wakeup-enabled while others aren't.

Clearly the appropriate changes will depend on the subsystem and the
kind of event.  They may also end up depending on the platform; perhaps
this will be used only on relatively small systems like an Android
phone.

Alan Stern
