From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/2] PM / Runtime: Clean up
	pm_runtime_disable()
Date: Thu, 28 Jan 2010 21:30:40 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001282129150.5247-100000__38833.0350899652$1264732307$gmane$org@netrider.rowland.org>
References: <201001282112.48214.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001282112.48214.rjw@sisk.pl>
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

On Thu, 28 Jan 2010, Rafael J. Wysocki wrote:

> > > - * If @check_resume is set and there's a resume request pending when
> > > - * __pm_runtime_disable() is called and power.disable_depth is zero, the
> > > - * function will wake up the device before disabling its run-time PM.
> > >   */
> > > -void __pm_runtime_disable(struct device *dev, bool check_resume)
> > > +void pm_runtime_disable(struct device *dev)
> > >  {
> > 
> > Why did you decide to remove the check_resume argument?  That decision 
> > should be explained in the patch description.
> 
> Well, I thought the "which is not necessary any more" would be a sufficient
> explanation ...

But why is it not necessary now, given that apparently it was necessary 
before?  What has changed to make it unnecessary?

Alan Stern
