From: Mark Lord <lkml@rtr.ca>
Subject: Re: 2.6.14-rc4-mm1: USB suspend regression
Date: Wed, 19 Oct 2005 10:53:03 -0400
Message-ID: <43565DCF.5020404@rtr.ca>
References: <Pine.LNX.4.44L0.0510172048290.30056-100000@netrider.rowland.org> <200510191514.00186.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751019AbVJSOxE@vger.kernel.org>
In-Reply-To: <200510191514.00186.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>
List-Id: linux-pm@vger.kernel.org

None of the recent kernels can resume-from-ram reliably for me
if I use CONFIG_USB_SUSPEND (set).   But with that option UNset,
suspend/resume to/from RAM works very well.

BUT.. new in 2.6.14-rc*, is that the ehci_hcd USB hispeed driver
no longer survives resume from ram.  I have to unload/reload the
module to get hispeed USB after resume.

-ml
