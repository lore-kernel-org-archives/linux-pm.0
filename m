From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 3/3] ACPI / PM: Avoid resuming devices in ACPI PM
 domain during system suspend
Date: Thu, 8 May 2014 10:59:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1405081058420.1087-100000@iolanthe.rowland.org>
References: <2719001.qTQrFyBHGg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2719001.qTQrFyBHGg@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 8 May 2014, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rework the ACPI PM domain's PM callbacks to avoid resuming devices
> during system suspend (in order to modify their wakeup settings etc.)
> if that isn't necessary.

Wasn't there going to be a patch in this series doing the same thing 
for PCI?  Or has it not yet been written?

Alan Stern
