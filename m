From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rft]autosuspend for btusb
Date: Fri, 22 Aug 2008 15:33:53 +0200
Message-ID: <1219412033.7591.464.camel__6229.058528743$1219416339$gmane$org@violet.holtmann.net>
References: <200808221520.19791.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808221520.19791.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-usb@vger.kernel.org, Stefan Seyfried <seife@suse.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Oliver,

> this patch against vanilla 2.6.27-rc4 implements full autosuspend for
> btusb. It should allow the HCI to be suspended during periods of inactivity
> while retaining full service if the device supports USB remote wakeup.

actually we do have two cases. An inactive device can be woken up by an
HCI Connection Request coming via the interrupt endpoint or if we have a
send_frame callback via the Bluetooth stack itself.

What do we do if a device does not support remote wakeup?

> Please test and/or comment on the code.
> It works for me with a few glitches but still needs to be a bit polished.

Please explain the tx_in_flight stuff to me. It looks unneeded since we
anchor all TX URBs anyway.

So can we just leave the ISOC interface stuff out of it and try to get
the case right where we have control and interrupt URBs only and maybe
bulk URBs in case we an ACL link up.

This reminds me that we should extend the notify() callback to inform
about sniff and active state changes. Since in theory when a connection
goes into sniff mode, we could suspend it.

Regards

Marcel
