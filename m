From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [BUG] sleeping function called from invalid context
 during resume
Date: Mon, 10 Jul 2006 11:21:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607101118270.7513-100000@iolanthe.rowland.org>
References: <CFF307C98FEABE47A452B27C06B85BB6ECFA44@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422656AbWGJPVg@vger.kernel.org>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECFA44@hdsmsx411.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 10 Jul 2006, Brown, Len wrote:

> Okay, if system_state is off limits, there here is what I've got
> (interesting part is the last 20 lines)
> 
> ACPI: acpi_os_allocate() fixes
> 
> Replace acpi_in_resume with a more general hack
> to check irqs_disabled() on any kmalloc() from ACPI.
> While setting (system_state != SYSTEM_RUNNING) on resume
> seemed more general, Andrew Morton preferred this approach.

I'm not sure how you would like to handle this, but a similar fix needs to 
be made in drivers/acpi/osl.c:acpi_os_wait_semaphore().  If interrupts are 
disabled the timeout argument should be set to 0, so that the routine will 
call down_trylock() instead of down() or schedule_timeout_interruptible().

Alan Stern
