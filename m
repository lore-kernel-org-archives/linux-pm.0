From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Update 2x][PATCH] USB / PM: Drop CONFIG_PM_RUNTIME from the USB core
Date: Mon, 01 Dec 2014 02:12:51 +0100
Message-ID: <22502474.I00WlQ6xeB@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1411301045010.10461-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58135 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751701AbaLAAvb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 30 Nov 2014 19:51:31 -0500
In-Reply-To: <Pine.LNX.4.44L0.1411301045010.10461-100000@netrider.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, USB development list <linux-usb@vger.kernel.org>

On Sunday, November 30, 2014 10:45:39 AM Alan Stern wrote:
> On Sat, 29 Nov 2014, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> > selected) PM_RUNTIME is always set if PM is set, so quite a few
> > #ifdef blocks depending on CONFIG_PM_RUNTIME may now be changed to
> > depend on CONFIG_PM (or even dropped in some cases).
> > 
> > Replace CONFIG_PM_RUNTIME with CONFIG_PM in the USB core code
> > and documentation.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > Added the Documentation/usb/power-management.txt changes.
> > 
> > Of course, this depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME
> > if PM_SLEEP is selected) which is in linux-next only (via linux-pm) at the
> > moment.
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Thanks!

Greg, would there be any problems if I took this into the linux-pm tree?

Rafael

