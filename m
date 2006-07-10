From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [linux-pm] [BUG] sleeping function called from invalid context
 during resume
Date: Mon, 10 Jul 2006 15:02:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607101452310.5721-100000@iolanthe.rowland.org>
References: <CFF307C98FEABE47A452B27C06B85BB6ED003F@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ED003F@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 10 Jul 2006, Brown, Len wrote:

> oops, looks like I e-mailed and attached a diff that was
> from before I built and tested.  The version in git
> has one line different -- includes actypes.h as you suggest.
> I've updated the attachment in the bug report above to match git.
> 
> note that the definitions of acpi_cpu_flags
> and acpi_thread_id are not un-needed.  Indeed,
> they must occur in aclinux.h above where actypes.h
> is included or the ACPICA defaults would be used
> and that would break the Linux build.

Thank you.  Additional comments added to the bug report (#3469).

Alan Stern

