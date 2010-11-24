From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH ver. 2] PM: add synchronous runtime interface
	for interrupt handlers
Date: Wed, 24 Nov 2010 21:33:56 +0100
Message-ID: <201011242133.56304.rjw__48264.0828741298$1290630932$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1011240950220.1513-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1011240950220.1513-100000@iolanthe.rowland.org>
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
Cc: Partha Basak <p-basak2@ti.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, November 24, 2010, Alan Stern wrote:
> On Tue, 23 Nov 2010, Rafael J. Wysocki wrote:
> 
> > > Or maybe you think that when pm_runtime_put_sync detects the 
> > > usage_count has decremented to 0 and the device is irq-safe, it should 
> > > call rpm_suspend directly instead of calling rpm_idle?
> > 
> > That also would work for me, actually.
> 
> Okay, then consider this proposal.  I'll introduce a new
> pm_runtime_put_sync_suspend() function which decrements the usage_count
> and calls rpm_suspend directly if the count drops to 0.  Then interrupt
> handlers could use this function in place of pm_runtime_put_sync(),
> provided the device was irq-safe.
> 
> Not only that, pm_runtime_put_sync_suspend() would be available for
> anyone to use.  It must be reasonably common for runtime_idle routines
> to do nothing but call pm_runtime_suspend().  The new API call would
> save a little overhead.

Fine by me.

Thanks,
Rafael
