From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [rft]autosuspend for btusb
Date: Fri, 22 Aug 2008 15:51:56 +0200
Message-ID: <200808221551.57225.oliver__36960.9644906179$1219413281$gmane$org@neukum.org>
References: <200808221520.19791.oliver@neukum.org>
	<1219412033.7591.464.camel@violet.holtmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1219412033.7591.464.camel@violet.holtmann.net>
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
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-usb@vger.kernel.org, Stefan Seyfried <seife@suse.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Freitag 22 August 2008 15:33:53 schrieb Marcel Holtmann:
> Hi Oliver,
> 
> > this patch against vanilla 2.6.27-rc4 implements full autosuspend for
> > btusb. It should allow the HCI to be suspended during periods of inactivity
> > while retaining full service if the device supports USB remote wakeup.
> 
> actually we do have two cases. An inactive device can be woken up by an
> HCI Connection Request coming via the interrupt endpoint or if we have a
> send_frame callback via the Bluetooth stack itself.

Yes, if send_frame triggers it, we wake using a work queue. A connection
request will wake us via remote wakeup.

> What do we do if a device does not support remote wakeup?

Autosuspend on close, resume on open. I don't think we can do more.

> > Please test and/or comment on the code.
> > It works for me with a few glitches but still needs to be a bit polished.
> 
> Please explain the tx_in_flight stuff to me. It looks unneeded since we
> anchor all TX URBs anyway.

The completion of an URB may happen after the autosuspend timeout passed.
But we cannot use the pm counters as they are not accessible in interrupt.
Hence we must maintain a counter ourselves.

> So can we just leave the ISOC interface stuff out of it and try to get

The isoc stuff should be handled already, but I haven't tested that.

> the case right where we have control and interrupt URBs only and maybe
> bulk URBs in case we an ACL link up.
> 
> This reminds me that we should extend the notify() callback to inform
> about sniff and active state changes. Since in theory when a connection
> goes into sniff mode, we could suspend it.

We should definitely do that.

	Regards
		Oliver


	
