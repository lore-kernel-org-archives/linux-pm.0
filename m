From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: One issue regarding the run time power management
Date: Sun, 7 Nov 2010 11:31:00 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011071125180.13843-100000@netrider.rowland.org>
References: <201011030418.02830.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011030418.02830.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, Raj Kumar <rajkumar278@hotmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 3 Nov 2010, Rafael J. Wysocki wrote:

> On Tuesday, November 02, 2010, Raj Kumar wrote:
> > 
> > Hi,
> >  
> > There is a one issue coming regarding the run time power management during system suspend, Suppose
> > system suspend is going on and before the suspend callback of driver is executed, driver issues a runtime resume to run time power management core before it gets
> > the system suspend call back but System suspend is going on then how the run time power management prevents this condition?
> >  
> > As I saw the code during dpm_prepare, power usage count is incremented by 1 by calling pm_runtime_get_noresume(dev) and then it calls
> > pm_runtime_barrier,
> >  
> > Since During System suspend, driver calls pm_runtime_get which will invoke 
> >  
> > atomic_inc(&dev->power.usage_count);
> >  
> > which increments the power usage count and calls pm_request_resume which does not have any check on power usage count,
> 
> pm_request_resume() called during system suspend will not have any effect, unless it is called before
> the pm_runtime_barrier() in dpm_prepare(), in which case the device is going to be resumed and
> system suspend will be aborted, because the PM workqueue if frozen before the suspend of
> devices.

Should pm_request_resume be changed?  Maybe it should abort a system
sleep transition.  Or maybe it should abort the sleep if the device in 
question has already been suspended.

Alan Stern
