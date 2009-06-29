From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update] PM: Introduce core framework for
 run-time PM of I/O devices (rev. 6)
Date: Mon, 29 Jun 2009 13:29:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906291259320.17436-100000__34012.0890098207$1246296707$gmane$org@iolanthe.rowland.org>
References: <200906291839.16631.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906291839.16631.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 29 Jun 2009, Rafael J. Wysocki wrote:

> Theoretically, we are, but practically we want to be able to use
> pm_runtime_put() (the asynchronous version) after a pm_runtime_resume()
> that found the device operational, but that would result in queuing a request
> using the same work structure that is used by the pending suspend request.
> Don't you see a problem here?

This is a different situation.  pm_runtime_resume does have the luxury 
of killing the suspend request, and it should do so.

Let's think about it this way.  Why does a driver call
pm_request_resume in the first place?  Because an interrupt handler or
spinlocked region wants to do some I/O, so the device has to
be active.

But when will it do the I/O?  If the device is currently suspended, the
driver can do the I/O at the end of its runtime_resume callback.  But
if the status is RPM_ACTIVE, the callback won't be invoked, so the
interrupt handler will have to do the I/O directly.  The same is true
for RPM_IDLE.

Except for one problem: In RPM_IDLE, a suspend might occur at any time.  
(In theory the same thing could happen in RPM_ACTIVE.)  To prevent
this, the driver can call pm_runtime_get before pm_request_resume.  
When the I/O is all finished, it calls pm_request_put.

If the work routine starts running before the pm_request_put, it will 
see that the counter is positive so it will set the status back to 
RPM_ACTIVE.  Then the put will queue an idle notification.  If the work 
routine hasn't started running before the pm_request_put then the 
status will remain RPM_IDLE all along.

Regardless, it's not necessary for pm_request_resume to kill the 
suspend request.  And even if it did, the driver would still need to 
implement both pathways for doing the I/O.


> > As long as the behavior is documented, I think it will be okay for
> > pm_request_resume not to cancel a pending suspend request.
> 
> I could agree with that, but what about pm_runtime_resume() happening after
> a suspend request has been scheduled?  Should it also ignore the pending
> suspend request?

It could, but probably it shouldn't.

> In which case it would be consistent to allow to schedule suspends even though
> the resume counter is greater than 0.

True enough, although I'm not sure there's a good reason for it.  You 
certainly can increment the resume counter after scheduling a suspend 
request -- the effect would be the same.

Alan Stern
