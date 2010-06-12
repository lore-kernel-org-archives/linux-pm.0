From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH ver. 2] PM: describe kernel policy regarding
	wakeup defaults
Date: Sun, 13 Jun 2010 00:42:07 +0200
Message-ID: <201006130042.08005.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1006081724060.1387-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006081724060.1387-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 08, 2010, Alan Stern wrote:
> On Tue, 8 Jun 2010, Rafael J. Wysocki wrote:
> 
> > On Tuesday 08 June 2010, Alan Stern wrote:
> > > This patch (as1381b) updates a comment describing the kernel's policy
> > > toward enabling wakeup by default.
> > > 
> > > It also makes device_set_wakeup_capable() actually do something when
> > > CONFIG_PM isn't enabled.  It's not clear this is necessary; however if
> > > it isn't then device_init_wakeup() and device_can_wakeup() should also
> > > be do-nothing routines.  Furthermore, I don't expect this change to
> > > have any noticeable effect -- but if it does then clearly the old
> > > behavior was wrong.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > 
> > > ---
> > > 
> > > Rafael, I don't know if you got the earlier version of this patch.  
> > 
> > I did.
> > 
> > > This one applies against 2.6.35-rc1.
> > 
> > I assume I should replace the old patch with this one.
> 
> Yes.  If nothing else, the merge will be simpler.

Applied to suspend-2.6/linux-next.

Rafael
