From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 3/3] ACPI / PM: Avoid resuming devices in ACPI PM domain during system suspend
Date: Thu, 08 May 2014 21:40:43 +0200
Message-ID: <1678557.ZOxSn5icam@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1405081058420.1087-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61886 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755061AbaEHTYE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 May 2014 15:24:04 -0400
In-Reply-To: <Pine.LNX.4.44L0.1405081058420.1087-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thursday, May 08, 2014 10:59:38 AM Alan Stern wrote:
> On Thu, 8 May 2014, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Rework the ACPI PM domain's PM callbacks to avoid resuming devices
> > during system suspend (in order to modify their wakeup settings etc.)
> > if that isn't necessary.
> 
> Wasn't there going to be a patch in this series doing the same thing 
> for PCI?  Or has it not yet been written?

Not yet written. :-)

Rafael

