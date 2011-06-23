From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI / PM: Block races between runtime PM and
	system sleep
Date: Fri, 24 Jun 2011 00:35:14 +0200
Message-ID: <201106240035.14913.rjw__1632.68354158408$1308869157$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1106231727180.2033-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106231727180.2033-100000@iolanthe.rowland.org>
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
Cc: Tejun Heo <tj@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, June 23, 2011, Alan Stern wrote:
> On Thu, 23 Jun 2011, Rafael J. Wysocki wrote:
> 
> > > Then maybe this disable_depth > 0 case should return something other
> > > than 0.  Something new, like -EACCES.  That way the caller would
> > > realize something strange was going on but wouldn't have to treat the 
> > > situation as an error.
> > 
> > I would be fine with that, but then we'd need to reserve that error code,
> > so that it's not returned by subsystem callbacks (or even we should convert
> > it to a different error code if it is returned by the subsystem callback in
> > rpm_resume()). 
> > 
> > > After all, the return value from pm_runtime_get_sync() is documented to 
> > > be the error code for the underlying pm_runtime_resume().  It doesn't 
> > > refer to the increment operation -- that always succeeds.
> > 
> > That means we should change the caller, which is the SCSI subsystem in this
> > particular case, to check the error code.  The problem with this approach
> > is that the same error code may be returned in a different situation, so
> > we should prevent that from happening in the first place.  Still, suppose
> > that we do that and that the caller checks the error code.  What is it
> > supposed to do in that situation?  The only reasonable action for the
> > caller is to ignore the error code if it means disable_depth > 0 and go
> > on with whatever it has to do, but that's what it will do if the
> > pm_runtime_get_sync() returns 0 in that situation.
> > 
> > So, in my opinion it simply may be best to update the documentation of
> > pm_runtime_get_sync() along with the code changes. :-)
> 
> The only reason you're doing this is for the SCSI error-handler 
> routine?

Yes, it is.

> I think it would be easier to change that routine instead of the PM 
> core.  It should be smart enough to know that a runtime PM call isn't 
> needed during a system sleep transition, i.e., between the scsi_host's 
> suspend and resume callbacks.  Maybe check the new is_suspended flag.  
> You'd also have to make sure the scsi_host wasn't runtime suspended 
> when the sleep begins, rather like PCI.

Well, I think the problem is still there even at run time if runtime PM
happens to be disabled for shost_gendev (this probably never happens in
practice, though, except when runtime PM is disabled during system
suspend, which also wasn't done before).

> I'm still not clear on why the error handler needs to run at this time.

Because SATA ports are suspended with the help of the SCSI error handling
mechanism (which Tejun claims is the best way to do that).

But the thing done by scsi_autopm_get_host() is entirely reasonable
(maybe except that calling pm_runtime_put_sync() after failing
pm_runtime_get_sync() is rather pointless, pm_runtime_put_noidle() would
be sufficient), but it doesn't work for disabled runtime PM.

So, the question is whether or not what scsi_autopm_get_host() does should work
when runtime PM is disabled and I think it should.  Hence the patch.

Now, I agree that the proposed change is a little ugly, because it makes
"resume with taking reference" behave differently from "resume".  The
solution to that would be to return a special error code in the "disabled
runtime PM" case.  However, in that case we'd need to change the runtime PM
code in general to return this particular error code in the "disabled runtime
PM" case and to prevent this error code from being returned in other
circumstances.  In addition to that, we'de need to change the SCSI code, of
course.

Do you think that would be better?

Rafael
