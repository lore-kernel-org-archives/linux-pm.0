From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [linux-pm] [BUG] sleeping function called from invalid context
 during resume
Date: Mon, 10 Jul 2006 15:15:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607101513070.5721-100000@iolanthe.rowland.org>
References: <CFF307C98FEABE47A452B27C06B85BB6ED008C@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ED008C@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 10 Jul 2006, Brown, Len wrote:

> >... a similar fix needs to be made in
> drivers/acpi/osl.c:acpi_os_wait_semaphore().
> >If interrupts are disabled the timeout argument should be set to 0, so
> that the 
> >routine will call down_trylock() instead of down() or
> schedule_timeout_interruptible().
> 
> We used to have a hack in acpi_os_wait_semaphore():
> 
> if (in_atomic())
> 	timeout = 0;
> 
> But we deleted it upon ACPICA 20060608 when the
> ACPICA locks that were used at interrupt-time were
> converted to be Linux spin-locks.
> 
> Now it is still conceivable that during resume before interrutps are
> re-enabled,
> the PCI interrupt link devices run AML and go to acquire an AML mutex
> with
> a timeout.  However, we are single threaded at that point, so it isn't
> possible for them to acquire the mutex -- timeout or not.
> 
> I don't like the looks of the "workaround" above -- it makes the code
> confusing.
> 
> I'd be open to putting a BUG_ON() in the sleep case if interrupts are
> not enabled.
> 
> Is there another case that you can think of?

I can't give you an answer now; this case was triggered during 
resume-from-disk on my computer at home.

Tonight I'll attach a stack trace to the bug report.  Let's continue 
further discussion there, off-list.

Alan Stern

