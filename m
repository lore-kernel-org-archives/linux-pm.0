From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usb: host: ehci: workaround PME bug on AMD EHCI controller
Date: Fri, 16 Jun 2017 13:30:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1706161327410.1715-100000@iolanthe.rowland.org>
References: <CAAd53p4ntaZ48dsHG+ftDadgOnX=xwX9c3WeBr2SXZye3VL4CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:45552 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1752426AbdFPRaR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2017 13:30:17 -0400
In-Reply-To: <CAAd53p4ntaZ48dsHG+ftDadgOnX=xwX9c3WeBr2SXZye3VL4CA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, gregkh@linuxfoundation.org, USB list <linux-usb@vger.kernel.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

On Sat, 17 Jun 2017, Kai-Heng Feng wrote:

> On Fri, Jun 16, 2017 at 11:07 AM, Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> > On Thu, Jun 15, 2017 at 10:12 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> Those documents refer to a hardware bug with a workaround in the BIOS.
> >> Have you checked to see if your BIOS is up to date?
> >
> > Yes, it's up to date.
> >
> 
> Alan, I re-sent a patch but I forgot to add you to CC list:
> http://marc.info/?l=linux-pci&m=149760607914628&w=2

Thanks for letting me know.  The patch seems reasonable.

Have you tested it with system suspend?  That is, if you suspend the 
whole computer, does plugging or unplugging a USB device cause the 
system to wake up?

Alan Stern
