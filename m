From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] PM / Runtime: Allow to inactivate devices during
 system suspend
Date: Wed, 20 Nov 2013 11:58:31 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1311201156070.1826-100000@iolanthe.rowland.org>
References: <CAPDyKFocLDLLp0mJghP-+nwacxM58T3EengqW0vLka=WeRQxvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:36753 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754471Ab3KTQ6c (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2013 11:58:32 -0500
In-Reply-To: <CAPDyKFocLDLLp0mJghP-+nwacxM58T3EengqW0vLka=WeRQxvw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PCI <linux-pci@vger.kernel.org>, linux-usb@vger.kernel.org, Kevin Hilman <khilman@linaro.org>

On Wed, 20 Nov 2013, Ulf Hansson wrote:

> Do note that, the intent with my RFC is also to simplify for drivers
> in general using runtime PM. No matter how you put it, the
> consequences of preventing runtime suspend during system suspend are
> causing confusions.

Then fix the confusion.  Explain peoples' mistakes to them.

Plenty of other parts of the kernel are difficult or confusing to use.  
Sometimes there simply is no way to avoid it.  We deal with the 
situation by teaching people how to use these facilities properly.

Alan Stern

