From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/7] PM: Asynchronous suspend and resume
	(updated)
Date: Tue, 18 Aug 2009 16:22:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908181606520.2653-100000__10280.3914262497$1250627091$gmane$org@iolanthe.rowland.org>
References: <200908182156.30320.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908182156.30320.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 18 Aug 2009, Rafael J. Wysocki wrote:

> > Also, I think a better approach to the async execution would not
> > require adding a struct completion to each device and making each async
> > thread wait for the completion to be signalled.  Instead, have a single
> > master thread (i.e., the thread doing the suspend) monitor the
> > dependencies and have it farm the devices out to async threads as they
> > become ready to be suspended or resumed.
> 
> Do you mean that the master thread should check the dependencies
> _before_ executing, for example, __device_resume() and execute it
> asynchronously only if they are already satisfied?  In that case we might lose
> the opportunity to save some time.

That's almost what I mean.  The master thread should keep track of the 
state of all the devices.  Each time a suspend or resume completes, the 
master thread should determine which devices now have all their 
dependencies satisfied as a result, and should asynchronously execute 
__device_resume() for each one of them.

> For example, assume devices A and B depend on C. Say that normally, A would be
> handled before B, so if C hasn't finished yet, the A's callback will be
> executed synchronously.  Now, if both A and B take time T to complete the
> callback and C finishes dT after we've called A synchronously, we'll lose the
> chance to save T - dT by handling A and B in parallel.

No, that's not what I mean.  Until C is finished, the master thread
will sleep.  When C finishes the master thread will wake up, note that
A and B can now be resumed, fire off two async threads to resume them, 
and go back to sleep.

> The master thread might chose another device for asynchronous execution, but
> then it should revisit A and B and that still is going to be suboptimal
> time-wise in some specific situations (eg. A and B are the last two devices to
> handle).
> 
> > Finally, devices that don't have async_suspend set should implicitly 
> > depend on everything that comes after them (for suspend) or before them 
> > (for resume) in the device list.
> 
> They do, through dpm_list.

Do they?  I didn't read the code closely enough to tell.  This
requirement should of course be met by whichever scheme we end up
using.  I mentioned it because it provides a simple way of including 
synchronous operations in an async framework.

Alan Stern
