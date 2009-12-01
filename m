From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: allow for usage_count > 0 in
	pm_runtime_get()
Date: Wed, 2 Dec 2009 00:09:57 +0100
Message-ID: <200912020009.57496.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0911301659460.4478-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0911301659460.4478-100000@iolanthe.rowland.org>
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

On Monday 30 November 2009, Alan Stern wrote:
> On Mon, 30 Nov 2009, Rafael J. Wysocki wrote:
> 
> > On Monday 30 November 2009, Alan Stern wrote:
> > > This patch (as1308) fixes __pm_runtime_get().  Currently the routine
> > > will resume a device if the prior usage count was 0.  But this isn't
> > > right; thanks to pm_runtime_get_noresume() the usage count can be
> > > positive even while the device is suspended.
> > > 
> > > Now the routine always tries to carry out a resume when called
> > > synchronously.  When called asynchronously, it avoids the overhead of
> > > an unnecessary spinlock acquisition by doing the resume only if the
> > > device's state was SUSPENDING or SUSPENDED.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > All three patches applied to suspend-2.6/linux-next.  Do you want me to push
> > them to Linus before 2.6.32, or perhaps the $subject one only?
> 
> Thanks.  The patches are not urgently needed; they can wait until the 
> merge window.
> 
> BTW, I just noticed that the runtime_idle method is documented as 
> returning void but defined in pm.h as returning int.  Obviously the 
> definition is wrong, since no return value is ever used.  Would you 
> like to fix it?

In fact it's been changed to return int at the Matthew's request, because
bus type code might use the return value from a driver's callback.  In fact
the PCI runtime PM framework being worked on at the moment uses
the return value of a driver's runtime_idle(), if implemented.

So, the documentation has to be changed rather than the definition.

Thanks,
Rafael
