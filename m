From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend (uhci_hcd) defunct in mmotm 2008-09-13-03-09
Date: Wed, 24 Sep 2008 10:49:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0809241047500.2650-100000__33224.5864127346$1222268207$gmane$org@iolanthe.rowland.org>
References: <48DA1CA5.20409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48DA1CA5.20409@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 24 Sep 2008, Jiri Slaby wrote:

> >> pm_op(): pci_pm_suspend+0x0/0xd0 returns -16
> >> PM: Device 0000:00:1d.0 failed to suspend: error -16
> >> PM: Some devices failed to suspend
> > 
> > The reason for this error is that the root hub wasn't already 
> > suspended.  Was there a USB device plugged into that controller?
> 
> No:

> > If you still run into problems, post more of the dmesg log (with 
> > CONFIG_USB_DEBUG enabled, of course!).
> 
> Hm, it doesn't work. 2 dmesgs from mmotm 2008-09-10-19-39 (without usb debug)
> [ok] and -rc6+gkh-all (with usb debug) [fail]:
> http://decibel.fi.muni.cz/~xslaby/dmesg_fail.hcd
> http://decibel.fi.muni.cz/~xslaby/dmesg_ok.hcd

In fact neither of those logs includes USB debugging messages.  Maybe
you omitted a mkinitrd step.

Alan Stern
