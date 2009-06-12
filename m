From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Fri, 12 Jun 2009 21:09:34 +0200
Message-ID: <200906122109.35589.rjw__4848.54022874988$1244833883$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0906121027300.2915-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906121027300.2915-100000@iolanthe.rowland.org>
Content-Disposition: inline
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday 12 June 2009, Alan Stern wrote:
> On Fri, 12 Jun 2009, Oliver Neukum wrote:
> 
> > Am Freitag, 12. Juni 2009 04:16:10 schrieb Alan Stern:
> > > What tree constraint?  You mean that the PM core shouldn't allow
> > > devices to suspend unless all their children are suspended?  Why
> > > doesn't it still apply?
> > 
> > Because the hardware doesn't need it.
> 
> But maybe drivers need it.
> 
> > > Remember, when Rafael and I say "suspend" here, we don't mean "go to a
> > > low-power state".  We mean "the PM core calls the runtime_suspend
> > > method".  No matter what actions the link hardware may decide to take
> > > on its own, the PM core will still want to observe the
> > > all-children-suspended restriction when calling runtime_suspend
> > > methods.
> > 
> > No. The core if it insists all children be suspended will not use
> > the hardware's full capabilities.
> 
> That isn't what I said.  The core does not insist that all children be 
> suspended, i.e., be in a low-power state.  It insists only that the 
> children's drivers' runtime_suspend methods have been called.  Those 
> methods are not obligated to put the children in a low-power state.
> 
> > If it leaves such power saving measures to the drivers, latency
> > accounting will be wrong.
> > 
> > > > I think there are devices who can be suspended while children are active
> > > > and devices which can not be. This is an attribute of the device and
> > > > should be evaluated by the core.
> > >
> > > Clearly it should be decided by the driver.  Should there be a bit for
> > > it in the dev_pm_info structure?
> > 
> > Yes.
> 
> That would resolve the issue.

So, are you suggesting that the core should only check the "all children
suspended" condition if special flag is set in dev_pm_info?

Best,
Rafael
