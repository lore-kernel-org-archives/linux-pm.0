From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] Re: NAK new drivers without proper power management?
Date: Sun, 11 Feb 2007 11:36:53 -0600
Message-ID: <45CF5435.7030802@shaw.ca>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no>
 <200702101130.44471.rjw@sisk.pl>
 <Pine.LNX.4.64.0702101231281.20138@iabervon.org>
 <200702102050.28218.rjw@sisk.pl> <20070211065404.GA943@1wt.eu>
 <20070211121339.GB4204@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750755AbXBKRg5@vger.kernel.org>
In-reply-to: <20070211121339.GB4204@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Willy Tarreau <w@1wt.eu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Barkalow <barkalow@iabervon.org>, nigel@nigel.suspend2.net, linux-kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Matthew Garrett wrote:
> On Sun, Feb 11, 2007 at 07:54:04AM +0100, Willy Tarreau wrote:
> 
>> instead of modifying all drivers to explicitly state that they don't support
>> it, we should start with a test of the NULL pointer for .suspend which should
>> mean exactly the same without modifying the drivers. I find it obvious that
>> a driver which does provide a suspend function will not support it. And if
>> some drivers (eg /dev/null) can support it anyway, it's better to change
>> *those* drivers to explicitly mark them as compatible.
> 
> No, that doesn't work. In the absence of suspend/resume methods, the PCI 
> layer will implement basic PM itself. In some cases, this works. In 
> others, it doesn't. There's no way to automatically determine which is 
> which without modifying the drivers.
> 

The only thing that the PCI layer does for PM is the stuff that the 
driver would normally tell the PCI layer to do as part of a proper 
suspend/resume implementation: enable/disable the device and 
save/restore the PCI configuration space (only the standardized part, I 
believe). This is the bare minimum that's needed on all PCI devices, 
whether or not they even have a driver loaded. I suspect the number of 
PCI devices where this is truly all they need, i.e. no state in any IO 
ports or MMIO registers that need to be reset on resume, is quite low. 
Maybe in some cases it may appear to work by luck, i.e. the registers 
happening to be set to the correct values (especially on 
suspend-to-disk) but this is not a proper implementation.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
