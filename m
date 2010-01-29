From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] PM / Runtime: Clean up
	pm_runtime_disable()
Date: Fri, 29 Jan 2010 14:43:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001291435290.23361-100000__2294.5961253301$1264794254$gmane$org@netrider.rowland.org>
References: <201001291601.37812.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001291601.37812.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 29 Jan 2010, Rafael J. Wysocki wrote:

> On Friday 29 January 2010, Alan Stern wrote:
> > On Thu, 28 Jan 2010, Rafael J. Wysocki wrote:
> > 
> > > > > - * If @check_resume is set and there's a resume request pending when
> > > > > - * __pm_runtime_disable() is called and power.disable_depth is zero, the
> > > > > - * function will wake up the device before disabling its run-time PM.
> > > > >   */
> > > > > -void __pm_runtime_disable(struct device *dev, bool check_resume)
> > > > > +void pm_runtime_disable(struct device *dev)
> > > > >  {
> > > > 
> > > > Why did you decide to remove the check_resume argument?  That decision 
> > > > should be explained in the patch description.
> > > 
> > > Well, I thought the "which is not necessary any more" would be a sufficient
> > > explanation ...
> > 
> > But why is it not necessary now,
> 
> Well, all of the existing callers use only one value of it, which is 'false'
> (perhaps I should write that in the changelog).

I don't understand.  Isn't the existing version of pm_runtime_disable()
a caller which sets check_resume to 'true'?  There certainly are places 
that call pm_runtime_disable().

> > given that apparently it was necessary before?  What has changed to make
> > it unnecessary?
> 
> It was used in the system suspend code path in main.c (in dpm_prepare()) IIRC,
> but it was replaced by the current code.
> 
> I don't really think it's useful to try to recall why it was used at one point.
> It's not used now and I don't have a usage case for it.  If no one else knows
> it will be necessary, removing it is the right thing to do.

A particularly important usage case for pm_runtime_disable() is when a
bus subsystem or driver does when resuming from system sleep and the
device was already runtime-suspended when the sleep began.  However in 
this case (and all the other cases I'm aware of) there's no need to 
check whether a resume request is pending before doing the 
runtime_disable.

I wasn't saying that the patch is wrong, just asking the reason for it.

Alan Stern
