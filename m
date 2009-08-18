From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/7] PM: Asynchronous suspend and resume
	(updated)
Date: Wed, 19 Aug 2009 00:33:23 +0200
Message-ID: <200908190033.23502.rjw__32510.1504372016$1250634917$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908181606520.2653-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908181606520.2653-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 18 August 2009, Alan Stern wrote:
> On Tue, 18 Aug 2009, Rafael J. Wysocki wrote:
> 
> > > Also, I think a better approach to the async execution would not
> > > require adding a struct completion to each device and making each async
> > > thread wait for the completion to be signalled.  Instead, have a single
> > > master thread (i.e., the thread doing the suspend) monitor the
> > > dependencies and have it farm the devices out to async threads as they
> > > become ready to be suspended or resumed.
> > 
> > Do you mean that the master thread should check the dependencies
> > _before_ executing, for example, __device_resume() and execute it
> > asynchronously only if they are already satisfied?  In that case we might lose
> > the opportunity to save some time.
> 
> That's almost what I mean.  The master thread should keep track of the 
> state of all the devices.  Each time a suspend or resume completes, the 
> master thread should determine which devices now have all their 
> dependencies satisfied as a result, and should asynchronously execute 
> __device_resume() for each one of them.
> 
> > For example, assume devices A and B depend on C. Say that normally, A would be
> > handled before B, so if C hasn't finished yet, the A's callback will be
> > executed synchronously.  Now, if both A and B take time T to complete the
> > callback and C finishes dT after we've called A synchronously, we'll lose the
> > chance to save T - dT by handling A and B in parallel.
> 
> No, that's not what I mean.  Until C is finished, the master thread
> will sleep.  When C finishes the master thread will wake up, note that
> A and B can now be resumed, fire off two async threads to resume them, 
> and go back to sleep.

There's a problem that for safety reasons I maintain the ordering of dpm_list
and the callbacks are scheduled for async execution in the same order in
which they would have been executed synchronously.  If were to change this,
we'd have to be _very_ careful.

Thanks,
Rafael
