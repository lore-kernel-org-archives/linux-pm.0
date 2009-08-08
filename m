From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 00/05] PM: Runtime PM v13 for Platform
	Devices 20090807
Date: Sat, 8 Aug 2009 15:47:56 +0200
Message-ID: <200908081547.56394.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908071206380.3063-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908071206380.3063-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

On Friday 07 August 2009, Alan Stern wrote:
> On Sat, 8 Aug 2009, Magnus Damm wrote:
> 
> > On Fri, Aug 7, 2009 at 11:32 PM, Alan Stern<stern@rowland.harvard.edu> wrote:
> > > On Fri, 7 Aug 2009, Magnus Damm wrote:
> > >
> > >> PM: Runtime PM v13 for Platform Devices 20090807
> > >>
> > >> [PATCH 01/05] PM: Runtime PM v13 - add dev_pm_ops helpers
> > >
> > > This patch doesn't do anything much, besides reverting a change I asked
> > > Rafael to make.  I don't see how it helps platform-specific code do
> > > anything.
> > 
> > It's helping different bus types to implement the runtime part of the
> > dev_pm_ops in a consistent way. I suggest that all bus types should
> > return -ENOSYS if the callback is missing.
> 
> Doesn't Rafael's code already do this?
> 
> >  And they can do so by using
> > the helper functions. The change is not platform specific, but my
> > latest SuperH platform Runtime PM prototype makes use of it.
> > 
> > The latest SuperH specific Runtime PM implementation require
> > dev_pm_ops even though there is no work to be done for the driver. The
> > code works in a sort of opt-in way at this point, so callbacks are
> > explicitly required. I'd like us to standardize on this behaviour if
> > possible, so runtime pm enabled platform drivers can be shared between
> > different platform bus implementations. So my LCDC platform driver
> > will work fine on both SuperH SoCs and ARM SoCs.
> 
> I still don't see the connection.  Why are helper functions useful?
> 
> > Sorry for reverting your change, but I couldn't see any clear benefit
> > with the v11->v13 lock-drop-inside-the-if-case change. Isn't it just
> > avoiding dropping the lock in the uncommon error case? Maybe I'm
> > misunderstanding.
> 
> Basically you are right, except for one thing: The error case might not
> be so uncommon.  That's the benefit.
> 
> Rafael, along these lines, I suspect we might not want to go into an
> error state if a runtime suspend fails because there is no callback
> function.  Returning -ENOSYS to the caller is fine, but leave 
> runtime_error set to 0.  Maybe do the same for runtime resume.

Yes, I've just made this change.

> > >> [PATCH 02/05] PM: Runtime PM v13 - let bus-less devices succeed
> > >
> > > This could be added without 01/05.  But why do you want it?  Busless
> > > devices don't have PM runtime callbacks, so whether the core thinks the
> > > callbacks succeed or not doesn't make any difference.
> > >
> > > You say that "Runtime suspend and resume of devices on the platform bus
> > > is impossible without this change", but you don't explain why -- or why
> > > the patch makes runtime suspend and resume of these devices possible.
> > 
> > Right now, in the standard upstream kernel all platform devices get
> > assigned a parent device unless one exists are registration time. The
> > shared parent device is parent-less. Since the Runtime PM code resumes
> > the parent before the child, the resume operation will fail because
> > there is no dev_pm_ops for the shared parent.
> 
> Not if the parent is disabled for runtime PM, which it is in this case, 
> right?
> 
> > So I wonder which way that is the best to allow resuming platform
> > devices. Patch [02/05] is one way, but maybe there are more elegant
> > ways to handle it? Should the platform code be modified instead? If
> > so, how? I suppose root hubs for USB may have a similar issue, no?
> 
> If necessary, I would suggest adding appropriate dummy runtime PM 
> routines for that catch-all parent device.  But it may not be 
> necessary.
> 
> 
> > >> [PATCH 03/05] PM: Runtime PM v13 - add debug printouts
> > >
> > > This looks good.
> > 
> > Thanks. Maybe it's a good plan to add similar printouts to other
> > functions as well?
> 
> Perhaps so.  When writing similar code for USB I found that lots of 
> debugging printouts were needed all over the place, to get everything 
> working right.  Once it was working, they were a nuisance.

I've added such messages to __pm_runtime_idle(), for consistency.

Thanks,
Rafael
