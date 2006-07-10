From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [linux-pm] [BUG] sleeping function called from invalid context during resume
Date: Mon, 10 Jul 2006 11:51:00 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECFDB0@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

 
>> http://bugzilla.kernel.org/show_bug.cgi?id=3469
>> 
>> Make acpi_os_allocate() into an inline function to
>> allow /proc/slab_allocators to work.
>
>Another problem with this patch; it doesn't compile.

Hmmm, to you refer to the patch on the bug-id, the one
in e-mail, or the one checked into git?

My appologies if they don't match.  I've compiled 
this into a few dozen kernels at this point.

thanks,
-Len
