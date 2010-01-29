From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM / Runtime: Clean up
	pm_runtime_disable()
Date: Fri, 29 Jan 2010 21:01:45 +0100
Message-ID: <201001292101.45553.rjw__37014.5967267037$1264795415$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1001291435290.23361-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1001291435290.23361-100000@netrider.rowland.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday 29 January 2010, Alan Stern wrote:
> On Fri, 29 Jan 2010, Rafael J. Wysocki wrote:
> 
> > On Friday 29 January 2010, Alan Stern wrote:
> > > On Thu, 28 Jan 2010, Rafael J. Wysocki wrote:
> > > 
> > > > > > - * If @check_resume is set and there's a resume request pending when
> > > > > > - * __pm_runtime_disable() is called and power.disable_depth is zero, the
> > > > > > - * function will wake up the device before disabling its run-time PM.
> > > > > >   */
> > > > > > -void __pm_runtime_disable(struct device *dev, bool check_resume)
> > > > > > +void pm_runtime_disable(struct device *dev)
> > > > > >  {
> > > > > 
> > > > > Why did you decide to remove the check_resume argument?  That decision 
> > > > > should be explained in the patch description.
> > > > 
> > > > Well, I thought the "which is not necessary any more" would be a sufficient
> > > > explanation ...
> > > 
> > > But why is it not necessary now,
> > 
> > Well, all of the existing callers use only one value of it, which is 'false'
> > (perhaps I should write that in the changelog).
> 
> I don't understand.  Isn't the existing version of pm_runtime_disable()
> a caller which sets check_resume to 'true'?  There certainly are places 
> that call pm_runtime_disable().

Sorry, you're absolutely right, so the patch is wrong.

Rafael
